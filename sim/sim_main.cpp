// verilator harness for sim_top: two clocks (fab 125MHz, afi 200MHz),
// auto-baud UART decoder on uart_txd, timeout + PASS/FAIL detection.
#include "Vsim_top.h"
#include "Vsim_top_sim_top.h"
#include "Vsim_top_soc__Bz1.h"
#include "Vsim_top_AlvxChip.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <cstdio>
#include <cstring>
#include <string>

static void dump_cpu(Vsim_top *top) {
    Vsim_top_AlvxChip *c = top->sim_top->u_soc->u_chip;
    printf("[cpu] pc=%08x priv=%d mstatus.MIE=%d mip={MEIP%d,MTIP%d,MSIP%d} "
           "mie={MEIE%d,MTIE%d,MSIE%d} mcause=%d:%x mepc=%08x mtvec=%08x "
           "scause=%d:%x sepc=%08x stvec=%08x satp=%d:%x:%x "
           "clint_time=%llu cmp=%llu tip=%d fHalt=%d haltIt=%d "
           "inWfi=%d sip={STIP%d,SSIP%d,SEIP%d} sie={STIE%d,SSIE%d,SEIE%d}\n",
           c->__PVT__IBusCachedPlugin_fetchPc_pc,
           c->__PVT__CsrPlugin_privilege,
           (int)c->__PVT__CsrPlugin_mstatus_MIE,
           (int)c->__PVT__CsrPlugin_mip_MEIP, (int)c->__PVT__CsrPlugin_mip_MTIP,
           (int)c->__PVT__CsrPlugin_mip_MSIP,
           (int)c->__PVT__CsrPlugin_mie_MEIE, (int)c->__PVT__CsrPlugin_mie_MTIE,
           (int)c->__PVT__CsrPlugin_mie_MSIE,
           (int)c->__PVT__CsrPlugin_mcause_interrupt,
           (int)c->__PVT__CsrPlugin_mcause_exceptionCode,
           c->__PVT__CsrPlugin_mepc, c->__PVT__CsrPlugin_mtvec_base << 2,
           (int)c->__PVT__CsrPlugin_scause_interrupt,
           (int)c->__PVT__CsrPlugin_scause_exceptionCode,
           c->__PVT__CsrPlugin_sepc, c->__PVT__CsrPlugin_stvec_base << 2,
           (int)c->__PVT__CsrPlugin_satp_MODE, (int)c->__PVT__CsrPlugin_satp_ASID,
           c->__PVT__CsrPlugin_satp_PPN,
           (unsigned long long)c->__PVT__clintCtrl__DOT__logic_time,
           (unsigned long long)c->__PVT__clintCtrl__DOT__logic_harts_0_cmp,
           (int)c->__PVT__clintCtrl__DOT__logic_harts_0_timerInterrupt,
           (int)c->__PVT__IBusCachedPlugin_fetcherHalt,
           (int)c->__PVT__DebugPlugin_haltIt,
           (int)c->CsrPlugin_inWfi,
           (int)c->__PVT__CsrPlugin_sip_STIP, (int)c->__PVT__CsrPlugin_sip_SSIP,
           (int)c->__PVT__CsrPlugin_sip_SEIP_OR,
           (int)c->__PVT__CsrPlugin_sie_STIE, (int)c->__PVT__CsrPlugin_sie_SSIE,
           (int)c->__PVT__CsrPlugin_sie_SEIE);
}

static vluint64_t sim_time = 0;   // in 0.5ns ticks

double sc_time_stamp() { return sim_time; }

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Vsim_top *top = new Vsim_top;

    VerilatedVcdC *vcd = nullptr;
    vluint64_t trace_until = 0;
    if (getenv("SIM_TRACE")) {
        trace_until = strtoull(getenv("SIM_TRACE"), 0, 0);
        Verilated::traceEverOn(true);
        vcd = new VerilatedVcdC;
        top->trace(vcd, 99);
        vcd->open("sim.vcd");
    }

    vluint64_t max_ticks = 40000000;      // ~20ms of sim time
    const char *stop_str = getenv("SIM_STOP");   // stop on this uart output
    if (getenv("SIM_TICKS")) max_ticks = strtoull(getenv("SIM_TICKS"), 0, 0);
    // stall watchdog: fire when fetchPc AND ibus-accept counter are both
    // frozen for SIM_STALL ticks (catches wfi/j. parks that produce no
    // bus traffic). Polling loops still move pc -> not flagged.
    vluint64_t stall_ticks = 0;
    if (getenv("SIM_STALL")) stall_ticks = strtoull(getenv("SIM_STALL"), 0, 0);
    uint32_t last_pc = ~0u, last_ibacc = ~0u;
    vluint64_t last_move = 0;
    bool stalled = false;

    // periodic cpu-state dump (full fetchPc + CSRs + clint), ticks
    vluint64_t dump_ivl = 0;
    if (getenv("SIM_DUMP")) dump_ivl = strtoull(getenv("SIM_DUMP"), 0, 0);
    vluint64_t next_dump = 0;

    // reset
    top->clk = 0; top->afi_clk = 0; top->reset_n = 0;
    top->uart_rxd = 1; top->keys = 0xF;
    for (int i = 0; i < 800; i++) {       // 400ns
        sim_time++;
        if (sim_time % 8 == 0) top->clk ^= 1;
        if (sim_time % 5 == 0) top->afi_clk ^= 1;
        top->eval();
    }
    top->reset_n = 1;

    // uart decode: bit = (divider+1)*8 clk periods = *16 sim ticks.
    // divider is read live from the config reg each cycle so it tracks
    // whatever boot stage programmed it (boot_sim:8, kernel driver:135).
    vluint64_t BIT = 1152;                 // boot_sim divider 8+1 * 8 * 16
    bool bit_fixed = getenv("UART_BIT_TICKS") != nullptr;
    if (bit_fixed) BIT = strtoull(getenv("UART_BIT_TICKS"),0,0);
    int ustate = 0;                        // 0=idle,1=receiving
    vluint64_t edge_t = 0;
    int ubit = 0; unsigned uchar_sh = 0;
    int prev_txd = 1;
    std::string ulog;

    bool done = false;
    while (!done && sim_time < max_ticks) {
        sim_time++;
        bool clk_edge  = (sim_time % 8 == 0);
        bool afi_edge  = (sim_time % 5 == 0);
        if (clk_edge)  top->clk ^= 1;
        if (afi_edge)  top->afi_clk ^= 1;
        top->eval();
        if (vcd) {
            vcd->dump(sim_time);
            if (trace_until && sim_time > trace_until) { vcd->close(); vcd = nullptr; }
        }
        if (!bit_fixed && clk_edge)
            BIT = ((vluint64_t)top->sim_top->u_soc->u_chip->
                   __PVT__u_apb__DOT__uart__DOT__bridge_uartConfigReg_clockDivider + 1)
                  * 8 * 16;

        // MMIO trace: log every accepted dBus command to non-DDR space
        if (getenv("MMIO_TRACE") && clk_edge) {
            Vsim_top_AlvxChip *c = top->sim_top->u_soc->u_chip;
            bool acc = (c->__PVT__dBusAvalon_read || c->__PVT__dBusAvalon_write)
                       && c->__PVT__dBusAvalon_waitRequestn;
            if (acc && (c->__PVT__dBusAvalon_address & 0x80000000u)) {
                printf("[mmio] %c %08x @pc=%08x t=%llu\n",
                       c->__PVT__dBusAvalon_write ? 'W' : 'R',
                       c->__PVT__dBusAvalon_address,
                       c->__PVT__IBusCachedPlugin_fetchPc_pc,
                       (unsigned long long)sim_time);
            }
        }

        int txd = top->uart_txd;
        if (txd != prev_txd && getenv("TXD_EDGES"))
            printf("[edge] %llu -> %d\n", (unsigned long long)sim_time, txd);
        if (ustate == 0) {
            if (prev_txd == 1 && txd == 0) {   // falling edge = start bit
                ustate = 1; edge_t = sim_time; ubit = 0; uchar_sh = 0;
            }
        } else {
            // sample bit ubit at edge + (ubit+1.5)*BIT
            if (sim_time - edge_t >= BIT * (ubit + 1) + BIT / 2) {
                uchar_sh |= (txd & 1) << ubit;
                ubit++;
                if (ubit == 9) {           // 8 data + stop
                    char c = (char)(uchar_sh & 0xff);
                    static FILE *uf = nullptr;
                    if (!uf) uf = fopen("uart.log", "w");
                    if (uf) { fputc(c, uf); fflush(uf); }
                    if (getenv("UART_HEX"))
                        fprintf(stderr, "[%llu]%02x=%c edge+%llu\n",
                            (unsigned long long)sim_time, uchar_sh,
                            (c>=32&&c<127)?c:'.', sim_time-edge_t);
                    ulog += c;
                    putchar(c); fflush(stdout);
                    if (stop_str && ulog.find(stop_str) != std::string::npos)
                        done = true;
                    if (c == '\n' || ulog.size() > 256) ulog.clear();
                    ustate = 0;
                }
            }
        }
        prev_txd = txd;

        if (dump_ivl && sim_time >= next_dump) {
            next_dump = sim_time + dump_ivl;
            printf("\n@%llu ", (unsigned long long)sim_time);
            dump_cpu(top);
        }

        if (stall_ticks) {
            // dbg[3]=chip_dbg (pc[15:0]), dbg[0][15:0]=ibus accept count
            uint32_t pc    = top->dbg[3] & 0xFFFF;
            uint32_t ibacc = top->dbg[0] & 0xFFFF;
            if (pc != last_pc || ibacc != last_ibacc) {
                last_move = sim_time;
                last_pc = pc; last_ibacc = ibacc;
            } else if (sim_time - last_move > stall_ticks) {
                printf("\n[stall] fetchPc frozen at 0x%04x, dbg=%08x %08x %08x %08x\n",
                       pc, top->dbg[3], top->dbg[2], top->dbg[1], top->dbg[0]);
                dump_cpu(top);
                stalled = true;
                break;
            }
        }
    }

    printf("\n[sim] %s at tick %llu (%.1f us)\n",
           done ? "STOP-STRING HIT" : (stalled ? "STALL" : (sim_time >= max_ticks ? "TIMEOUT" : "END")),
           (unsigned long long)sim_time, sim_time / 2000.0);
    delete top;
    return done ? 0 : 1;
}
