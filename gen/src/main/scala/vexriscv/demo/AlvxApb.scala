package vexriscv.demo

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb._
import spinal.lib.bus.avalon.{AvalonMM, AvalonMMConfig}
import spinal.lib.bus.misc.SizeMapping
import spinal.lib.com.spi._
import spinal.lib.com.uart._
import spinal.lib.graphic.{Rgb, RgbConfig, VideoDma, VideoDmaGeneric}
import spinal.lib.graphic.hdmi.TmdsEncoder
import spinal.lib.graphic.vga.VgaCtrl
import spinal.lib.io.TriStateArray

// AlvxApb: peripheral block for the AL156A VexRiscv SoC.
// One APB3 slave window (1 MB) with an internal decoder:
//   0x0000 gpio_led  (6b out)        0x4000 uart (Apb3UartCtrl)
//   0x1000 gpio_key  (4b in + irq)   0x5000 spi_sd (Apb3SpiMasterCtrl)
//   0x2000 gpio_ext1 (32b out)       0x6000 sysid + key-irq status
//   0x3000 gpio_ext2 (32b out)       0x7000 video (fb dma + 720p timing + tmds)
// The fabric adapts the Avalon slave port to this apb port (avl2apb.v).
// Video: VideoDma streams the DDR framebuffer on a 32-bit Avalon read
// master into a CDC fifo; VgaCtrl makes 720p timing on pix_clk and three
// TmdsEncoder blocks produce the TMDS codes (serializer stays in top.v).
object AlvxApbGen {
  def main(args: Array[String]) {
    SpinalVerilog(AlvxApb())
  }
}

object AlvxApb {
  val vidMemConfig = AvalonMMConfig.bursted(
    addressWidth    = 30,
    dataWidth       = 32,
    burstCountWidth = 4
  ).getReadOnlyConfig
}

case class AlvxApb() extends Component {
  val io = new Bundle {
    val apb       = slave(Apb3(Apb3Config(addressWidth = 20, dataWidth = 32)))

    val uart_txd  = out Bool()
    val uart_rxd  = in  Bool()

    val leds      = out Bits(6 bits)          // [3:0] carrier, [4] green, [5] red
    val keys      = in  Bits(4 bits)

    val ext1      = out Bits(32 bits)
    val ext2      = out Bits(32 bits)

    val sd_sclk   = out Bool()
    val sd_mosi   = out Bool()
    val sd_miso   = in  Bool()
    val sd_ncs    = out Bool()

    val irq_uart  = out Bool()
    val irq_spi   = out Bool()
    val irq_key   = out Bool()                // sticky edge flag, cleared via sysid reg

    // video: pixel clock domain + DDR read master + tmds codes
    val pix_clk   = in  Bool()
    val pix_reset = in  Bool()
    val vid_mem   = master(AvalonMM(AlvxApb.vidMemConfig))
    val tmds0     = out Bits(10 bits)         // blue  + hsync/vsync ctrl
    val tmds1     = out Bits(10 bits)         // green
    val tmds2     = out Bits(10 bits)         // red
    val vid_status = out Bits(4 bits)         // {busy, underRun, enable} for mailbox
  }

  // ---------------- gpio ----------------
  val gpioLed  = Apb3Gpio(gpioWidth = 6,  withReadSync = true)
  val gpioKey  = Apb3Gpio(gpioWidth = 4,  withReadSync = true)
  val gpioExt1 = Apb3Gpio(gpioWidth = 32, withReadSync = true)
  val gpioExt2 = Apb3Gpio(gpioWidth = 32, withReadSync = true)

  // Apb3Gpio drives a tristate bus {read,write,writeEnable}; for
  // output-only pins we use the write reg directly and feed the pin back
  // into read so software reads the real pad state. Direction regs are
  // left to software.
  for (i <- 0 until 6) {
    io.leds(i) := gpioLed.io.gpio.write(i)
    gpioLed.io.gpio.read(i) := io.leds(i)
  }
  for (i <- 0 until 4) {
    gpioKey.io.gpio.read(i) := io.keys(i)
  }
  for (i <- 0 until 32) {
    io.ext1(i) := gpioExt1.io.gpio.write(i)
    gpioExt1.io.gpio.read(i) := io.ext1(i)
    io.ext2(i) := gpioExt2.io.gpio.write(i)
    gpioExt2.io.gpio.read(i) := io.ext2(i)
  }

  // ---------------- uart ----------------
  val uart = Apb3UartCtrl(UartCtrlMemoryMappedConfig(
    uartCtrlConfig = UartCtrlGenerics(
      dataWidthMax      = 8,
      clockDividerWidth = 20,
      preSamplingSize   = 1,
      samplingSize      = 5,
      postSamplingSize  = 2
    ),
    txFifoDepth = 16,
    rxFifoDepth = 16
  ))
  io.uart_txd := uart.io.uart.txd
  uart.io.uart.rxd := io.uart_rxd
  io.irq_uart := uart.io.interrupt

  // ---------------- spi (sd card) ----------------
  val spi = Apb3SpiMasterCtrl(SpiMasterCtrlMemoryMappedConfig(
    ctrlGenerics = SpiMasterCtrlGenerics(
      ssWidth    = 1,
      timerWidth = 12,
      dataWidth  = 8
    ),
    cmdFifoDepth = 32,
    rspFifoDepth = 32
  ))
  io.sd_sclk := spi.io.spi.sclk
  io.sd_mosi := spi.io.spi.mosi
  io.sd_ncs  := spi.io.spi.ss(0)
  spi.io.spi.miso := io.sd_miso
  io.irq_spi := spi.io.interrupt

  // ---------------- key irq (edge -> sticky flag) ----------------
  val keys_d  = RegNext(io.keys) init(0xF)
  val keyFlag = Reg(Bool) init(False)
  when(io.keys =/= keys_d) { keyFlag := True }
  io.irq_key := keyFlag

  // ---------------- sysid + misc regs ----------------
  val sysid = new Area {
    val apb = Apb3(Apb3Config(addressWidth = 12, dataWidth = 32))
    val factory = Apb3SlaveFactory(apb)
    factory.read(B(0x4C565830l, 32 bits), 0x00)       // 'LVX0' magic id
    factory.read(B(20261021, 32 bits), 0x04)          // build date
    factory.read(B(125, 32 bits), 0x08)               // fab_clk MHz
    factory.onWrite(0x0C) { keyFlag := False }          // any write clears
    factory.read(keyFlag, 0x0C)
  }

  // ---------------- video ----------------
  // fab_clk side: VideoDma + CSRs; pix_clk side: VgaCtrl timing + TmdsEncoder.
  // The CDC fifo lives inside VideoDma (frameClock = pixClockDomain).
  val video = new Area {
    val rgbCfg = RgbConfig(8, 8, 8)
    val pixClockDomain = ClockDomain(
      clock = io.pix_clk,
      reset = io.pix_reset,
      config = ClockDomainConfig(resetKind = ASYNC)
    )

    // frame: 640x480 RGB888 words = 307200 words = 38400 bursts of 8
    val BEAT_PER_ACCESS = 8
    val dma = VideoDma(VideoDmaGeneric(
      addressWidth      = 25,       // burst-granular (32B) address
      dataWidth         = 32,
      beatPerAccess     = BEAT_PER_ACCESS,
      sizeWidth         = 18,       // max bursts-1 = 262143 -> 8 MB
      frameFragmentType = Bits(32 bits),
      pendingRequetMax  = 31,       // +1 must be a power of 2
      fifoSize          = 8192,     // words; ~13.6 lines of buffer
      frameClock        = pixClockDomain
    ))

    // ---- CSRs (fab clock) ----
    val enable   = RegInit(False)
    val base     = RegInit(U(0x18000000 / 32, 25 bits))  // 32B units
    val size     = RegInit(U(307200 / 8 - 1, 18 bits))   // burst count - 1
    val underRun = RegInit(False)

    // restart one frame read at every v-sync boundary while enabled
    val startReq = RegInit(False)
    dma.io.start := startReq
    dma.io.base  := base
    dma.io.size  := size
    startReq     := False

    // ---- mem -> Avalon read master (fixed 8-word bursts) ----
    io.vid_mem.read       := dma.io.mem.cmd.valid
    io.vid_mem.address    := dma.io.mem.cmd.payload << 5   // 32B units -> byte
    io.vid_mem.burstCount := U(BEAT_PER_ACCESS)
    dma.io.mem.cmd.ready  := io.vid_mem.read && io.vid_mem.waitRequestn

    val rspBeat = Counter(BEAT_PER_ACCESS)
    dma.io.mem.rsp.valid    := io.vid_mem.readDataValid
    dma.io.mem.rsp.fragment := io.vid_mem.readData
    dma.io.mem.rsp.last     := rspBeat.willOverflow
    when(io.vid_mem.readDataValid) { rspBeat.increment() }

    // ---- pixel clock area: timing + tmds ----
    val pixArea = new ClockingArea(pixClockDomain) {
      val enPix   = BufferCC(enable)
      val ctrl    = new VgaCtrl(rgbCfg)
      ctrl.io.softReset := !enPix
      // VGA 640x480: h 640 + 96sync + 48back + 16front; v 480 + 2 + 33 + 10
      // negative sync polarity (720p used positive)
      ctrl.io.timings.setAs(
        hPixels = 640, hSync = 96, hFront = 16, hBack = 48, hPolarity = false,
        vPixels = 480, vSync = 2,  vFront = 10, vBack = 33, vPolarity = false
      )
      // dma words are 32-bit x8r8g8b8 (rgb in low 24 bits); feed Rgb stream.
      // Rgb declares r first and assignFromBits maps r to the LSB, so feed
      // {b,g,r} byte order to land r=frag[23:16].
      val rgbFrag = Fragment(Rgb(rgbCfg))
      rgbFrag.last := dma.io.frame.last
      rgbFrag.fragment.assignFromBits(
        dma.io.frame.fragment(7 downto 0) ##
        dma.io.frame.fragment(15 downto 8) ##
        dma.io.frame.fragment(23 downto 16)
      )
      ctrl.feedWith(dma.io.frame.translateWith(rgbFrag))

      val frameTgl = Reg(Bool) init(False)
      frameTgl toggleWhen ctrl.io.frameStart

      val errTgl = Reg(Bool) init(False)
      errTgl toggleWhen ctrl.io.error

      val encB, encG, encR = new TmdsEncoder()
      encB.io.VD := ctrl.io.vga.color.b
      encB.io.CD := Cat(ctrl.io.vga.vSync, ctrl.io.vga.hSync)
      encG.io.VD := ctrl.io.vga.color.g
      encG.io.CD := B"00"
      encR.io.VD := ctrl.io.vga.color.r
      encR.io.CD := B"00"
      for (e <- List(encB, encG, encR)) e.io.VDE := ctrl.io.vga.colorEn
      io.tmds0 := encB.io.TMDS
      io.tmds1 := encG.io.TMDS
      io.tmds2 := encR.io.TMDS
    }

    // vsync edge / underrun edge -> fab domain
    val frameTglD = BufferCC(pixArea.frameTgl)
    val frameTglQ = RegNext(frameTglD)
    val errTglD   = BufferCC(pixArea.errTgl)
    val errTglQ   = RegNext(errTglD)
    val enQ       = RegNext(enable)
    // kick off the first frame immediately on enable; re-arm at every vsync
    when((enable && !enQ) || (enable && !dma.io.busy && (frameTglD =/= frameTglQ))) {
      startReq := True
    }
    when(errTglD =/= errTglQ) { underRun := True }

    io.vid_status := B"0" ## dma.io.busy ## underRun ## enable

    // ---- apb regs ----
    val regs = new Area {
      val apb = Apb3(Apb3Config(addressWidth = 12, dataWidth = 32))
      val factory = Apb3SlaveFactory(apb)
      factory.driveAndRead(base,   0x00)
      factory.driveAndRead(size,   0x04)
      factory.driveAndRead(enable, 0x08, bitOffset = 0)
      factory.onWrite(0x0C) { underRun := False }
      factory.read(dma.io.busy ## underRun, 0x0C)
    }
  }

  // ---------------- decoder ----------------
  val decoder = Apb3Decoder(
    master = io.apb,
    slaves = List(
      gpioLed.io.apb   -> (0x00000, 4 kB),
      gpioKey.io.apb   -> (0x01000, 4 kB),
      gpioExt1.io.apb  -> (0x02000, 4 kB),
      gpioExt2.io.apb  -> (0x03000, 4 kB),
      uart.io.apb      -> (0x04000, 4 kB),
      spi.io.apb       -> (0x05000, 4 kB),
      sysid.apb        -> (0x06000, 4 kB),
      video.regs.apb   -> (0x07000, 4 kB)
    )
  )
}
