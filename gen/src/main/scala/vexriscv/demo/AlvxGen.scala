package vexriscv.demo

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.{Apb3, Apb3Config}
import spinal.lib.bus.amba4.axilite.AxiLite4SpecRenamer
import spinal.lib.bus.avalon.AvalonMM
import spinal.lib.com.jtag.Jtag
import spinal.lib.eda.altera.ResetEmitterTag
import spinal.lib.misc.AxiLite4Clint
import spinal.lib.misc.plic.AxiLite4Plic
import vexriscv.ip.{DataCacheConfig, InstructionCacheConfig}
import vexriscv.plugin._
import vexriscv.{Riscv, VexRiscv, VexRiscvConfig, plugin}

// AlvxChip: AL156A VexRiscv SoC chip-level toplevel (single generated file).
//   RV32IMA + Sv32 MMU (Linux capable, OpenSBI csr profile)
//   4KB I$/4KB D$ (32B lines; way <= page for MMU), internal LR/SC + AMO
//   iBus/dBus exported as Avalon-MM masters (32-bit, bursts; byte addr)
//   Integrated CLINT (msip/mtime/mtimecmp) + PLIC (31 sources, M+S targets)
//     -> exported as AXI4-Lite slaves (clint 64KB, plic 4MB)
//   APB3 slave window (20-bit) into the AlvxApb peripheral block
//   JTAG debug port (Spinal SystemDebugger protocol)
//
// Avalon note: waitRequestn is ACTIVE-LOW; burstcount is in 32-bit beats.
// clint/plic axil addresses are byte addresses within their windows.
object AlvxGen {
  def main(args: Array[String]) {
    val report = SpinalVerilog {

      val cpuConfig = VexRiscvConfig(
        plugins = List(
          new IBusCachedPlugin(
            resetVector = 0x00000000l,
            compressedGen = false,
            prediction = STATIC,
            config = InstructionCacheConfig(
              cacheSize = 4096,
              bytePerLine = 32,
              wayCount = 1,
              addressWidth = 32,
              cpuDataWidth = 32,
              memDataWidth = 32,
              catchIllegalAccess = true,
              catchAccessFault = true,
              asyncTagMemory = false,
              twoCycleRam = true,
              twoCycleCache = true
            ),
            memoryTranslatorPortConfig = MmuPortConfig(
              portTlbSize = 4,
              latency = 1,
              earlyRequireMmuLockup = true,
              earlyCacheHits = true
            )
          ),
          new DBusCachedPlugin(
            dBusCmdMasterPipe = true,
            dBusCmdSlavePipe = true,
            dBusRspSlavePipe = true,
            config = new DataCacheConfig(
              cacheSize         = 4096,
              bytePerLine       = 32,
              wayCount          = 1,
              addressWidth      = 32,
              cpuDataWidth      = 32,
              memDataWidth      = 32,
              catchAccessError  = true,
              catchIllegal      = true,
              catchUnaligned    = true,
              withLrSc = true,
              withAmo  = true
            ),
            memoryTranslatorPortConfig = MmuPortConfig(
              portTlbSize = 4,
              latency = 1,
              earlyRequireMmuLockup = true,
              earlyCacheHits = true
            )
          ),
          new MmuPlugin(
            ioRange      = _(31 downto 28) === 0xF
          ),
          new DecoderSimplePlugin(
            catchIllegalInstruction = true
          ),
          new RegFilePlugin(
            regFileReadyKind = plugin.SYNC,
            zeroBoot = false
          ),
          new IntAluPlugin,
          new SrcPlugin(
            separatedAddSub = false,
            executeInsertion = true
          ),
          new FullBarrelShifterPlugin,
          new MulPlugin,
          new DivPlugin,
          new HazardSimplePlugin(
            bypassExecute           = true,
            bypassMemory            = true,
            bypassWriteBack         = true,
            bypassWriteBackBuffer   = true,
            pessimisticUseSrc       = false,
            pessimisticWriteRegFile = false,
            pessimisticAddressMatch = false
          ),
          new DebugPlugin(ClockDomain.current.clone(reset = Bool().setName("debugReset"))),
          new BranchPlugin(
            earlyBranch = false,
            catchAddressMisaligned = true
          ),
          new CsrPlugin(CsrPluginConfig.openSbi(mhartid = 0, misa = Riscv.misaToInt(s"ima")).copy(utimeAccess = CsrAccess.READ_ONLY)),
          new YamlPlugin("cpu0.yaml")
        )
      )

      val chip = new VexRiscv(cpuConfig){
        // -- integrated clint + plic (axi4-lite slaves) --
        val clintCtrl = new AxiLite4Clint(1, bufferTime = false)
        val plicCtrl = new AxiLite4Plic(
          sourceCount = 31,
          targetCount = 2
        )
        val clint = clintCtrl.io.bus.toIo()
        val plic = plicCtrl.io.bus.toIo()
        val plicInterrupts = in Bits(32 bits)
        plicCtrl.io.sources := plicInterrupts >> 1
        AxiLite4SpecRenamer(clint)
        AxiLite4SpecRenamer(plic)

        // -- apb3 peripheral block --
        val u_apb = AlvxApb()
        val apb = slave(Apb3(Apb3Config(addressWidth = 20, dataWidth = 32)))
        apb <> u_apb.io.apb

        val uart_txd = out Bool();      val uart_rxd = in Bool()
        val leds     = out Bits(6 bits); val keys    = in Bits(4 bits)
        val ext1     = out Bits(32 bits); val ext2   = out Bits(32 bits)
        val sd_sclk  = out Bool();      val sd_mosi  = out Bool()
        val sd_miso  = in  Bool();      val sd_ncs   = out Bool()
        val irq_uart = out Bool();      val irq_spi  = out Bool()
        val irq_key  = out Bool()

        uart_txd := u_apb.io.uart_txd
        u_apb.io.uart_rxd := uart_rxd
        leds := u_apb.io.leds
        u_apb.io.keys := keys
        ext1 := u_apb.io.ext1
        ext2 := u_apb.io.ext2
        sd_sclk := u_apb.io.sd_sclk
        sd_mosi := u_apb.io.sd_mosi
        u_apb.io.sd_miso := sd_miso
        sd_ncs := u_apb.io.sd_ncs
        irq_uart := u_apb.io.irq_uart
        irq_spi  := u_apb.io.irq_spi
        irq_key  := u_apb.io.irq_key

        // -- video: fb dma (Avalon read master) + pix clock + tmds codes --
        val pix_clk   = in Bool()
        val pix_reset = in Bool()
        val vidMemAvalon = master(AvalonMM(AlvxApb.vidMemConfig))
        val tmds0 = out Bits(10 bits)
        val tmds1 = out Bits(10 bits)
        val tmds2 = out Bits(10 bits)
        val vid_status = out Bits(4 bits)

        u_apb.io.pix_clk   := pix_clk
        u_apb.io.pix_reset := pix_reset
        vidMemAvalon <> u_apb.io.vid_mem
        tmds0 := u_apb.io.tmds0
        tmds1 := u_apb.io.tmds1
        tmds2 := u_apb.io.tmds2
        vid_status := u_apb.io.vid_status
      }

      chip.setDefinitionName("AlvxChip")
      chip.rework {
        var iBus : spinal.lib.bus.avalon.AvalonMM = null
        for (plugin <- cpuConfig.plugins) plugin match {
          case plugin: IBusCachedPlugin => {
            plugin.iBus.setAsDirectionLess()
            iBus = master(plugin.iBus.toAvalon())
              .setName("iBusAvalon")
          }
          case plugin: DBusCachedPlugin => {
            plugin.dBus.setAsDirectionLess()
            master(plugin.dBus.toAvalon())
              .setName("dBusAvalon")
          }
          case plugin: DebugPlugin => plugin.debugClockDomain {
            plugin.io.bus.setAsDirectionLess()
            val jtag = slave(new Jtag())
              .setName("jtag")
            jtag <> plugin.io.bus.fromJtag()
            plugin.io.resetOut
              .addTag(ResetEmitterTag(plugin.debugClockDomain))
              .parent = null
          }
          case plugin: CsrPlugin => {
            plugin.timerInterrupt     .setAsDirectionLess() := chip.clintCtrl.io.timerInterrupt(0)
            plugin.softwareInterrupt  .setAsDirectionLess() := chip.clintCtrl.io.softwareInterrupt(0)
            plugin.externalInterrupt  .setAsDirectionLess() := chip.plicCtrl.io.targets(0)
            plugin.externalInterruptS .setAsDirectionLess() := chip.plicCtrl.io.targets(1)
            plugin.utime              .setAsDirectionLess() := chip.clintCtrl.io.time
          }
          case _ =>
        }
      }
      chip
    }
  }
}
