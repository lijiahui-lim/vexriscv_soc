// verilator harness for sim_top: two clocks (fab 125MHz, afi 200MHz),
// auto-baud UART decoder on uart_txd, timeout + PASS/FAIL detection.
#include "Vsim_top.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <cstdio>
#include <cstring>
#include <string>

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
    vluint64_t max_cycles = 0;
    if (getenv("SIM_TICKS")) max_ticks = strtoull(getenv("SIM_TICKS"), 0, 0);

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
    // divider 135 -> bit 1088 clk = 17408 ticks (~114890 baud @125MHz).
    vluint64_t BIT = 17408;                // divider 135+1 * 8 * 16
    if (getenv("UART_BIT_TICKS")) BIT = strtoull(getenv("UART_BIT_TICKS"),0,0);
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
    }

    printf("\n[sim] %s at tick %llu (%.1f us)\n",
           done ? "STOP-STRING HIT" : (sim_time >= max_ticks ? "TIMEOUT" : "END"),
           (unsigned long long)sim_time, sim_time / 2000.0);
    delete top;
    return done ? 0 : 1;
}
