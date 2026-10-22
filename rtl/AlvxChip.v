// Generator : SpinalHDL v1.13.0    git head : d9d72474863badf47d8585d187f3e04ae4749c59
// Component : AlvxChip
// Git hash  : 4c2369e4e28c2d1c4830dc780e854ca027ca43b9

`timescale 1ns/1ps

module AlvxChip (
  input  wire          clint_awvalid,
  output wire          clint_awready,
  input  wire [15:0]   clint_awaddr,
  input  wire [2:0]    clint_awprot,
  input  wire          clint_wvalid,
  output wire          clint_wready,
  input  wire [31:0]   clint_wdata,
  input  wire [3:0]    clint_wstrb,
  output wire          clint_bvalid,
  input  wire          clint_bready,
  output wire [1:0]    clint_bresp,
  input  wire          clint_arvalid,
  output wire          clint_arready,
  input  wire [15:0]   clint_araddr,
  input  wire [2:0]    clint_arprot,
  output wire          clint_rvalid,
  input  wire          clint_rready,
  output wire [31:0]   clint_rdata,
  output wire [1:0]    clint_rresp,
  input  wire          plic_awvalid,
  output wire          plic_awready,
  input  wire [21:0]   plic_awaddr,
  input  wire [2:0]    plic_awprot,
  input  wire          plic_wvalid,
  output wire          plic_wready,
  input  wire [31:0]   plic_wdata,
  input  wire [3:0]    plic_wstrb,
  output wire          plic_bvalid,
  input  wire          plic_bready,
  output wire [1:0]    plic_bresp,
  input  wire          plic_arvalid,
  output wire          plic_arready,
  input  wire [21:0]   plic_araddr,
  input  wire [2:0]    plic_arprot,
  output wire          plic_rvalid,
  input  wire          plic_rready,
  output wire [31:0]   plic_rdata,
  output wire [1:0]    plic_rresp,
  input  wire [31:0]   plicInterrupts,
  input  wire [19:0]   apb_PADDR,
  input  wire [0:0]    apb_PSEL,
  input  wire          apb_PENABLE,
  output wire          apb_PREADY,
  input  wire          apb_PWRITE,
  input  wire [31:0]   apb_PWDATA,
  output wire [31:0]   apb_PRDATA,
  output wire          apb_PSLVERROR,
  output wire          uart_txd,
  input  wire          uart_rxd,
  output wire [5:0]    leds,
  input  wire [3:0]    keys,
  output wire [31:0]   ext1,
  output wire [31:0]   ext2,
  output wire          sd_sclk,
  output wire          sd_mosi,
  input  wire          sd_miso,
  output wire          sd_ncs,
  output wire          irq_uart,
  output wire          irq_spi,
  output wire          irq_key,
  input  wire          pix_clk,
  input  wire          pix_reset,
  output wire          vidMemAvalon_read,
  input  wire          vidMemAvalon_waitRequestn,
  output wire [29:0]   vidMemAvalon_address,
  output wire [3:0]    vidMemAvalon_burstCount,
  input  wire          vidMemAvalon_readDataValid,
  input  wire [31:0]   vidMemAvalon_readData,
  output wire [9:0]    tmds0,
  output wire [9:0]    tmds1,
  output wire [9:0]    tmds2,
  output wire [3:0]    vid_status,
  output wire          debug_resetOut,
  output wire          iBusAvalon_read,
  input  wire          iBusAvalon_waitRequestn,
  output wire [31:0]   iBusAvalon_address,
  output wire [3:0]    iBusAvalon_burstCount,
  input  wire [1:0]    iBusAvalon_response,
  input  wire          iBusAvalon_readDataValid,
  input  wire [31:0]   iBusAvalon_readData,
  output wire          dBusAvalon_read,
  output wire          dBusAvalon_write,
  input  wire          dBusAvalon_waitRequestn,
  output wire [31:0]   dBusAvalon_address,
  output wire [3:0]    dBusAvalon_burstCount,
  output wire [3:0]    dBusAvalon_byteEnable,
  output wire [31:0]   dBusAvalon_writeData,
  input  wire [1:0]    dBusAvalon_response,
  input  wire          dBusAvalon_readDataValid,
  input  wire [31:0]   dBusAvalon_readData,
  input  wire          jtag_tms,
  input  wire          jtag_tdi,
  output wire          jtag_tdo,
  input  wire          jtag_tck,
  input  wire          clk,
  input  wire          reset,
  input  wire          debugReset,
  output wire [95:0]   cpu_dbg
);
  localparam ShiftCtrlEnum_DISABLE_1 = 2'd0;
  localparam ShiftCtrlEnum_SLL_1 = 2'd1;
  localparam ShiftCtrlEnum_SRL_1 = 2'd2;
  localparam ShiftCtrlEnum_SRA_1 = 2'd3;
  localparam BranchCtrlEnum_INC = 2'd0;
  localparam BranchCtrlEnum_B = 2'd1;
  localparam BranchCtrlEnum_JAL = 2'd2;
  localparam BranchCtrlEnum_JALR = 2'd3;
  localparam EnvCtrlEnum_NONE = 3'd0;
  localparam EnvCtrlEnum_XRET = 3'd1;
  localparam EnvCtrlEnum_WFI = 3'd2;
  localparam EnvCtrlEnum_ECALL = 3'd3;
  localparam EnvCtrlEnum_EBREAK = 3'd4;
  localparam AluBitwiseCtrlEnum_XOR_1 = 2'd0;
  localparam AluBitwiseCtrlEnum_OR_1 = 2'd1;
  localparam AluBitwiseCtrlEnum_AND_1 = 2'd2;
  localparam Src2CtrlEnum_RS = 2'd0;
  localparam Src2CtrlEnum_IMI = 2'd1;
  localparam Src2CtrlEnum_IMS = 2'd2;
  localparam Src2CtrlEnum_PC = 2'd3;
  localparam AluCtrlEnum_ADD_SUB = 2'd0;
  localparam AluCtrlEnum_SLT_SLTU = 2'd1;
  localparam AluCtrlEnum_BITWISE = 2'd2;
  localparam Src1CtrlEnum_RS = 2'd0;
  localparam Src1CtrlEnum_IMU = 2'd1;
  localparam Src1CtrlEnum_PC_INCREMENT = 2'd2;
  localparam Src1CtrlEnum_URS1 = 2'd3;
  localparam MmuPlugin_shared_State_IDLE = 3'd0;
  localparam MmuPlugin_shared_State_L1_CMD = 3'd1;
  localparam MmuPlugin_shared_State_L1_RSP = 3'd2;
  localparam MmuPlugin_shared_State_L0_CMD = 3'd3;
  localparam MmuPlugin_shared_State_L0_RSP = 3'd4;
  localparam Response_OKAY = 2'd0;
  localparam Response_RESERVED = 2'd1;
  localparam Response_SLAVEERROR = 2'd2;
  localparam Response_DECODEERROR = 2'd3;

  wire       [30:0]   plicCtrl_io_sources;
  wire                IBusCachedPlugin_cache_io_flush;
  wire                IBusCachedPlugin_cache_io_cpu_prefetch_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isStuck;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isStuck;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isUser;
  reg                 IBusCachedPlugin_cache_io_cpu_fill_valid;
  reg                 dataCache_1_io_cpu_execute_isValid;
  reg        [31:0]   dataCache_1_io_cpu_execute_address;
  reg                 dataCache_1_io_cpu_execute_args_wr;
  reg        [1:0]    dataCache_1_io_cpu_execute_args_size;
  reg                 dataCache_1_io_cpu_execute_args_isLrsc;
  wire                dataCache_1_io_cpu_execute_args_amoCtrl_swap;
  wire       [2:0]    dataCache_1_io_cpu_execute_args_amoCtrl_alu;
  reg                 dataCache_1_io_cpu_memory_isValid;
  wire       [31:0]   dataCache_1_io_cpu_memory_address;
  reg                 dataCache_1_io_cpu_memory_mmuRsp_isIoAccess;
  reg                 dataCache_1_io_cpu_writeBack_isValid;
  wire                dataCache_1_io_cpu_writeBack_isUser;
  wire       [31:0]   dataCache_1_io_cpu_writeBack_storeData;
  wire       [31:0]   dataCache_1_io_cpu_writeBack_address;
  wire                dataCache_1_io_cpu_flush_valid;
  wire                dataCache_1_io_cpu_flush_payload_singleLine;
  wire       [6:0]    dataCache_1_io_cpu_flush_payload_lineId;
  reg        [31:0]   RegFilePlugin_regFile_spinal_port0;
  reg        [31:0]   RegFilePlugin_regFile_spinal_port1;
  wire                clintCtrl_io_bus_aw_ready;
  wire                clintCtrl_io_bus_w_ready;
  wire                clintCtrl_io_bus_b_valid;
  wire       [1:0]    clintCtrl_io_bus_b_payload_resp;
  wire                clintCtrl_io_bus_ar_ready;
  wire                clintCtrl_io_bus_r_valid;
  wire       [31:0]   clintCtrl_io_bus_r_payload_data;
  wire       [1:0]    clintCtrl_io_bus_r_payload_resp;
  wire       [0:0]    clintCtrl_io_timerInterrupt;
  wire       [0:0]    clintCtrl_io_softwareInterrupt;
  wire       [63:0]   clintCtrl_io_time;
  wire                plicCtrl_io_bus_aw_ready;
  wire                plicCtrl_io_bus_w_ready;
  wire                plicCtrl_io_bus_b_valid;
  wire       [1:0]    plicCtrl_io_bus_b_payload_resp;
  wire                plicCtrl_io_bus_ar_ready;
  wire                plicCtrl_io_bus_r_valid;
  wire       [31:0]   plicCtrl_io_bus_r_payload_data;
  wire       [1:0]    plicCtrl_io_bus_r_payload_resp;
  wire       [1:0]    plicCtrl_io_targets;
  wire                u_apb_io_apb_PREADY;
  wire       [31:0]   u_apb_io_apb_PRDATA;
  wire                u_apb_io_apb_PSLVERROR;
  wire                u_apb_io_uart_txd;
  wire       [5:0]    u_apb_io_leds;
  wire       [31:0]   u_apb_io_ext1;
  wire       [31:0]   u_apb_io_ext2;
  wire                u_apb_io_sd_sclk;
  wire                u_apb_io_sd_mosi;
  wire                u_apb_io_sd_ncs;
  wire                u_apb_io_irq_uart;
  wire                u_apb_io_irq_spi;
  wire                u_apb_io_irq_key;
  wire                u_apb_io_vid_mem_read;
  wire       [29:0]   u_apb_io_vid_mem_address;
  wire       [3:0]    u_apb_io_vid_mem_burstCount;
  wire       [9:0]    u_apb_io_tmds0;
  wire       [9:0]    u_apb_io_tmds1;
  wire       [9:0]    u_apb_io_tmds2;
  wire       [3:0]    u_apb_io_vid_status;
  wire                IBusCachedPlugin_cache_io_cpu_prefetch_haltIt;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_fetch_data;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress;
  wire                IBusCachedPlugin_cache_io_cpu_decode_error;
  wire                IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling;
  wire                IBusCachedPlugin_cache_io_cpu_decode_mmuException;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_decode_data;
  wire                IBusCachedPlugin_cache_io_cpu_decode_cacheMiss;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_decode_physicalAddress;
  wire                IBusCachedPlugin_cache_io_mem_cmd_valid;
  wire       [31:0]   IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  wire       [2:0]    IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  wire                dataCache_1_io_cpu_execute_haltIt;
  wire                dataCache_1_io_cpu_execute_refilling;
  wire                dataCache_1_io_cpu_memory_isWrite;
  wire                dataCache_1_io_cpu_writeBack_haltIt;
  wire       [31:0]   dataCache_1_io_cpu_writeBack_data;
  wire                dataCache_1_io_cpu_writeBack_mmuException;
  wire                dataCache_1_io_cpu_writeBack_unalignedAccess;
  wire                dataCache_1_io_cpu_writeBack_accessError;
  wire                dataCache_1_io_cpu_writeBack_isWrite;
  wire                dataCache_1_io_cpu_writeBack_keepMemRspData;
  wire                dataCache_1_io_cpu_writeBack_exclusiveOk;
  wire                dataCache_1_io_cpu_flush_ready;
  wire                dataCache_1_io_cpu_redo;
  wire                dataCache_1_io_cpu_writesPending;
  wire                dataCache_1_io_mem_cmd_valid;
  wire                dataCache_1_io_mem_cmd_payload_wr;
  wire                dataCache_1_io_mem_cmd_payload_uncached;
  wire       [31:0]   dataCache_1_io_mem_cmd_payload_address;
  wire       [31:0]   dataCache_1_io_mem_cmd_payload_data;
  wire       [3:0]    dataCache_1_io_mem_cmd_payload_mask;
  wire       [2:0]    dataCache_1_io_mem_cmd_payload_size;
  wire                dataCache_1_io_mem_cmd_payload_last;
  wire                jtagBridge_1_io_jtag_tdo;
  wire                jtagBridge_1_io_remote_cmd_valid;
  wire                jtagBridge_1_io_remote_cmd_payload_last;
  wire       [0:0]    jtagBridge_1_io_remote_cmd_payload_fragment;
  wire                jtagBridge_1_io_remote_rsp_ready;
  wire                systemDebugger_1_io_remote_cmd_ready;
  wire                systemDebugger_1_io_remote_rsp_valid;
  wire                systemDebugger_1_io_remote_rsp_payload_error;
  wire       [31:0]   systemDebugger_1_io_remote_rsp_payload_data;
  wire                systemDebugger_1_io_mem_cmd_valid;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_address;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_data;
  wire                systemDebugger_1_io_mem_cmd_payload_wr;
  wire       [1:0]    systemDebugger_1_io_mem_cmd_payload_size;
  wire       [51:0]   _zz_memory_MUL_LOW;
  wire       [51:0]   _zz_memory_MUL_LOW_1;
  wire       [51:0]   _zz_memory_MUL_LOW_2;
  wire       [32:0]   _zz_memory_MUL_LOW_3;
  wire       [51:0]   _zz_memory_MUL_LOW_4;
  wire       [49:0]   _zz_memory_MUL_LOW_5;
  wire       [51:0]   _zz_memory_MUL_LOW_6;
  wire       [49:0]   _zz_memory_MUL_LOW_7;
  wire       [31:0]   _zz_execute_SHIFT_RIGHT;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_1;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_2;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_1;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_2;
  wire                _zz_decode_LEGAL_INSTRUCTION_3;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_4;
  wire       [17:0]   _zz_decode_LEGAL_INSTRUCTION_5;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_6;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_7;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_8;
  wire                _zz_decode_LEGAL_INSTRUCTION_9;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_10;
  wire       [11:0]   _zz_decode_LEGAL_INSTRUCTION_11;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_12;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_13;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_14;
  wire                _zz_decode_LEGAL_INSTRUCTION_15;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_16;
  wire       [5:0]    _zz_decode_LEGAL_INSTRUCTION_17;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_18;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_19;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_20;
  wire                _zz_decode_LEGAL_INSTRUCTION_21;
  wire                _zz_decode_LEGAL_INSTRUCTION_22;
  wire       [4:0]    _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1;
  reg        [31:0]   _zz_IBusCachedPlugin_jump_pcLoad_payload_6;
  wire       [2:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload_7;
  wire       [31:0]   _zz_IBusCachedPlugin_fetchPc_pc;
  wire       [2:0]    _zz_IBusCachedPlugin_fetchPc_pc_1;
  wire       [11:0]   _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  wire       [31:0]   _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2;
  wire       [19:0]   _zz__zz_2;
  wire       [11:0]   _zz__zz_4;
  wire       [31:0]   _zz__zz_6;
  wire       [31:0]   _zz__zz_6_1;
  wire       [19:0]   _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload;
  wire       [11:0]   _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_4;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_5;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_6;
  wire       [26:0]   _zz_io_cpu_flush_payload_lineId;
  wire       [26:0]   _zz_io_cpu_flush_payload_lineId_1;
  wire       [2:0]    _zz_DBusCachedPlugin_exceptionBus_payload_code;
  wire       [2:0]    _zz_DBusCachedPlugin_exceptionBus_payload_code_1;
  reg        [7:0]    _zz_writeBack_DBusCachedPlugin_rspShifted;
  wire       [1:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_1;
  reg        [7:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_2;
  wire       [0:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_3;
  wire       [0:0]    _zz_writeBack_DBusCachedPlugin_rspRf;
  wire       [9:0]    _zz_MmuPlugin_ports_0_cacheHitsCalc;
  wire       [9:0]    _zz_MmuPlugin_ports_0_cacheHitsCalc_1;
  wire                _zz_MmuPlugin_ports_0_cacheHitsCalc_2;
  wire                _zz_MmuPlugin_ports_0_cacheHitsCalc_3;
  wire                _zz_MmuPlugin_ports_0_cacheHitsCalc_4;
  wire                _zz_MmuPlugin_ports_0_cacheHitsCalc_5;
  reg                 _zz_MmuPlugin_ports_0_cacheLine_valid_4;
  reg                 _zz_MmuPlugin_ports_0_cacheLine_exception;
  reg                 _zz_MmuPlugin_ports_0_cacheLine_superPage;
  reg        [9:0]    _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0;
  reg        [9:0]    _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1;
  reg        [9:0]    _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0;
  reg        [9:0]    _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1;
  reg                 _zz_MmuPlugin_ports_0_cacheLine_allowRead;
  reg                 _zz_MmuPlugin_ports_0_cacheLine_allowWrite;
  reg                 _zz_MmuPlugin_ports_0_cacheLine_allowExecute;
  reg                 _zz_MmuPlugin_ports_0_cacheLine_allowUser;
  wire       [1:0]    _zz_MmuPlugin_ports_0_entryToReplace_valueNext;
  wire       [0:0]    _zz_MmuPlugin_ports_0_entryToReplace_valueNext_1;
  wire       [9:0]    _zz_MmuPlugin_ports_1_cacheHitsCalc;
  wire       [9:0]    _zz_MmuPlugin_ports_1_cacheHitsCalc_1;
  wire                _zz_MmuPlugin_ports_1_cacheHitsCalc_2;
  wire                _zz_MmuPlugin_ports_1_cacheHitsCalc_3;
  wire                _zz_MmuPlugin_ports_1_cacheHitsCalc_4;
  wire                _zz_MmuPlugin_ports_1_cacheHitsCalc_5;
  reg                 _zz_MmuPlugin_ports_1_cacheLine_valid_4;
  reg                 _zz_MmuPlugin_ports_1_cacheLine_exception;
  reg                 _zz_MmuPlugin_ports_1_cacheLine_superPage;
  reg        [9:0]    _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0;
  reg        [9:0]    _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1;
  reg        [9:0]    _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0;
  reg        [9:0]    _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1;
  reg                 _zz_MmuPlugin_ports_1_cacheLine_allowRead;
  reg                 _zz_MmuPlugin_ports_1_cacheLine_allowWrite;
  reg                 _zz_MmuPlugin_ports_1_cacheLine_allowExecute;
  reg                 _zz_MmuPlugin_ports_1_cacheLine_allowUser;
  wire       [1:0]    _zz_MmuPlugin_ports_1_entryToReplace_valueNext;
  wire       [0:0]    _zz_MmuPlugin_ports_1_entryToReplace_valueNext_1;
  wire       [1:0]    _zz__zz_MmuPlugin_shared_refills_2;
  wire       [31:0]   _zz__zz_decode_IS_CSR;
  wire       [31:0]   _zz__zz_decode_IS_CSR_1;
  wire       [31:0]   _zz__zz_decode_IS_CSR_2;
  wire       [31:0]   _zz__zz_decode_IS_CSR_3;
  wire                _zz__zz_decode_IS_CSR_4;
  wire                _zz__zz_decode_IS_CSR_5;
  wire       [0:0]    _zz__zz_decode_IS_CSR_6;
  wire                _zz__zz_decode_IS_CSR_7;
  wire       [31:0]   _zz__zz_decode_IS_CSR_8;
  wire       [31:0]   _zz__zz_decode_IS_CSR_9;
  wire       [31:0]   _zz__zz_decode_IS_CSR_10;
  wire       [31:0]   _zz__zz_decode_IS_CSR_11;
  wire       [0:0]    _zz__zz_decode_IS_CSR_12;
  wire       [31:0]   _zz__zz_decode_IS_CSR_13;
  wire       [31:0]   _zz__zz_decode_IS_CSR_14;
  wire       [31:0]   _zz__zz_decode_IS_CSR_15;
  wire       [0:0]    _zz__zz_decode_IS_CSR_16;
  wire                _zz__zz_decode_IS_CSR_17;
  wire       [0:0]    _zz__zz_decode_IS_CSR_18;
  wire       [31:0]   _zz__zz_decode_IS_CSR_19;
  wire       [27:0]   _zz__zz_decode_IS_CSR_20;
  wire       [31:0]   _zz__zz_decode_IS_CSR_21;
  wire       [31:0]   _zz__zz_decode_IS_CSR_22;
  wire                _zz__zz_decode_IS_CSR_23;
  wire       [1:0]    _zz__zz_decode_IS_CSR_24;
  wire       [31:0]   _zz__zz_decode_IS_CSR_25;
  wire       [31:0]   _zz__zz_decode_IS_CSR_26;
  wire                _zz__zz_decode_IS_CSR_27;
  wire       [31:0]   _zz__zz_decode_IS_CSR_28;
  wire       [0:0]    _zz__zz_decode_IS_CSR_29;
  wire       [31:0]   _zz__zz_decode_IS_CSR_30;
  wire       [31:0]   _zz__zz_decode_IS_CSR_31;
  wire       [22:0]   _zz__zz_decode_IS_CSR_32;
  wire       [0:0]    _zz__zz_decode_IS_CSR_33;
  wire       [0:0]    _zz__zz_decode_IS_CSR_34;
  wire       [0:0]    _zz__zz_decode_IS_CSR_35;
  wire                _zz__zz_decode_IS_CSR_36;
  wire       [31:0]   _zz__zz_decode_IS_CSR_37;
  wire       [0:0]    _zz__zz_decode_IS_CSR_38;
  wire       [31:0]   _zz__zz_decode_IS_CSR_39;
  wire       [31:0]   _zz__zz_decode_IS_CSR_40;
  wire       [18:0]   _zz__zz_decode_IS_CSR_41;
  wire       [0:0]    _zz__zz_decode_IS_CSR_42;
  wire       [31:0]   _zz__zz_decode_IS_CSR_43;
  wire       [2:0]    _zz__zz_decode_IS_CSR_44;
  wire       [31:0]   _zz__zz_decode_IS_CSR_45;
  wire       [31:0]   _zz__zz_decode_IS_CSR_46;
  wire                _zz__zz_decode_IS_CSR_47;
  wire                _zz__zz_decode_IS_CSR_48;
  wire       [0:0]    _zz__zz_decode_IS_CSR_49;
  wire       [31:0]   _zz__zz_decode_IS_CSR_50;
  wire                _zz__zz_decode_IS_CSR_51;
  wire       [31:0]   _zz__zz_decode_IS_CSR_52;
  wire       [31:0]   _zz__zz_decode_IS_CSR_53;
  wire       [0:0]    _zz__zz_decode_IS_CSR_54;
  wire       [0:0]    _zz__zz_decode_IS_CSR_55;
  wire       [31:0]   _zz__zz_decode_IS_CSR_56;
  wire       [4:0]    _zz__zz_decode_IS_CSR_57;
  wire       [31:0]   _zz__zz_decode_IS_CSR_58;
  wire       [31:0]   _zz__zz_decode_IS_CSR_59;
  wire                _zz__zz_decode_IS_CSR_60;
  wire       [31:0]   _zz__zz_decode_IS_CSR_61;
  wire       [0:0]    _zz__zz_decode_IS_CSR_62;
  wire       [1:0]    _zz__zz_decode_IS_CSR_63;
  wire                _zz__zz_decode_IS_CSR_64;
  wire       [31:0]   _zz__zz_decode_IS_CSR_65;
  wire       [14:0]   _zz__zz_decode_IS_CSR_66;
  wire       [2:0]    _zz__zz_decode_IS_CSR_67;
  wire       [31:0]   _zz__zz_decode_IS_CSR_68;
  wire       [31:0]   _zz__zz_decode_IS_CSR_69;
  wire                _zz__zz_decode_IS_CSR_70;
  wire       [31:0]   _zz__zz_decode_IS_CSR_71;
  wire                _zz__zz_decode_IS_CSR_72;
  wire       [31:0]   _zz__zz_decode_IS_CSR_73;
  wire                _zz__zz_decode_IS_CSR_74;
  wire                _zz__zz_decode_IS_CSR_75;
  wire       [31:0]   _zz__zz_decode_IS_CSR_76;
  wire       [0:0]    _zz__zz_decode_IS_CSR_77;
  wire       [31:0]   _zz__zz_decode_IS_CSR_78;
  wire       [31:0]   _zz__zz_decode_IS_CSR_79;
  wire       [2:0]    _zz__zz_decode_IS_CSR_80;
  wire                _zz__zz_decode_IS_CSR_81;
  wire       [31:0]   _zz__zz_decode_IS_CSR_82;
  wire       [0:0]    _zz__zz_decode_IS_CSR_83;
  wire       [31:0]   _zz__zz_decode_IS_CSR_84;
  wire       [31:0]   _zz__zz_decode_IS_CSR_85;
  wire       [0:0]    _zz__zz_decode_IS_CSR_86;
  wire       [0:0]    _zz__zz_decode_IS_CSR_87;
  wire       [0:0]    _zz__zz_decode_IS_CSR_88;
  wire       [3:0]    _zz__zz_decode_IS_CSR_89;
  wire                _zz__zz_decode_IS_CSR_90;
  wire       [31:0]   _zz__zz_decode_IS_CSR_91;
  wire       [0:0]    _zz__zz_decode_IS_CSR_92;
  wire       [31:0]   _zz__zz_decode_IS_CSR_93;
  wire       [31:0]   _zz__zz_decode_IS_CSR_94;
  wire       [1:0]    _zz__zz_decode_IS_CSR_95;
  wire                _zz__zz_decode_IS_CSR_96;
  wire       [31:0]   _zz__zz_decode_IS_CSR_97;
  wire                _zz__zz_decode_IS_CSR_98;
  wire       [31:0]   _zz__zz_decode_IS_CSR_99;
  wire       [11:0]   _zz__zz_decode_IS_CSR_100;
  wire       [6:0]    _zz__zz_decode_IS_CSR_101;
  wire       [0:0]    _zz__zz_decode_IS_CSR_102;
  wire       [31:0]   _zz__zz_decode_IS_CSR_103;
  wire       [31:0]   _zz__zz_decode_IS_CSR_104;
  wire       [4:0]    _zz__zz_decode_IS_CSR_105;
  wire                _zz__zz_decode_IS_CSR_106;
  wire       [31:0]   _zz__zz_decode_IS_CSR_107;
  wire       [0:0]    _zz__zz_decode_IS_CSR_108;
  wire       [31:0]   _zz__zz_decode_IS_CSR_109;
  wire       [31:0]   _zz__zz_decode_IS_CSR_110;
  wire       [2:0]    _zz__zz_decode_IS_CSR_111;
  wire                _zz__zz_decode_IS_CSR_112;
  wire       [0:0]    _zz__zz_decode_IS_CSR_113;
  wire       [0:0]    _zz__zz_decode_IS_CSR_114;
  wire       [31:0]   _zz__zz_decode_IS_CSR_115;
  wire                _zz__zz_decode_IS_CSR_116;
  wire       [0:0]    _zz__zz_decode_IS_CSR_117;
  wire       [0:0]    _zz__zz_decode_IS_CSR_118;
  wire       [31:0]   _zz__zz_decode_IS_CSR_119;
  wire       [31:0]   _zz__zz_decode_IS_CSR_120;
  wire       [0:0]    _zz__zz_decode_IS_CSR_121;
  wire       [1:0]    _zz__zz_decode_IS_CSR_122;
  wire                _zz__zz_decode_IS_CSR_123;
  wire       [31:0]   _zz__zz_decode_IS_CSR_124;
  wire       [8:0]    _zz__zz_decode_IS_CSR_125;
  wire                _zz__zz_decode_IS_CSR_126;
  wire                _zz__zz_decode_IS_CSR_127;
  wire       [31:0]   _zz__zz_decode_IS_CSR_128;
  wire       [0:0]    _zz__zz_decode_IS_CSR_129;
  wire       [0:0]    _zz__zz_decode_IS_CSR_130;
  wire       [31:0]   _zz__zz_decode_IS_CSR_131;
  wire       [31:0]   _zz__zz_decode_IS_CSR_132;
  wire       [6:0]    _zz__zz_decode_IS_CSR_133;
  wire                _zz__zz_decode_IS_CSR_134;
  wire       [0:0]    _zz__zz_decode_IS_CSR_135;
  wire       [31:0]   _zz__zz_decode_IS_CSR_136;
  wire       [4:0]    _zz__zz_decode_IS_CSR_137;
  wire                _zz__zz_decode_IS_CSR_138;
  wire       [31:0]   _zz__zz_decode_IS_CSR_139;
  wire       [0:0]    _zz__zz_decode_IS_CSR_140;
  wire       [31:0]   _zz__zz_decode_IS_CSR_141;
  wire       [31:0]   _zz__zz_decode_IS_CSR_142;
  wire       [1:0]    _zz__zz_decode_IS_CSR_143;
  wire                _zz__zz_decode_IS_CSR_144;
  wire       [0:0]    _zz__zz_decode_IS_CSR_145;
  wire       [1:0]    _zz__zz_decode_IS_CSR_146;
  wire       [31:0]   _zz__zz_decode_IS_CSR_147;
  wire       [31:0]   _zz__zz_decode_IS_CSR_148;
  wire       [4:0]    _zz__zz_decode_IS_CSR_149;
  wire                _zz__zz_decode_IS_CSR_150;
  wire                _zz__zz_decode_IS_CSR_151;
  wire       [31:0]   _zz__zz_decode_IS_CSR_152;
  wire       [0:0]    _zz__zz_decode_IS_CSR_153;
  wire       [31:0]   _zz__zz_decode_IS_CSR_154;
  wire       [31:0]   _zz__zz_decode_IS_CSR_155;
  wire       [0:0]    _zz__zz_decode_IS_CSR_156;
  wire       [31:0]   _zz__zz_decode_IS_CSR_157;
  wire       [31:0]   _zz__zz_decode_IS_CSR_158;
  wire       [0:0]    _zz__zz_decode_IS_CSR_159;
  wire       [0:0]    _zz__zz_decode_IS_CSR_160;
  wire       [1:0]    _zz__zz_decode_IS_CSR_161;
  wire                _zz__zz_decode_IS_CSR_162;
  wire       [2:0]    _zz__zz_decode_IS_CSR_163;
  wire       [1:0]    _zz__zz_decode_IS_CSR_164;
  wire                _zz__zz_decode_IS_CSR_165;
  wire                _zz__zz_decode_IS_CSR_166;
  wire       [0:0]    _zz__zz_decode_IS_CSR_167;
  wire       [0:0]    _zz__zz_decode_IS_CSR_168;
  wire                _zz__zz_decode_IS_CSR_169;
  wire                _zz_RegFilePlugin_regFile_port;
  wire                _zz_decode_RegFilePlugin_rs1Data;
  wire                _zz_RegFilePlugin_regFile_port_1;
  wire                _zz_decode_RegFilePlugin_rs2Data;
  wire       [0:0]    _zz__zz_execute_REGFILE_WRITE_DATA;
  wire       [2:0]    _zz__zz_execute_SRC1;
  wire       [4:0]    _zz__zz_execute_SRC1_1;
  wire       [11:0]   _zz__zz_execute_SRC2_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_1;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_3;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_4;
  wire       [65:0]   _zz_writeBack_MulPlugin_result;
  wire       [65:0]   _zz_writeBack_MulPlugin_result_1;
  wire       [31:0]   _zz__zz_decode_RS2_2;
  wire       [31:0]   _zz__zz_decode_RS2_2_1;
  wire       [5:0]    _zz_memory_DivPlugin_div_counter_valueNext;
  wire       [0:0]    _zz_memory_DivPlugin_div_counter_valueNext_1;
  wire       [32:0]   _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator;
  wire       [31:0]   _zz_memory_DivPlugin_div_stage_0_outRemainder;
  wire       [31:0]   _zz_memory_DivPlugin_div_stage_0_outRemainder_1;
  wire       [32:0]   _zz_memory_DivPlugin_div_stage_0_outNumerator;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_1;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_2;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_3;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_4;
  wire       [0:0]    _zz_memory_DivPlugin_div_result_5;
  wire       [32:0]   _zz_memory_DivPlugin_rs1_2;
  wire       [0:0]    _zz_memory_DivPlugin_rs1_3;
  wire       [31:0]   _zz_memory_DivPlugin_rs2_1;
  wire       [0:0]    _zz_memory_DivPlugin_rs2_2;
  wire       [19:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_2;
  wire       [11:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_4;
  wire       [31:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_6;
  wire       [31:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1;
  wire       [31:0]   _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2;
  wire       [19:0]   _zz__zz_execute_BranchPlugin_branch_src2_2;
  wire       [11:0]   _zz__zz_execute_BranchPlugin_branch_src2_4;
  wire       [0:0]    _zz_execute_BranchPlugin_branch_src2_6;
  wire       [7:0]    _zz_execute_BranchPlugin_branch_src2_7;
  wire                _zz_execute_BranchPlugin_branch_src2_8;
  wire       [0:0]    _zz_execute_BranchPlugin_branch_src2_9;
  wire       [0:0]    _zz_execute_BranchPlugin_branch_src2_10;
  wire       [2:0]    _zz_execute_BranchPlugin_branch_src2_11;
  wire       [1:0]    _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
  wire       [1:0]    _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1;
  wire                _zz_when;
  wire       [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_25;
  wire       [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_26;
  wire       [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_27;
  wire       [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_28;
  wire       [51:0]   memory_MUL_LOW;
  wire       [31:0]   execute_BRANCH_CALC;
  wire                execute_BRANCH_DO;
  wire       [33:0]   memory_MUL_HH;
  wire       [33:0]   execute_MUL_HH;
  wire       [33:0]   execute_MUL_HL;
  wire       [33:0]   execute_MUL_LH;
  wire       [31:0]   execute_MUL_LL;
  wire       [31:0]   execute_SHIFT_RIGHT;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [31:0]   memory_MEMORY_STORE_DATA_RF;
  wire       [31:0]   execute_MEMORY_STORE_DATA_RF;
  wire                decode_CSR_READ_OPCODE;
  wire                decode_CSR_WRITE_OPCODE;
  wire                decode_PREDICTION_HAD_BRANCHED1;
  wire                decode_DO_EBREAK;
  wire                decode_SRC2_FORCE_ZERO;
  wire                decode_IS_CSR;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL_1;
  wire       [2:0]    _zz_memory_to_writeBack_ENV_CTRL;
  wire       [2:0]    _zz_memory_to_writeBack_ENV_CTRL_1;
  wire       [2:0]    _zz_execute_to_memory_ENV_CTRL;
  wire       [2:0]    _zz_execute_to_memory_ENV_CTRL_1;
  wire       [2:0]    decode_ENV_CTRL;
  wire       [2:0]    _zz_decode_ENV_CTRL;
  wire       [2:0]    _zz_decode_to_execute_ENV_CTRL;
  wire       [2:0]    _zz_decode_to_execute_ENV_CTRL_1;
  wire                decode_IS_RS2_SIGNED;
  wire                decode_IS_RS1_SIGNED;
  wire                decode_IS_DIV;
  wire                memory_IS_MUL;
  wire                execute_IS_MUL;
  wire                decode_IS_MUL;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL_1;
  wire       [1:0]    decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL_1;
  wire       [1:0]    decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  wire                decode_SRC_LESS_UNSIGNED;
  wire                decode_IS_SFENCE_VMA2;
  wire                decode_MEMORY_MANAGMENT;
  wire                memory_MEMORY_LRSC;
  wire                memory_MEMORY_WR;
  wire                decode_MEMORY_WR;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire       [1:0]    decode_SRC2_CTRL;
  wire       [1:0]    _zz_decode_SRC2_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC2_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC2_CTRL_1;
  wire       [1:0]    decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL_1;
  wire       [1:0]    decode_SRC1_CTRL;
  wire       [1:0]    _zz_decode_SRC1_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC1_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SRC1_CTRL_1;
  wire                decode_RESCHEDULE_NEXT;
  wire                decode_MEMORY_FORCE_CONSTISTENCY;
  wire       [31:0]   writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire                execute_CSR_READ_OPCODE;
  wire                execute_CSR_WRITE_OPCODE;
  wire                execute_IS_CSR;
  wire       [2:0]    memory_ENV_CTRL;
  wire       [2:0]    _zz_memory_ENV_CTRL;
  wire       [2:0]    execute_ENV_CTRL;
  wire       [2:0]    _zz_execute_ENV_CTRL;
  wire       [2:0]    writeBack_ENV_CTRL;
  wire       [2:0]    _zz_writeBack_ENV_CTRL;
  wire                execute_RESCHEDULE_NEXT;
  wire       [31:0]   memory_BRANCH_CALC;
  wire                memory_BRANCH_DO;
  wire                execute_PREDICTION_HAD_BRANCHED1;
  wire                execute_BRANCH_COND_RESULT;
  wire       [1:0]    execute_BRANCH_CTRL;
  wire       [1:0]    _zz_execute_BRANCH_CTRL;
  wire       [31:0]   execute_PC;
  wire                execute_DO_EBREAK;
  wire                decode_IS_EBREAK;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  reg        [31:0]   _zz_decode_RS2;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire                memory_REGFILE_WRITE_VALID;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  reg        [31:0]   decode_RS2;
  reg        [31:0]   decode_RS1;
  wire                execute_IS_RS1_SIGNED;
  wire                execute_IS_DIV;
  wire                execute_IS_RS2_SIGNED;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_IS_DIV;
  wire                writeBack_IS_MUL;
  wire       [33:0]   writeBack_MUL_HH;
  wire       [51:0]   writeBack_MUL_LOW;
  wire       [33:0]   memory_MUL_HL;
  wire       [33:0]   memory_MUL_LH;
  wire       [31:0]   memory_MUL_LL;
  wire       [31:0]   memory_SHIFT_RIGHT;
  reg        [31:0]   _zz_decode_RS2_1;
  wire       [1:0]    memory_SHIFT_CTRL;
  wire       [1:0]    _zz_memory_SHIFT_CTRL;
  wire       [1:0]    execute_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_SHIFT_CTRL;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_execute_to_memory_PC;
  wire       [1:0]    execute_SRC2_CTRL;
  wire       [1:0]    _zz_execute_SRC2_CTRL;
  wire       [1:0]    execute_SRC1_CTRL;
  wire       [1:0]    _zz_execute_SRC1_CTRL;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       [1:0]    execute_ALU_CTRL;
  wire       [1:0]    _zz_execute_ALU_CTRL;
  wire       [31:0]   execute_SRC2;
  wire       [31:0]   execute_SRC1;
  wire       [1:0]    execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_execute_ALU_BITWISE_CTRL;
  wire       [31:0]   _zz_lastStageRegFileWrite_payload_address;
  wire                _zz_lastStageRegFileWrite_valid;
  reg                 _zz_1;
  wire       [31:0]   decode_INSTRUCTION_ANTICIPATED;
  reg                 decode_REGFILE_WRITE_VALID;
  wire                decode_LEGAL_INSTRUCTION;
  wire       [1:0]    _zz_decode_BRANCH_CTRL;
  wire       [2:0]    _zz_decode_ENV_CTRL_1;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_1;
  wire       [1:0]    _zz_decode_SRC2_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_CTRL_1;
  wire       [1:0]    _zz_decode_SRC1_CTRL_1;
  wire                execute_IS_SFENCE_VMA2;
  wire                writeBack_IS_DBUS_SHARING;
  wire                execute_IS_DBUS_SHARING;
  wire                memory_IS_DBUS_SHARING;
  reg        [31:0]   _zz_decode_RS2_2;
  wire                writeBack_MEMORY_LRSC;
  wire                writeBack_MEMORY_WR;
  wire       [31:0]   writeBack_MEMORY_STORE_DATA_RF;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire                writeBack_MEMORY_ENABLE;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire                memory_MEMORY_ENABLE;
  reg                 execute_MEMORY_AMO;
  reg                 execute_MEMORY_LRSC;
  wire                execute_MEMORY_FORCE_CONSTISTENCY;
  (* keep , syn_keep *) wire       [31:0]   execute_RS1 /* synthesis syn_keep = 1 */ ;
  wire                execute_MEMORY_MANAGMENT;
  (* keep , syn_keep *) wire       [31:0]   execute_RS2 /* synthesis syn_keep = 1 */ ;
  wire                execute_MEMORY_WR;
  wire       [31:0]   execute_SRC_ADD;
  wire                execute_MEMORY_ENABLE;
  wire       [31:0]   execute_INSTRUCTION;
  wire                decode_MEMORY_AMO;
  wire                decode_MEMORY_LRSC;
  reg                 _zz_decode_MEMORY_FORCE_CONSTISTENCY;
  wire                decode_MEMORY_ENABLE;
  wire                decode_FLUSH_ALL;
  reg                 IBusCachedPlugin_rsp_issueDetected_4;
  reg                 IBusCachedPlugin_rsp_issueDetected_3;
  reg                 IBusCachedPlugin_rsp_issueDetected_2;
  reg                 IBusCachedPlugin_rsp_issueDetected_1;
  wire       [1:0]    decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_1;
  wire       [31:0]   decode_INSTRUCTION;
  reg        [31:0]   _zz_execute_to_memory_FORMAL_PC_NEXT;
  reg        [31:0]   _zz_memory_to_writeBack_FORMAL_PC_NEXT;
  reg        [31:0]   _zz_decode_to_execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_PC;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  reg                 decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  reg                 decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  reg                 execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  reg                 execute_arbitration_flushIt;
  reg                 execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  reg                 memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  reg                 memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  reg                 writeBack_arbitration_haltItself;
  wire                writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  reg                 writeBack_arbitration_flushIt;
  reg                 writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  reg                 IBusCachedPlugin_fetcherHalt;
  wire                IBusCachedPlugin_forceNoDecodeCond;
  reg                 IBusCachedPlugin_incomingInstruction;
  wire                IBusCachedPlugin_predictionJumpInterface_valid;
  (* keep , syn_keep *) wire       [31:0]   IBusCachedPlugin_predictionJumpInterface_payload /* synthesis syn_keep = 1 */ ;
  reg                 IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  wire                IBusCachedPlugin_decodePrediction_rsp_wasWrong;
  wire                IBusCachedPlugin_pcValids_0;
  wire                IBusCachedPlugin_pcValids_1;
  wire                IBusCachedPlugin_pcValids_2;
  wire                IBusCachedPlugin_pcValids_3;
  reg                 IBusCachedPlugin_decodeExceptionPort_valid;
  reg        [3:0]    IBusCachedPlugin_decodeExceptionPort_payload_code;
  wire       [31:0]   IBusCachedPlugin_decodeExceptionPort_payload_badAddr;
  wire                IBusCachedPlugin_mmuBus_cmd_0_isValid;
  wire                IBusCachedPlugin_mmuBus_cmd_0_isStuck;
  wire       [31:0]   IBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  wire                IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
  wire                IBusCachedPlugin_mmuBus_cmd_1_isValid;
  wire                IBusCachedPlugin_mmuBus_cmd_1_isStuck;
  wire       [31:0]   IBusCachedPlugin_mmuBus_cmd_1_virtualAddress;
  wire                IBusCachedPlugin_mmuBus_cmd_1_bypassTranslation;
  reg        [31:0]   IBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire                IBusCachedPlugin_mmuBus_rsp_isIoAccess;
  reg                 IBusCachedPlugin_mmuBus_rsp_isPaging;
  reg                 IBusCachedPlugin_mmuBus_rsp_allowRead;
  reg                 IBusCachedPlugin_mmuBus_rsp_allowWrite;
  reg                 IBusCachedPlugin_mmuBus_rsp_allowExecute;
  reg                 IBusCachedPlugin_mmuBus_rsp_exception;
  reg                 IBusCachedPlugin_mmuBus_rsp_refilling;
  wire                IBusCachedPlugin_mmuBus_rsp_bypassTranslation;
  wire                IBusCachedPlugin_mmuBus_rsp_ways_0_sel;
  wire       [31:0]   IBusCachedPlugin_mmuBus_rsp_ways_0_physical;
  wire                IBusCachedPlugin_mmuBus_rsp_ways_1_sel;
  wire       [31:0]   IBusCachedPlugin_mmuBus_rsp_ways_1_physical;
  wire                IBusCachedPlugin_mmuBus_rsp_ways_2_sel;
  wire       [31:0]   IBusCachedPlugin_mmuBus_rsp_ways_2_physical;
  wire                IBusCachedPlugin_mmuBus_rsp_ways_3_sel;
  wire       [31:0]   IBusCachedPlugin_mmuBus_rsp_ways_3_physical;
  wire                IBusCachedPlugin_mmuBus_end;
  wire                IBusCachedPlugin_mmuBus_busy;
  wire                dBus_cmd_valid;
  wire                dBus_cmd_ready;
  wire                dBus_cmd_payload_wr;
  wire                dBus_cmd_payload_uncached;
  wire       [31:0]   dBus_cmd_payload_address;
  wire       [31:0]   dBus_cmd_payload_data;
  wire       [3:0]    dBus_cmd_payload_mask;
  wire       [2:0]    dBus_cmd_payload_size;
  wire                dBus_cmd_payload_last;
  wire                dBus_rsp_valid;
  wire                dBus_rsp_payload_last;
  wire       [31:0]   dBus_rsp_payload_data;
  wire                dBus_rsp_payload_error;
  wire                DBusCachedPlugin_mmuBus_cmd_0_isValid;
  wire                DBusCachedPlugin_mmuBus_cmd_0_isStuck;
  wire       [31:0]   DBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  reg                 DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
  wire                DBusCachedPlugin_mmuBus_cmd_1_isValid;
  wire                DBusCachedPlugin_mmuBus_cmd_1_isStuck;
  wire       [31:0]   DBusCachedPlugin_mmuBus_cmd_1_virtualAddress;
  reg                 DBusCachedPlugin_mmuBus_cmd_1_bypassTranslation;
  reg        [31:0]   DBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire                DBusCachedPlugin_mmuBus_rsp_isIoAccess;
  reg                 DBusCachedPlugin_mmuBus_rsp_isPaging;
  reg                 DBusCachedPlugin_mmuBus_rsp_allowRead;
  reg                 DBusCachedPlugin_mmuBus_rsp_allowWrite;
  reg                 DBusCachedPlugin_mmuBus_rsp_allowExecute;
  reg                 DBusCachedPlugin_mmuBus_rsp_exception;
  reg                 DBusCachedPlugin_mmuBus_rsp_refilling;
  wire                DBusCachedPlugin_mmuBus_rsp_bypassTranslation;
  wire                DBusCachedPlugin_mmuBus_rsp_ways_0_sel;
  wire       [31:0]   DBusCachedPlugin_mmuBus_rsp_ways_0_physical;
  wire                DBusCachedPlugin_mmuBus_rsp_ways_1_sel;
  wire       [31:0]   DBusCachedPlugin_mmuBus_rsp_ways_1_physical;
  wire                DBusCachedPlugin_mmuBus_rsp_ways_2_sel;
  wire       [31:0]   DBusCachedPlugin_mmuBus_rsp_ways_2_physical;
  wire                DBusCachedPlugin_mmuBus_rsp_ways_3_sel;
  wire       [31:0]   DBusCachedPlugin_mmuBus_rsp_ways_3_physical;
  wire                DBusCachedPlugin_mmuBus_end;
  wire                DBusCachedPlugin_mmuBus_busy;
  reg                 DBusCachedPlugin_redoBranch_valid;
  wire       [31:0]   DBusCachedPlugin_redoBranch_payload;
  reg                 DBusCachedPlugin_exceptionBus_valid;
  reg        [3:0]    DBusCachedPlugin_exceptionBus_payload_code;
  wire       [31:0]   DBusCachedPlugin_exceptionBus_payload_badAddr;
  reg                 _zz_when_DBusCachedPlugin_l473;
  reg                 MmuPlugin_dBusAccess_cmd_valid;
  reg                 MmuPlugin_dBusAccess_cmd_ready;
  reg        [31:0]   MmuPlugin_dBusAccess_cmd_payload_address;
  wire       [1:0]    MmuPlugin_dBusAccess_cmd_payload_size;
  wire                MmuPlugin_dBusAccess_cmd_payload_write;
  wire       [31:0]   MmuPlugin_dBusAccess_cmd_payload_data;
  wire       [3:0]    MmuPlugin_dBusAccess_cmd_payload_writeMask;
  wire                MmuPlugin_dBusAccess_rsp_valid;
  wire       [31:0]   MmuPlugin_dBusAccess_rsp_payload_data;
  wire                MmuPlugin_dBusAccess_rsp_payload_error;
  wire                MmuPlugin_dBusAccess_rsp_payload_redo;
  wire                decodeExceptionPort_valid;
  wire       [3:0]    decodeExceptionPort_payload_code;
  wire       [31:0]   decodeExceptionPort_payload_badAddr;
  wire                debug_bus_cmd_valid;
  reg                 debug_bus_cmd_ready;
  wire                debug_bus_cmd_payload_wr;
  wire       [7:0]    debug_bus_cmd_payload_address;
  wire       [31:0]   debug_bus_cmd_payload_data;
  reg        [31:0]   debug_bus_rsp_data;
  reg                 DebugPlugin_injectionPort_valid;
  reg                 DebugPlugin_injectionPort_ready;
  wire       [31:0]   DebugPlugin_injectionPort_payload;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  wire                BranchPlugin_branchExceptionPort_valid;
  wire       [3:0]    BranchPlugin_branchExceptionPort_payload_code;
  wire       [31:0]   BranchPlugin_branchExceptionPort_payload_badAddr;
  reg                 BranchPlugin_inDebugNoFetchFlag;
  wire       [31:0]   CsrPlugin_csrMapping_readDataSignal;
  wire       [31:0]   CsrPlugin_csrMapping_readDataInit;
  wire       [31:0]   CsrPlugin_csrMapping_writeDataSignal;
  reg                 CsrPlugin_csrMapping_allowCsrSignal;
  wire                CsrPlugin_csrMapping_hazardFree;
  reg                 CsrPlugin_csrMapping_doForceFailCsr;
  reg                 CsrPlugin_inWfi /* verilator public */ ;
  reg                 CsrPlugin_thirdPartyWake;
  reg                 CsrPlugin_jumpInterface_valid;
  reg        [31:0]   CsrPlugin_jumpInterface_payload;
  reg                 CsrPlugin_redoInterface_valid;
  wire       [31:0]   CsrPlugin_redoInterface_payload;
  wire                CsrPlugin_exceptionPendings_0;
  wire                CsrPlugin_exceptionPendings_1;
  wire                CsrPlugin_exceptionPendings_2;
  wire                CsrPlugin_exceptionPendings_3;
  wire                timerInterrupt;
  wire                externalInterrupt;
  wire                softwareInterrupt;
  wire                externalInterruptS;
  wire                contextSwitching;
  reg        [1:0]    CsrPlugin_privilege;
  reg                 CsrPlugin_forceMachineWire;
  reg                 CsrPlugin_selfException_valid;
  reg        [3:0]    CsrPlugin_selfException_payload_code;
  wire       [31:0]   CsrPlugin_selfException_payload_badAddr;
  reg                 CsrPlugin_allowInterrupts;
  reg                 CsrPlugin_allowException;
  reg                 CsrPlugin_allowEbreakException;
  wire       [63:0]   utime;
  reg                 CsrPlugin_xretAwayFromMachine;
  wire                IBusCachedPlugin_externalFlush;
  wire                IBusCachedPlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusCachedPlugin_jump_pcLoad_payload;
  wire       [4:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload;
  wire       [4:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload_1;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_2;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_3;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_4;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_5;
  wire                IBusCachedPlugin_fetchPc_output_valid;
  wire                IBusCachedPlugin_fetchPc_output_ready;
  wire       [31:0]   IBusCachedPlugin_fetchPc_output_payload;
  reg        [31:0]   IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusCachedPlugin_fetchPc_correction;
  reg                 IBusCachedPlugin_fetchPc_correctionReg;
  wire                IBusCachedPlugin_fetchPc_output_fire;
  wire                IBusCachedPlugin_fetchPc_corrected;
  reg                 IBusCachedPlugin_fetchPc_pcRegPropagate;
  reg                 IBusCachedPlugin_fetchPc_booted;
  reg                 IBusCachedPlugin_fetchPc_inc;
  wire                when_Fetcher_l133;
  wire                when_Fetcher_l133_1;
  reg        [31:0]   IBusCachedPlugin_fetchPc_pc;
  wire                IBusCachedPlugin_fetchPc_redo_valid;
  wire       [31:0]   IBusCachedPlugin_fetchPc_redo_payload;
  reg                 IBusCachedPlugin_fetchPc_flushed;
  wire                when_Fetcher_l160;
  reg                 IBusCachedPlugin_iBusRsp_redoFetch;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_output_payload;
  reg                 IBusCachedPlugin_iBusRsp_stages_0_halt;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_1_halt;
  wire                IBusCachedPlugin_iBusRsp_stages_2_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_2_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_2_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_2_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_2_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_2_output_payload;
  reg                 IBusCachedPlugin_iBusRsp_stages_2_halt;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_payload;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_payload;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready;
  wire                IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_payload;
  wire                IBusCachedPlugin_iBusRsp_flush;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_ready;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_ready;
  reg                 _zz_IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  reg                 _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  reg        [31:0]   _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  reg                 IBusCachedPlugin_iBusRsp_readyForError;
  wire                IBusCachedPlugin_iBusRsp_output_valid;
  wire                IBusCachedPlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_output_payload_pc;
  wire                IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusCachedPlugin_iBusRsp_output_payload_isRvc;
  wire                when_Fetcher_l242;
  wire                when_Fetcher_l322;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_0;
  wire                when_Fetcher_l331;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_1;
  wire                when_Fetcher_l331_1;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_2;
  wire                when_Fetcher_l331_2;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_3;
  wire                when_Fetcher_l331_3;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_4;
  wire                when_Fetcher_l331_4;
  wire                _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  reg        [18:0]   _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1;
  wire                _zz_2;
  reg        [10:0]   _zz_3;
  wire                _zz_4;
  reg        [18:0]   _zz_5;
  reg                 _zz_6;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload;
  reg        [10:0]   _zz_IBusCachedPlugin_predictionJumpInterface_payload_1;
  wire                _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
  reg        [18:0]   _zz_IBusCachedPlugin_predictionJumpInterface_payload_3;
  wire                iBus_cmd_valid;
  wire                iBus_cmd_ready;
  reg        [31:0]   iBus_cmd_payload_address;
  wire       [2:0]    iBus_cmd_payload_size;
  wire                iBus_rsp_valid;
  wire       [31:0]   iBus_rsp_payload_data;
  wire                iBus_rsp_payload_error;
  reg        [31:0]   IBusCachedPlugin_rspCounter;
  wire                IBusCachedPlugin_s0_tightlyCoupledHit;
  reg                 IBusCachedPlugin_s1_tightlyCoupledHit;
  reg                 IBusCachedPlugin_s2_tightlyCoupledHit;
  wire                IBusCachedPlugin_rsp_iBusRspOutputHalt;
  wire                IBusCachedPlugin_rsp_issueDetected;
  reg                 IBusCachedPlugin_rsp_redoFetch;
  wire                when_IBusCachedPlugin_l245;
  wire                when_IBusCachedPlugin_l250;
  wire                when_IBusCachedPlugin_l256;
  wire                when_IBusCachedPlugin_l262;
  wire                when_IBusCachedPlugin_l273;
  wire                io_mem_cmd_s2mPipe_valid;
  reg                 io_mem_cmd_s2mPipe_ready;
  wire                io_mem_cmd_s2mPipe_payload_wr;
  wire                io_mem_cmd_s2mPipe_payload_uncached;
  wire       [31:0]   io_mem_cmd_s2mPipe_payload_address;
  wire       [31:0]   io_mem_cmd_s2mPipe_payload_data;
  wire       [3:0]    io_mem_cmd_s2mPipe_payload_mask;
  wire       [2:0]    io_mem_cmd_s2mPipe_payload_size;
  wire                io_mem_cmd_s2mPipe_payload_last;
  reg                 io_mem_cmd_rValidN;
  reg                 io_mem_cmd_rData_wr;
  reg                 io_mem_cmd_rData_uncached;
  reg        [31:0]   io_mem_cmd_rData_address;
  reg        [31:0]   io_mem_cmd_rData_data;
  reg        [3:0]    io_mem_cmd_rData_mask;
  reg        [2:0]    io_mem_cmd_rData_size;
  reg                 io_mem_cmd_rData_last;
  wire                io_mem_cmd_s2mPipe_m2sPipe_valid;
  wire                io_mem_cmd_s2mPipe_m2sPipe_ready;
  wire                io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  wire                io_mem_cmd_s2mPipe_m2sPipe_payload_uncached;
  wire       [31:0]   io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  wire       [31:0]   io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  wire       [3:0]    io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  wire       [2:0]    io_mem_cmd_s2mPipe_m2sPipe_payload_size;
  wire                io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  reg                 io_mem_cmd_s2mPipe_rValid;
  reg                 io_mem_cmd_s2mPipe_rData_wr;
  reg                 io_mem_cmd_s2mPipe_rData_uncached;
  reg        [31:0]   io_mem_cmd_s2mPipe_rData_address;
  reg        [31:0]   io_mem_cmd_s2mPipe_rData_data;
  reg        [3:0]    io_mem_cmd_s2mPipe_rData_mask;
  reg        [2:0]    io_mem_cmd_s2mPipe_rData_size;
  reg                 io_mem_cmd_s2mPipe_rData_last;
  wire                when_Stream_l477;
  reg                 dBus_rsp_regNext_valid;
  reg                 dBus_rsp_regNext_payload_last;
  reg        [31:0]   dBus_rsp_regNext_payload_data;
  reg                 dBus_rsp_regNext_payload_error;
  reg        [31:0]   DBusCachedPlugin_rspCounter;
  wire                when_DBusCachedPlugin_l353;
  wire                when_DBusCachedPlugin_l361;
  wire       [1:0]    execute_DBusCachedPlugin_size;
  reg        [31:0]   _zz_execute_MEMORY_STORE_DATA_RF;
  wire                io_cpu_flush_isStall;
  wire                when_DBusCachedPlugin_l395;
  wire                when_DBusCachedPlugin_l411;
  wire                when_DBusCachedPlugin_l473;
  wire                when_DBusCachedPlugin_l534;
  wire                when_DBusCachedPlugin_l554;
  wire       [31:0]   writeBack_DBusCachedPlugin_rspData;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_0;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_1;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_2;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_3;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspShifted;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspRf;
  wire                when_DBusCachedPlugin_l571;
  wire       [1:0]    switch_Misc_l245;
  wire                _zz_writeBack_DBusCachedPlugin_rspFormated;
  reg        [31:0]   _zz_writeBack_DBusCachedPlugin_rspFormated_1;
  wire                _zz_writeBack_DBusCachedPlugin_rspFormated_2;
  reg        [31:0]   _zz_writeBack_DBusCachedPlugin_rspFormated_3;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspFormated;
  wire                when_DBusCachedPlugin_l581;
  reg                 DBusCachedPlugin_forceDatapath;
  wire                when_DBusCachedPlugin_l605;
  wire                when_DBusCachedPlugin_l606;
  wire                MmuPlugin_dBusAccess_cmd_fire;
  reg                 MmuPlugin_status_sum;
  reg                 MmuPlugin_status_mxr;
  reg                 MmuPlugin_status_mprv;
  reg                 MmuPlugin_satp_mode;
  reg        [8:0]    MmuPlugin_satp_asid;
  reg        [21:0]   MmuPlugin_satp_ppn;
  reg                 MmuPlugin_ports_0_cache_0_valid;
  reg                 MmuPlugin_ports_0_cache_0_exception;
  reg                 MmuPlugin_ports_0_cache_0_superPage;
  reg        [9:0]    MmuPlugin_ports_0_cache_0_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_0_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_0_cache_0_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_0_physicalAddress_1;
  reg                 MmuPlugin_ports_0_cache_0_allowRead;
  reg                 MmuPlugin_ports_0_cache_0_allowWrite;
  reg                 MmuPlugin_ports_0_cache_0_allowExecute;
  reg                 MmuPlugin_ports_0_cache_0_allowUser;
  reg                 MmuPlugin_ports_0_cache_1_valid;
  reg                 MmuPlugin_ports_0_cache_1_exception;
  reg                 MmuPlugin_ports_0_cache_1_superPage;
  reg        [9:0]    MmuPlugin_ports_0_cache_1_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_1_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_0_cache_1_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_1_physicalAddress_1;
  reg                 MmuPlugin_ports_0_cache_1_allowRead;
  reg                 MmuPlugin_ports_0_cache_1_allowWrite;
  reg                 MmuPlugin_ports_0_cache_1_allowExecute;
  reg                 MmuPlugin_ports_0_cache_1_allowUser;
  reg                 MmuPlugin_ports_0_cache_2_valid;
  reg                 MmuPlugin_ports_0_cache_2_exception;
  reg                 MmuPlugin_ports_0_cache_2_superPage;
  reg        [9:0]    MmuPlugin_ports_0_cache_2_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_2_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_0_cache_2_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_2_physicalAddress_1;
  reg                 MmuPlugin_ports_0_cache_2_allowRead;
  reg                 MmuPlugin_ports_0_cache_2_allowWrite;
  reg                 MmuPlugin_ports_0_cache_2_allowExecute;
  reg                 MmuPlugin_ports_0_cache_2_allowUser;
  reg                 MmuPlugin_ports_0_cache_3_valid;
  reg                 MmuPlugin_ports_0_cache_3_exception;
  reg                 MmuPlugin_ports_0_cache_3_superPage;
  reg        [9:0]    MmuPlugin_ports_0_cache_3_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_3_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_0_cache_3_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_0_cache_3_physicalAddress_1;
  reg                 MmuPlugin_ports_0_cache_3_allowRead;
  reg                 MmuPlugin_ports_0_cache_3_allowWrite;
  reg                 MmuPlugin_ports_0_cache_3_allowExecute;
  reg                 MmuPlugin_ports_0_cache_3_allowUser;
  reg                 MmuPlugin_ports_0_dirty;
  wire                when_MmuPlugin_l117;
  reg                 MmuPlugin_ports_0_requireMmuLockupCalc;
  wire                when_MmuPlugin_l131;
  wire                when_MmuPlugin_l132;
  wire       [3:0]    MmuPlugin_ports_0_cacheHitsCalc;
  wire                when_MmuPlugin_l124;
  reg                 MmuPlugin_ports_0_requireMmuLockup;
  wire                when_MmuPlugin_l124_1;
  reg        [3:0]    MmuPlugin_ports_0_cacheHits;
  wire                MmuPlugin_ports_0_cacheHit;
  wire                _zz_MmuPlugin_ports_0_cacheLine_valid;
  wire                _zz_MmuPlugin_ports_0_cacheLine_valid_1;
  wire                _zz_MmuPlugin_ports_0_cacheLine_valid_2;
  wire       [1:0]    _zz_MmuPlugin_ports_0_cacheLine_valid_3;
  wire                MmuPlugin_ports_0_cacheLine_valid;
  wire                MmuPlugin_ports_0_cacheLine_exception;
  wire                MmuPlugin_ports_0_cacheLine_superPage;
  wire       [9:0]    MmuPlugin_ports_0_cacheLine_virtualAddress_0;
  wire       [9:0]    MmuPlugin_ports_0_cacheLine_virtualAddress_1;
  wire       [9:0]    MmuPlugin_ports_0_cacheLine_physicalAddress_0;
  wire       [9:0]    MmuPlugin_ports_0_cacheLine_physicalAddress_1;
  wire                MmuPlugin_ports_0_cacheLine_allowRead;
  wire                MmuPlugin_ports_0_cacheLine_allowWrite;
  wire                MmuPlugin_ports_0_cacheLine_allowExecute;
  wire                MmuPlugin_ports_0_cacheLine_allowUser;
  reg                 MmuPlugin_ports_0_entryToReplace_willIncrement;
  wire                MmuPlugin_ports_0_entryToReplace_willClear;
  reg        [1:0]    MmuPlugin_ports_0_entryToReplace_valueNext;
  reg        [1:0]    MmuPlugin_ports_0_entryToReplace_value;
  wire                MmuPlugin_ports_0_entryToReplace_willOverflowIfInc;
  wire                MmuPlugin_ports_0_entryToReplace_willOverflow;
  reg                 MmuPlugin_ports_1_cache_0_valid;
  reg                 MmuPlugin_ports_1_cache_0_exception;
  reg                 MmuPlugin_ports_1_cache_0_superPage;
  reg        [9:0]    MmuPlugin_ports_1_cache_0_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_0_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_1_cache_0_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_0_physicalAddress_1;
  reg                 MmuPlugin_ports_1_cache_0_allowRead;
  reg                 MmuPlugin_ports_1_cache_0_allowWrite;
  reg                 MmuPlugin_ports_1_cache_0_allowExecute;
  reg                 MmuPlugin_ports_1_cache_0_allowUser;
  reg                 MmuPlugin_ports_1_cache_1_valid;
  reg                 MmuPlugin_ports_1_cache_1_exception;
  reg                 MmuPlugin_ports_1_cache_1_superPage;
  reg        [9:0]    MmuPlugin_ports_1_cache_1_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_1_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_1_cache_1_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_1_physicalAddress_1;
  reg                 MmuPlugin_ports_1_cache_1_allowRead;
  reg                 MmuPlugin_ports_1_cache_1_allowWrite;
  reg                 MmuPlugin_ports_1_cache_1_allowExecute;
  reg                 MmuPlugin_ports_1_cache_1_allowUser;
  reg                 MmuPlugin_ports_1_cache_2_valid;
  reg                 MmuPlugin_ports_1_cache_2_exception;
  reg                 MmuPlugin_ports_1_cache_2_superPage;
  reg        [9:0]    MmuPlugin_ports_1_cache_2_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_2_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_1_cache_2_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_2_physicalAddress_1;
  reg                 MmuPlugin_ports_1_cache_2_allowRead;
  reg                 MmuPlugin_ports_1_cache_2_allowWrite;
  reg                 MmuPlugin_ports_1_cache_2_allowExecute;
  reg                 MmuPlugin_ports_1_cache_2_allowUser;
  reg                 MmuPlugin_ports_1_cache_3_valid;
  reg                 MmuPlugin_ports_1_cache_3_exception;
  reg                 MmuPlugin_ports_1_cache_3_superPage;
  reg        [9:0]    MmuPlugin_ports_1_cache_3_virtualAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_3_virtualAddress_1;
  reg        [9:0]    MmuPlugin_ports_1_cache_3_physicalAddress_0;
  reg        [9:0]    MmuPlugin_ports_1_cache_3_physicalAddress_1;
  reg                 MmuPlugin_ports_1_cache_3_allowRead;
  reg                 MmuPlugin_ports_1_cache_3_allowWrite;
  reg                 MmuPlugin_ports_1_cache_3_allowExecute;
  reg                 MmuPlugin_ports_1_cache_3_allowUser;
  reg                 MmuPlugin_ports_1_dirty;
  wire                when_MmuPlugin_l117_1;
  reg                 MmuPlugin_ports_1_requireMmuLockupCalc;
  wire                when_MmuPlugin_l131_1;
  wire                when_MmuPlugin_l132_1;
  wire                when_MmuPlugin_l134;
  wire       [3:0]    MmuPlugin_ports_1_cacheHitsCalc;
  wire                when_MmuPlugin_l124_2;
  reg                 MmuPlugin_ports_1_requireMmuLockup;
  wire                when_MmuPlugin_l124_3;
  reg        [3:0]    MmuPlugin_ports_1_cacheHits;
  wire                MmuPlugin_ports_1_cacheHit;
  wire                _zz_MmuPlugin_ports_1_cacheLine_valid;
  wire                _zz_MmuPlugin_ports_1_cacheLine_valid_1;
  wire                _zz_MmuPlugin_ports_1_cacheLine_valid_2;
  wire       [1:0]    _zz_MmuPlugin_ports_1_cacheLine_valid_3;
  wire                MmuPlugin_ports_1_cacheLine_valid;
  wire                MmuPlugin_ports_1_cacheLine_exception;
  wire                MmuPlugin_ports_1_cacheLine_superPage;
  wire       [9:0]    MmuPlugin_ports_1_cacheLine_virtualAddress_0;
  wire       [9:0]    MmuPlugin_ports_1_cacheLine_virtualAddress_1;
  wire       [9:0]    MmuPlugin_ports_1_cacheLine_physicalAddress_0;
  wire       [9:0]    MmuPlugin_ports_1_cacheLine_physicalAddress_1;
  wire                MmuPlugin_ports_1_cacheLine_allowRead;
  wire                MmuPlugin_ports_1_cacheLine_allowWrite;
  wire                MmuPlugin_ports_1_cacheLine_allowExecute;
  wire                MmuPlugin_ports_1_cacheLine_allowUser;
  reg                 MmuPlugin_ports_1_entryToReplace_willIncrement;
  wire                MmuPlugin_ports_1_entryToReplace_willClear;
  reg        [1:0]    MmuPlugin_ports_1_entryToReplace_valueNext;
  reg        [1:0]    MmuPlugin_ports_1_entryToReplace_value;
  wire                MmuPlugin_ports_1_entryToReplace_willOverflowIfInc;
  wire                MmuPlugin_ports_1_entryToReplace_willOverflow;
  reg        [2:0]    MmuPlugin_shared_state_1;
  reg        [9:0]    MmuPlugin_shared_vpn_0;
  reg        [9:0]    MmuPlugin_shared_vpn_1;
  reg        [1:0]    MmuPlugin_shared_portSortedOh;
  reg                 MmuPlugin_shared_dBusRspStaged_valid;
  reg        [31:0]   MmuPlugin_shared_dBusRspStaged_payload_data;
  reg                 MmuPlugin_shared_dBusRspStaged_payload_error;
  reg                 MmuPlugin_shared_dBusRspStaged_payload_redo;
  wire                MmuPlugin_shared_dBusRsp_pte_V;
  wire                MmuPlugin_shared_dBusRsp_pte_R;
  wire                MmuPlugin_shared_dBusRsp_pte_W;
  wire                MmuPlugin_shared_dBusRsp_pte_X;
  wire                MmuPlugin_shared_dBusRsp_pte_U;
  wire                MmuPlugin_shared_dBusRsp_pte_G;
  wire                MmuPlugin_shared_dBusRsp_pte_A;
  wire                MmuPlugin_shared_dBusRsp_pte_D;
  wire       [1:0]    MmuPlugin_shared_dBusRsp_pte_RSW;
  wire       [9:0]    MmuPlugin_shared_dBusRsp_pte_PPN0;
  wire       [11:0]   MmuPlugin_shared_dBusRsp_pte_PPN1;
  wire                MmuPlugin_shared_dBusRsp_exception;
  wire                MmuPlugin_shared_dBusRsp_leaf;
  wire                when_MmuPlugin_l211;
  reg                 MmuPlugin_shared_pteBuffer_V;
  reg                 MmuPlugin_shared_pteBuffer_R;
  reg                 MmuPlugin_shared_pteBuffer_W;
  reg                 MmuPlugin_shared_pteBuffer_X;
  reg                 MmuPlugin_shared_pteBuffer_U;
  reg                 MmuPlugin_shared_pteBuffer_G;
  reg                 MmuPlugin_shared_pteBuffer_A;
  reg                 MmuPlugin_shared_pteBuffer_D;
  reg        [1:0]    MmuPlugin_shared_pteBuffer_RSW;
  reg        [9:0]    MmuPlugin_shared_pteBuffer_PPN0;
  reg        [11:0]   MmuPlugin_shared_pteBuffer_PPN1;
  wire       [1:0]    _zz_MmuPlugin_shared_refills;
  reg        [1:0]    _zz_MmuPlugin_shared_refills_1;
  wire       [1:0]    MmuPlugin_shared_refills;
  wire       [1:0]    _zz_MmuPlugin_shared_refills_2;
  reg        [1:0]    _zz_MmuPlugin_shared_refills_3;
  wire                when_MmuPlugin_l223;
  wire       [31:0]   _zz_MmuPlugin_shared_vpn_0;
  wire                when_MmuPlugin_l250;
  wire                when_MmuPlugin_l279;
  wire                when_MmuPlugin_l281;
  wire                when_MmuPlugin_l287;
  wire                when_MmuPlugin_l287_1;
  wire                when_MmuPlugin_l287_2;
  wire                when_MmuPlugin_l287_3;
  wire                when_MmuPlugin_l281_1;
  wire                when_MmuPlugin_l287_4;
  wire                when_MmuPlugin_l287_5;
  wire                when_MmuPlugin_l287_6;
  wire                when_MmuPlugin_l287_7;
  wire                when_MmuPlugin_l311;
  wire       [37:0]   _zz_decode_IS_CSR;
  wire                _zz_decode_IS_CSR_1;
  wire                _zz_decode_IS_CSR_2;
  wire                _zz_decode_IS_CSR_3;
  wire                _zz_decode_IS_CSR_4;
  wire                _zz_decode_IS_CSR_5;
  wire                _zz_decode_IS_CSR_6;
  wire                _zz_decode_IS_CSR_7;
  wire                _zz_decode_IS_CSR_8;
  wire                _zz_decode_IS_CSR_9;
  wire                _zz_decode_IS_CSR_10;
  wire                _zz_decode_IS_CSR_11;
  wire       [1:0]    _zz_decode_SRC1_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_CTRL_2;
  wire       [1:0]    _zz_decode_SRC2_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_2;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_2;
  wire       [2:0]    _zz_decode_ENV_CTRL_2;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_2;
  wire                when_RegFilePlugin_l63;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  reg        [4:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  reg        [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_10;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_execute_REGFILE_WRITE_DATA;
  reg        [31:0]   _zz_execute_SRC1;
  wire                _zz_execute_SRC2;
  reg        [19:0]   _zz_execute_SRC2_1;
  wire                _zz_execute_SRC2_2;
  reg        [19:0]   _zz_execute_SRC2_3;
  reg        [31:0]   _zz_execute_SRC2_4;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  wire       [4:0]    execute_FullBarrelShifterPlugin_amplitude;
  reg        [31:0]   _zz_execute_FullBarrelShifterPlugin_reversed;
  wire       [31:0]   execute_FullBarrelShifterPlugin_reversed;
  reg        [31:0]   _zz_decode_RS2_3;
  reg                 execute_MulPlugin_aSigned;
  reg                 execute_MulPlugin_bSigned;
  wire       [31:0]   execute_MulPlugin_a;
  wire       [31:0]   execute_MulPlugin_b;
  wire       [1:0]    switch_MulPlugin_l87;
  wire       [15:0]   execute_MulPlugin_aULow;
  wire       [15:0]   execute_MulPlugin_bULow;
  wire       [16:0]   execute_MulPlugin_aSLow;
  wire       [16:0]   execute_MulPlugin_bSLow;
  wire       [16:0]   execute_MulPlugin_aHigh;
  wire       [16:0]   execute_MulPlugin_bHigh;
  wire       [65:0]   writeBack_MulPlugin_result;
  wire                when_MulPlugin_l147;
  wire       [1:0]    switch_MulPlugin_l148;
  reg        [32:0]   memory_DivPlugin_rs1;
  reg        [31:0]   memory_DivPlugin_rs2;
  reg        [64:0]   memory_DivPlugin_accumulator;
  wire                memory_DivPlugin_frontendOk;
  reg                 memory_DivPlugin_div_needRevert;
  reg                 memory_DivPlugin_div_counter_willIncrement;
  reg                 memory_DivPlugin_div_counter_willClear;
  reg        [5:0]    memory_DivPlugin_div_counter_valueNext;
  reg        [5:0]    memory_DivPlugin_div_counter_value;
  wire                memory_DivPlugin_div_counter_willOverflowIfInc;
  wire                memory_DivPlugin_div_counter_willOverflow;
  reg                 memory_DivPlugin_div_done;
  wire                when_MulDivIterativePlugin_l126;
  wire                when_MulDivIterativePlugin_l126_1;
  reg        [31:0]   memory_DivPlugin_div_result;
  wire                when_MulDivIterativePlugin_l128;
  wire                when_MulDivIterativePlugin_l129;
  wire                when_MulDivIterativePlugin_l132;
  wire       [31:0]   _zz_memory_DivPlugin_div_stage_0_remainderShifted;
  wire       [32:0]   memory_DivPlugin_div_stage_0_remainderShifted;
  wire       [32:0]   memory_DivPlugin_div_stage_0_remainderMinusDenominator;
  wire       [31:0]   memory_DivPlugin_div_stage_0_outRemainder;
  wire       [31:0]   memory_DivPlugin_div_stage_0_outNumerator;
  wire                when_MulDivIterativePlugin_l151;
  wire       [31:0]   _zz_memory_DivPlugin_div_result;
  wire                when_MulDivIterativePlugin_l162;
  wire                _zz_memory_DivPlugin_rs2;
  wire                _zz_memory_DivPlugin_rs1;
  reg        [32:0]   _zz_memory_DivPlugin_rs1_1;
  reg                 HazardSimplePlugin_src0Hazard;
  reg                 HazardSimplePlugin_src1Hazard;
  wire                HazardSimplePlugin_writeBackWrites_valid;
  wire       [4:0]    HazardSimplePlugin_writeBackWrites_payload_address;
  wire       [31:0]   HazardSimplePlugin_writeBackWrites_payload_data;
  reg                 HazardSimplePlugin_writeBackBuffer_valid;
  reg        [4:0]    HazardSimplePlugin_writeBackBuffer_payload_address;
  reg        [31:0]   HazardSimplePlugin_writeBackBuffer_payload_data;
  wire                HazardSimplePlugin_addr0Match;
  wire                HazardSimplePlugin_addr1Match;
  wire                when_HazardSimplePlugin_l47;
  wire                when_HazardSimplePlugin_l48;
  wire                when_HazardSimplePlugin_l51;
  wire                when_HazardSimplePlugin_l45;
  wire                when_HazardSimplePlugin_l57;
  wire                when_HazardSimplePlugin_l58;
  wire                when_HazardSimplePlugin_l48_1;
  wire                when_HazardSimplePlugin_l51_1;
  wire                when_HazardSimplePlugin_l45_1;
  wire                when_HazardSimplePlugin_l57_1;
  wire                when_HazardSimplePlugin_l58_1;
  wire                when_HazardSimplePlugin_l48_2;
  wire                when_HazardSimplePlugin_l51_2;
  wire                when_HazardSimplePlugin_l45_2;
  wire                when_HazardSimplePlugin_l57_2;
  wire                when_HazardSimplePlugin_l58_2;
  wire                when_HazardSimplePlugin_l105;
  wire                when_HazardSimplePlugin_l108;
  wire                when_HazardSimplePlugin_l113;
  reg                 DebugPlugin_firstCycle;
  reg                 DebugPlugin_secondCycle;
  reg                 DebugPlugin_resetIt;
  reg                 DebugPlugin_haltIt;
  reg                 DebugPlugin_stepIt;
  reg                 DebugPlugin_isPipBusy;
  reg                 DebugPlugin_godmode;
  wire                when_DebugPlugin_l238;
  reg                 DebugPlugin_haltedByBreak;
  reg                 DebugPlugin_debugUsed /* verilator public */ ;
  reg                 DebugPlugin_disableEbreak;
  wire                DebugPlugin_allowEBreak;
  reg        [31:0]   DebugPlugin_busReadDataReg;
  reg                 _zz_when_DebugPlugin_l257;
  wire                when_DebugPlugin_l257;
  wire       [5:0]    switch_DebugPlugin_l280;
  wire                when_DebugPlugin_l284;
  wire                when_DebugPlugin_l284_1;
  wire                when_DebugPlugin_l285;
  wire                when_DebugPlugin_l285_1;
  wire                when_DebugPlugin_l286;
  wire                when_DebugPlugin_l287;
  wire                when_DebugPlugin_l288;
  wire                when_DebugPlugin_l288_1;
  wire                when_DebugPlugin_l308;
  wire                when_DebugPlugin_l311;
  wire                when_DebugPlugin_l324;
  reg                 DebugPlugin_resetIt_regNext;
  wire                when_DebugPlugin_l344;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    switch_Misc_l245_1;
  reg                 _zz_execute_BRANCH_COND_RESULT;
  reg                 _zz_execute_BRANCH_COND_RESULT_1;
  wire                _zz_execute_BranchPlugin_missAlignedTarget;
  reg        [19:0]   _zz_execute_BranchPlugin_missAlignedTarget_1;
  wire                _zz_execute_BranchPlugin_missAlignedTarget_2;
  reg        [10:0]   _zz_execute_BranchPlugin_missAlignedTarget_3;
  wire                _zz_execute_BranchPlugin_missAlignedTarget_4;
  reg        [18:0]   _zz_execute_BranchPlugin_missAlignedTarget_5;
  reg                 _zz_execute_BranchPlugin_missAlignedTarget_6;
  wire                execute_BranchPlugin_missAlignedTarget;
  reg        [31:0]   execute_BranchPlugin_branch_src1;
  reg        [31:0]   execute_BranchPlugin_branch_src2;
  wire                _zz_execute_BranchPlugin_branch_src2;
  reg        [19:0]   _zz_execute_BranchPlugin_branch_src2_1;
  wire                _zz_execute_BranchPlugin_branch_src2_2;
  reg        [10:0]   _zz_execute_BranchPlugin_branch_src2_3;
  wire                _zz_execute_BranchPlugin_branch_src2_4;
  reg        [18:0]   _zz_execute_BranchPlugin_branch_src2_5;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  reg        [1:0]    _zz_CsrPlugin_privilege;
  wire       [1:0]    CsrPlugin_misa_base;
  wire       [25:0]   CsrPlugin_misa_extensions;
  reg        [1:0]    CsrPlugin_mtvec_mode;
  reg        [29:0]   CsrPlugin_mtvec_base;
  reg        [31:0]   CsrPlugin_mepc;
  reg                 CsrPlugin_mstatus_MIE;
  reg                 CsrPlugin_mstatus_MPIE;
  reg        [1:0]    CsrPlugin_mstatus_MPP;
  reg                 CsrPlugin_mip_MEIP;
  reg                 CsrPlugin_mip_MTIP;
  reg                 CsrPlugin_mip_MSIP;
  reg                 CsrPlugin_mie_MEIE;
  reg                 CsrPlugin_mie_MTIE;
  reg                 CsrPlugin_mie_MSIE;
  reg        [31:0]   CsrPlugin_mscratch;
  reg                 CsrPlugin_mcause_interrupt;
  reg        [3:0]    CsrPlugin_mcause_exceptionCode;
  reg        [31:0]   CsrPlugin_mtval;
  reg        [63:0]   CsrPlugin_mcycle;
  reg        [63:0]   CsrPlugin_minstret;
  reg                 CsrPlugin_medeleg_IAM;
  reg                 CsrPlugin_medeleg_IAF;
  reg                 CsrPlugin_medeleg_II;
  reg                 CsrPlugin_medeleg_BP;
  reg                 CsrPlugin_medeleg_LAM;
  reg                 CsrPlugin_medeleg_LAF;
  reg                 CsrPlugin_medeleg_SAM;
  reg                 CsrPlugin_medeleg_SAF;
  reg                 CsrPlugin_medeleg_EU;
  reg                 CsrPlugin_medeleg_ES;
  reg                 CsrPlugin_medeleg_IPF;
  reg                 CsrPlugin_medeleg_LPF;
  reg                 CsrPlugin_medeleg_SPF;
  reg                 CsrPlugin_mideleg_ST;
  reg                 CsrPlugin_mideleg_SE;
  reg                 CsrPlugin_mideleg_SS;
  wire                CsrPlugin_mcounteren_IR;
  reg                 CsrPlugin_mcounteren_TM;
  wire                CsrPlugin_mcounteren_CY;
  wire                CsrPlugin_scounteren_IR;
  reg                 CsrPlugin_scounteren_TM;
  wire                CsrPlugin_scounteren_CY;
  reg                 CsrPlugin_sstatus_SIE;
  reg                 CsrPlugin_sstatus_SPIE;
  reg        [0:0]    CsrPlugin_sstatus_SPP;
  reg                 CsrPlugin_sip_SEIP_SOFT;
  reg                 CsrPlugin_sip_SEIP_INPUT;
  wire                CsrPlugin_sip_SEIP_OR;
  reg                 CsrPlugin_sip_STIP;
  reg                 CsrPlugin_sip_SSIP;
  reg                 CsrPlugin_sie_SEIE;
  reg                 CsrPlugin_sie_STIE;
  reg                 CsrPlugin_sie_SSIE;
  reg        [1:0]    CsrPlugin_stvec_mode;
  reg        [29:0]   CsrPlugin_stvec_base;
  reg        [31:0]   CsrPlugin_sscratch;
  reg                 CsrPlugin_scause_interrupt;
  reg        [3:0]    CsrPlugin_scause_exceptionCode;
  reg        [31:0]   CsrPlugin_stval;
  reg        [31:0]   CsrPlugin_sepc;
  reg        [21:0]   CsrPlugin_satp_PPN;
  reg        [8:0]    CsrPlugin_satp_ASID;
  reg        [0:0]    CsrPlugin_satp_MODE;
  reg                 CsrPlugin_rescheduleLogic_rescheduleNext;
  wire                when_CsrPlugin_l1153;
  wire                _zz_when_CsrPlugin_l1302;
  wire                _zz_when_CsrPlugin_l1302_1;
  wire                _zz_when_CsrPlugin_l1302_2;
  wire                _zz_when_CsrPlugin_l1302_3;
  wire                _zz_when_CsrPlugin_l1302_4;
  wire                _zz_when_CsrPlugin_l1302_5;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg        [3:0]    CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg        [31:0]   CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  reg        [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire                when_CsrPlugin_l1216;
  wire                when_CsrPlugin_l1216_1;
  wire                when_CsrPlugin_l1216_2;
  wire                when_CsrPlugin_l1216_3;
  wire                when_CsrPlugin_l1216_4;
  wire                when_CsrPlugin_l1216_5;
  wire                when_CsrPlugin_l1216_6;
  wire                when_CsrPlugin_l1216_7;
  wire                when_CsrPlugin_l1216_8;
  wire                when_CsrPlugin_l1216_9;
  wire                when_CsrPlugin_l1216_10;
  wire                when_CsrPlugin_l1216_11;
  wire                when_CsrPlugin_l1216_12;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire       [1:0]    _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  wire                _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
  wire                when_CsrPlugin_l1259;
  wire                when_CsrPlugin_l1259_1;
  wire                when_CsrPlugin_l1259_2;
  wire                when_CsrPlugin_l1259_3;
  wire                when_CsrPlugin_l1272;
  reg                 CsrPlugin_interrupt_valid;
  reg        [3:0]    CsrPlugin_interrupt_code /* verilator public */ ;
  reg        [1:0]    CsrPlugin_interrupt_targetPrivilege;
  wire                when_CsrPlugin_l1296;
  wire                when_CsrPlugin_l1296_1;
  wire                when_CsrPlugin_l1302;
  wire                when_CsrPlugin_l1302_1;
  wire                when_CsrPlugin_l1302_2;
  wire                when_CsrPlugin_l1302_3;
  wire                when_CsrPlugin_l1302_4;
  wire                when_CsrPlugin_l1302_5;
  wire                when_CsrPlugin_l1302_6;
  wire                when_CsrPlugin_l1302_7;
  wire                when_CsrPlugin_l1302_8;
  wire                CsrPlugin_exception;
  reg                 CsrPlugin_lastStageWasWfi;
  reg                 CsrPlugin_pipelineLiberator_pcValids_0;
  reg                 CsrPlugin_pipelineLiberator_pcValids_1;
  reg                 CsrPlugin_pipelineLiberator_pcValids_2;
  wire                CsrPlugin_pipelineLiberator_active;
  wire                when_CsrPlugin_l1335;
  wire                when_CsrPlugin_l1335_1;
  wire                when_CsrPlugin_l1335_2;
  wire                when_CsrPlugin_l1340;
  reg                 CsrPlugin_pipelineLiberator_done;
  wire                when_CsrPlugin_l1346;
  wire                CsrPlugin_interruptJump /* verilator public */ ;
  reg                 CsrPlugin_hadException /* verilator public */ ;
  reg        [1:0]    CsrPlugin_targetPrivilege;
  reg        [3:0]    CsrPlugin_trapCause;
  wire                CsrPlugin_trapCauseEbreakDebug;
  reg        [1:0]    CsrPlugin_xtvec_mode;
  reg        [29:0]   CsrPlugin_xtvec_base;
  wire                CsrPlugin_trapEnterDebug;
  wire                when_CsrPlugin_l1390;
  wire                when_CsrPlugin_l1398;
  wire                when_CsrPlugin_l1456;
  wire       [1:0]    switch_CsrPlugin_l1460;
  wire                when_CsrPlugin_l1468;
  reg                 execute_CsrPlugin_wfiWake;
  wire                when_CsrPlugin_l1519;
  wire                when_CsrPlugin_l1521;
  wire                when_CsrPlugin_l1527;
  wire                execute_CsrPlugin_blockedBySideEffects;
  reg                 execute_CsrPlugin_illegalAccess;
  reg                 execute_CsrPlugin_illegalInstruction;
  wire                when_CsrPlugin_l1540;
  wire                when_CsrPlugin_l1547;
  wire                when_CsrPlugin_l1548;
  wire                when_CsrPlugin_l1555;
  wire                when_CsrPlugin_l1565;
  reg                 execute_CsrPlugin_writeInstruction;
  reg                 execute_CsrPlugin_readInstruction;
  wire                execute_CsrPlugin_writeEnable;
  wire                execute_CsrPlugin_readEnable;
  reg        [31:0]   execute_CsrPlugin_readToWriteData;
  wire                switch_Misc_l245_2;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_writeDataSignal;
  wire                when_CsrPlugin_l1587;
  wire                when_CsrPlugin_l1591;
  wire       [11:0]   execute_CsrPlugin_csrAddress;
  wire                when_Pipeline_l124;
  reg        [31:0]   decode_to_execute_PC;
  wire                when_Pipeline_l124_1;
  reg        [31:0]   execute_to_memory_PC;
  wire                when_Pipeline_l124_2;
  reg        [31:0]   memory_to_writeBack_PC;
  wire                when_Pipeline_l124_3;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  wire                when_Pipeline_l124_4;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  wire                when_Pipeline_l124_5;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  wire                when_Pipeline_l124_6;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_7;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_8;
  reg        [31:0]   memory_to_writeBack_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_9;
  reg                 decode_to_execute_MEMORY_FORCE_CONSTISTENCY;
  wire                when_Pipeline_l124_10;
  reg                 decode_to_execute_RESCHEDULE_NEXT;
  wire                when_Pipeline_l124_11;
  reg        [1:0]    decode_to_execute_SRC1_CTRL;
  wire                when_Pipeline_l124_12;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  wire                when_Pipeline_l124_13;
  reg                 decode_to_execute_MEMORY_ENABLE;
  wire                when_Pipeline_l124_14;
  reg                 execute_to_memory_MEMORY_ENABLE;
  wire                when_Pipeline_l124_15;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  wire                when_Pipeline_l124_16;
  reg        [1:0]    decode_to_execute_ALU_CTRL;
  wire                when_Pipeline_l124_17;
  reg        [1:0]    decode_to_execute_SRC2_CTRL;
  wire                when_Pipeline_l124_18;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_19;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_20;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_21;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  wire                when_Pipeline_l124_22;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_23;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_24;
  reg                 decode_to_execute_MEMORY_WR;
  wire                when_Pipeline_l124_25;
  reg                 execute_to_memory_MEMORY_WR;
  wire                when_Pipeline_l124_26;
  reg                 memory_to_writeBack_MEMORY_WR;
  wire                when_Pipeline_l124_27;
  reg                 decode_to_execute_MEMORY_LRSC;
  wire                when_Pipeline_l124_28;
  reg                 execute_to_memory_MEMORY_LRSC;
  wire                when_Pipeline_l124_29;
  reg                 memory_to_writeBack_MEMORY_LRSC;
  wire                when_Pipeline_l124_30;
  reg                 decode_to_execute_MEMORY_AMO;
  wire                when_Pipeline_l124_31;
  reg                 decode_to_execute_MEMORY_MANAGMENT;
  wire                when_Pipeline_l124_32;
  reg                 decode_to_execute_IS_SFENCE_VMA2;
  wire                when_Pipeline_l124_33;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  wire                when_Pipeline_l124_34;
  reg        [1:0]    decode_to_execute_ALU_BITWISE_CTRL;
  wire                when_Pipeline_l124_35;
  reg        [1:0]    decode_to_execute_SHIFT_CTRL;
  wire                when_Pipeline_l124_36;
  reg        [1:0]    execute_to_memory_SHIFT_CTRL;
  wire                when_Pipeline_l124_37;
  reg                 decode_to_execute_IS_MUL;
  wire                when_Pipeline_l124_38;
  reg                 execute_to_memory_IS_MUL;
  wire                when_Pipeline_l124_39;
  reg                 memory_to_writeBack_IS_MUL;
  wire                when_Pipeline_l124_40;
  reg                 decode_to_execute_IS_DIV;
  wire                when_Pipeline_l124_41;
  reg                 execute_to_memory_IS_DIV;
  wire                when_Pipeline_l124_42;
  reg                 decode_to_execute_IS_RS1_SIGNED;
  wire                when_Pipeline_l124_43;
  reg                 decode_to_execute_IS_RS2_SIGNED;
  wire                when_Pipeline_l124_44;
  reg        [2:0]    decode_to_execute_ENV_CTRL;
  wire                when_Pipeline_l124_45;
  reg        [2:0]    execute_to_memory_ENV_CTRL;
  wire                when_Pipeline_l124_46;
  reg        [2:0]    memory_to_writeBack_ENV_CTRL;
  wire                when_Pipeline_l124_47;
  reg        [1:0]    decode_to_execute_BRANCH_CTRL;
  wire                when_Pipeline_l124_48;
  reg                 decode_to_execute_IS_CSR;
  wire                when_Pipeline_l124_49;
  reg        [31:0]   decode_to_execute_RS1;
  wire                when_Pipeline_l124_50;
  reg        [31:0]   decode_to_execute_RS2;
  wire                when_Pipeline_l124_51;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  wire                when_Pipeline_l124_52;
  reg                 decode_to_execute_DO_EBREAK;
  wire                when_Pipeline_l124_53;
  reg                 decode_to_execute_PREDICTION_HAD_BRANCHED1;
  wire                when_Pipeline_l124_54;
  reg                 decode_to_execute_CSR_WRITE_OPCODE;
  wire                when_Pipeline_l124_55;
  reg                 decode_to_execute_CSR_READ_OPCODE;
  wire                when_Pipeline_l124_56;
  reg        [31:0]   execute_to_memory_MEMORY_STORE_DATA_RF;
  wire                when_Pipeline_l124_57;
  reg        [31:0]   memory_to_writeBack_MEMORY_STORE_DATA_RF;
  wire                when_Pipeline_l124_58;
  reg                 execute_to_memory_IS_DBUS_SHARING;
  wire                when_Pipeline_l124_59;
  reg                 memory_to_writeBack_IS_DBUS_SHARING;
  wire                when_Pipeline_l124_60;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_61;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_62;
  reg        [31:0]   execute_to_memory_SHIFT_RIGHT;
  wire                when_Pipeline_l124_63;
  reg        [31:0]   execute_to_memory_MUL_LL;
  wire                when_Pipeline_l124_64;
  reg        [33:0]   execute_to_memory_MUL_LH;
  wire                when_Pipeline_l124_65;
  reg        [33:0]   execute_to_memory_MUL_HL;
  wire                when_Pipeline_l124_66;
  reg        [33:0]   execute_to_memory_MUL_HH;
  wire                when_Pipeline_l124_67;
  reg        [33:0]   memory_to_writeBack_MUL_HH;
  wire                when_Pipeline_l124_68;
  reg                 execute_to_memory_BRANCH_DO;
  wire                when_Pipeline_l124_69;
  reg        [31:0]   execute_to_memory_BRANCH_CALC;
  wire                when_Pipeline_l124_70;
  reg        [51:0]   memory_to_writeBack_MUL_LOW;
  wire                when_Pipeline_l151;
  wire                when_Pipeline_l154;
  wire                when_Pipeline_l151_1;
  wire                when_Pipeline_l154_1;
  wire                when_Pipeline_l151_2;
  wire                when_Pipeline_l154_2;
  reg        [2:0]    IBusCachedPlugin_injector_port_state;
  wire                when_Fetcher_l391;
  wire                when_CsrPlugin_l1669;
  reg                 execute_CsrPlugin_csr_768;
  wire                when_CsrPlugin_l1669_1;
  reg                 execute_CsrPlugin_csr_256;
  wire                when_CsrPlugin_l1669_2;
  reg                 execute_CsrPlugin_csr_384;
  wire                when_CsrPlugin_l1669_3;
  reg                 execute_CsrPlugin_csr_3857;
  wire                when_CsrPlugin_l1669_4;
  reg                 execute_CsrPlugin_csr_3858;
  wire                when_CsrPlugin_l1669_5;
  reg                 execute_CsrPlugin_csr_3859;
  wire                when_CsrPlugin_l1669_6;
  reg                 execute_CsrPlugin_csr_3860;
  wire                when_CsrPlugin_l1669_7;
  reg                 execute_CsrPlugin_csr_769;
  wire                when_CsrPlugin_l1669_8;
  reg                 execute_CsrPlugin_csr_836;
  wire                when_CsrPlugin_l1669_9;
  reg                 execute_CsrPlugin_csr_772;
  wire                when_CsrPlugin_l1669_10;
  reg                 execute_CsrPlugin_csr_773;
  wire                when_CsrPlugin_l1669_11;
  reg                 execute_CsrPlugin_csr_833;
  wire                when_CsrPlugin_l1669_12;
  reg                 execute_CsrPlugin_csr_832;
  wire                when_CsrPlugin_l1669_13;
  reg                 execute_CsrPlugin_csr_834;
  wire                when_CsrPlugin_l1669_14;
  reg                 execute_CsrPlugin_csr_835;
  wire                when_CsrPlugin_l1669_15;
  reg                 execute_CsrPlugin_csr_770;
  wire                when_CsrPlugin_l1669_16;
  reg                 execute_CsrPlugin_csr_771;
  wire                when_CsrPlugin_l1669_17;
  reg                 execute_CsrPlugin_csr_3073;
  wire                when_CsrPlugin_l1669_18;
  reg                 execute_CsrPlugin_csr_3201;
  wire                when_CsrPlugin_l1669_19;
  reg                 execute_CsrPlugin_csr_774;
  wire                when_CsrPlugin_l1669_20;
  reg                 execute_CsrPlugin_csr_262;
  wire                when_CsrPlugin_l1669_21;
  reg                 execute_CsrPlugin_csr_324;
  wire                when_CsrPlugin_l1669_22;
  reg                 execute_CsrPlugin_csr_260;
  wire                when_CsrPlugin_l1669_23;
  reg                 execute_CsrPlugin_csr_261;
  wire                when_CsrPlugin_l1669_24;
  reg                 execute_CsrPlugin_csr_321;
  wire                when_CsrPlugin_l1669_25;
  reg                 execute_CsrPlugin_csr_320;
  wire                when_CsrPlugin_l1669_26;
  reg                 execute_CsrPlugin_csr_322;
  wire                when_CsrPlugin_l1669_27;
  reg                 execute_CsrPlugin_csr_323;
  wire                when_CsrPlugin_l1669_28;
  reg                 execute_CsrPlugin_csr_784;
  wire       [1:0]    switch_CsrPlugin_l1031;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_2;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_3;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_4;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_5;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_6;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_7;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_8;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_9;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_10;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_11;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_12;
  wire                when_CsrPlugin_l1076;
  wire                when_CsrPlugin_l1077;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_13;
  wire                when_CsrPlugin_l1076_1;
  wire                when_CsrPlugin_l1077_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_14;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_15;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_16;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_17;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_18;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_19;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_20;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_21;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_22;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_23;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_24;
  wire                when_CsrPlugin_l1702;
  wire       [11:0]   _zz_when_CsrPlugin_l1709;
  wire                when_CsrPlugin_l1709;
  reg                 when_CsrPlugin_l1719;
  wire                when_CsrPlugin_l1717;
  wire                when_CsrPlugin_l1725;
  wire                debug_bus_cmd_fire;
  reg                 debug_bus_cmd_fire_regNext;
  `ifndef SYNTHESIS
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_1_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_1_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_1_string;
  reg [47:0] decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_1_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_1_string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_1_string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_to_execute_SRC2_CTRL_string;
  reg [23:0] _zz_decode_to_execute_SRC2_CTRL_1_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_1_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_to_execute_SRC1_CTRL_string;
  reg [95:0] _zz_decode_to_execute_SRC1_CTRL_1_string;
  reg [47:0] memory_ENV_CTRL_string;
  reg [47:0] _zz_memory_ENV_CTRL_string;
  reg [47:0] execute_ENV_CTRL_string;
  reg [47:0] _zz_execute_ENV_CTRL_string;
  reg [47:0] writeBack_ENV_CTRL_string;
  reg [47:0] _zz_writeBack_ENV_CTRL_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_execute_BRANCH_CTRL_string;
  reg [71:0] memory_SHIFT_CTRL_string;
  reg [71:0] _zz_memory_SHIFT_CTRL_string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_SHIFT_CTRL_string;
  reg [23:0] execute_SRC2_CTRL_string;
  reg [23:0] _zz_execute_SRC2_CTRL_string;
  reg [95:0] execute_SRC1_CTRL_string;
  reg [95:0] _zz_execute_SRC1_CTRL_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_execute_ALU_CTRL_string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_execute_ALU_BITWISE_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_string;
  reg [47:0] _zz_decode_ENV_CTRL_1_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_1_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_1_string;
  reg [23:0] _zz_decode_SRC2_CTRL_1_string;
  reg [63:0] _zz_decode_ALU_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_1_string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_1_string;
  reg [47:0] MmuPlugin_shared_state_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_2_string;
  reg [63:0] _zz_decode_ALU_CTRL_2_string;
  reg [23:0] _zz_decode_SRC2_CTRL_2_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_2_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_2_string;
  reg [47:0] _zz_decode_ENV_CTRL_2_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_2_string;
  reg [95:0] decode_to_execute_SRC1_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [23:0] decode_to_execute_SRC2_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] execute_to_memory_SHIFT_CTRL_string;
  reg [47:0] decode_to_execute_ENV_CTRL_string;
  reg [47:0] execute_to_memory_ENV_CTRL_string;
  reg [47:0] memory_to_writeBack_ENV_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [87:0] iBusAvalon_response_string;
  reg [87:0] dBusAvalon_response_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;

  assign _zz_when = (|{decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid});
  assign _zz_memory_MUL_LOW = ($signed(_zz_memory_MUL_LOW_1) + $signed(_zz_memory_MUL_LOW_4));
  assign _zz_memory_MUL_LOW_1 = ($signed(52'h0) + $signed(_zz_memory_MUL_LOW_2));
  assign _zz_memory_MUL_LOW_3 = {1'b0,memory_MUL_LL};
  assign _zz_memory_MUL_LOW_2 = {{19{_zz_memory_MUL_LOW_3[32]}}, _zz_memory_MUL_LOW_3};
  assign _zz_memory_MUL_LOW_5 = ({16'd0,memory_MUL_LH} <<< 5'd16);
  assign _zz_memory_MUL_LOW_4 = {{2{_zz_memory_MUL_LOW_5[49]}}, _zz_memory_MUL_LOW_5};
  assign _zz_memory_MUL_LOW_7 = ({16'd0,memory_MUL_HL} <<< 5'd16);
  assign _zz_memory_MUL_LOW_6 = {{2{_zz_memory_MUL_LOW_7[49]}}, _zz_memory_MUL_LOW_7};
  assign _zz_execute_SHIFT_RIGHT_1 = ($signed(_zz_execute_SHIFT_RIGHT_2) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT_1[31 : 0];
  assign _zz_execute_SHIFT_RIGHT_2 = {((execute_SHIFT_CTRL == ShiftCtrlEnum_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1 = (_zz_IBusCachedPlugin_jump_pcLoad_payload - 5'h01);
  assign _zz_IBusCachedPlugin_fetchPc_pc_1 = {IBusCachedPlugin_fetchPc_inc,2'b00};
  assign _zz_IBusCachedPlugin_fetchPc_pc = {29'd0, _zz_IBusCachedPlugin_fetchPc_pc_1};
  assign _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2 = {{_zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz__zz_2 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz__zz_4 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz__zz_6 = {{_zz_3,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz__zz_6_1 = {{_zz_5,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_io_cpu_flush_payload_lineId = _zz_io_cpu_flush_payload_lineId_1;
  assign _zz_io_cpu_flush_payload_lineId_1 = (execute_RS1 >>> 3'd5);
  assign _zz_DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 3'b111 : 3'b101);
  assign _zz_DBusCachedPlugin_exceptionBus_payload_code_1 = (writeBack_MEMORY_WR ? 3'b110 : 3'b100);
  assign _zz_writeBack_DBusCachedPlugin_rspRf = (! dataCache_1_io_cpu_writeBack_exclusiveOk);
  assign _zz_MmuPlugin_ports_0_entryToReplace_valueNext_1 = MmuPlugin_ports_0_entryToReplace_willIncrement;
  assign _zz_MmuPlugin_ports_0_entryToReplace_valueNext = {1'd0, _zz_MmuPlugin_ports_0_entryToReplace_valueNext_1};
  assign _zz_MmuPlugin_ports_1_entryToReplace_valueNext_1 = MmuPlugin_ports_1_entryToReplace_willIncrement;
  assign _zz_MmuPlugin_ports_1_entryToReplace_valueNext = {1'd0, _zz_MmuPlugin_ports_1_entryToReplace_valueNext_1};
  assign _zz__zz_MmuPlugin_shared_refills_2 = (_zz_MmuPlugin_shared_refills_1 - 2'b01);
  assign _zz__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
  assign _zz__zz_execute_SRC1 = 3'b100;
  assign _zz__zz_execute_SRC1_1 = execute_INSTRUCTION[19 : 15];
  assign _zz__zz_execute_SRC2_2 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_execute_SrcPlugin_addSub = ($signed(_zz_execute_SrcPlugin_addSub_1) + $signed(_zz_execute_SrcPlugin_addSub_4));
  assign _zz_execute_SrcPlugin_addSub_1 = ($signed(_zz_execute_SrcPlugin_addSub_2) + $signed(_zz_execute_SrcPlugin_addSub_3));
  assign _zz_execute_SrcPlugin_addSub_2 = execute_SRC1;
  assign _zz_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? 32'h00000001 : 32'h0);
  assign _zz_writeBack_MulPlugin_result = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_writeBack_MulPlugin_result_1 = ({32'd0,writeBack_MUL_HH} <<< 6'd32);
  assign _zz__zz_decode_RS2_2 = writeBack_MUL_LOW[31 : 0];
  assign _zz__zz_decode_RS2_2_1 = writeBack_MulPlugin_result[63 : 32];
  assign _zz_memory_DivPlugin_div_counter_valueNext_1 = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_memory_DivPlugin_div_counter_valueNext = {5'd0, _zz_memory_DivPlugin_div_counter_valueNext_1};
  assign _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator = {1'd0, memory_DivPlugin_rs2};
  assign _zz_memory_DivPlugin_div_stage_0_outRemainder = memory_DivPlugin_div_stage_0_remainderMinusDenominator[31:0];
  assign _zz_memory_DivPlugin_div_stage_0_outRemainder_1 = memory_DivPlugin_div_stage_0_remainderShifted[31:0];
  assign _zz_memory_DivPlugin_div_stage_0_outNumerator = {_zz_memory_DivPlugin_div_stage_0_remainderShifted,(! memory_DivPlugin_div_stage_0_remainderMinusDenominator[32])};
  assign _zz_memory_DivPlugin_div_result_1 = _zz_memory_DivPlugin_div_result_2;
  assign _zz_memory_DivPlugin_div_result_2 = _zz_memory_DivPlugin_div_result_3;
  assign _zz_memory_DivPlugin_div_result_3 = ({memory_DivPlugin_div_needRevert,(memory_DivPlugin_div_needRevert ? (~ _zz_memory_DivPlugin_div_result) : _zz_memory_DivPlugin_div_result)} + _zz_memory_DivPlugin_div_result_4);
  assign _zz_memory_DivPlugin_div_result_5 = memory_DivPlugin_div_needRevert;
  assign _zz_memory_DivPlugin_div_result_4 = {32'd0, _zz_memory_DivPlugin_div_result_5};
  assign _zz_memory_DivPlugin_rs1_3 = _zz_memory_DivPlugin_rs1;
  assign _zz_memory_DivPlugin_rs1_2 = {32'd0, _zz_memory_DivPlugin_rs1_3};
  assign _zz_memory_DivPlugin_rs2_2 = _zz_memory_DivPlugin_rs2;
  assign _zz_memory_DivPlugin_rs2_1 = {31'd0, _zz_memory_DivPlugin_rs2_2};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6 = {_zz_execute_BranchPlugin_missAlignedTarget_1,execute_INSTRUCTION[31 : 20]};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1 = {{_zz_execute_BranchPlugin_missAlignedTarget_3,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2 = {{_zz_execute_BranchPlugin_missAlignedTarget_5,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz__zz_execute_BranchPlugin_branch_src2_2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BranchPlugin_branch_src2_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_execute_BranchPlugin_branch_src2_11 = 3'b100;
  assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code & (~ _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1));
  assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1 = (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code - 2'b01);
  assign _zz_decode_RegFilePlugin_rs1Data = 1'b1;
  assign _zz_decode_RegFilePlugin_rs2Data = 1'b1;
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_7 = {_zz_IBusCachedPlugin_jump_pcLoad_payload_3,{_zz_IBusCachedPlugin_jump_pcLoad_payload_5,_zz_IBusCachedPlugin_jump_pcLoad_payload_4}};
  assign _zz_writeBack_DBusCachedPlugin_rspShifted_1 = dataCache_1_io_cpu_writeBack_address[1 : 0];
  assign _zz_writeBack_DBusCachedPlugin_rspShifted_3 = dataCache_1_io_cpu_writeBack_address[1 : 1];
  assign _zz_decode_LEGAL_INSTRUCTION = 32'h0000107f;
  assign _zz_decode_LEGAL_INSTRUCTION_1 = (decode_INSTRUCTION & 32'h0000207f);
  assign _zz_decode_LEGAL_INSTRUCTION_2 = 32'h00002073;
  assign _zz_decode_LEGAL_INSTRUCTION_3 = ((decode_INSTRUCTION & 32'h0000407f) == 32'h00004063);
  assign _zz_decode_LEGAL_INSTRUCTION_4 = ((decode_INSTRUCTION & 32'h0000207f) == 32'h00002013);
  assign _zz_decode_LEGAL_INSTRUCTION_5 = {((decode_INSTRUCTION & 32'h0000107f) == 32'h00000013),{((decode_INSTRUCTION & 32'h0000603f) == 32'h00000023),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_6) == 32'h00000003),{(_zz_decode_LEGAL_INSTRUCTION_7 == _zz_decode_LEGAL_INSTRUCTION_8),{_zz_decode_LEGAL_INSTRUCTION_9,{_zz_decode_LEGAL_INSTRUCTION_10,_zz_decode_LEGAL_INSTRUCTION_11}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_6 = 32'h0000207f;
  assign _zz_decode_LEGAL_INSTRUCTION_7 = (decode_INSTRUCTION & 32'h0000505f);
  assign _zz_decode_LEGAL_INSTRUCTION_8 = 32'h00000003;
  assign _zz_decode_LEGAL_INSTRUCTION_9 = ((decode_INSTRUCTION & 32'h0000707b) == 32'h00000063);
  assign _zz_decode_LEGAL_INSTRUCTION_10 = ((decode_INSTRUCTION & 32'h0000607f) == 32'h0000000f);
  assign _zz_decode_LEGAL_INSTRUCTION_11 = {((decode_INSTRUCTION & 32'h1800707f) == 32'h0000202f),{((decode_INSTRUCTION & 32'hfc00007f) == 32'h00000033),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_12) == 32'h0800202f),{(_zz_decode_LEGAL_INSTRUCTION_13 == _zz_decode_LEGAL_INSTRUCTION_14),{_zz_decode_LEGAL_INSTRUCTION_15,{_zz_decode_LEGAL_INSTRUCTION_16,_zz_decode_LEGAL_INSTRUCTION_17}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_12 = 32'he800707f;
  assign _zz_decode_LEGAL_INSTRUCTION_13 = (decode_INSTRUCTION & 32'h01f0707f);
  assign _zz_decode_LEGAL_INSTRUCTION_14 = 32'h0000500f;
  assign _zz_decode_LEGAL_INSTRUCTION_15 = ((decode_INSTRUCTION & 32'hbe00705f) == 32'h00005013);
  assign _zz_decode_LEGAL_INSTRUCTION_16 = ((decode_INSTRUCTION & 32'hfe00305f) == 32'h00001013);
  assign _zz_decode_LEGAL_INSTRUCTION_17 = {((decode_INSTRUCTION & 32'hbe00707f) == 32'h00000033),{((decode_INSTRUCTION & 32'hf9f0707f) == 32'h1000202f),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_18) == 32'h12000073),{(_zz_decode_LEGAL_INSTRUCTION_19 == _zz_decode_LEGAL_INSTRUCTION_20),{_zz_decode_LEGAL_INSTRUCTION_21,_zz_decode_LEGAL_INSTRUCTION_22}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_18 = 32'hfe007fff;
  assign _zz_decode_LEGAL_INSTRUCTION_19 = (decode_INSTRUCTION & 32'hdfffffff);
  assign _zz_decode_LEGAL_INSTRUCTION_20 = 32'h10200073;
  assign _zz_decode_LEGAL_INSTRUCTION_21 = ((decode_INSTRUCTION & 32'hffefffff) == 32'h00000073);
  assign _zz_decode_LEGAL_INSTRUCTION_22 = ((decode_INSTRUCTION & 32'hffffffff) == 32'h10500073);
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_4 = decode_INSTRUCTION[31];
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_5 = decode_INSTRUCTION[31];
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_6 = decode_INSTRUCTION[7];
  assign _zz_MmuPlugin_ports_0_cacheHitsCalc = IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22];
  assign _zz_MmuPlugin_ports_0_cacheHitsCalc_1 = IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12];
  assign _zz_MmuPlugin_ports_0_cacheHitsCalc_2 = (MmuPlugin_ports_0_cache_1_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22]);
  assign _zz_MmuPlugin_ports_0_cacheHitsCalc_3 = (MmuPlugin_ports_0_cache_1_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12]);
  assign _zz_MmuPlugin_ports_0_cacheHitsCalc_4 = (MmuPlugin_ports_0_cache_0_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22]);
  assign _zz_MmuPlugin_ports_0_cacheHitsCalc_5 = (MmuPlugin_ports_0_cache_0_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12]);
  assign _zz_MmuPlugin_ports_1_cacheHitsCalc = DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22];
  assign _zz_MmuPlugin_ports_1_cacheHitsCalc_1 = DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12];
  assign _zz_MmuPlugin_ports_1_cacheHitsCalc_2 = (MmuPlugin_ports_1_cache_1_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22]);
  assign _zz_MmuPlugin_ports_1_cacheHitsCalc_3 = (MmuPlugin_ports_1_cache_1_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12]);
  assign _zz_MmuPlugin_ports_1_cacheHitsCalc_4 = (MmuPlugin_ports_1_cache_0_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22]);
  assign _zz_MmuPlugin_ports_1_cacheHitsCalc_5 = (MmuPlugin_ports_1_cache_0_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12]);
  assign _zz__zz_decode_IS_CSR = (decode_INSTRUCTION & 32'h00001050);
  assign _zz__zz_decode_IS_CSR_1 = 32'h00001050;
  assign _zz__zz_decode_IS_CSR_2 = (decode_INSTRUCTION & 32'h00002050);
  assign _zz__zz_decode_IS_CSR_3 = 32'h00002050;
  assign _zz__zz_decode_IS_CSR_4 = ((decode_INSTRUCTION & 32'h0000001c) == 32'h00000004);
  assign _zz__zz_decode_IS_CSR_5 = ((decode_INSTRUCTION & 32'h00000058) == 32'h00000040);
  assign _zz__zz_decode_IS_CSR_6 = _zz_decode_IS_CSR_11;
  assign _zz__zz_decode_IS_CSR_7 = (|{(_zz__zz_decode_IS_CSR_8 == _zz__zz_decode_IS_CSR_9),(_zz__zz_decode_IS_CSR_10 == _zz__zz_decode_IS_CSR_11)});
  assign _zz__zz_decode_IS_CSR_12 = (|(_zz__zz_decode_IS_CSR_13 == _zz__zz_decode_IS_CSR_14));
  assign _zz__zz_decode_IS_CSR_15 = {(|_zz_decode_IS_CSR_11),{(|_zz__zz_decode_IS_CSR_16),{_zz__zz_decode_IS_CSR_17,{_zz__zz_decode_IS_CSR_18,_zz__zz_decode_IS_CSR_20}}}};
  assign _zz__zz_decode_IS_CSR_8 = (decode_INSTRUCTION & 32'h10103050);
  assign _zz__zz_decode_IS_CSR_9 = 32'h00000050;
  assign _zz__zz_decode_IS_CSR_10 = (decode_INSTRUCTION & 32'h12203050);
  assign _zz__zz_decode_IS_CSR_11 = 32'h10000050;
  assign _zz__zz_decode_IS_CSR_13 = (decode_INSTRUCTION & 32'h02103050);
  assign _zz__zz_decode_IS_CSR_14 = 32'h00000050;
  assign _zz__zz_decode_IS_CSR_16 = _zz_decode_IS_CSR_10;
  assign _zz__zz_decode_IS_CSR_17 = (|_zz_decode_IS_CSR_10);
  assign _zz__zz_decode_IS_CSR_18 = (|((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_19) == 32'h02004020));
  assign _zz__zz_decode_IS_CSR_20 = {(|(_zz__zz_decode_IS_CSR_21 == _zz__zz_decode_IS_CSR_22)),{(|_zz__zz_decode_IS_CSR_23),{(|_zz__zz_decode_IS_CSR_24),{_zz__zz_decode_IS_CSR_27,{_zz__zz_decode_IS_CSR_29,_zz__zz_decode_IS_CSR_32}}}}};
  assign _zz__zz_decode_IS_CSR_19 = 32'h02004064;
  assign _zz__zz_decode_IS_CSR_21 = (decode_INSTRUCTION & 32'h02004074);
  assign _zz__zz_decode_IS_CSR_22 = 32'h02000030;
  assign _zz__zz_decode_IS_CSR_23 = ((decode_INSTRUCTION & 32'h02007054) == 32'h00005010);
  assign _zz__zz_decode_IS_CSR_24 = {((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_25) == 32'h40001010),((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_26) == 32'h00001010)};
  assign _zz__zz_decode_IS_CSR_27 = (|((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_28) == 32'h00001000));
  assign _zz__zz_decode_IS_CSR_29 = (|(_zz__zz_decode_IS_CSR_30 == _zz__zz_decode_IS_CSR_31));
  assign _zz__zz_decode_IS_CSR_32 = {(|{_zz__zz_decode_IS_CSR_33,_zz__zz_decode_IS_CSR_34}),{(|_zz__zz_decode_IS_CSR_35),{_zz__zz_decode_IS_CSR_36,{_zz__zz_decode_IS_CSR_38,_zz__zz_decode_IS_CSR_41}}}};
  assign _zz__zz_decode_IS_CSR_25 = 32'h40003054;
  assign _zz__zz_decode_IS_CSR_26 = 32'h02007054;
  assign _zz__zz_decode_IS_CSR_28 = 32'h00001000;
  assign _zz__zz_decode_IS_CSR_30 = (decode_INSTRUCTION & 32'h00003000);
  assign _zz__zz_decode_IS_CSR_31 = 32'h00002000;
  assign _zz__zz_decode_IS_CSR_33 = _zz_decode_IS_CSR_9;
  assign _zz__zz_decode_IS_CSR_34 = ((decode_INSTRUCTION & 32'h00005000) == 32'h00001000);
  assign _zz__zz_decode_IS_CSR_35 = _zz_decode_IS_CSR_2;
  assign _zz__zz_decode_IS_CSR_36 = (|((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_37) == 32'h00004008));
  assign _zz__zz_decode_IS_CSR_38 = (|(_zz__zz_decode_IS_CSR_39 == _zz__zz_decode_IS_CSR_40));
  assign _zz__zz_decode_IS_CSR_41 = {(|{_zz__zz_decode_IS_CSR_42,_zz__zz_decode_IS_CSR_44}),{(|_zz__zz_decode_IS_CSR_49),{_zz__zz_decode_IS_CSR_51,{_zz__zz_decode_IS_CSR_54,_zz__zz_decode_IS_CSR_66}}}};
  assign _zz__zz_decode_IS_CSR_37 = 32'h00004048;
  assign _zz__zz_decode_IS_CSR_39 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz__zz_decode_IS_CSR_40 = 32'h00000024;
  assign _zz__zz_decode_IS_CSR_42 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_43) == 32'h00000020);
  assign _zz__zz_decode_IS_CSR_44 = {(_zz__zz_decode_IS_CSR_45 == _zz__zz_decode_IS_CSR_46),{_zz__zz_decode_IS_CSR_47,_zz__zz_decode_IS_CSR_48}};
  assign _zz__zz_decode_IS_CSR_49 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_50) == 32'h00000008);
  assign _zz__zz_decode_IS_CSR_51 = (|(_zz__zz_decode_IS_CSR_52 == _zz__zz_decode_IS_CSR_53));
  assign _zz__zz_decode_IS_CSR_54 = (|{_zz__zz_decode_IS_CSR_55,_zz__zz_decode_IS_CSR_57});
  assign _zz__zz_decode_IS_CSR_66 = {(|_zz__zz_decode_IS_CSR_67),{_zz__zz_decode_IS_CSR_74,{_zz__zz_decode_IS_CSR_87,_zz__zz_decode_IS_CSR_100}}};
  assign _zz__zz_decode_IS_CSR_43 = 32'h00000034;
  assign _zz__zz_decode_IS_CSR_45 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz__zz_decode_IS_CSR_46 = 32'h00000020;
  assign _zz__zz_decode_IS_CSR_47 = ((decode_INSTRUCTION & 32'h08000070) == 32'h08000020);
  assign _zz__zz_decode_IS_CSR_48 = ((decode_INSTRUCTION & 32'h10000070) == 32'h00000020);
  assign _zz__zz_decode_IS_CSR_50 = 32'h10000008;
  assign _zz__zz_decode_IS_CSR_52 = (decode_INSTRUCTION & 32'h10000008);
  assign _zz__zz_decode_IS_CSR_53 = 32'h10000008;
  assign _zz__zz_decode_IS_CSR_55 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_56) == 32'h00002040);
  assign _zz__zz_decode_IS_CSR_57 = {(_zz__zz_decode_IS_CSR_58 == _zz__zz_decode_IS_CSR_59),{_zz__zz_decode_IS_CSR_60,{_zz__zz_decode_IS_CSR_62,_zz__zz_decode_IS_CSR_63}}};
  assign _zz__zz_decode_IS_CSR_67 = {(_zz__zz_decode_IS_CSR_68 == _zz__zz_decode_IS_CSR_69),{_zz__zz_decode_IS_CSR_70,_zz__zz_decode_IS_CSR_72}};
  assign _zz__zz_decode_IS_CSR_74 = (|{_zz__zz_decode_IS_CSR_75,{_zz__zz_decode_IS_CSR_77,_zz__zz_decode_IS_CSR_80}});
  assign _zz__zz_decode_IS_CSR_87 = (|{_zz__zz_decode_IS_CSR_88,_zz__zz_decode_IS_CSR_89});
  assign _zz__zz_decode_IS_CSR_100 = {(|_zz__zz_decode_IS_CSR_101),{_zz__zz_decode_IS_CSR_116,{_zz__zz_decode_IS_CSR_121,_zz__zz_decode_IS_CSR_125}}};
  assign _zz__zz_decode_IS_CSR_56 = 32'h00002040;
  assign _zz__zz_decode_IS_CSR_58 = (decode_INSTRUCTION & 32'h00001040);
  assign _zz__zz_decode_IS_CSR_59 = 32'h00001040;
  assign _zz__zz_decode_IS_CSR_60 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_61) == 32'h00000040);
  assign _zz__zz_decode_IS_CSR_62 = _zz_decode_IS_CSR_9;
  assign _zz__zz_decode_IS_CSR_63 = {_zz_decode_IS_CSR_6,_zz__zz_decode_IS_CSR_64};
  assign _zz__zz_decode_IS_CSR_68 = (decode_INSTRUCTION & 32'h08000020);
  assign _zz__zz_decode_IS_CSR_69 = 32'h08000020;
  assign _zz__zz_decode_IS_CSR_70 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_71) == 32'h00000020);
  assign _zz__zz_decode_IS_CSR_72 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_73) == 32'h00000020);
  assign _zz__zz_decode_IS_CSR_75 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_76) == 32'h00000040);
  assign _zz__zz_decode_IS_CSR_77 = (_zz__zz_decode_IS_CSR_78 == _zz__zz_decode_IS_CSR_79);
  assign _zz__zz_decode_IS_CSR_80 = {_zz__zz_decode_IS_CSR_81,{_zz__zz_decode_IS_CSR_83,_zz__zz_decode_IS_CSR_86}};
  assign _zz__zz_decode_IS_CSR_88 = _zz_decode_IS_CSR_8;
  assign _zz__zz_decode_IS_CSR_89 = {_zz__zz_decode_IS_CSR_90,{_zz__zz_decode_IS_CSR_92,_zz__zz_decode_IS_CSR_95}};
  assign _zz__zz_decode_IS_CSR_101 = {_zz_decode_IS_CSR_4,{_zz__zz_decode_IS_CSR_102,_zz__zz_decode_IS_CSR_105}};
  assign _zz__zz_decode_IS_CSR_116 = (|{_zz__zz_decode_IS_CSR_117,_zz__zz_decode_IS_CSR_118});
  assign _zz__zz_decode_IS_CSR_121 = (|_zz__zz_decode_IS_CSR_122);
  assign _zz__zz_decode_IS_CSR_125 = {_zz__zz_decode_IS_CSR_126,{_zz__zz_decode_IS_CSR_129,_zz__zz_decode_IS_CSR_133}};
  assign _zz__zz_decode_IS_CSR_61 = 32'h00000050;
  assign _zz__zz_decode_IS_CSR_64 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_65) == 32'h00000040);
  assign _zz__zz_decode_IS_CSR_71 = 32'h10000020;
  assign _zz__zz_decode_IS_CSR_73 = 32'h00000028;
  assign _zz__zz_decode_IS_CSR_76 = 32'h00000040;
  assign _zz__zz_decode_IS_CSR_78 = (decode_INSTRUCTION & 32'h00004020);
  assign _zz__zz_decode_IS_CSR_79 = 32'h00004020;
  assign _zz__zz_decode_IS_CSR_81 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_82) == 32'h00000010);
  assign _zz__zz_decode_IS_CSR_83 = (_zz__zz_decode_IS_CSR_84 == _zz__zz_decode_IS_CSR_85);
  assign _zz__zz_decode_IS_CSR_86 = _zz_decode_IS_CSR_8;
  assign _zz__zz_decode_IS_CSR_90 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_91) == 32'h00002010);
  assign _zz__zz_decode_IS_CSR_92 = (_zz__zz_decode_IS_CSR_93 == _zz__zz_decode_IS_CSR_94);
  assign _zz__zz_decode_IS_CSR_95 = {_zz__zz_decode_IS_CSR_96,_zz__zz_decode_IS_CSR_98};
  assign _zz__zz_decode_IS_CSR_102 = (_zz__zz_decode_IS_CSR_103 == _zz__zz_decode_IS_CSR_104);
  assign _zz__zz_decode_IS_CSR_105 = {_zz__zz_decode_IS_CSR_106,{_zz__zz_decode_IS_CSR_108,_zz__zz_decode_IS_CSR_111}};
  assign _zz__zz_decode_IS_CSR_117 = _zz_decode_IS_CSR_7;
  assign _zz__zz_decode_IS_CSR_118 = (_zz__zz_decode_IS_CSR_119 == _zz__zz_decode_IS_CSR_120);
  assign _zz__zz_decode_IS_CSR_122 = {_zz_decode_IS_CSR_7,_zz__zz_decode_IS_CSR_123};
  assign _zz__zz_decode_IS_CSR_126 = (|_zz__zz_decode_IS_CSR_127);
  assign _zz__zz_decode_IS_CSR_129 = (|_zz__zz_decode_IS_CSR_130);
  assign _zz__zz_decode_IS_CSR_133 = {_zz__zz_decode_IS_CSR_134,{_zz__zz_decode_IS_CSR_145,_zz__zz_decode_IS_CSR_149}};
  assign _zz__zz_decode_IS_CSR_65 = 32'h02400040;
  assign _zz__zz_decode_IS_CSR_82 = 32'h00000030;
  assign _zz__zz_decode_IS_CSR_84 = (decode_INSTRUCTION & 32'h02000010);
  assign _zz__zz_decode_IS_CSR_85 = 32'h00000010;
  assign _zz__zz_decode_IS_CSR_91 = 32'h00002030;
  assign _zz__zz_decode_IS_CSR_93 = (decode_INSTRUCTION & 32'h00001030);
  assign _zz__zz_decode_IS_CSR_94 = 32'h00000010;
  assign _zz__zz_decode_IS_CSR_96 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_97) == 32'h00000020);
  assign _zz__zz_decode_IS_CSR_98 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_99) == 32'h00002020);
  assign _zz__zz_decode_IS_CSR_103 = (decode_INSTRUCTION & 32'h00001010);
  assign _zz__zz_decode_IS_CSR_104 = 32'h00001010;
  assign _zz__zz_decode_IS_CSR_106 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_107) == 32'h00002010);
  assign _zz__zz_decode_IS_CSR_108 = (_zz__zz_decode_IS_CSR_109 == _zz__zz_decode_IS_CSR_110);
  assign _zz__zz_decode_IS_CSR_111 = {_zz__zz_decode_IS_CSR_112,{_zz__zz_decode_IS_CSR_113,_zz__zz_decode_IS_CSR_114}};
  assign _zz__zz_decode_IS_CSR_119 = (decode_INSTRUCTION & 32'h00000070);
  assign _zz__zz_decode_IS_CSR_120 = 32'h00000020;
  assign _zz__zz_decode_IS_CSR_123 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_124) == 32'h0);
  assign _zz__zz_decode_IS_CSR_127 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_128) == 32'h00004010);
  assign _zz__zz_decode_IS_CSR_130 = (_zz__zz_decode_IS_CSR_131 == _zz__zz_decode_IS_CSR_132);
  assign _zz__zz_decode_IS_CSR_134 = (|{_zz__zz_decode_IS_CSR_135,_zz__zz_decode_IS_CSR_137});
  assign _zz__zz_decode_IS_CSR_145 = (|_zz__zz_decode_IS_CSR_146);
  assign _zz__zz_decode_IS_CSR_149 = {_zz__zz_decode_IS_CSR_150,{_zz__zz_decode_IS_CSR_159,_zz__zz_decode_IS_CSR_163}};
  assign _zz__zz_decode_IS_CSR_97 = 32'h02003020;
  assign _zz__zz_decode_IS_CSR_99 = 32'h02002068;
  assign _zz__zz_decode_IS_CSR_107 = 32'h00002010;
  assign _zz__zz_decode_IS_CSR_109 = (decode_INSTRUCTION & 32'h00002008);
  assign _zz__zz_decode_IS_CSR_110 = 32'h00002008;
  assign _zz__zz_decode_IS_CSR_112 = ((decode_INSTRUCTION & 32'h00000050) == 32'h00000010);
  assign _zz__zz_decode_IS_CSR_113 = _zz_decode_IS_CSR_8;
  assign _zz__zz_decode_IS_CSR_114 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_115) == 32'h0);
  assign _zz__zz_decode_IS_CSR_124 = 32'h00000020;
  assign _zz__zz_decode_IS_CSR_128 = 32'h00004014;
  assign _zz__zz_decode_IS_CSR_131 = (decode_INSTRUCTION & 32'h00006014);
  assign _zz__zz_decode_IS_CSR_132 = 32'h00002010;
  assign _zz__zz_decode_IS_CSR_135 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_136) == 32'h0);
  assign _zz__zz_decode_IS_CSR_137 = {_zz_decode_IS_CSR_6,{_zz__zz_decode_IS_CSR_138,{_zz__zz_decode_IS_CSR_140,_zz__zz_decode_IS_CSR_143}}};
  assign _zz__zz_decode_IS_CSR_146 = {_zz_decode_IS_CSR_5,(_zz__zz_decode_IS_CSR_147 == _zz__zz_decode_IS_CSR_148)};
  assign _zz__zz_decode_IS_CSR_150 = (|{_zz__zz_decode_IS_CSR_151,{_zz__zz_decode_IS_CSR_153,_zz__zz_decode_IS_CSR_156}});
  assign _zz__zz_decode_IS_CSR_159 = (|{_zz__zz_decode_IS_CSR_160,_zz__zz_decode_IS_CSR_161});
  assign _zz__zz_decode_IS_CSR_163 = {(|_zz__zz_decode_IS_CSR_164),{_zz__zz_decode_IS_CSR_166,_zz__zz_decode_IS_CSR_169}};
  assign _zz__zz_decode_IS_CSR_115 = 32'h00000028;
  assign _zz__zz_decode_IS_CSR_136 = 32'h00000044;
  assign _zz__zz_decode_IS_CSR_138 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_139) == 32'h00002000);
  assign _zz__zz_decode_IS_CSR_140 = (_zz__zz_decode_IS_CSR_141 == _zz__zz_decode_IS_CSR_142);
  assign _zz__zz_decode_IS_CSR_143 = {_zz__zz_decode_IS_CSR_144,_zz_decode_IS_CSR_5};
  assign _zz__zz_decode_IS_CSR_147 = (decode_INSTRUCTION & 32'h00000058);
  assign _zz__zz_decode_IS_CSR_148 = 32'h0;
  assign _zz__zz_decode_IS_CSR_151 = ((decode_INSTRUCTION & _zz__zz_decode_IS_CSR_152) == 32'h00000040);
  assign _zz__zz_decode_IS_CSR_153 = (_zz__zz_decode_IS_CSR_154 == _zz__zz_decode_IS_CSR_155);
  assign _zz__zz_decode_IS_CSR_156 = (_zz__zz_decode_IS_CSR_157 == _zz__zz_decode_IS_CSR_158);
  assign _zz__zz_decode_IS_CSR_160 = _zz_decode_IS_CSR_4;
  assign _zz__zz_decode_IS_CSR_161 = {_zz_decode_IS_CSR_3,_zz__zz_decode_IS_CSR_162};
  assign _zz__zz_decode_IS_CSR_164 = {_zz_decode_IS_CSR_3,_zz__zz_decode_IS_CSR_165};
  assign _zz__zz_decode_IS_CSR_166 = (|{_zz__zz_decode_IS_CSR_167,_zz__zz_decode_IS_CSR_168});
  assign _zz__zz_decode_IS_CSR_169 = (|_zz_decode_IS_CSR_1);
  assign _zz__zz_decode_IS_CSR_139 = 32'h00006004;
  assign _zz__zz_decode_IS_CSR_141 = (decode_INSTRUCTION & 32'h00005004);
  assign _zz__zz_decode_IS_CSR_142 = 32'h00001000;
  assign _zz__zz_decode_IS_CSR_144 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004000);
  assign _zz__zz_decode_IS_CSR_152 = 32'h00000044;
  assign _zz__zz_decode_IS_CSR_154 = (decode_INSTRUCTION & 32'h00002014);
  assign _zz__zz_decode_IS_CSR_155 = 32'h00002010;
  assign _zz__zz_decode_IS_CSR_157 = (decode_INSTRUCTION & 32'h40000034);
  assign _zz__zz_decode_IS_CSR_158 = 32'h40000030;
  assign _zz__zz_decode_IS_CSR_162 = ((decode_INSTRUCTION & 32'h00002014) == 32'h00000004);
  assign _zz__zz_decode_IS_CSR_165 = ((decode_INSTRUCTION & 32'h0000004c) == 32'h00000004);
  assign _zz__zz_decode_IS_CSR_167 = _zz_decode_IS_CSR_1;
  assign _zz__zz_decode_IS_CSR_168 = _zz_decode_IS_CSR_2;
  assign _zz_execute_BranchPlugin_branch_src2_6 = execute_INSTRUCTION[31];
  assign _zz_execute_BranchPlugin_branch_src2_7 = execute_INSTRUCTION[19 : 12];
  assign _zz_execute_BranchPlugin_branch_src2_8 = execute_INSTRUCTION[20];
  assign _zz_execute_BranchPlugin_branch_src2_9 = execute_INSTRUCTION[31];
  assign _zz_execute_BranchPlugin_branch_src2_10 = execute_INSTRUCTION[7];
  assign _zz_CsrPlugin_csrMapping_readDataInit_25 = 32'h0;
  assign _zz_CsrPlugin_csrMapping_readDataInit_26 = 32'h0;
  assign _zz_CsrPlugin_csrMapping_readDataInit_27 = 32'h0;
  assign _zz_CsrPlugin_csrMapping_readDataInit_28 = 32'h0;
  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs1Data) begin
      RegFilePlugin_regFile_spinal_port0 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs2Data) begin
      RegFilePlugin_regFile_spinal_port1 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  AxiLite4Clint clintCtrl (
    .io_bus_aw_valid        (clint_awvalid                        ), //i
    .io_bus_aw_ready        (clintCtrl_io_bus_aw_ready            ), //o
    .io_bus_aw_payload_addr (clint_awaddr[15:0]                   ), //i
    .io_bus_aw_payload_prot (clint_awprot[2:0]                    ), //i
    .io_bus_w_valid         (clint_wvalid                         ), //i
    .io_bus_w_ready         (clintCtrl_io_bus_w_ready             ), //o
    .io_bus_w_payload_data  (clint_wdata[31:0]                    ), //i
    .io_bus_w_payload_strb  (clint_wstrb[3:0]                     ), //i
    .io_bus_b_valid         (clintCtrl_io_bus_b_valid             ), //o
    .io_bus_b_ready         (clint_bready                         ), //i
    .io_bus_b_payload_resp  (clintCtrl_io_bus_b_payload_resp[1:0] ), //o
    .io_bus_ar_valid        (clint_arvalid                        ), //i
    .io_bus_ar_ready        (clintCtrl_io_bus_ar_ready            ), //o
    .io_bus_ar_payload_addr (clint_araddr[15:0]                   ), //i
    .io_bus_ar_payload_prot (clint_arprot[2:0]                    ), //i
    .io_bus_r_valid         (clintCtrl_io_bus_r_valid             ), //o
    .io_bus_r_ready         (clint_rready                         ), //i
    .io_bus_r_payload_data  (clintCtrl_io_bus_r_payload_data[31:0]), //o
    .io_bus_r_payload_resp  (clintCtrl_io_bus_r_payload_resp[1:0] ), //o
    .io_timerInterrupt      (clintCtrl_io_timerInterrupt          ), //o
    .io_softwareInterrupt   (clintCtrl_io_softwareInterrupt       ), //o
    .io_time                (clintCtrl_io_time[63:0]              ), //o
    .clk                    (clk                                  ), //i
    .reset                  (reset                                )  //i
  );
  AxiLite4Plic plicCtrl (
    .io_bus_aw_valid        (plic_awvalid                        ), //i
    .io_bus_aw_ready        (plicCtrl_io_bus_aw_ready            ), //o
    .io_bus_aw_payload_addr (plic_awaddr[21:0]                   ), //i
    .io_bus_aw_payload_prot (plic_awprot[2:0]                    ), //i
    .io_bus_w_valid         (plic_wvalid                         ), //i
    .io_bus_w_ready         (plicCtrl_io_bus_w_ready             ), //o
    .io_bus_w_payload_data  (plic_wdata[31:0]                    ), //i
    .io_bus_w_payload_strb  (plic_wstrb[3:0]                     ), //i
    .io_bus_b_valid         (plicCtrl_io_bus_b_valid             ), //o
    .io_bus_b_ready         (plic_bready                         ), //i
    .io_bus_b_payload_resp  (plicCtrl_io_bus_b_payload_resp[1:0] ), //o
    .io_bus_ar_valid        (plic_arvalid                        ), //i
    .io_bus_ar_ready        (plicCtrl_io_bus_ar_ready            ), //o
    .io_bus_ar_payload_addr (plic_araddr[21:0]                   ), //i
    .io_bus_ar_payload_prot (plic_arprot[2:0]                    ), //i
    .io_bus_r_valid         (plicCtrl_io_bus_r_valid             ), //o
    .io_bus_r_ready         (plic_rready                         ), //i
    .io_bus_r_payload_data  (plicCtrl_io_bus_r_payload_data[31:0]), //o
    .io_bus_r_payload_resp  (plicCtrl_io_bus_r_payload_resp[1:0] ), //o
    .io_sources             (plicCtrl_io_sources[30:0]           ), //i
    .io_targets             (plicCtrl_io_targets[1:0]            ), //o
    .clk                    (clk                                 ), //i
    .reset                  (reset                               )  //i
  );
  AlvxApb u_apb (
    .io_apb_PADDR             (apb_PADDR[19:0]                 ), //i
    .io_apb_PSEL              (apb_PSEL                        ), //i
    .io_apb_PENABLE           (apb_PENABLE                     ), //i
    .io_apb_PREADY            (u_apb_io_apb_PREADY             ), //o
    .io_apb_PWRITE            (apb_PWRITE                      ), //i
    .io_apb_PWDATA            (apb_PWDATA[31:0]                ), //i
    .io_apb_PRDATA            (u_apb_io_apb_PRDATA[31:0]       ), //o
    .io_apb_PSLVERROR         (u_apb_io_apb_PSLVERROR          ), //o
    .io_uart_txd              (u_apb_io_uart_txd               ), //o
    .io_uart_rxd              (uart_rxd                        ), //i
    .io_leds                  (u_apb_io_leds[5:0]              ), //o
    .io_keys                  (keys[3:0]                       ), //i
    .io_ext1                  (u_apb_io_ext1[31:0]             ), //o
    .io_ext2                  (u_apb_io_ext2[31:0]             ), //o
    .io_sd_sclk               (u_apb_io_sd_sclk                ), //o
    .io_sd_mosi               (u_apb_io_sd_mosi                ), //o
    .io_sd_miso               (sd_miso                         ), //i
    .io_sd_ncs                (u_apb_io_sd_ncs                 ), //o
    .io_irq_uart              (u_apb_io_irq_uart               ), //o
    .io_irq_spi               (u_apb_io_irq_spi                ), //o
    .io_irq_key               (u_apb_io_irq_key                ), //o
    .io_pix_clk               (pix_clk                         ), //i
    .io_pix_reset             (pix_reset                       ), //i
    .io_vid_mem_read          (u_apb_io_vid_mem_read           ), //o
    .io_vid_mem_waitRequestn  (vidMemAvalon_waitRequestn       ), //i
    .io_vid_mem_address       (u_apb_io_vid_mem_address[29:0]  ), //o
    .io_vid_mem_burstCount    (u_apb_io_vid_mem_burstCount[3:0]), //o
    .io_vid_mem_readDataValid (vidMemAvalon_readDataValid      ), //i
    .io_vid_mem_readData      (vidMemAvalon_readData[31:0]     ), //i
    .io_tmds0                 (u_apb_io_tmds0[9:0]             ), //o
    .io_tmds1                 (u_apb_io_tmds1[9:0]             ), //o
    .io_tmds2                 (u_apb_io_tmds2[9:0]             ), //o
    .io_vid_status            (u_apb_io_vid_status[3:0]        ), //o
    .clk                      (clk                             ), //i
    .reset                    (reset                           )  //i
  );
  InstructionCache IBusCachedPlugin_cache (
    .io_flush                              (IBusCachedPlugin_cache_io_flush                           ), //i
    .io_cpu_prefetch_isValid               (IBusCachedPlugin_cache_io_cpu_prefetch_isValid            ), //i
    .io_cpu_prefetch_haltIt                (IBusCachedPlugin_cache_io_cpu_prefetch_haltIt             ), //o
    .io_cpu_prefetch_pc                    (IBusCachedPlugin_iBusRsp_stages_0_input_payload[31:0]     ), //i
    .io_cpu_fetch_isValid                  (IBusCachedPlugin_cache_io_cpu_fetch_isValid               ), //i
    .io_cpu_fetch_isStuck                  (IBusCachedPlugin_cache_io_cpu_fetch_isStuck               ), //i
    .io_cpu_fetch_isRemoved                (                                                          ), //i
    .io_cpu_fetch_pc                       (IBusCachedPlugin_iBusRsp_stages_1_input_payload[31:0]     ), //i
    .io_cpu_fetch_data                     (IBusCachedPlugin_cache_io_cpu_fetch_data[31:0]            ), //o
    .io_cpu_fetch_mmuRsp_physicalAddress   (IBusCachedPlugin_mmuBus_rsp_physicalAddress[31:0]         ), //i
    .io_cpu_fetch_mmuRsp_isIoAccess        (IBusCachedPlugin_mmuBus_rsp_isIoAccess                    ), //i
    .io_cpu_fetch_mmuRsp_isPaging          (IBusCachedPlugin_mmuBus_rsp_isPaging                      ), //i
    .io_cpu_fetch_mmuRsp_allowRead         (IBusCachedPlugin_mmuBus_rsp_allowRead                     ), //i
    .io_cpu_fetch_mmuRsp_allowWrite        (IBusCachedPlugin_mmuBus_rsp_allowWrite                    ), //i
    .io_cpu_fetch_mmuRsp_allowExecute      (IBusCachedPlugin_mmuBus_rsp_allowExecute                  ), //i
    .io_cpu_fetch_mmuRsp_exception         (IBusCachedPlugin_mmuBus_rsp_exception                     ), //i
    .io_cpu_fetch_mmuRsp_refilling         (IBusCachedPlugin_mmuBus_rsp_refilling                     ), //i
    .io_cpu_fetch_mmuRsp_bypassTranslation (IBusCachedPlugin_mmuBus_rsp_bypassTranslation             ), //i
    .io_cpu_fetch_mmuRsp_ways_0_sel        (IBusCachedPlugin_mmuBus_rsp_ways_0_sel                    ), //i
    .io_cpu_fetch_mmuRsp_ways_0_physical   (IBusCachedPlugin_mmuBus_rsp_ways_0_physical[31:0]         ), //i
    .io_cpu_fetch_mmuRsp_ways_1_sel        (IBusCachedPlugin_mmuBus_rsp_ways_1_sel                    ), //i
    .io_cpu_fetch_mmuRsp_ways_1_physical   (IBusCachedPlugin_mmuBus_rsp_ways_1_physical[31:0]         ), //i
    .io_cpu_fetch_mmuRsp_ways_2_sel        (IBusCachedPlugin_mmuBus_rsp_ways_2_sel                    ), //i
    .io_cpu_fetch_mmuRsp_ways_2_physical   (IBusCachedPlugin_mmuBus_rsp_ways_2_physical[31:0]         ), //i
    .io_cpu_fetch_mmuRsp_ways_3_sel        (IBusCachedPlugin_mmuBus_rsp_ways_3_sel                    ), //i
    .io_cpu_fetch_mmuRsp_ways_3_physical   (IBusCachedPlugin_mmuBus_rsp_ways_3_physical[31:0]         ), //i
    .io_cpu_fetch_physicalAddress          (IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress[31:0] ), //o
    .io_cpu_decode_isValid                 (IBusCachedPlugin_cache_io_cpu_decode_isValid              ), //i
    .io_cpu_decode_isStuck                 (IBusCachedPlugin_cache_io_cpu_decode_isStuck              ), //i
    .io_cpu_decode_pc                      (IBusCachedPlugin_iBusRsp_stages_2_input_payload[31:0]     ), //i
    .io_cpu_decode_physicalAddress         (IBusCachedPlugin_cache_io_cpu_decode_physicalAddress[31:0]), //o
    .io_cpu_decode_data                    (IBusCachedPlugin_cache_io_cpu_decode_data[31:0]           ), //o
    .io_cpu_decode_cacheMiss               (IBusCachedPlugin_cache_io_cpu_decode_cacheMiss            ), //o
    .io_cpu_decode_error                   (IBusCachedPlugin_cache_io_cpu_decode_error                ), //o
    .io_cpu_decode_mmuRefilling            (IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling         ), //o
    .io_cpu_decode_mmuException            (IBusCachedPlugin_cache_io_cpu_decode_mmuException         ), //o
    .io_cpu_decode_isUser                  (IBusCachedPlugin_cache_io_cpu_decode_isUser               ), //i
    .io_cpu_fill_valid                     (IBusCachedPlugin_cache_io_cpu_fill_valid                  ), //i
    .io_cpu_fill_payload                   (IBusCachedPlugin_cache_io_cpu_decode_physicalAddress[31:0]), //i
    .io_mem_cmd_valid                      (IBusCachedPlugin_cache_io_mem_cmd_valid                   ), //o
    .io_mem_cmd_ready                      (iBus_cmd_ready                                            ), //i
    .io_mem_cmd_payload_address            (IBusCachedPlugin_cache_io_mem_cmd_payload_address[31:0]   ), //o
    .io_mem_cmd_payload_size               (IBusCachedPlugin_cache_io_mem_cmd_payload_size[2:0]       ), //o
    .io_mem_rsp_valid                      (iBus_rsp_valid                                            ), //i
    .io_mem_rsp_payload_data               (iBus_rsp_payload_data[31:0]                               ), //i
    .io_mem_rsp_payload_error              (iBus_rsp_payload_error                                    ), //i
    ._zz_when_Fetcher_l411                 (IBusCachedPlugin_injector_port_state[2:0]                 ), //i
    ._zz_decodeStage_hit_data_1            (DebugPlugin_injectionPort_payload[31:0]                   ), //i
    .clk                                   (clk                                                       ), //i
    .reset                                 (reset                                                     )  //i
  );
  DataCache dataCache_1 (
    .io_cpu_execute_isValid                 (dataCache_1_io_cpu_execute_isValid               ), //i
    .io_cpu_execute_address                 (dataCache_1_io_cpu_execute_address[31:0]         ), //i
    .io_cpu_execute_haltIt                  (dataCache_1_io_cpu_execute_haltIt                ), //o
    .io_cpu_execute_args_wr                 (dataCache_1_io_cpu_execute_args_wr               ), //i
    .io_cpu_execute_args_size               (dataCache_1_io_cpu_execute_args_size[1:0]        ), //i
    .io_cpu_execute_args_isLrsc             (dataCache_1_io_cpu_execute_args_isLrsc           ), //i
    .io_cpu_execute_args_isAmo              (execute_MEMORY_AMO                               ), //i
    .io_cpu_execute_args_amoCtrl_swap       (dataCache_1_io_cpu_execute_args_amoCtrl_swap     ), //i
    .io_cpu_execute_args_amoCtrl_alu        (dataCache_1_io_cpu_execute_args_amoCtrl_alu[2:0] ), //i
    .io_cpu_execute_args_totalyConsistent   (execute_MEMORY_FORCE_CONSTISTENCY                ), //i
    .io_cpu_execute_refilling               (dataCache_1_io_cpu_execute_refilling             ), //o
    .io_cpu_memory_isValid                  (dataCache_1_io_cpu_memory_isValid                ), //i
    .io_cpu_memory_isStuck                  (memory_arbitration_isStuck                       ), //i
    .io_cpu_memory_isWrite                  (dataCache_1_io_cpu_memory_isWrite                ), //o
    .io_cpu_memory_address                  (dataCache_1_io_cpu_memory_address[31:0]          ), //i
    .io_cpu_memory_mmuRsp_physicalAddress   (DBusCachedPlugin_mmuBus_rsp_physicalAddress[31:0]), //i
    .io_cpu_memory_mmuRsp_isIoAccess        (dataCache_1_io_cpu_memory_mmuRsp_isIoAccess      ), //i
    .io_cpu_memory_mmuRsp_isPaging          (DBusCachedPlugin_mmuBus_rsp_isPaging             ), //i
    .io_cpu_memory_mmuRsp_allowRead         (DBusCachedPlugin_mmuBus_rsp_allowRead            ), //i
    .io_cpu_memory_mmuRsp_allowWrite        (DBusCachedPlugin_mmuBus_rsp_allowWrite           ), //i
    .io_cpu_memory_mmuRsp_allowExecute      (DBusCachedPlugin_mmuBus_rsp_allowExecute         ), //i
    .io_cpu_memory_mmuRsp_exception         (DBusCachedPlugin_mmuBus_rsp_exception            ), //i
    .io_cpu_memory_mmuRsp_refilling         (DBusCachedPlugin_mmuBus_rsp_refilling            ), //i
    .io_cpu_memory_mmuRsp_bypassTranslation (DBusCachedPlugin_mmuBus_rsp_bypassTranslation    ), //i
    .io_cpu_memory_mmuRsp_ways_0_sel        (DBusCachedPlugin_mmuBus_rsp_ways_0_sel           ), //i
    .io_cpu_memory_mmuRsp_ways_0_physical   (DBusCachedPlugin_mmuBus_rsp_ways_0_physical[31:0]), //i
    .io_cpu_memory_mmuRsp_ways_1_sel        (DBusCachedPlugin_mmuBus_rsp_ways_1_sel           ), //i
    .io_cpu_memory_mmuRsp_ways_1_physical   (DBusCachedPlugin_mmuBus_rsp_ways_1_physical[31:0]), //i
    .io_cpu_memory_mmuRsp_ways_2_sel        (DBusCachedPlugin_mmuBus_rsp_ways_2_sel           ), //i
    .io_cpu_memory_mmuRsp_ways_2_physical   (DBusCachedPlugin_mmuBus_rsp_ways_2_physical[31:0]), //i
    .io_cpu_memory_mmuRsp_ways_3_sel        (DBusCachedPlugin_mmuBus_rsp_ways_3_sel           ), //i
    .io_cpu_memory_mmuRsp_ways_3_physical   (DBusCachedPlugin_mmuBus_rsp_ways_3_physical[31:0]), //i
    .io_cpu_writeBack_isValid               (dataCache_1_io_cpu_writeBack_isValid             ), //i
    .io_cpu_writeBack_isStuck               (writeBack_arbitration_isStuck                    ), //i
    .io_cpu_writeBack_isFiring              (writeBack_arbitration_isFiring                   ), //i
    .io_cpu_writeBack_isUser                (dataCache_1_io_cpu_writeBack_isUser              ), //i
    .io_cpu_writeBack_haltIt                (dataCache_1_io_cpu_writeBack_haltIt              ), //o
    .io_cpu_writeBack_isWrite               (dataCache_1_io_cpu_writeBack_isWrite             ), //o
    .io_cpu_writeBack_storeData             (dataCache_1_io_cpu_writeBack_storeData[31:0]     ), //i
    .io_cpu_writeBack_data                  (dataCache_1_io_cpu_writeBack_data[31:0]          ), //o
    .io_cpu_writeBack_address               (dataCache_1_io_cpu_writeBack_address[31:0]       ), //i
    .io_cpu_writeBack_mmuException          (dataCache_1_io_cpu_writeBack_mmuException        ), //o
    .io_cpu_writeBack_unalignedAccess       (dataCache_1_io_cpu_writeBack_unalignedAccess     ), //o
    .io_cpu_writeBack_accessError           (dataCache_1_io_cpu_writeBack_accessError         ), //o
    .io_cpu_writeBack_keepMemRspData        (dataCache_1_io_cpu_writeBack_keepMemRspData      ), //o
    .io_cpu_writeBack_fence_SW              (                                                 ), //i
    .io_cpu_writeBack_fence_SR              (                                                 ), //i
    .io_cpu_writeBack_fence_SO              (                                                 ), //i
    .io_cpu_writeBack_fence_SI              (                                                 ), //i
    .io_cpu_writeBack_fence_PW              (                                                 ), //i
    .io_cpu_writeBack_fence_PR              (                                                 ), //i
    .io_cpu_writeBack_fence_PO              (                                                 ), //i
    .io_cpu_writeBack_fence_PI              (                                                 ), //i
    .io_cpu_writeBack_fence_FM              (                                                 ), //i
    .io_cpu_writeBack_exclusiveOk           (dataCache_1_io_cpu_writeBack_exclusiveOk         ), //o
    .io_cpu_redo                            (dataCache_1_io_cpu_redo                          ), //o
    .io_cpu_flush_valid                     (dataCache_1_io_cpu_flush_valid                   ), //i
    .io_cpu_flush_ready                     (dataCache_1_io_cpu_flush_ready                   ), //o
    .io_cpu_flush_payload_singleLine        (dataCache_1_io_cpu_flush_payload_singleLine      ), //i
    .io_cpu_flush_payload_lineId            (dataCache_1_io_cpu_flush_payload_lineId[6:0]     ), //i
    .io_cpu_writesPending                   (dataCache_1_io_cpu_writesPending                 ), //o
    .io_mem_cmd_valid                       (dataCache_1_io_mem_cmd_valid                     ), //o
    .io_mem_cmd_ready                       (io_mem_cmd_rValidN                               ), //i
    .io_mem_cmd_payload_wr                  (dataCache_1_io_mem_cmd_payload_wr                ), //o
    .io_mem_cmd_payload_uncached            (dataCache_1_io_mem_cmd_payload_uncached          ), //o
    .io_mem_cmd_payload_address             (dataCache_1_io_mem_cmd_payload_address[31:0]     ), //o
    .io_mem_cmd_payload_data                (dataCache_1_io_mem_cmd_payload_data[31:0]        ), //o
    .io_mem_cmd_payload_mask                (dataCache_1_io_mem_cmd_payload_mask[3:0]         ), //o
    .io_mem_cmd_payload_size                (dataCache_1_io_mem_cmd_payload_size[2:0]         ), //o
    .io_mem_cmd_payload_last                (dataCache_1_io_mem_cmd_payload_last              ), //o
    .io_mem_rsp_valid                       (dBus_rsp_regNext_valid                           ), //i
    .io_mem_rsp_payload_last                (dBus_rsp_regNext_payload_last                    ), //i
    .io_mem_rsp_payload_data                (dBus_rsp_regNext_payload_data[31:0]              ), //i
    .io_mem_rsp_payload_error               (dBus_rsp_regNext_payload_error                   ), //i
    .clk                                    (clk                                              ), //i
    .reset                                  (reset                                            )  //i
  );
  JtagBridge jtagBridge_1 (
    .io_jtag_tms                    (jtag_tms                                         ), //i
    .io_jtag_tdi                    (jtag_tdi                                         ), //i
    .io_jtag_tdo                    (jtagBridge_1_io_jtag_tdo                         ), //o
    .io_jtag_tck                    (jtag_tck                                         ), //i
    .io_remote_cmd_valid            (jtagBridge_1_io_remote_cmd_valid                 ), //o
    .io_remote_cmd_ready            (systemDebugger_1_io_remote_cmd_ready             ), //i
    .io_remote_cmd_payload_last     (jtagBridge_1_io_remote_cmd_payload_last          ), //o
    .io_remote_cmd_payload_fragment (jtagBridge_1_io_remote_cmd_payload_fragment      ), //o
    .io_remote_rsp_valid            (systemDebugger_1_io_remote_rsp_valid             ), //i
    .io_remote_rsp_ready            (jtagBridge_1_io_remote_rsp_ready                 ), //o
    .io_remote_rsp_payload_error    (systemDebugger_1_io_remote_rsp_payload_error     ), //i
    .io_remote_rsp_payload_data     (systemDebugger_1_io_remote_rsp_payload_data[31:0]), //i
    .clk                            (clk                                              ), //i
    .debugReset                     (debugReset                                       )  //i
  );
  SystemDebugger systemDebugger_1 (
    .io_remote_cmd_valid            (jtagBridge_1_io_remote_cmd_valid                 ), //i
    .io_remote_cmd_ready            (systemDebugger_1_io_remote_cmd_ready             ), //o
    .io_remote_cmd_payload_last     (jtagBridge_1_io_remote_cmd_payload_last          ), //i
    .io_remote_cmd_payload_fragment (jtagBridge_1_io_remote_cmd_payload_fragment      ), //i
    .io_remote_rsp_valid            (systemDebugger_1_io_remote_rsp_valid             ), //o
    .io_remote_rsp_ready            (jtagBridge_1_io_remote_rsp_ready                 ), //i
    .io_remote_rsp_payload_error    (systemDebugger_1_io_remote_rsp_payload_error     ), //o
    .io_remote_rsp_payload_data     (systemDebugger_1_io_remote_rsp_payload_data[31:0]), //o
    .io_mem_cmd_valid               (systemDebugger_1_io_mem_cmd_valid                ), //o
    .io_mem_cmd_ready               (debug_bus_cmd_ready                              ), //i
    .io_mem_cmd_payload_address     (systemDebugger_1_io_mem_cmd_payload_address[31:0]), //o
    .io_mem_cmd_payload_data        (systemDebugger_1_io_mem_cmd_payload_data[31:0]   ), //o
    .io_mem_cmd_payload_wr          (systemDebugger_1_io_mem_cmd_payload_wr           ), //o
    .io_mem_cmd_payload_size        (systemDebugger_1_io_mem_cmd_payload_size[1:0]    ), //o
    .io_mem_rsp_valid               (debug_bus_cmd_fire_regNext                       ), //i
    .io_mem_rsp_payload             (debug_bus_rsp_data[31:0]                         ), //i
    .clk                            (clk                                              ), //i
    .debugReset                     (debugReset                                       )  //i
  );
  always @(*) begin
    case(_zz_IBusCachedPlugin_jump_pcLoad_payload_7)
      3'b000 : _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = DBusCachedPlugin_redoBranch_payload;
      3'b001 : _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = CsrPlugin_jumpInterface_payload;
      3'b010 : _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = BranchPlugin_jumpInterface_payload;
      3'b011 : _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = CsrPlugin_redoInterface_payload;
      default : _zz_IBusCachedPlugin_jump_pcLoad_payload_6 = IBusCachedPlugin_predictionJumpInterface_payload;
    endcase
  end

  always @(*) begin
    case(_zz_writeBack_DBusCachedPlugin_rspShifted_1)
      2'b00 : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_0;
      2'b01 : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_1;
      2'b10 : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_2;
      default : _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_3;
    endcase
  end

  always @(*) begin
    case(_zz_writeBack_DBusCachedPlugin_rspShifted_3)
      1'b0 : _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_1;
      default : _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_3;
    endcase
  end

  always @(*) begin
    case(_zz_MmuPlugin_ports_0_cacheLine_valid_3)
      2'b00 : begin
        _zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_0_valid;
        _zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_0_exception;
        _zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_0_superPage;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_0_virtualAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_0_virtualAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_0_physicalAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_0_physicalAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_0_allowRead;
        _zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_0_allowWrite;
        _zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_0_allowExecute;
        _zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_0_allowUser;
      end
      2'b01 : begin
        _zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_1_valid;
        _zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_1_exception;
        _zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_1_superPage;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_1_virtualAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_1_virtualAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_1_physicalAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_1_physicalAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_1_allowRead;
        _zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_1_allowWrite;
        _zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_1_allowExecute;
        _zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_1_allowUser;
      end
      2'b10 : begin
        _zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_2_valid;
        _zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_2_exception;
        _zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_2_superPage;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_2_virtualAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_2_virtualAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_2_physicalAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_2_physicalAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_2_allowRead;
        _zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_2_allowWrite;
        _zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_2_allowExecute;
        _zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_2_allowUser;
      end
      default : begin
        _zz_MmuPlugin_ports_0_cacheLine_valid_4 = MmuPlugin_ports_0_cache_3_valid;
        _zz_MmuPlugin_ports_0_cacheLine_exception = MmuPlugin_ports_0_cache_3_exception;
        _zz_MmuPlugin_ports_0_cacheLine_superPage = MmuPlugin_ports_0_cache_3_superPage;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0 = MmuPlugin_ports_0_cache_3_virtualAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1 = MmuPlugin_ports_0_cache_3_virtualAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0 = MmuPlugin_ports_0_cache_3_physicalAddress_0;
        _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1 = MmuPlugin_ports_0_cache_3_physicalAddress_1;
        _zz_MmuPlugin_ports_0_cacheLine_allowRead = MmuPlugin_ports_0_cache_3_allowRead;
        _zz_MmuPlugin_ports_0_cacheLine_allowWrite = MmuPlugin_ports_0_cache_3_allowWrite;
        _zz_MmuPlugin_ports_0_cacheLine_allowExecute = MmuPlugin_ports_0_cache_3_allowExecute;
        _zz_MmuPlugin_ports_0_cacheLine_allowUser = MmuPlugin_ports_0_cache_3_allowUser;
      end
    endcase
  end

  always @(*) begin
    case(_zz_MmuPlugin_ports_1_cacheLine_valid_3)
      2'b00 : begin
        _zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_0_valid;
        _zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_0_exception;
        _zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_0_superPage;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_0_virtualAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_0_virtualAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_0_physicalAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_0_physicalAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_0_allowRead;
        _zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_0_allowWrite;
        _zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_0_allowExecute;
        _zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_0_allowUser;
      end
      2'b01 : begin
        _zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_1_valid;
        _zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_1_exception;
        _zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_1_superPage;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_1_virtualAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_1_virtualAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_1_physicalAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_1_physicalAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_1_allowRead;
        _zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_1_allowWrite;
        _zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_1_allowExecute;
        _zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_1_allowUser;
      end
      2'b10 : begin
        _zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_2_valid;
        _zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_2_exception;
        _zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_2_superPage;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_2_virtualAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_2_virtualAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_2_physicalAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_2_physicalAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_2_allowRead;
        _zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_2_allowWrite;
        _zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_2_allowExecute;
        _zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_2_allowUser;
      end
      default : begin
        _zz_MmuPlugin_ports_1_cacheLine_valid_4 = MmuPlugin_ports_1_cache_3_valid;
        _zz_MmuPlugin_ports_1_cacheLine_exception = MmuPlugin_ports_1_cache_3_exception;
        _zz_MmuPlugin_ports_1_cacheLine_superPage = MmuPlugin_ports_1_cache_3_superPage;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0 = MmuPlugin_ports_1_cache_3_virtualAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1 = MmuPlugin_ports_1_cache_3_virtualAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0 = MmuPlugin_ports_1_cache_3_physicalAddress_0;
        _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1 = MmuPlugin_ports_1_cache_3_physicalAddress_1;
        _zz_MmuPlugin_ports_1_cacheLine_allowRead = MmuPlugin_ports_1_cache_3_allowRead;
        _zz_MmuPlugin_ports_1_cacheLine_allowWrite = MmuPlugin_ports_1_cache_3_allowWrite;
        _zz_MmuPlugin_ports_1_cacheLine_allowExecute = MmuPlugin_ports_1_cache_3_allowExecute;
        _zz_MmuPlugin_ports_1_cacheLine_allowUser = MmuPlugin_ports_1_cache_3_allowUser;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_memory_to_writeBack_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_memory_to_writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_memory_to_writeBack_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_to_writeBack_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_memory_to_writeBack_ENV_CTRL_1_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_memory_to_writeBack_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_1_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_execute_to_memory_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_execute_to_memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_execute_to_memory_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_to_memory_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_execute_to_memory_ENV_CTRL_1_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_execute_to_memory_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_execute_to_memory_ENV_CTRL_1_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : decode_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : decode_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : decode_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : decode_ENV_CTRL_string = "EBREAK";
      default : decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_decode_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_decode_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_decode_to_execute_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_decode_to_execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_to_execute_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_to_execute_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_decode_to_execute_ENV_CTRL_1_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_decode_to_execute_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_to_execute_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_string = "PC ";
      default : _zz_decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_decode_to_execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_to_execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_to_execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_to_execute_SRC2_CTRL_string = "PC ";
      default : _zz_decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC2_CTRL_1)
      Src2CtrlEnum_RS : _zz_decode_to_execute_SRC2_CTRL_1_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_to_execute_SRC2_CTRL_1_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_to_execute_SRC2_CTRL_1_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_to_execute_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_to_execute_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_decode_to_execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_to_execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC1_CTRL_1)
      Src1CtrlEnum_RS : _zz_decode_to_execute_SRC1_CTRL_1_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_to_execute_SRC1_CTRL_1_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_to_execute_SRC1_CTRL_1_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_to_execute_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_to_execute_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : memory_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : memory_ENV_CTRL_string = "EBREAK";
      default : memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_memory_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : execute_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : execute_ENV_CTRL_string = "EBREAK";
      default : execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_execute_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : writeBack_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : writeBack_ENV_CTRL_string = "EBREAK";
      default : writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : _zz_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_writeBack_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : memory_SHIFT_CTRL_string = "SRA_1    ";
      default : memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SRC2_CTRL)
      Src2CtrlEnum_RS : execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : execute_SRC2_CTRL_string = "PC ";
      default : execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_execute_SRC2_CTRL_string = "PC ";
      default : _zz_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(execute_SRC1_CTRL)
      Src1CtrlEnum_RS : execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : execute_SRC1_CTRL_string = "URS1        ";
      default : execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_execute_SRC1_CTRL_string = "URS1        ";
      default : _zz_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_1)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_1_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_1_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_decode_ENV_CTRL_1_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_decode_ENV_CTRL_1_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_1)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_1_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_1_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_1_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_1)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_1_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_1_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_1_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(MmuPlugin_shared_state_1)
      MmuPlugin_shared_State_IDLE : MmuPlugin_shared_state_1_string = "IDLE  ";
      MmuPlugin_shared_State_L1_CMD : MmuPlugin_shared_state_1_string = "L1_CMD";
      MmuPlugin_shared_State_L1_RSP : MmuPlugin_shared_state_1_string = "L1_RSP";
      MmuPlugin_shared_State_L0_CMD : MmuPlugin_shared_state_1_string = "L0_CMD";
      MmuPlugin_shared_State_L0_RSP : MmuPlugin_shared_state_1_string = "L0_RSP";
      default : MmuPlugin_shared_state_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_2)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_2_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_2_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_2_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_2_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_2_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_2)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_2_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_2_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_2_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_2)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_2_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_2_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_2_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_2_string = "PC ";
      default : _zz_decode_SRC2_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_2)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_2)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_2_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_2_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_2_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_2_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_2_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_2)
      EnvCtrlEnum_NONE : _zz_decode_ENV_CTRL_2_string = "NONE  ";
      EnvCtrlEnum_XRET : _zz_decode_ENV_CTRL_2_string = "XRET  ";
      EnvCtrlEnum_WFI : _zz_decode_ENV_CTRL_2_string = "WFI   ";
      EnvCtrlEnum_ECALL : _zz_decode_ENV_CTRL_2_string = "ECALL ";
      EnvCtrlEnum_EBREAK : _zz_decode_ENV_CTRL_2_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_2)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_2_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_2_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_2_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_2_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC1_CTRL)
      Src1CtrlEnum_RS : decode_to_execute_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : decode_to_execute_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC2_CTRL)
      Src2CtrlEnum_RS : decode_to_execute_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : decode_to_execute_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : decode_to_execute_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : decode_to_execute_SRC2_CTRL_string = "PC ";
      default : decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      EnvCtrlEnum_NONE : decode_to_execute_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : decode_to_execute_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : decode_to_execute_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : decode_to_execute_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      EnvCtrlEnum_NONE : execute_to_memory_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : execute_to_memory_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : execute_to_memory_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : execute_to_memory_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      EnvCtrlEnum_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      EnvCtrlEnum_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      EnvCtrlEnum_WFI : memory_to_writeBack_ENV_CTRL_string = "WFI   ";
      EnvCtrlEnum_ECALL : memory_to_writeBack_ENV_CTRL_string = "ECALL ";
      EnvCtrlEnum_EBREAK : memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(iBusAvalon_response)
      Response_OKAY : iBusAvalon_response_string = "OKAY       ";
      Response_RESERVED : iBusAvalon_response_string = "RESERVED   ";
      Response_SLAVEERROR : iBusAvalon_response_string = "SLAVEERROR ";
      Response_DECODEERROR : iBusAvalon_response_string = "DECODEERROR";
      default : iBusAvalon_response_string = "???????????";
    endcase
  end
  always @(*) begin
    case(dBusAvalon_response)
      Response_OKAY : dBusAvalon_response_string = "OKAY       ";
      Response_RESERVED : dBusAvalon_response_string = "RESERVED   ";
      Response_SLAVEERROR : dBusAvalon_response_string = "SLAVEERROR ";
      Response_DECODEERROR : dBusAvalon_response_string = "DECODEERROR";
      default : dBusAvalon_response_string = "???????????";
    endcase
  end
  `endif

  assign memory_MUL_LOW = ($signed(_zz_memory_MUL_LOW) + $signed(_zz_memory_MUL_LOW_6));
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0};
  assign execute_BRANCH_DO = ((execute_PREDICTION_HAD_BRANCHED1 != execute_BRANCH_COND_RESULT) || execute_BranchPlugin_missAlignedTarget);
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign execute_MUL_HL = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign execute_MUL_LH = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign execute_MUL_LL = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT;
  assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA;
  assign memory_MEMORY_STORE_DATA_RF = execute_to_memory_MEMORY_STORE_DATA_RF;
  assign execute_MEMORY_STORE_DATA_RF = _zz_execute_MEMORY_STORE_DATA_RF;
  assign decode_CSR_READ_OPCODE = (decode_INSTRUCTION[13 : 7] != 7'h20);
  assign decode_CSR_WRITE_OPCODE = (! (((decode_INSTRUCTION[14 : 13] == 2'b01) && (decode_INSTRUCTION[19 : 15] == 5'h0)) || ((decode_INSTRUCTION[14 : 13] == 2'b11) && (decode_INSTRUCTION[19 : 15] == 5'h0))));
  assign decode_PREDICTION_HAD_BRANCHED1 = IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  assign decode_DO_EBREAK = (((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0)) && DebugPlugin_allowEBreak);
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  assign decode_IS_CSR = _zz_decode_IS_CSR[37];
  assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1;
  assign _zz_memory_to_writeBack_ENV_CTRL = _zz_memory_to_writeBack_ENV_CTRL_1;
  assign _zz_execute_to_memory_ENV_CTRL = _zz_execute_to_memory_ENV_CTRL_1;
  assign decode_ENV_CTRL = _zz_decode_ENV_CTRL;
  assign _zz_decode_to_execute_ENV_CTRL = _zz_decode_to_execute_ENV_CTRL_1;
  assign decode_IS_RS2_SIGNED = _zz_decode_IS_CSR[30];
  assign decode_IS_RS1_SIGNED = _zz_decode_IS_CSR[29];
  assign decode_IS_DIV = _zz_decode_IS_CSR[28];
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_decode_IS_CSR[27];
  assign _zz_execute_to_memory_SHIFT_CTRL = _zz_execute_to_memory_SHIFT_CTRL_1;
  assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1;
  assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  assign decode_SRC_LESS_UNSIGNED = _zz_decode_IS_CSR[22];
  assign decode_IS_SFENCE_VMA2 = _zz_decode_IS_CSR[21];
  assign decode_MEMORY_MANAGMENT = _zz_decode_IS_CSR[20];
  assign memory_MEMORY_LRSC = execute_to_memory_MEMORY_LRSC;
  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
  assign decode_MEMORY_WR = _zz_decode_IS_CSR[14];
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_IS_CSR[13];
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_IS_CSR[12];
  assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL;
  assign _zz_decode_to_execute_SRC2_CTRL = _zz_decode_to_execute_SRC2_CTRL_1;
  assign decode_ALU_CTRL = _zz_decode_ALU_CTRL;
  assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1;
  assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL;
  assign _zz_decode_to_execute_SRC1_CTRL = _zz_decode_to_execute_SRC1_CTRL_1;
  assign decode_RESCHEDULE_NEXT = _zz_decode_IS_CSR[1];
  assign decode_MEMORY_FORCE_CONSTISTENCY = _zz_decode_MEMORY_FORCE_CONSTISTENCY;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = (decode_PC + 32'h00000004);
  assign memory_PC = execute_to_memory_PC;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_memory_ENV_CTRL;
  assign execute_ENV_CTRL = _zz_execute_ENV_CTRL;
  assign writeBack_ENV_CTRL = _zz_writeBack_ENV_CTRL;
  assign execute_RESCHEDULE_NEXT = decode_to_execute_RESCHEDULE_NEXT;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PREDICTION_HAD_BRANCHED1 = decode_to_execute_PREDICTION_HAD_BRANCHED1;
  assign execute_BRANCH_COND_RESULT = _zz_execute_BRANCH_COND_RESULT_1;
  assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL;
  assign execute_PC = decode_to_execute_PC;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_decode_IS_CSR[31];
  assign decode_RS2_USE = _zz_decode_IS_CSR[18];
  assign decode_RS1_USE = _zz_decode_IS_CSR[6];
  always @(*) begin
    _zz_decode_RS2 = execute_REGFILE_WRITE_DATA;
    if(when_CsrPlugin_l1587) begin
      _zz_decode_RS2 = CsrPlugin_csrMapping_readDataSignal;
    end
    if(DBusCachedPlugin_forceDatapath) begin
      _zz_decode_RS2 = MmuPlugin_dBusAccess_cmd_payload_address;
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    decode_RS2 = decode_RegFilePlugin_rs2Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr1Match) begin
        decode_RS2 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l51) begin
          decode_RS2 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l51_1) begin
          decode_RS2 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l51_2) begin
          decode_RS2 = _zz_decode_RS2;
        end
      end
    end
  end

  always @(*) begin
    decode_RS1 = decode_RegFilePlugin_rs1Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr0Match) begin
        decode_RS1 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l48) begin
          decode_RS1 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l48_1) begin
          decode_RS1 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l48_2) begin
          decode_RS1 = _zz_decode_RS2;
        end
      end
    end
  end

  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @(*) begin
    _zz_decode_RS2_1 = memory_REGFILE_WRITE_DATA;
    if(memory_arbitration_isValid) begin
      case(memory_SHIFT_CTRL)
        ShiftCtrlEnum_SLL_1 : begin
          _zz_decode_RS2_1 = _zz_decode_RS2_3;
        end
        ShiftCtrlEnum_SRL_1, ShiftCtrlEnum_SRA_1 : begin
          _zz_decode_RS2_1 = memory_SHIFT_RIGHT;
        end
        default : begin
        end
      endcase
    end
    if(when_MulDivIterativePlugin_l128) begin
      _zz_decode_RS2_1 = memory_DivPlugin_div_result;
    end
  end

  assign memory_SHIFT_CTRL = _zz_memory_SHIFT_CTRL;
  assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_execute_to_memory_PC = execute_PC;
  assign execute_SRC2_CTRL = _zz_execute_SRC2_CTRL;
  assign execute_SRC1_CTRL = _zz_execute_SRC1_CTRL;
  assign decode_SRC_USE_SUB_LESS = _zz_decode_IS_CSR[4];
  assign decode_SRC_ADD_ZERO = _zz_decode_IS_CSR[19];
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign execute_ALU_CTRL = _zz_execute_ALU_CTRL;
  assign execute_SRC2 = _zz_execute_SRC2_4;
  assign execute_SRC1 = _zz_execute_SRC1;
  assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL;
  assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION;
  assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    _zz_1 = 1'b0;
    if(lastStageRegFileWrite_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusCachedPlugin_cache_io_cpu_fetch_data);
  always @(*) begin
    decode_REGFILE_WRITE_VALID = _zz_decode_IS_CSR[11];
    if(when_RegFilePlugin_l63) begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = (|{((decode_INSTRUCTION & 32'h0000005f) == 32'h00000017),{((decode_INSTRUCTION & 32'h0000007f) == 32'h0000006f),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION) == 32'h00001073),{(_zz_decode_LEGAL_INSTRUCTION_1 == _zz_decode_LEGAL_INSTRUCTION_2),{_zz_decode_LEGAL_INSTRUCTION_3,{_zz_decode_LEGAL_INSTRUCTION_4,_zz_decode_LEGAL_INSTRUCTION_5}}}}}});
  assign execute_IS_SFENCE_VMA2 = decode_to_execute_IS_SFENCE_VMA2;
  assign writeBack_IS_DBUS_SHARING = memory_to_writeBack_IS_DBUS_SHARING;
  assign execute_IS_DBUS_SHARING = MmuPlugin_dBusAccess_cmd_fire;
  assign memory_IS_DBUS_SHARING = execute_to_memory_IS_DBUS_SHARING;
  always @(*) begin
    _zz_decode_RS2_2 = writeBack_REGFILE_WRITE_DATA;
    if(when_DBusCachedPlugin_l581) begin
      _zz_decode_RS2_2 = writeBack_DBusCachedPlugin_rspFormated;
    end
    if(when_MulPlugin_l147) begin
      case(switch_MulPlugin_l148)
        2'b00 : begin
          _zz_decode_RS2_2 = _zz__zz_decode_RS2_2;
        end
        default : begin
          _zz_decode_RS2_2 = _zz__zz_decode_RS2_2_1;
        end
      endcase
    end
  end

  assign writeBack_MEMORY_LRSC = memory_to_writeBack_MEMORY_LRSC;
  assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR;
  assign writeBack_MEMORY_STORE_DATA_RF = memory_to_writeBack_MEMORY_STORE_DATA_RF;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  always @(*) begin
    execute_MEMORY_AMO = decode_to_execute_MEMORY_AMO;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        execute_MEMORY_AMO = 1'b0;
      end
    end
  end

  always @(*) begin
    execute_MEMORY_LRSC = decode_to_execute_MEMORY_LRSC;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        execute_MEMORY_LRSC = 1'b0;
      end
    end
  end

  assign execute_MEMORY_FORCE_CONSTISTENCY = decode_to_execute_MEMORY_FORCE_CONSTISTENCY;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign decode_MEMORY_AMO = _zz_decode_IS_CSR[17];
  assign decode_MEMORY_LRSC = _zz_decode_IS_CSR[16];
  assign decode_MEMORY_ENABLE = _zz_decode_IS_CSR[5];
  assign decode_FLUSH_ALL = _zz_decode_IS_CSR[0];
  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_4 = IBusCachedPlugin_rsp_issueDetected_3;
    if(when_IBusCachedPlugin_l262) begin
      IBusCachedPlugin_rsp_issueDetected_4 = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_3 = IBusCachedPlugin_rsp_issueDetected_2;
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_rsp_issueDetected_3 = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_2 = IBusCachedPlugin_rsp_issueDetected_1;
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_rsp_issueDetected_2 = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_1 = IBusCachedPlugin_rsp_issueDetected;
    if(when_IBusCachedPlugin_l245) begin
      IBusCachedPlugin_rsp_issueDetected_1 = 1'b1;
    end
  end

  assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1;
  assign decode_INSTRUCTION = IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  always @(*) begin
    _zz_execute_to_memory_FORMAL_PC_NEXT = execute_FORMAL_PC_NEXT;
    if(CsrPlugin_redoInterface_valid) begin
      _zz_execute_to_memory_FORMAL_PC_NEXT = CsrPlugin_redoInterface_payload;
    end
  end

  always @(*) begin
    _zz_memory_to_writeBack_FORMAL_PC_NEXT = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid) begin
      _zz_memory_to_writeBack_FORMAL_PC_NEXT = BranchPlugin_jumpInterface_payload;
    end
  end

  always @(*) begin
    _zz_decode_to_execute_FORMAL_PC_NEXT = decode_FORMAL_PC_NEXT;
    if(IBusCachedPlugin_predictionJumpInterface_valid) begin
      _zz_decode_to_execute_FORMAL_PC_NEXT = IBusCachedPlugin_predictionJumpInterface_payload;
    end
  end

  assign decode_PC = IBusCachedPlugin_iBusRsp_output_payload_pc;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @(*) begin
    decode_arbitration_haltItself = 1'b0;
    if(when_DBusCachedPlugin_l353) begin
      decode_arbitration_haltItself = 1'b1;
    end
    case(IBusCachedPlugin_injector_port_state)
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_HazardSimplePlugin_l113) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_rescheduleLogic_rescheduleNext) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_pipelineLiberator_active) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_CsrPlugin_l1527) begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    decode_arbitration_removeIt = 1'b0;
    if(_zz_when) begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed) begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  always @(*) begin
    decode_arbitration_flushNext = 1'b0;
    if(IBusCachedPlugin_predictionJumpInterface_valid) begin
      decode_arbitration_flushNext = 1'b1;
    end
    if(_zz_when) begin
      decode_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_haltItself = 1'b0;
    if(when_DBusCachedPlugin_l395) begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(when_CsrPlugin_l1519) begin
      if(when_CsrPlugin_l1521) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(when_CsrPlugin_l1591) begin
      if(execute_CsrPlugin_blockedBySideEffects) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(when_DBusCachedPlugin_l411) begin
      execute_arbitration_haltByOther = 1'b1;
    end
    if(when_DebugPlugin_l308) begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_removeIt = 1'b0;
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_removeIt = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_flushIt = 1'b0;
    if(when_DebugPlugin_l308) begin
      if(when_DebugPlugin_l311) begin
        execute_arbitration_flushIt = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_flushNext = 1'b0;
    if(when_DebugPlugin_l308) begin
      if(when_DebugPlugin_l311) begin
        execute_arbitration_flushNext = 1'b1;
      end
    end
    if(CsrPlugin_rescheduleLogic_rescheduleNext) begin
      execute_arbitration_flushNext = 1'b1;
    end
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    memory_arbitration_haltItself = 1'b0;
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l129) begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @(*) begin
    memory_arbitration_removeIt = 1'b0;
    if(BranchPlugin_branchExceptionPort_valid) begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed) begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  always @(*) begin
    memory_arbitration_flushNext = 1'b0;
    if(BranchPlugin_jumpInterface_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
    if(BranchPlugin_branchExceptionPort_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(when_DBusCachedPlugin_l554) begin
      writeBack_arbitration_haltItself = 1'b1;
    end
  end

  assign writeBack_arbitration_haltByOther = 1'b0;
  always @(*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(DBusCachedPlugin_exceptionBus_valid) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
    if(writeBack_arbitration_isFlushed) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_flushIt = 1'b0;
    if(DBusCachedPlugin_redoBranch_valid) begin
      writeBack_arbitration_flushIt = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_flushNext = 1'b0;
    if(DBusCachedPlugin_redoBranch_valid) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(DBusCachedPlugin_exceptionBus_valid) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(when_CsrPlugin_l1390) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(when_CsrPlugin_l1456) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  assign clint_awready = clintCtrl_io_bus_aw_ready;
  assign clint_wready = clintCtrl_io_bus_w_ready;
  assign clint_bvalid = clintCtrl_io_bus_b_valid;
  assign clint_bresp = clintCtrl_io_bus_b_payload_resp;
  assign clint_arready = clintCtrl_io_bus_ar_ready;
  assign clint_rvalid = clintCtrl_io_bus_r_valid;
  assign clint_rdata = clintCtrl_io_bus_r_payload_data;
  assign clint_rresp = clintCtrl_io_bus_r_payload_resp;
  assign plic_awready = plicCtrl_io_bus_aw_ready;
  assign plic_wready = plicCtrl_io_bus_w_ready;
  assign plic_bvalid = plicCtrl_io_bus_b_valid;
  assign plic_bresp = plicCtrl_io_bus_b_payload_resp;
  assign plic_arready = plicCtrl_io_bus_ar_ready;
  assign plic_rvalid = plicCtrl_io_bus_r_valid;
  assign plic_rdata = plicCtrl_io_bus_r_payload_data;
  assign plic_rresp = plicCtrl_io_bus_r_payload_resp;
  assign plicCtrl_io_sources = (plicInterrupts >>> 1'd1);
  assign apb_PREADY = u_apb_io_apb_PREADY;
  assign apb_PRDATA = u_apb_io_apb_PRDATA;
  assign apb_PSLVERROR = u_apb_io_apb_PSLVERROR;
  assign uart_txd = u_apb_io_uart_txd;
  assign leds = u_apb_io_leds;
  assign ext1 = u_apb_io_ext1;
  assign ext2 = u_apb_io_ext2;
  assign sd_sclk = u_apb_io_sd_sclk;
  assign sd_mosi = u_apb_io_sd_mosi;
  assign sd_ncs = u_apb_io_sd_ncs;
  assign irq_uart = u_apb_io_irq_uart;
  assign irq_spi = u_apb_io_irq_spi;
  assign irq_key = u_apb_io_irq_key;
  assign vidMemAvalon_read = u_apb_io_vid_mem_read;
  assign vidMemAvalon_address = u_apb_io_vid_mem_address;
  assign vidMemAvalon_burstCount = u_apb_io_vid_mem_burstCount;
  assign tmds0 = u_apb_io_tmds0;
  assign tmds1 = u_apb_io_tmds1;
  assign tmds2 = u_apb_io_tmds2;
  assign vid_status = u_apb_io_vid_status;
  always @(*) begin
    IBusCachedPlugin_fetcherHalt = 1'b0;
    if(when_DebugPlugin_l308) begin
      if(when_DebugPlugin_l311) begin
        IBusCachedPlugin_fetcherHalt = 1'b1;
      end
    end
    if(DebugPlugin_haltIt) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_DebugPlugin_l324) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1272) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1390) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1456) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
  end

  assign IBusCachedPlugin_forceNoDecodeCond = 1'b0;
  always @(*) begin
    IBusCachedPlugin_incomingInstruction = 1'b0;
    if(when_Fetcher_l242) begin
      IBusCachedPlugin_incomingInstruction = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_DBusCachedPlugin_l473 = 1'b0;
    if(DebugPlugin_godmode) begin
      _zz_when_DBusCachedPlugin_l473 = 1'b1;
    end
  end

  always @(*) begin
    BranchPlugin_inDebugNoFetchFlag = 1'b0;
    if(DebugPlugin_godmode) begin
      BranchPlugin_inDebugNoFetchFlag = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_csrMapping_allowCsrSignal = 1'b0;
    if(when_CsrPlugin_l1702) begin
      CsrPlugin_csrMapping_allowCsrSignal = 1'b1;
    end
    if(when_CsrPlugin_l1709) begin
      CsrPlugin_csrMapping_allowCsrSignal = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_csrMapping_doForceFailCsr = 1'b0;
    if(execute_CsrPlugin_csr_3073) begin
      if(when_CsrPlugin_l1076) begin
        CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
      end
      if(when_CsrPlugin_l1077) begin
        CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
      end
    end
    if(execute_CsrPlugin_csr_3201) begin
      if(when_CsrPlugin_l1076_1) begin
        CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
      end
      if(when_CsrPlugin_l1077_1) begin
        CsrPlugin_csrMapping_doForceFailCsr = 1'b1;
      end
    end
  end

  assign CsrPlugin_csrMapping_readDataSignal = CsrPlugin_csrMapping_readDataInit;
  always @(*) begin
    CsrPlugin_inWfi = 1'b0;
    if(when_CsrPlugin_l1519) begin
      CsrPlugin_inWfi = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_thirdPartyWake = 1'b0;
    if(DebugPlugin_haltIt) begin
      CsrPlugin_thirdPartyWake = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(when_CsrPlugin_l1390) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(when_CsrPlugin_l1456) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_payload = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_CsrPlugin_l1390) begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,2'b00};
    end
    if(when_CsrPlugin_l1456) begin
      case(switch_CsrPlugin_l1460)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        2'b01 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_sepc;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    CsrPlugin_forceMachineWire = 1'b0;
    if(DebugPlugin_godmode) begin
      CsrPlugin_forceMachineWire = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_allowInterrupts = 1'b1;
    if(when_DebugPlugin_l344) begin
      CsrPlugin_allowInterrupts = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowException = 1'b1;
    if(DebugPlugin_godmode) begin
      CsrPlugin_allowException = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowEbreakException = 1'b1;
    if(DebugPlugin_allowEBreak) begin
      CsrPlugin_allowEbreakException = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_xretAwayFromMachine = 1'b0;
    if(when_CsrPlugin_l1456) begin
      case(switch_CsrPlugin_l1460)
        2'b11 : begin
          if(when_CsrPlugin_l1468) begin
            CsrPlugin_xretAwayFromMachine = 1'b1;
          end
        end
        2'b01 : begin
          CsrPlugin_xretAwayFromMachine = 1'b1;
        end
        default : begin
        end
      endcase
    end
  end

  assign IBusCachedPlugin_externalFlush = (|{writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}});
  assign IBusCachedPlugin_jump_pcLoad_valid = (|{CsrPlugin_redoInterface_valid,{CsrPlugin_jumpInterface_valid,{BranchPlugin_jumpInterface_valid,{DBusCachedPlugin_redoBranch_valid,IBusCachedPlugin_predictionJumpInterface_valid}}}});
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload = {IBusCachedPlugin_predictionJumpInterface_valid,{CsrPlugin_redoInterface_valid,{BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,DBusCachedPlugin_redoBranch_valid}}}};
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_1 = (_zz_IBusCachedPlugin_jump_pcLoad_payload & (~ _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1));
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_2 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[3];
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_3 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[4];
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_4 = (_zz_IBusCachedPlugin_jump_pcLoad_payload_1[1] || _zz_IBusCachedPlugin_jump_pcLoad_payload_2);
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_5 = (_zz_IBusCachedPlugin_jump_pcLoad_payload_1[2] || _zz_IBusCachedPlugin_jump_pcLoad_payload_2);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_IBusCachedPlugin_jump_pcLoad_payload_6;
  always @(*) begin
    IBusCachedPlugin_fetchPc_correction = 1'b0;
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_correction = 1'b1;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_correction = 1'b1;
    end
  end

  assign IBusCachedPlugin_fetchPc_output_fire = (IBusCachedPlugin_fetchPc_output_valid && IBusCachedPlugin_fetchPc_output_ready);
  assign IBusCachedPlugin_fetchPc_corrected = (IBusCachedPlugin_fetchPc_correction || IBusCachedPlugin_fetchPc_correctionReg);
  always @(*) begin
    IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready) begin
      IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  assign when_Fetcher_l133 = (IBusCachedPlugin_fetchPc_correction || IBusCachedPlugin_fetchPc_pcRegPropagate);
  assign when_Fetcher_l133_1 = ((! IBusCachedPlugin_fetchPc_output_valid) && IBusCachedPlugin_fetchPc_output_ready);
  always @(*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_IBusCachedPlugin_fetchPc_pc);
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_fetchPc_redo_payload;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    IBusCachedPlugin_fetchPc_pc[0] = 1'b0;
    IBusCachedPlugin_fetchPc_pc[1] = 1'b0;
  end

  always @(*) begin
    IBusCachedPlugin_fetchPc_flushed = 1'b0;
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_flushed = 1'b1;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_flushed = 1'b1;
    end
  end

  assign when_Fetcher_l160 = (IBusCachedPlugin_fetchPc_booted && ((IBusCachedPlugin_fetchPc_output_ready || IBusCachedPlugin_fetchPc_correction) || IBusCachedPlugin_fetchPc_pcRegPropagate));
  assign IBusCachedPlugin_fetchPc_output_valid = ((! IBusCachedPlugin_fetcherHalt) && IBusCachedPlugin_fetchPc_booted);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_pc;
  always @(*) begin
    IBusCachedPlugin_iBusRsp_redoFetch = 1'b0;
    if(IBusCachedPlugin_rsp_redoFetch) begin
      IBusCachedPlugin_iBusRsp_redoFetch = 1'b1;
    end
  end

  assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid;
  assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  always @(*) begin
    IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0;
    if(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt) begin
      IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1;
    end
    if(IBusCachedPlugin_mmuBus_busy) begin
      IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready = (! IBusCachedPlugin_iBusRsp_stages_0_halt);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_valid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = (IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_ready && _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_valid;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_ready = IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_haltWhen_payload;
  assign IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0;
  assign _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready = (! IBusCachedPlugin_iBusRsp_stages_1_halt);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_valid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = (IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_ready && _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_valid;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_ready = IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_haltWhen_payload;
  always @(*) begin
    IBusCachedPlugin_iBusRsp_stages_2_halt = 1'b0;
    if(when_IBusCachedPlugin_l273) begin
      IBusCachedPlugin_iBusRsp_stages_2_halt = 1'b1;
    end
  end

  assign _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready = (! IBusCachedPlugin_iBusRsp_stages_2_halt);
  assign IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_valid = (IBusCachedPlugin_iBusRsp_stages_2_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_2_input_ready = (IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_ready && _zz_IBusCachedPlugin_iBusRsp_stages_2_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_payload = IBusCachedPlugin_iBusRsp_stages_2_input_payload;
  assign IBusCachedPlugin_iBusRsp_stages_2_output_valid = IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_valid;
  assign IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_ready = IBusCachedPlugin_iBusRsp_stages_2_output_ready;
  assign IBusCachedPlugin_iBusRsp_stages_2_output_payload = IBusCachedPlugin_iBusRsp_stages_2_input_haltWhen_payload;
  assign IBusCachedPlugin_fetchPc_redo_valid = IBusCachedPlugin_iBusRsp_redoFetch;
  assign IBusCachedPlugin_fetchPc_redo_payload = IBusCachedPlugin_iBusRsp_stages_2_input_payload;
  assign IBusCachedPlugin_iBusRsp_flush = ((decode_arbitration_removeIt || (decode_arbitration_flushNext && (! decode_arbitration_isStuck))) || IBusCachedPlugin_iBusRsp_redoFetch);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_valid = IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_ready = ((1'b0 && (! IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid)) || IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_ready);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid = _zz_IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_ready = IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_fetchPc_pcReg;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid)) || IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_ready);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid = _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload = _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  assign IBusCachedPlugin_iBusRsp_stages_2_input_valid = IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_ready = IBusCachedPlugin_iBusRsp_stages_2_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_2_input_payload = IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload;
  always @(*) begin
    IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
    if(when_Fetcher_l322) begin
      IBusCachedPlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign when_Fetcher_l242 = (IBusCachedPlugin_iBusRsp_stages_1_input_valid || IBusCachedPlugin_iBusRsp_stages_2_input_valid);
  assign when_Fetcher_l322 = (! IBusCachedPlugin_pcValids_0);
  assign when_Fetcher_l331 = (! (! IBusCachedPlugin_iBusRsp_stages_1_input_ready));
  assign when_Fetcher_l331_1 = (! (! IBusCachedPlugin_iBusRsp_stages_2_input_ready));
  assign when_Fetcher_l331_2 = (! execute_arbitration_isStuck);
  assign when_Fetcher_l331_3 = (! memory_arbitration_isStuck);
  assign when_Fetcher_l331_4 = (! writeBack_arbitration_isStuck);
  assign IBusCachedPlugin_pcValids_0 = IBusCachedPlugin_injector_nextPcCalc_valids_1;
  assign IBusCachedPlugin_pcValids_1 = IBusCachedPlugin_injector_nextPcCalc_valids_2;
  assign IBusCachedPlugin_pcValids_2 = IBusCachedPlugin_injector_nextPcCalc_valids_3;
  assign IBusCachedPlugin_pcValids_3 = IBusCachedPlugin_injector_nextPcCalc_valids_4;
  assign IBusCachedPlugin_iBusRsp_output_ready = (! decode_arbitration_isStuck);
  always @(*) begin
    decode_arbitration_isValid = IBusCachedPlugin_iBusRsp_output_valid;
    case(IBusCachedPlugin_injector_port_state)
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      default : begin
      end
    endcase
    if(IBusCachedPlugin_forceNoDecodeCond) begin
      decode_arbitration_isValid = 1'b0;
    end
  end

  assign _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch = _zz__zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch[11];
  always @(*) begin
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[18] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[17] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[16] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[15] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[14] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[13] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[12] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[11] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[10] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[9] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[8] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[7] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[6] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[5] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[4] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[3] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[2] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[1] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_1[0] = _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch;
  end

  always @(*) begin
    IBusCachedPlugin_decodePrediction_cmd_hadBranch = ((decode_BRANCH_CTRL == BranchCtrlEnum_JAL) || ((decode_BRANCH_CTRL == BranchCtrlEnum_B) && _zz_IBusCachedPlugin_decodePrediction_cmd_hadBranch_2[31]));
    if(_zz_6) begin
      IBusCachedPlugin_decodePrediction_cmd_hadBranch = 1'b0;
    end
  end

  assign _zz_2 = _zz__zz_2[19];
  always @(*) begin
    _zz_3[10] = _zz_2;
    _zz_3[9] = _zz_2;
    _zz_3[8] = _zz_2;
    _zz_3[7] = _zz_2;
    _zz_3[6] = _zz_2;
    _zz_3[5] = _zz_2;
    _zz_3[4] = _zz_2;
    _zz_3[3] = _zz_2;
    _zz_3[2] = _zz_2;
    _zz_3[1] = _zz_2;
    _zz_3[0] = _zz_2;
  end

  assign _zz_4 = _zz__zz_4[11];
  always @(*) begin
    _zz_5[18] = _zz_4;
    _zz_5[17] = _zz_4;
    _zz_5[16] = _zz_4;
    _zz_5[15] = _zz_4;
    _zz_5[14] = _zz_4;
    _zz_5[13] = _zz_4;
    _zz_5[12] = _zz_4;
    _zz_5[11] = _zz_4;
    _zz_5[10] = _zz_4;
    _zz_5[9] = _zz_4;
    _zz_5[8] = _zz_4;
    _zz_5[7] = _zz_4;
    _zz_5[6] = _zz_4;
    _zz_5[5] = _zz_4;
    _zz_5[4] = _zz_4;
    _zz_5[3] = _zz_4;
    _zz_5[2] = _zz_4;
    _zz_5[1] = _zz_4;
    _zz_5[0] = _zz_4;
  end

  always @(*) begin
    case(decode_BRANCH_CTRL)
      BranchCtrlEnum_JAL : begin
        _zz_6 = _zz__zz_6[1];
      end
      default : begin
        _zz_6 = _zz__zz_6_1[1];
      end
    endcase
  end

  assign IBusCachedPlugin_predictionJumpInterface_valid = (decode_arbitration_isValid && IBusCachedPlugin_decodePrediction_cmd_hadBranch);
  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload = _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload[19];
  always @(*) begin
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[10] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[9] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[8] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[7] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[6] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[5] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[4] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[3] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[2] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[1] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_1[0] = _zz_IBusCachedPlugin_predictionJumpInterface_payload;
  end

  assign _zz_IBusCachedPlugin_predictionJumpInterface_payload_2 = _zz__zz_IBusCachedPlugin_predictionJumpInterface_payload_2[11];
  always @(*) begin
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[18] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[17] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[16] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[15] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[14] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[13] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[12] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[11] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[10] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[9] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[8] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[7] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[6] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[5] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[4] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[3] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[2] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[1] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
    _zz_IBusCachedPlugin_predictionJumpInterface_payload_3[0] = _zz_IBusCachedPlugin_predictionJumpInterface_payload_2;
  end

  assign IBusCachedPlugin_predictionJumpInterface_payload = (decode_PC + ((decode_BRANCH_CTRL == BranchCtrlEnum_JAL) ? {{_zz_IBusCachedPlugin_predictionJumpInterface_payload_1,{{{_zz_IBusCachedPlugin_predictionJumpInterface_payload_4,decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_IBusCachedPlugin_predictionJumpInterface_payload_3,{{{_zz_IBusCachedPlugin_predictionJumpInterface_payload_5,_zz_IBusCachedPlugin_predictionJumpInterface_payload_6},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = IBusCachedPlugin_cache_io_mem_cmd_valid;
  always @(*) begin
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  end

  assign iBus_cmd_payload_size = IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  assign IBusCachedPlugin_s0_tightlyCoupledHit = 1'b0;
  assign IBusCachedPlugin_cache_io_cpu_prefetch_isValid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && (! IBusCachedPlugin_s0_tightlyCoupledHit));
  assign IBusCachedPlugin_mmuBus_cmd_0_isValid = IBusCachedPlugin_cache_io_cpu_prefetch_isValid;
  assign IBusCachedPlugin_mmuBus_cmd_0_isStuck = (! IBusCachedPlugin_iBusRsp_stages_0_input_ready);
  assign IBusCachedPlugin_mmuBus_cmd_0_virtualAddress = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  assign IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0;
  assign IBusCachedPlugin_cache_io_cpu_fetch_isValid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && (! IBusCachedPlugin_s1_tightlyCoupledHit));
  assign IBusCachedPlugin_cache_io_cpu_fetch_isStuck = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_mmuBus_cmd_1_isValid = IBusCachedPlugin_cache_io_cpu_fetch_isValid;
  assign IBusCachedPlugin_mmuBus_cmd_1_isStuck = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_mmuBus_cmd_1_virtualAddress = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  assign IBusCachedPlugin_mmuBus_cmd_1_bypassTranslation = 1'b0;
  assign IBusCachedPlugin_mmuBus_end = (IBusCachedPlugin_iBusRsp_stages_1_input_ready || IBusCachedPlugin_externalFlush);
  assign IBusCachedPlugin_cache_io_cpu_decode_isValid = (IBusCachedPlugin_iBusRsp_stages_2_input_valid && (! IBusCachedPlugin_s2_tightlyCoupledHit));
  assign IBusCachedPlugin_cache_io_cpu_decode_isStuck = (! IBusCachedPlugin_iBusRsp_stages_2_input_ready);
  assign IBusCachedPlugin_cache_io_cpu_decode_isUser = (CsrPlugin_privilege == 2'b00);
  assign IBusCachedPlugin_rsp_iBusRspOutputHalt = 1'b0;
  assign IBusCachedPlugin_rsp_issueDetected = 1'b0;
  always @(*) begin
    IBusCachedPlugin_rsp_redoFetch = 1'b0;
    if(when_IBusCachedPlugin_l245) begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_cache_io_cpu_fill_valid = (IBusCachedPlugin_rsp_redoFetch && (! IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling));
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_cache_io_cpu_fill_valid = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_decodeExceptionPort_valid = 1'b0;
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
    end
    if(when_IBusCachedPlugin_l262) begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @(*) begin
    IBusCachedPlugin_decodeExceptionPort_payload_code = 4'bxxxx;
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = 4'b1100;
    end
    if(when_IBusCachedPlugin_l262) begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = 4'b0001;
    end
  end

  assign IBusCachedPlugin_decodeExceptionPort_payload_badAddr = {IBusCachedPlugin_iBusRsp_stages_2_input_payload[31 : 2],2'b00};
  assign when_IBusCachedPlugin_l245 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_mmuRefilling) && (! IBusCachedPlugin_rsp_issueDetected));
  assign when_IBusCachedPlugin_l250 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_mmuException) && (! IBusCachedPlugin_rsp_issueDetected_1));
  assign when_IBusCachedPlugin_l256 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_cacheMiss) && (! IBusCachedPlugin_rsp_issueDetected_2));
  assign when_IBusCachedPlugin_l262 = ((IBusCachedPlugin_cache_io_cpu_decode_isValid && IBusCachedPlugin_cache_io_cpu_decode_error) && (! IBusCachedPlugin_rsp_issueDetected_3));
  assign when_IBusCachedPlugin_l273 = (IBusCachedPlugin_rsp_issueDetected_4 || IBusCachedPlugin_rsp_iBusRspOutputHalt);
  assign IBusCachedPlugin_iBusRsp_output_valid = IBusCachedPlugin_iBusRsp_stages_2_output_valid;
  assign IBusCachedPlugin_iBusRsp_stages_2_output_ready = IBusCachedPlugin_iBusRsp_output_ready;
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = IBusCachedPlugin_cache_io_cpu_decode_data;
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_iBusRsp_stages_2_output_payload;
  assign IBusCachedPlugin_cache_io_flush = (decode_arbitration_isValid && decode_FLUSH_ALL);
  assign io_mem_cmd_s2mPipe_valid = (dataCache_1_io_mem_cmd_valid || (! io_mem_cmd_rValidN));
  assign io_mem_cmd_s2mPipe_payload_wr = (io_mem_cmd_rValidN ? dataCache_1_io_mem_cmd_payload_wr : io_mem_cmd_rData_wr);
  assign io_mem_cmd_s2mPipe_payload_uncached = (io_mem_cmd_rValidN ? dataCache_1_io_mem_cmd_payload_uncached : io_mem_cmd_rData_uncached);
  assign io_mem_cmd_s2mPipe_payload_address = (io_mem_cmd_rValidN ? dataCache_1_io_mem_cmd_payload_address : io_mem_cmd_rData_address);
  assign io_mem_cmd_s2mPipe_payload_data = (io_mem_cmd_rValidN ? dataCache_1_io_mem_cmd_payload_data : io_mem_cmd_rData_data);
  assign io_mem_cmd_s2mPipe_payload_mask = (io_mem_cmd_rValidN ? dataCache_1_io_mem_cmd_payload_mask : io_mem_cmd_rData_mask);
  assign io_mem_cmd_s2mPipe_payload_size = (io_mem_cmd_rValidN ? dataCache_1_io_mem_cmd_payload_size : io_mem_cmd_rData_size);
  assign io_mem_cmd_s2mPipe_payload_last = (io_mem_cmd_rValidN ? dataCache_1_io_mem_cmd_payload_last : io_mem_cmd_rData_last);
  always @(*) begin
    io_mem_cmd_s2mPipe_ready = io_mem_cmd_s2mPipe_m2sPipe_ready;
    if(when_Stream_l477) begin
      io_mem_cmd_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l477 = (! io_mem_cmd_s2mPipe_m2sPipe_valid);
  assign io_mem_cmd_s2mPipe_m2sPipe_valid = io_mem_cmd_s2mPipe_rValid;
  assign io_mem_cmd_s2mPipe_m2sPipe_payload_wr = io_mem_cmd_s2mPipe_rData_wr;
  assign io_mem_cmd_s2mPipe_m2sPipe_payload_uncached = io_mem_cmd_s2mPipe_rData_uncached;
  assign io_mem_cmd_s2mPipe_m2sPipe_payload_address = io_mem_cmd_s2mPipe_rData_address;
  assign io_mem_cmd_s2mPipe_m2sPipe_payload_data = io_mem_cmd_s2mPipe_rData_data;
  assign io_mem_cmd_s2mPipe_m2sPipe_payload_mask = io_mem_cmd_s2mPipe_rData_mask;
  assign io_mem_cmd_s2mPipe_m2sPipe_payload_size = io_mem_cmd_s2mPipe_rData_size;
  assign io_mem_cmd_s2mPipe_m2sPipe_payload_last = io_mem_cmd_s2mPipe_rData_last;
  assign dBus_cmd_valid = io_mem_cmd_s2mPipe_m2sPipe_valid;
  assign io_mem_cmd_s2mPipe_m2sPipe_ready = dBus_cmd_ready;
  assign dBus_cmd_payload_wr = io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  assign dBus_cmd_payload_uncached = io_mem_cmd_s2mPipe_m2sPipe_payload_uncached;
  assign dBus_cmd_payload_address = io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  assign dBus_cmd_payload_data = io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  assign dBus_cmd_payload_mask = io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  assign dBus_cmd_payload_size = io_mem_cmd_s2mPipe_m2sPipe_payload_size;
  assign dBus_cmd_payload_last = io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  assign when_DBusCachedPlugin_l353 = ((DBusCachedPlugin_mmuBus_busy && decode_arbitration_isValid) && decode_MEMORY_ENABLE);
  always @(*) begin
    _zz_decode_MEMORY_FORCE_CONSTISTENCY = 1'b0;
    if(when_DBusCachedPlugin_l361) begin
      if(decode_MEMORY_LRSC) begin
        _zz_decode_MEMORY_FORCE_CONSTISTENCY = 1'b1;
      end
      if(decode_MEMORY_AMO) begin
        _zz_decode_MEMORY_FORCE_CONSTISTENCY = 1'b1;
      end
    end
  end

  assign when_DBusCachedPlugin_l361 = decode_INSTRUCTION[25];
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    dataCache_1_io_cpu_execute_isValid = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        if(when_DBusCachedPlugin_l606) begin
          dataCache_1_io_cpu_execute_isValid = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    dataCache_1_io_cpu_execute_address = execute_SRC_ADD;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        dataCache_1_io_cpu_execute_address = MmuPlugin_dBusAccess_cmd_payload_address;
      end
    end
  end

  always @(*) begin
    dataCache_1_io_cpu_execute_args_wr = execute_MEMORY_WR;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        dataCache_1_io_cpu_execute_args_wr = 1'b0;
      end
    end
  end

  always @(*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_execute_MEMORY_STORE_DATA_RF = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_execute_MEMORY_STORE_DATA_RF = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_execute_MEMORY_STORE_DATA_RF = execute_RS2[31 : 0];
      end
    endcase
  end

  always @(*) begin
    dataCache_1_io_cpu_execute_args_size = execute_DBusCachedPlugin_size;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        dataCache_1_io_cpu_execute_args_size = MmuPlugin_dBusAccess_cmd_payload_size;
      end
    end
  end

  assign DBusCachedPlugin_mmuBus_cmd_0_isValid = dataCache_1_io_cpu_execute_isValid;
  assign DBusCachedPlugin_mmuBus_cmd_0_isStuck = execute_arbitration_isStuck;
  assign DBusCachedPlugin_mmuBus_cmd_0_virtualAddress = execute_SRC_ADD;
  always @(*) begin
    DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0;
    if(execute_IS_DBUS_SHARING) begin
      DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b1;
    end
  end

  assign dataCache_1_io_cpu_flush_valid = (execute_arbitration_isValid && execute_MEMORY_MANAGMENT);
  assign dataCache_1_io_cpu_flush_payload_singleLine = (execute_INSTRUCTION[19 : 15] != 5'h0);
  assign dataCache_1_io_cpu_flush_payload_lineId = _zz_io_cpu_flush_payload_lineId[6:0];
  assign io_cpu_flush_isStall = (dataCache_1_io_cpu_flush_valid && (! dataCache_1_io_cpu_flush_ready));
  assign when_DBusCachedPlugin_l395 = (io_cpu_flush_isStall || dataCache_1_io_cpu_execute_haltIt);
  always @(*) begin
    dataCache_1_io_cpu_execute_args_isLrsc = 1'b0;
    if(execute_MEMORY_LRSC) begin
      dataCache_1_io_cpu_execute_args_isLrsc = 1'b1;
    end
  end

  assign dataCache_1_io_cpu_execute_args_amoCtrl_alu = execute_INSTRUCTION[31 : 29];
  assign dataCache_1_io_cpu_execute_args_amoCtrl_swap = execute_INSTRUCTION[27];
  assign when_DBusCachedPlugin_l411 = (dataCache_1_io_cpu_execute_refilling && execute_arbitration_isValid);
  always @(*) begin
    dataCache_1_io_cpu_memory_isValid = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
    if(memory_IS_DBUS_SHARING) begin
      dataCache_1_io_cpu_memory_isValid = 1'b1;
    end
  end

  assign dataCache_1_io_cpu_memory_address = memory_REGFILE_WRITE_DATA;
  assign DBusCachedPlugin_mmuBus_cmd_1_isValid = dataCache_1_io_cpu_memory_isValid;
  assign DBusCachedPlugin_mmuBus_cmd_1_isStuck = memory_arbitration_isStuck;
  assign DBusCachedPlugin_mmuBus_cmd_1_virtualAddress = dataCache_1_io_cpu_memory_address;
  always @(*) begin
    DBusCachedPlugin_mmuBus_cmd_1_bypassTranslation = 1'b0;
    if(memory_IS_DBUS_SHARING) begin
      DBusCachedPlugin_mmuBus_cmd_1_bypassTranslation = 1'b1;
    end
  end

  assign DBusCachedPlugin_mmuBus_end = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  always @(*) begin
    dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = DBusCachedPlugin_mmuBus_rsp_isIoAccess;
    if(when_DBusCachedPlugin_l473) begin
      dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = 1'b1;
    end
  end

  assign when_DBusCachedPlugin_l473 = (_zz_when_DBusCachedPlugin_l473 && (! dataCache_1_io_cpu_memory_isWrite));
  always @(*) begin
    dataCache_1_io_cpu_writeBack_isValid = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
    if(writeBack_IS_DBUS_SHARING) begin
      dataCache_1_io_cpu_writeBack_isValid = 1'b1;
    end
    if(writeBack_arbitration_haltByOther) begin
      dataCache_1_io_cpu_writeBack_isValid = 1'b0;
    end
  end

  assign dataCache_1_io_cpu_writeBack_isUser = (CsrPlugin_privilege == 2'b00);
  assign dataCache_1_io_cpu_writeBack_address = writeBack_REGFILE_WRITE_DATA;
  assign dataCache_1_io_cpu_writeBack_storeData[31 : 0] = writeBack_MEMORY_STORE_DATA_RF;
  always @(*) begin
    DBusCachedPlugin_redoBranch_valid = 1'b0;
    if(when_DBusCachedPlugin_l534) begin
      if(dataCache_1_io_cpu_redo) begin
        DBusCachedPlugin_redoBranch_valid = 1'b1;
      end
    end
  end

  assign DBusCachedPlugin_redoBranch_payload = writeBack_PC;
  always @(*) begin
    DBusCachedPlugin_exceptionBus_valid = 1'b0;
    if(when_DBusCachedPlugin_l534) begin
      if(dataCache_1_io_cpu_writeBack_accessError) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1_io_cpu_writeBack_mmuException) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1_io_cpu_writeBack_unalignedAccess) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1_io_cpu_redo) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b0;
      end
    end
  end

  assign DBusCachedPlugin_exceptionBus_payload_badAddr = writeBack_REGFILE_WRITE_DATA;
  always @(*) begin
    DBusCachedPlugin_exceptionBus_payload_code = 4'bxxxx;
    if(when_DBusCachedPlugin_l534) begin
      if(dataCache_1_io_cpu_writeBack_accessError) begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_DBusCachedPlugin_exceptionBus_payload_code};
      end
      if(dataCache_1_io_cpu_writeBack_mmuException) begin
        DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 4'b1111 : 4'b1101);
      end
      if(dataCache_1_io_cpu_writeBack_unalignedAccess) begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_DBusCachedPlugin_exceptionBus_payload_code_1};
      end
    end
  end

  assign when_DBusCachedPlugin_l534 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign when_DBusCachedPlugin_l554 = (dataCache_1_io_cpu_writeBack_isValid && dataCache_1_io_cpu_writeBack_haltIt);
  assign writeBack_DBusCachedPlugin_rspData = dataCache_1_io_cpu_writeBack_data;
  assign writeBack_DBusCachedPlugin_rspSplits_0 = writeBack_DBusCachedPlugin_rspData[7 : 0];
  assign writeBack_DBusCachedPlugin_rspSplits_1 = writeBack_DBusCachedPlugin_rspData[15 : 8];
  assign writeBack_DBusCachedPlugin_rspSplits_2 = writeBack_DBusCachedPlugin_rspData[23 : 16];
  assign writeBack_DBusCachedPlugin_rspSplits_3 = writeBack_DBusCachedPlugin_rspData[31 : 24];
  always @(*) begin
    writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_writeBack_DBusCachedPlugin_rspShifted;
    writeBack_DBusCachedPlugin_rspShifted[15 : 8] = _zz_writeBack_DBusCachedPlugin_rspShifted_2;
    writeBack_DBusCachedPlugin_rspShifted[23 : 16] = writeBack_DBusCachedPlugin_rspSplits_2;
    writeBack_DBusCachedPlugin_rspShifted[31 : 24] = writeBack_DBusCachedPlugin_rspSplits_3;
  end

  always @(*) begin
    writeBack_DBusCachedPlugin_rspRf = writeBack_DBusCachedPlugin_rspShifted[31 : 0];
    if(when_DBusCachedPlugin_l571) begin
      writeBack_DBusCachedPlugin_rspRf = {31'd0, _zz_writeBack_DBusCachedPlugin_rspRf};
    end
  end

  assign when_DBusCachedPlugin_l571 = (writeBack_MEMORY_LRSC && writeBack_MEMORY_WR);
  assign switch_Misc_l245 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_writeBack_DBusCachedPlugin_rspFormated = (writeBack_DBusCachedPlugin_rspRf[7] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[31] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[30] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[29] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[28] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[27] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[26] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[25] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[24] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[23] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[22] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[21] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[20] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[19] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[18] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[17] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[16] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[15] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[14] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[13] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[12] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[11] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[10] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[9] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[8] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[7 : 0] = writeBack_DBusCachedPlugin_rspRf[7 : 0];
  end

  assign _zz_writeBack_DBusCachedPlugin_rspFormated_2 = (writeBack_DBusCachedPlugin_rspRf[15] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[31] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[30] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[29] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[28] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[27] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[26] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[25] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[24] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[23] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[22] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[21] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[20] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[19] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[18] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[17] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[16] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[15 : 0] = writeBack_DBusCachedPlugin_rspRf[15 : 0];
  end

  always @(*) begin
    case(switch_Misc_l245)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_1;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_3;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspRf;
      end
    endcase
  end

  assign when_DBusCachedPlugin_l581 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  always @(*) begin
    MmuPlugin_dBusAccess_cmd_ready = 1'b0;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        if(when_DBusCachedPlugin_l606) begin
          MmuPlugin_dBusAccess_cmd_ready = (! execute_arbitration_isStuck);
        end
      end
    end
  end

  always @(*) begin
    DBusCachedPlugin_forceDatapath = 1'b0;
    if(MmuPlugin_dBusAccess_cmd_valid) begin
      if(when_DBusCachedPlugin_l605) begin
        DBusCachedPlugin_forceDatapath = 1'b1;
      end
    end
  end

  assign when_DBusCachedPlugin_l605 = (! (|{(writeBack_arbitration_isValid || CsrPlugin_exceptionPendings_3),{(memory_arbitration_isValid || CsrPlugin_exceptionPendings_2),(execute_arbitration_isValid || CsrPlugin_exceptionPendings_1)}}));
  assign when_DBusCachedPlugin_l606 = (! dataCache_1_io_cpu_execute_refilling);
  assign MmuPlugin_dBusAccess_cmd_fire = (MmuPlugin_dBusAccess_cmd_valid && MmuPlugin_dBusAccess_cmd_ready);
  assign MmuPlugin_dBusAccess_rsp_valid = ((writeBack_IS_DBUS_SHARING && (! dataCache_1_io_cpu_writeBack_isWrite)) && (dataCache_1_io_cpu_redo || (! dataCache_1_io_cpu_writeBack_haltIt)));
  assign MmuPlugin_dBusAccess_rsp_payload_data = writeBack_DBusCachedPlugin_rspRf;
  assign MmuPlugin_dBusAccess_rsp_payload_error = (dataCache_1_io_cpu_writeBack_unalignedAccess || dataCache_1_io_cpu_writeBack_accessError);
  assign MmuPlugin_dBusAccess_rsp_payload_redo = dataCache_1_io_cpu_redo;
  assign when_MmuPlugin_l117 = (! IBusCachedPlugin_mmuBus_cmd_1_isStuck);
  always @(*) begin
    MmuPlugin_ports_0_requireMmuLockupCalc = ((1'b1 && (! IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation)) && MmuPlugin_satp_mode);
    if(when_MmuPlugin_l131) begin
      MmuPlugin_ports_0_requireMmuLockupCalc = 1'b0;
    end
    if(when_MmuPlugin_l132) begin
      MmuPlugin_ports_0_requireMmuLockupCalc = 1'b0;
    end
  end

  assign when_MmuPlugin_l131 = ((! MmuPlugin_status_mprv) && (CsrPlugin_privilege == 2'b11));
  assign when_MmuPlugin_l132 = (CsrPlugin_privilege == 2'b11);
  assign MmuPlugin_ports_0_cacheHitsCalc = {((MmuPlugin_ports_0_cache_3_valid && (MmuPlugin_ports_0_cache_3_virtualAddress_1 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22])) && (MmuPlugin_ports_0_cache_3_superPage || (MmuPlugin_ports_0_cache_3_virtualAddress_0 == IBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12]))),{((MmuPlugin_ports_0_cache_2_valid && (MmuPlugin_ports_0_cache_2_virtualAddress_1 == _zz_MmuPlugin_ports_0_cacheHitsCalc)) && (MmuPlugin_ports_0_cache_2_superPage || (MmuPlugin_ports_0_cache_2_virtualAddress_0 == _zz_MmuPlugin_ports_0_cacheHitsCalc_1))),{((MmuPlugin_ports_0_cache_1_valid && _zz_MmuPlugin_ports_0_cacheHitsCalc_2) && (MmuPlugin_ports_0_cache_1_superPage || _zz_MmuPlugin_ports_0_cacheHitsCalc_3)),((MmuPlugin_ports_0_cache_0_valid && _zz_MmuPlugin_ports_0_cacheHitsCalc_4) && (MmuPlugin_ports_0_cache_0_superPage || _zz_MmuPlugin_ports_0_cacheHitsCalc_5))}}};
  assign when_MmuPlugin_l124 = (! IBusCachedPlugin_mmuBus_cmd_1_isStuck);
  assign when_MmuPlugin_l124_1 = (! IBusCachedPlugin_mmuBus_cmd_1_isStuck);
  assign MmuPlugin_ports_0_cacheHit = (|MmuPlugin_ports_0_cacheHits);
  assign _zz_MmuPlugin_ports_0_cacheLine_valid = MmuPlugin_ports_0_cacheHits[3];
  assign _zz_MmuPlugin_ports_0_cacheLine_valid_1 = (MmuPlugin_ports_0_cacheHits[1] || _zz_MmuPlugin_ports_0_cacheLine_valid);
  assign _zz_MmuPlugin_ports_0_cacheLine_valid_2 = (MmuPlugin_ports_0_cacheHits[2] || _zz_MmuPlugin_ports_0_cacheLine_valid);
  assign _zz_MmuPlugin_ports_0_cacheLine_valid_3 = {_zz_MmuPlugin_ports_0_cacheLine_valid_2,_zz_MmuPlugin_ports_0_cacheLine_valid_1};
  assign MmuPlugin_ports_0_cacheLine_valid = _zz_MmuPlugin_ports_0_cacheLine_valid_4;
  assign MmuPlugin_ports_0_cacheLine_exception = _zz_MmuPlugin_ports_0_cacheLine_exception;
  assign MmuPlugin_ports_0_cacheLine_superPage = _zz_MmuPlugin_ports_0_cacheLine_superPage;
  assign MmuPlugin_ports_0_cacheLine_virtualAddress_0 = _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_0;
  assign MmuPlugin_ports_0_cacheLine_virtualAddress_1 = _zz_MmuPlugin_ports_0_cacheLine_virtualAddress_1;
  assign MmuPlugin_ports_0_cacheLine_physicalAddress_0 = _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_0;
  assign MmuPlugin_ports_0_cacheLine_physicalAddress_1 = _zz_MmuPlugin_ports_0_cacheLine_physicalAddress_1;
  assign MmuPlugin_ports_0_cacheLine_allowRead = _zz_MmuPlugin_ports_0_cacheLine_allowRead;
  assign MmuPlugin_ports_0_cacheLine_allowWrite = _zz_MmuPlugin_ports_0_cacheLine_allowWrite;
  assign MmuPlugin_ports_0_cacheLine_allowExecute = _zz_MmuPlugin_ports_0_cacheLine_allowExecute;
  assign MmuPlugin_ports_0_cacheLine_allowUser = _zz_MmuPlugin_ports_0_cacheLine_allowUser;
  always @(*) begin
    MmuPlugin_ports_0_entryToReplace_willIncrement = 1'b0;
    if(when_MmuPlugin_l279) begin
      if(when_MmuPlugin_l281) begin
        MmuPlugin_ports_0_entryToReplace_willIncrement = 1'b1;
      end
    end
  end

  assign MmuPlugin_ports_0_entryToReplace_willClear = 1'b0;
  assign MmuPlugin_ports_0_entryToReplace_willOverflowIfInc = (MmuPlugin_ports_0_entryToReplace_value == 2'b11);
  assign MmuPlugin_ports_0_entryToReplace_willOverflow = (MmuPlugin_ports_0_entryToReplace_willOverflowIfInc && MmuPlugin_ports_0_entryToReplace_willIncrement);
  always @(*) begin
    MmuPlugin_ports_0_entryToReplace_valueNext = (MmuPlugin_ports_0_entryToReplace_value + _zz_MmuPlugin_ports_0_entryToReplace_valueNext);
    if(MmuPlugin_ports_0_entryToReplace_willClear) begin
      MmuPlugin_ports_0_entryToReplace_valueNext = 2'b00;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_0_requireMmuLockup) begin
      IBusCachedPlugin_mmuBus_rsp_physicalAddress = {{MmuPlugin_ports_0_cacheLine_physicalAddress_1,(MmuPlugin_ports_0_cacheLine_superPage ? IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_0_cacheLine_physicalAddress_0)},IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
    end else begin
      IBusCachedPlugin_mmuBus_rsp_physicalAddress = IBusCachedPlugin_mmuBus_cmd_1_virtualAddress;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_0_requireMmuLockup) begin
      IBusCachedPlugin_mmuBus_rsp_allowRead = (MmuPlugin_ports_0_cacheLine_allowRead || (MmuPlugin_status_mxr && MmuPlugin_ports_0_cacheLine_allowExecute));
    end else begin
      IBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_0_requireMmuLockup) begin
      IBusCachedPlugin_mmuBus_rsp_allowWrite = MmuPlugin_ports_0_cacheLine_allowWrite;
    end else begin
      IBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_0_requireMmuLockup) begin
      IBusCachedPlugin_mmuBus_rsp_allowExecute = MmuPlugin_ports_0_cacheLine_allowExecute;
    end else begin
      IBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_0_requireMmuLockup) begin
      IBusCachedPlugin_mmuBus_rsp_exception = (((! MmuPlugin_ports_0_dirty) && MmuPlugin_ports_0_cacheHit) && ((MmuPlugin_ports_0_cacheLine_exception || ((MmuPlugin_ports_0_cacheLine_allowUser && (CsrPlugin_privilege == 2'b01)) && (! MmuPlugin_status_sum))) || ((! MmuPlugin_ports_0_cacheLine_allowUser) && (CsrPlugin_privilege == 2'b00))));
    end else begin
      IBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_0_requireMmuLockup) begin
      IBusCachedPlugin_mmuBus_rsp_refilling = (MmuPlugin_ports_0_dirty || (! MmuPlugin_ports_0_cacheHit));
    end else begin
      IBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_0_requireMmuLockup) begin
      IBusCachedPlugin_mmuBus_rsp_isPaging = 1'b1;
    end else begin
      IBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0;
    end
  end

  assign IBusCachedPlugin_mmuBus_rsp_isIoAccess = (IBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == 4'b1111);
  assign IBusCachedPlugin_mmuBus_rsp_bypassTranslation = (! MmuPlugin_ports_0_requireMmuLockup);
  assign IBusCachedPlugin_mmuBus_rsp_ways_0_sel = MmuPlugin_ports_0_cacheHits[0];
  assign IBusCachedPlugin_mmuBus_rsp_ways_0_physical = {{MmuPlugin_ports_0_cache_0_physicalAddress_1,(MmuPlugin_ports_0_cache_0_superPage ? IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_0_cache_0_physicalAddress_0)},IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign IBusCachedPlugin_mmuBus_rsp_ways_1_sel = MmuPlugin_ports_0_cacheHits[1];
  assign IBusCachedPlugin_mmuBus_rsp_ways_1_physical = {{MmuPlugin_ports_0_cache_1_physicalAddress_1,(MmuPlugin_ports_0_cache_1_superPage ? IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_0_cache_1_physicalAddress_0)},IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign IBusCachedPlugin_mmuBus_rsp_ways_2_sel = MmuPlugin_ports_0_cacheHits[2];
  assign IBusCachedPlugin_mmuBus_rsp_ways_2_physical = {{MmuPlugin_ports_0_cache_2_physicalAddress_1,(MmuPlugin_ports_0_cache_2_superPage ? IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_0_cache_2_physicalAddress_0)},IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign IBusCachedPlugin_mmuBus_rsp_ways_3_sel = MmuPlugin_ports_0_cacheHits[3];
  assign IBusCachedPlugin_mmuBus_rsp_ways_3_physical = {{MmuPlugin_ports_0_cache_3_physicalAddress_1,(MmuPlugin_ports_0_cache_3_superPage ? IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_0_cache_3_physicalAddress_0)},IBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign when_MmuPlugin_l117_1 = (! DBusCachedPlugin_mmuBus_cmd_1_isStuck);
  always @(*) begin
    MmuPlugin_ports_1_requireMmuLockupCalc = ((1'b1 && (! DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation)) && MmuPlugin_satp_mode);
    if(when_MmuPlugin_l131_1) begin
      MmuPlugin_ports_1_requireMmuLockupCalc = 1'b0;
    end
    if(when_MmuPlugin_l132_1) begin
      if(when_MmuPlugin_l134) begin
        MmuPlugin_ports_1_requireMmuLockupCalc = 1'b0;
      end
    end
  end

  assign when_MmuPlugin_l131_1 = ((! MmuPlugin_status_mprv) && (CsrPlugin_privilege == 2'b11));
  assign when_MmuPlugin_l132_1 = (CsrPlugin_privilege == 2'b11);
  assign when_MmuPlugin_l134 = ((! MmuPlugin_status_mprv) || (CsrPlugin_mstatus_MPP == 2'b11));
  assign MmuPlugin_ports_1_cacheHitsCalc = {((MmuPlugin_ports_1_cache_3_valid && (MmuPlugin_ports_1_cache_3_virtualAddress_1 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[31 : 22])) && (MmuPlugin_ports_1_cache_3_superPage || (MmuPlugin_ports_1_cache_3_virtualAddress_0 == DBusCachedPlugin_mmuBus_cmd_0_virtualAddress[21 : 12]))),{((MmuPlugin_ports_1_cache_2_valid && (MmuPlugin_ports_1_cache_2_virtualAddress_1 == _zz_MmuPlugin_ports_1_cacheHitsCalc)) && (MmuPlugin_ports_1_cache_2_superPage || (MmuPlugin_ports_1_cache_2_virtualAddress_0 == _zz_MmuPlugin_ports_1_cacheHitsCalc_1))),{((MmuPlugin_ports_1_cache_1_valid && _zz_MmuPlugin_ports_1_cacheHitsCalc_2) && (MmuPlugin_ports_1_cache_1_superPage || _zz_MmuPlugin_ports_1_cacheHitsCalc_3)),((MmuPlugin_ports_1_cache_0_valid && _zz_MmuPlugin_ports_1_cacheHitsCalc_4) && (MmuPlugin_ports_1_cache_0_superPage || _zz_MmuPlugin_ports_1_cacheHitsCalc_5))}}};
  assign when_MmuPlugin_l124_2 = (! DBusCachedPlugin_mmuBus_cmd_1_isStuck);
  assign when_MmuPlugin_l124_3 = (! DBusCachedPlugin_mmuBus_cmd_1_isStuck);
  assign MmuPlugin_ports_1_cacheHit = (|MmuPlugin_ports_1_cacheHits);
  assign _zz_MmuPlugin_ports_1_cacheLine_valid = MmuPlugin_ports_1_cacheHits[3];
  assign _zz_MmuPlugin_ports_1_cacheLine_valid_1 = (MmuPlugin_ports_1_cacheHits[1] || _zz_MmuPlugin_ports_1_cacheLine_valid);
  assign _zz_MmuPlugin_ports_1_cacheLine_valid_2 = (MmuPlugin_ports_1_cacheHits[2] || _zz_MmuPlugin_ports_1_cacheLine_valid);
  assign _zz_MmuPlugin_ports_1_cacheLine_valid_3 = {_zz_MmuPlugin_ports_1_cacheLine_valid_2,_zz_MmuPlugin_ports_1_cacheLine_valid_1};
  assign MmuPlugin_ports_1_cacheLine_valid = _zz_MmuPlugin_ports_1_cacheLine_valid_4;
  assign MmuPlugin_ports_1_cacheLine_exception = _zz_MmuPlugin_ports_1_cacheLine_exception;
  assign MmuPlugin_ports_1_cacheLine_superPage = _zz_MmuPlugin_ports_1_cacheLine_superPage;
  assign MmuPlugin_ports_1_cacheLine_virtualAddress_0 = _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_0;
  assign MmuPlugin_ports_1_cacheLine_virtualAddress_1 = _zz_MmuPlugin_ports_1_cacheLine_virtualAddress_1;
  assign MmuPlugin_ports_1_cacheLine_physicalAddress_0 = _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_0;
  assign MmuPlugin_ports_1_cacheLine_physicalAddress_1 = _zz_MmuPlugin_ports_1_cacheLine_physicalAddress_1;
  assign MmuPlugin_ports_1_cacheLine_allowRead = _zz_MmuPlugin_ports_1_cacheLine_allowRead;
  assign MmuPlugin_ports_1_cacheLine_allowWrite = _zz_MmuPlugin_ports_1_cacheLine_allowWrite;
  assign MmuPlugin_ports_1_cacheLine_allowExecute = _zz_MmuPlugin_ports_1_cacheLine_allowExecute;
  assign MmuPlugin_ports_1_cacheLine_allowUser = _zz_MmuPlugin_ports_1_cacheLine_allowUser;
  always @(*) begin
    MmuPlugin_ports_1_entryToReplace_willIncrement = 1'b0;
    if(when_MmuPlugin_l279) begin
      if(when_MmuPlugin_l281_1) begin
        MmuPlugin_ports_1_entryToReplace_willIncrement = 1'b1;
      end
    end
  end

  assign MmuPlugin_ports_1_entryToReplace_willClear = 1'b0;
  assign MmuPlugin_ports_1_entryToReplace_willOverflowIfInc = (MmuPlugin_ports_1_entryToReplace_value == 2'b11);
  assign MmuPlugin_ports_1_entryToReplace_willOverflow = (MmuPlugin_ports_1_entryToReplace_willOverflowIfInc && MmuPlugin_ports_1_entryToReplace_willIncrement);
  always @(*) begin
    MmuPlugin_ports_1_entryToReplace_valueNext = (MmuPlugin_ports_1_entryToReplace_value + _zz_MmuPlugin_ports_1_entryToReplace_valueNext);
    if(MmuPlugin_ports_1_entryToReplace_willClear) begin
      MmuPlugin_ports_1_entryToReplace_valueNext = 2'b00;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_1_requireMmuLockup) begin
      DBusCachedPlugin_mmuBus_rsp_physicalAddress = {{MmuPlugin_ports_1_cacheLine_physicalAddress_1,(MmuPlugin_ports_1_cacheLine_superPage ? DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_1_cacheLine_physicalAddress_0)},DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
    end else begin
      DBusCachedPlugin_mmuBus_rsp_physicalAddress = DBusCachedPlugin_mmuBus_cmd_1_virtualAddress;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_1_requireMmuLockup) begin
      DBusCachedPlugin_mmuBus_rsp_allowRead = (MmuPlugin_ports_1_cacheLine_allowRead || (MmuPlugin_status_mxr && MmuPlugin_ports_1_cacheLine_allowExecute));
    end else begin
      DBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_1_requireMmuLockup) begin
      DBusCachedPlugin_mmuBus_rsp_allowWrite = MmuPlugin_ports_1_cacheLine_allowWrite;
    end else begin
      DBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_1_requireMmuLockup) begin
      DBusCachedPlugin_mmuBus_rsp_allowExecute = MmuPlugin_ports_1_cacheLine_allowExecute;
    end else begin
      DBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_1_requireMmuLockup) begin
      DBusCachedPlugin_mmuBus_rsp_exception = (((! MmuPlugin_ports_1_dirty) && MmuPlugin_ports_1_cacheHit) && ((MmuPlugin_ports_1_cacheLine_exception || ((MmuPlugin_ports_1_cacheLine_allowUser && (CsrPlugin_privilege == 2'b01)) && (! MmuPlugin_status_sum))) || ((! MmuPlugin_ports_1_cacheLine_allowUser) && (CsrPlugin_privilege == 2'b00))));
    end else begin
      DBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_1_requireMmuLockup) begin
      DBusCachedPlugin_mmuBus_rsp_refilling = (MmuPlugin_ports_1_dirty || (! MmuPlugin_ports_1_cacheHit));
    end else begin
      DBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
    end
  end

  always @(*) begin
    if(MmuPlugin_ports_1_requireMmuLockup) begin
      DBusCachedPlugin_mmuBus_rsp_isPaging = 1'b1;
    end else begin
      DBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0;
    end
  end

  assign DBusCachedPlugin_mmuBus_rsp_isIoAccess = (DBusCachedPlugin_mmuBus_rsp_physicalAddress[31 : 28] == 4'b1111);
  assign DBusCachedPlugin_mmuBus_rsp_bypassTranslation = (! MmuPlugin_ports_1_requireMmuLockup);
  assign DBusCachedPlugin_mmuBus_rsp_ways_0_sel = MmuPlugin_ports_1_cacheHits[0];
  assign DBusCachedPlugin_mmuBus_rsp_ways_0_physical = {{MmuPlugin_ports_1_cache_0_physicalAddress_1,(MmuPlugin_ports_1_cache_0_superPage ? DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_1_cache_0_physicalAddress_0)},DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign DBusCachedPlugin_mmuBus_rsp_ways_1_sel = MmuPlugin_ports_1_cacheHits[1];
  assign DBusCachedPlugin_mmuBus_rsp_ways_1_physical = {{MmuPlugin_ports_1_cache_1_physicalAddress_1,(MmuPlugin_ports_1_cache_1_superPage ? DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_1_cache_1_physicalAddress_0)},DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign DBusCachedPlugin_mmuBus_rsp_ways_2_sel = MmuPlugin_ports_1_cacheHits[2];
  assign DBusCachedPlugin_mmuBus_rsp_ways_2_physical = {{MmuPlugin_ports_1_cache_2_physicalAddress_1,(MmuPlugin_ports_1_cache_2_superPage ? DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_1_cache_2_physicalAddress_0)},DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign DBusCachedPlugin_mmuBus_rsp_ways_3_sel = MmuPlugin_ports_1_cacheHits[3];
  assign DBusCachedPlugin_mmuBus_rsp_ways_3_physical = {{MmuPlugin_ports_1_cache_3_physicalAddress_1,(MmuPlugin_ports_1_cache_3_superPage ? DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[21 : 12] : MmuPlugin_ports_1_cache_3_physicalAddress_0)},DBusCachedPlugin_mmuBus_cmd_1_virtualAddress[11 : 0]};
  assign MmuPlugin_shared_dBusRsp_pte_V = MmuPlugin_shared_dBusRspStaged_payload_data[0];
  assign MmuPlugin_shared_dBusRsp_pte_R = MmuPlugin_shared_dBusRspStaged_payload_data[1];
  assign MmuPlugin_shared_dBusRsp_pte_W = MmuPlugin_shared_dBusRspStaged_payload_data[2];
  assign MmuPlugin_shared_dBusRsp_pte_X = MmuPlugin_shared_dBusRspStaged_payload_data[3];
  assign MmuPlugin_shared_dBusRsp_pte_U = MmuPlugin_shared_dBusRspStaged_payload_data[4];
  assign MmuPlugin_shared_dBusRsp_pte_G = MmuPlugin_shared_dBusRspStaged_payload_data[5];
  assign MmuPlugin_shared_dBusRsp_pte_A = MmuPlugin_shared_dBusRspStaged_payload_data[6];
  assign MmuPlugin_shared_dBusRsp_pte_D = MmuPlugin_shared_dBusRspStaged_payload_data[7];
  assign MmuPlugin_shared_dBusRsp_pte_RSW = MmuPlugin_shared_dBusRspStaged_payload_data[9 : 8];
  assign MmuPlugin_shared_dBusRsp_pte_PPN0 = MmuPlugin_shared_dBusRspStaged_payload_data[19 : 10];
  assign MmuPlugin_shared_dBusRsp_pte_PPN1 = MmuPlugin_shared_dBusRspStaged_payload_data[31 : 20];
  assign MmuPlugin_shared_dBusRsp_exception = (((! MmuPlugin_shared_dBusRsp_pte_V) || ((! MmuPlugin_shared_dBusRsp_pte_R) && MmuPlugin_shared_dBusRsp_pte_W)) || MmuPlugin_shared_dBusRspStaged_payload_error);
  assign MmuPlugin_shared_dBusRsp_leaf = (MmuPlugin_shared_dBusRsp_pte_R || MmuPlugin_shared_dBusRsp_pte_X);
  assign when_MmuPlugin_l211 = (MmuPlugin_shared_dBusRspStaged_valid && (! MmuPlugin_shared_dBusRspStaged_payload_redo));
  always @(*) begin
    MmuPlugin_dBusAccess_cmd_valid = 1'b0;
    case(MmuPlugin_shared_state_1)
      MmuPlugin_shared_State_IDLE : begin
      end
      MmuPlugin_shared_State_L1_CMD : begin
        MmuPlugin_dBusAccess_cmd_valid = 1'b1;
      end
      MmuPlugin_shared_State_L1_RSP : begin
      end
      MmuPlugin_shared_State_L0_CMD : begin
        MmuPlugin_dBusAccess_cmd_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign MmuPlugin_dBusAccess_cmd_payload_write = 1'b0;
  assign MmuPlugin_dBusAccess_cmd_payload_size = 2'b10;
  always @(*) begin
    MmuPlugin_dBusAccess_cmd_payload_address = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(MmuPlugin_shared_state_1)
      MmuPlugin_shared_State_IDLE : begin
      end
      MmuPlugin_shared_State_L1_CMD : begin
        MmuPlugin_dBusAccess_cmd_payload_address = {{MmuPlugin_satp_ppn[19 : 0],MmuPlugin_shared_vpn_1},2'b00};
      end
      MmuPlugin_shared_State_L1_RSP : begin
      end
      MmuPlugin_shared_State_L0_CMD : begin
        MmuPlugin_dBusAccess_cmd_payload_address = {{{MmuPlugin_shared_pteBuffer_PPN1[9 : 0],MmuPlugin_shared_pteBuffer_PPN0},MmuPlugin_shared_vpn_0},2'b00};
      end
      default : begin
      end
    endcase
  end

  assign MmuPlugin_dBusAccess_cmd_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign MmuPlugin_dBusAccess_cmd_payload_writeMask = 4'bxxxx;
  assign _zz_MmuPlugin_shared_refills = {(((DBusCachedPlugin_mmuBus_cmd_1_isValid && MmuPlugin_ports_1_requireMmuLockup) && (! MmuPlugin_ports_1_dirty)) && (! MmuPlugin_ports_1_cacheHit)),(((IBusCachedPlugin_mmuBus_cmd_1_isValid && MmuPlugin_ports_0_requireMmuLockup) && (! MmuPlugin_ports_0_dirty)) && (! MmuPlugin_ports_0_cacheHit))};
  always @(*) begin
    _zz_MmuPlugin_shared_refills_1[0] = _zz_MmuPlugin_shared_refills[1];
    _zz_MmuPlugin_shared_refills_1[1] = _zz_MmuPlugin_shared_refills[0];
  end

  assign _zz_MmuPlugin_shared_refills_2 = (_zz_MmuPlugin_shared_refills_1 & (~ _zz__zz_MmuPlugin_shared_refills_2));
  always @(*) begin
    _zz_MmuPlugin_shared_refills_3[0] = _zz_MmuPlugin_shared_refills_2[1];
    _zz_MmuPlugin_shared_refills_3[1] = _zz_MmuPlugin_shared_refills_2[0];
  end

  assign MmuPlugin_shared_refills = _zz_MmuPlugin_shared_refills_3;
  assign when_MmuPlugin_l223 = (|MmuPlugin_shared_refills);
  assign _zz_MmuPlugin_shared_vpn_0 = (MmuPlugin_shared_refills[0] ? IBusCachedPlugin_mmuBus_cmd_1_virtualAddress : DBusCachedPlugin_mmuBus_cmd_1_virtualAddress);
  assign when_MmuPlugin_l250 = (MmuPlugin_shared_dBusRsp_leaf || MmuPlugin_shared_dBusRsp_exception);
  assign IBusCachedPlugin_mmuBus_busy = ((MmuPlugin_shared_state_1 != MmuPlugin_shared_State_IDLE) && MmuPlugin_shared_portSortedOh[0]);
  assign DBusCachedPlugin_mmuBus_busy = ((MmuPlugin_shared_state_1 != MmuPlugin_shared_State_IDLE) && MmuPlugin_shared_portSortedOh[1]);
  assign when_MmuPlugin_l279 = ((MmuPlugin_shared_dBusRspStaged_valid && (! MmuPlugin_shared_dBusRspStaged_payload_redo)) && (MmuPlugin_shared_dBusRsp_leaf || MmuPlugin_shared_dBusRsp_exception));
  assign when_MmuPlugin_l281 = MmuPlugin_shared_portSortedOh[0];
  assign when_MmuPlugin_l287 = (MmuPlugin_ports_0_entryToReplace_value == 2'b00);
  assign when_MmuPlugin_l287_1 = (MmuPlugin_ports_0_entryToReplace_value == 2'b01);
  assign when_MmuPlugin_l287_2 = (MmuPlugin_ports_0_entryToReplace_value == 2'b10);
  assign when_MmuPlugin_l287_3 = (MmuPlugin_ports_0_entryToReplace_value == 2'b11);
  assign when_MmuPlugin_l281_1 = MmuPlugin_shared_portSortedOh[1];
  assign when_MmuPlugin_l287_4 = (MmuPlugin_ports_1_entryToReplace_value == 2'b00);
  assign when_MmuPlugin_l287_5 = (MmuPlugin_ports_1_entryToReplace_value == 2'b01);
  assign when_MmuPlugin_l287_6 = (MmuPlugin_ports_1_entryToReplace_value == 2'b10);
  assign when_MmuPlugin_l287_7 = (MmuPlugin_ports_1_entryToReplace_value == 2'b11);
  assign when_MmuPlugin_l311 = ((execute_arbitration_isValid && execute_arbitration_isFiring) && execute_IS_SFENCE_VMA2);
  assign _zz_decode_IS_CSR_1 = ((decode_INSTRUCTION & 32'h00005048) == 32'h00001008);
  assign _zz_decode_IS_CSR_2 = ((decode_INSTRUCTION & 32'h02003050) == 32'h02000050);
  assign _zz_decode_IS_CSR_3 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004050);
  assign _zz_decode_IS_CSR_4 = ((decode_INSTRUCTION & 32'h00000048) == 32'h00000048);
  assign _zz_decode_IS_CSR_5 = ((decode_INSTRUCTION & 32'h00002050) == 32'h00002000);
  assign _zz_decode_IS_CSR_6 = ((decode_INSTRUCTION & 32'h00000018) == 32'h0);
  assign _zz_decode_IS_CSR_7 = ((decode_INSTRUCTION & 32'h00000004) == 32'h00000004);
  assign _zz_decode_IS_CSR_8 = ((decode_INSTRUCTION & 32'h0000000c) == 32'h00000004);
  assign _zz_decode_IS_CSR_9 = ((decode_INSTRUCTION & 32'h00002010) == 32'h00002000);
  assign _zz_decode_IS_CSR_10 = ((decode_INSTRUCTION & 32'h00001000) == 32'h0);
  assign _zz_decode_IS_CSR_11 = ((decode_INSTRUCTION & 32'h10103050) == 32'h00100050);
  assign _zz_decode_IS_CSR = {(|{(_zz__zz_decode_IS_CSR == _zz__zz_decode_IS_CSR_1),(_zz__zz_decode_IS_CSR_2 == _zz__zz_decode_IS_CSR_3)}),{(|{_zz_decode_IS_CSR_4,_zz__zz_decode_IS_CSR_4}),{(|_zz__zz_decode_IS_CSR_5),{(|_zz__zz_decode_IS_CSR_6),{_zz__zz_decode_IS_CSR_7,{_zz__zz_decode_IS_CSR_12,_zz__zz_decode_IS_CSR_15}}}}}};
  assign _zz_decode_SRC1_CTRL_2 = _zz_decode_IS_CSR[3 : 2];
  assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2;
  assign _zz_decode_ALU_CTRL_2 = _zz_decode_IS_CSR[8 : 7];
  assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2;
  assign _zz_decode_SRC2_CTRL_2 = _zz_decode_IS_CSR[10 : 9];
  assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2;
  assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_IS_CSR[24 : 23];
  assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2;
  assign _zz_decode_SHIFT_CTRL_2 = _zz_decode_IS_CSR[26 : 25];
  assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_2;
  assign _zz_decode_ENV_CTRL_2 = _zz_decode_IS_CSR[34 : 32];
  assign _zz_decode_ENV_CTRL_1 = _zz_decode_ENV_CTRL_2;
  assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_IS_CSR[36 : 35];
  assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_2;
  assign decodeExceptionPort_valid = (decode_arbitration_isValid && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = 4'b0010;
  assign decodeExceptionPort_payload_badAddr = decode_INSTRUCTION;
  assign when_RegFilePlugin_l63 = (decode_INSTRUCTION[11 : 7] == 5'h0);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = RegFilePlugin_regFile_spinal_port0;
  assign decode_RegFilePlugin_rs2Data = RegFilePlugin_regFile_spinal_port1;
  always @(*) begin
    lastStageRegFileWrite_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
    if(_zz_10) begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
    if(_zz_10) begin
      lastStageRegFileWrite_payload_address = 5'h0;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_data = _zz_decode_RS2_2;
    if(_zz_10) begin
      lastStageRegFileWrite_payload_data = 32'h0;
    end
  end

  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      AluBitwiseCtrlEnum_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_BITWISE : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise;
      end
      AluCtrlEnum_SLT_SLTU : begin
        _zz_execute_REGFILE_WRITE_DATA = {31'd0, _zz__zz_execute_REGFILE_WRITE_DATA};
      end
      default : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @(*) begin
    case(execute_SRC1_CTRL)
      Src1CtrlEnum_RS : begin
        _zz_execute_SRC1 = execute_RS1;
      end
      Src1CtrlEnum_PC_INCREMENT : begin
        _zz_execute_SRC1 = {29'd0, _zz__zz_execute_SRC1};
      end
      Src1CtrlEnum_IMU : begin
        _zz_execute_SRC1 = {execute_INSTRUCTION[31 : 12],12'h0};
      end
      default : begin
        _zz_execute_SRC1 = {27'd0, _zz__zz_execute_SRC1_1};
      end
    endcase
  end

  assign _zz_execute_SRC2 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_SRC2_1[19] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[18] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[17] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[16] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[15] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[14] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[13] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[12] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[11] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[10] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[9] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[8] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[7] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[6] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[5] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[4] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[3] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[2] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[1] = _zz_execute_SRC2;
    _zz_execute_SRC2_1[0] = _zz_execute_SRC2;
  end

  assign _zz_execute_SRC2_2 = _zz__zz_execute_SRC2_2[11];
  always @(*) begin
    _zz_execute_SRC2_3[19] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[18] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[17] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[16] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[15] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[14] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[13] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[12] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[11] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[10] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[9] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[8] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[7] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[6] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[5] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[4] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[3] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[2] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[1] = _zz_execute_SRC2_2;
    _zz_execute_SRC2_3[0] = _zz_execute_SRC2_2;
  end

  always @(*) begin
    case(execute_SRC2_CTRL)
      Src2CtrlEnum_RS : begin
        _zz_execute_SRC2_4 = execute_RS2;
      end
      Src2CtrlEnum_IMI : begin
        _zz_execute_SRC2_4 = {_zz_execute_SRC2_1,execute_INSTRUCTION[31 : 20]};
      end
      Src2CtrlEnum_IMS : begin
        _zz_execute_SRC2_4 = {_zz_execute_SRC2_3,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_execute_SRC2_4 = _zz_execute_to_memory_PC;
      end
    endcase
  end

  always @(*) begin
    execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub;
    if(execute_SRC2_FORCE_ZERO) begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @(*) begin
    _zz_execute_FullBarrelShifterPlugin_reversed[0] = execute_SRC1[31];
    _zz_execute_FullBarrelShifterPlugin_reversed[1] = execute_SRC1[30];
    _zz_execute_FullBarrelShifterPlugin_reversed[2] = execute_SRC1[29];
    _zz_execute_FullBarrelShifterPlugin_reversed[3] = execute_SRC1[28];
    _zz_execute_FullBarrelShifterPlugin_reversed[4] = execute_SRC1[27];
    _zz_execute_FullBarrelShifterPlugin_reversed[5] = execute_SRC1[26];
    _zz_execute_FullBarrelShifterPlugin_reversed[6] = execute_SRC1[25];
    _zz_execute_FullBarrelShifterPlugin_reversed[7] = execute_SRC1[24];
    _zz_execute_FullBarrelShifterPlugin_reversed[8] = execute_SRC1[23];
    _zz_execute_FullBarrelShifterPlugin_reversed[9] = execute_SRC1[22];
    _zz_execute_FullBarrelShifterPlugin_reversed[10] = execute_SRC1[21];
    _zz_execute_FullBarrelShifterPlugin_reversed[11] = execute_SRC1[20];
    _zz_execute_FullBarrelShifterPlugin_reversed[12] = execute_SRC1[19];
    _zz_execute_FullBarrelShifterPlugin_reversed[13] = execute_SRC1[18];
    _zz_execute_FullBarrelShifterPlugin_reversed[14] = execute_SRC1[17];
    _zz_execute_FullBarrelShifterPlugin_reversed[15] = execute_SRC1[16];
    _zz_execute_FullBarrelShifterPlugin_reversed[16] = execute_SRC1[15];
    _zz_execute_FullBarrelShifterPlugin_reversed[17] = execute_SRC1[14];
    _zz_execute_FullBarrelShifterPlugin_reversed[18] = execute_SRC1[13];
    _zz_execute_FullBarrelShifterPlugin_reversed[19] = execute_SRC1[12];
    _zz_execute_FullBarrelShifterPlugin_reversed[20] = execute_SRC1[11];
    _zz_execute_FullBarrelShifterPlugin_reversed[21] = execute_SRC1[10];
    _zz_execute_FullBarrelShifterPlugin_reversed[22] = execute_SRC1[9];
    _zz_execute_FullBarrelShifterPlugin_reversed[23] = execute_SRC1[8];
    _zz_execute_FullBarrelShifterPlugin_reversed[24] = execute_SRC1[7];
    _zz_execute_FullBarrelShifterPlugin_reversed[25] = execute_SRC1[6];
    _zz_execute_FullBarrelShifterPlugin_reversed[26] = execute_SRC1[5];
    _zz_execute_FullBarrelShifterPlugin_reversed[27] = execute_SRC1[4];
    _zz_execute_FullBarrelShifterPlugin_reversed[28] = execute_SRC1[3];
    _zz_execute_FullBarrelShifterPlugin_reversed[29] = execute_SRC1[2];
    _zz_execute_FullBarrelShifterPlugin_reversed[30] = execute_SRC1[1];
    _zz_execute_FullBarrelShifterPlugin_reversed[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == ShiftCtrlEnum_SLL_1) ? _zz_execute_FullBarrelShifterPlugin_reversed : execute_SRC1);
  always @(*) begin
    _zz_decode_RS2_3[0] = memory_SHIFT_RIGHT[31];
    _zz_decode_RS2_3[1] = memory_SHIFT_RIGHT[30];
    _zz_decode_RS2_3[2] = memory_SHIFT_RIGHT[29];
    _zz_decode_RS2_3[3] = memory_SHIFT_RIGHT[28];
    _zz_decode_RS2_3[4] = memory_SHIFT_RIGHT[27];
    _zz_decode_RS2_3[5] = memory_SHIFT_RIGHT[26];
    _zz_decode_RS2_3[6] = memory_SHIFT_RIGHT[25];
    _zz_decode_RS2_3[7] = memory_SHIFT_RIGHT[24];
    _zz_decode_RS2_3[8] = memory_SHIFT_RIGHT[23];
    _zz_decode_RS2_3[9] = memory_SHIFT_RIGHT[22];
    _zz_decode_RS2_3[10] = memory_SHIFT_RIGHT[21];
    _zz_decode_RS2_3[11] = memory_SHIFT_RIGHT[20];
    _zz_decode_RS2_3[12] = memory_SHIFT_RIGHT[19];
    _zz_decode_RS2_3[13] = memory_SHIFT_RIGHT[18];
    _zz_decode_RS2_3[14] = memory_SHIFT_RIGHT[17];
    _zz_decode_RS2_3[15] = memory_SHIFT_RIGHT[16];
    _zz_decode_RS2_3[16] = memory_SHIFT_RIGHT[15];
    _zz_decode_RS2_3[17] = memory_SHIFT_RIGHT[14];
    _zz_decode_RS2_3[18] = memory_SHIFT_RIGHT[13];
    _zz_decode_RS2_3[19] = memory_SHIFT_RIGHT[12];
    _zz_decode_RS2_3[20] = memory_SHIFT_RIGHT[11];
    _zz_decode_RS2_3[21] = memory_SHIFT_RIGHT[10];
    _zz_decode_RS2_3[22] = memory_SHIFT_RIGHT[9];
    _zz_decode_RS2_3[23] = memory_SHIFT_RIGHT[8];
    _zz_decode_RS2_3[24] = memory_SHIFT_RIGHT[7];
    _zz_decode_RS2_3[25] = memory_SHIFT_RIGHT[6];
    _zz_decode_RS2_3[26] = memory_SHIFT_RIGHT[5];
    _zz_decode_RS2_3[27] = memory_SHIFT_RIGHT[4];
    _zz_decode_RS2_3[28] = memory_SHIFT_RIGHT[3];
    _zz_decode_RS2_3[29] = memory_SHIFT_RIGHT[2];
    _zz_decode_RS2_3[30] = memory_SHIFT_RIGHT[1];
    _zz_decode_RS2_3[31] = memory_SHIFT_RIGHT[0];
  end

  assign execute_MulPlugin_a = execute_RS1;
  assign execute_MulPlugin_b = execute_RS2;
  assign switch_MulPlugin_l87 = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    case(switch_MulPlugin_l87)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(switch_MulPlugin_l87)
      2'b01 : begin
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign writeBack_MulPlugin_result = ($signed(_zz_writeBack_MulPlugin_result) + $signed(_zz_writeBack_MulPlugin_result_1));
  assign when_MulPlugin_l147 = (writeBack_arbitration_isValid && writeBack_IS_MUL);
  assign switch_MulPlugin_l148 = writeBack_INSTRUCTION[13 : 12];
  assign memory_DivPlugin_frontendOk = 1'b1;
  always @(*) begin
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l132) begin
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
    end
  end

  always @(*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(when_MulDivIterativePlugin_l162) begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_counter_willOverflowIfInc = (memory_DivPlugin_div_counter_value == 6'h21);
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_counter_willOverflowIfInc && memory_DivPlugin_div_counter_willIncrement);
  always @(*) begin
    if(memory_DivPlugin_div_counter_willOverflow) begin
      memory_DivPlugin_div_counter_valueNext = 6'h0;
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_memory_DivPlugin_div_counter_valueNext);
    end
    if(memory_DivPlugin_div_counter_willClear) begin
      memory_DivPlugin_div_counter_valueNext = 6'h0;
    end
  end

  assign when_MulDivIterativePlugin_l126 = (memory_DivPlugin_div_counter_value == 6'h20);
  assign when_MulDivIterativePlugin_l126_1 = (! memory_arbitration_isStuck);
  assign when_MulDivIterativePlugin_l128 = (memory_arbitration_isValid && memory_IS_DIV);
  assign when_MulDivIterativePlugin_l129 = ((! memory_DivPlugin_frontendOk) || (! memory_DivPlugin_div_done));
  assign when_MulDivIterativePlugin_l132 = (memory_DivPlugin_frontendOk && (! memory_DivPlugin_div_done));
  assign _zz_memory_DivPlugin_div_stage_0_remainderShifted = memory_DivPlugin_rs1[31 : 0];
  assign memory_DivPlugin_div_stage_0_remainderShifted = {memory_DivPlugin_accumulator[31 : 0],_zz_memory_DivPlugin_div_stage_0_remainderShifted[31]};
  assign memory_DivPlugin_div_stage_0_remainderMinusDenominator = (memory_DivPlugin_div_stage_0_remainderShifted - _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator);
  assign memory_DivPlugin_div_stage_0_outRemainder = ((! memory_DivPlugin_div_stage_0_remainderMinusDenominator[32]) ? _zz_memory_DivPlugin_div_stage_0_outRemainder : _zz_memory_DivPlugin_div_stage_0_outRemainder_1);
  assign memory_DivPlugin_div_stage_0_outNumerator = _zz_memory_DivPlugin_div_stage_0_outNumerator[31:0];
  assign when_MulDivIterativePlugin_l151 = (memory_DivPlugin_div_counter_value == 6'h20);
  assign _zz_memory_DivPlugin_div_result = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign when_MulDivIterativePlugin_l162 = (! memory_arbitration_isStuck);
  assign _zz_memory_DivPlugin_rs2 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_memory_DivPlugin_rs1 = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @(*) begin
    _zz_memory_DivPlugin_rs1_1[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_memory_DivPlugin_rs1_1[31 : 0] = execute_RS1;
  end

  always @(*) begin
    HazardSimplePlugin_src0Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l48) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l48_1) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l48_2) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l105) begin
      HazardSimplePlugin_src0Hazard = 1'b0;
    end
  end

  always @(*) begin
    HazardSimplePlugin_src1Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l51) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l51_1) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l51_2) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l108) begin
      HazardSimplePlugin_src1Hazard = 1'b0;
    end
  end

  assign HazardSimplePlugin_writeBackWrites_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
  assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
  assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_decode_RS2_2;
  assign HazardSimplePlugin_addr0Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19 : 15]);
  assign HazardSimplePlugin_addr1Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l47 = 1'b1;
  assign when_HazardSimplePlugin_l48 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58 = (1'b0 || (! when_HazardSimplePlugin_l47));
  assign when_HazardSimplePlugin_l48_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_1 = (1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign when_HazardSimplePlugin_l48_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_2 = (1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign when_HazardSimplePlugin_l105 = (! decode_RS1_USE);
  assign when_HazardSimplePlugin_l108 = (! decode_RS2_USE);
  assign when_HazardSimplePlugin_l113 = (decode_arbitration_isValid && (HazardSimplePlugin_src0Hazard || HazardSimplePlugin_src1Hazard));
  assign when_DebugPlugin_l238 = (DebugPlugin_haltIt && (! DebugPlugin_isPipBusy));
  assign DebugPlugin_allowEBreak = (DebugPlugin_debugUsed && (! DebugPlugin_disableEbreak));
  always @(*) begin
    debug_bus_cmd_ready = 1'b1;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l280)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            debug_bus_cmd_ready = DebugPlugin_injectionPort_ready;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if(when_DebugPlugin_l257) begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign when_DebugPlugin_l257 = (! _zz_when_DebugPlugin_l257);
  always @(*) begin
    DebugPlugin_injectionPort_valid = 1'b0;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l280)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_injectionPort_valid = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign DebugPlugin_injectionPort_payload = debug_bus_cmd_payload_data;
  assign switch_DebugPlugin_l280 = debug_bus_cmd_payload_address[7 : 2];
  assign when_DebugPlugin_l284 = debug_bus_cmd_payload_data[16];
  assign when_DebugPlugin_l284_1 = debug_bus_cmd_payload_data[24];
  assign when_DebugPlugin_l285 = debug_bus_cmd_payload_data[17];
  assign when_DebugPlugin_l285_1 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l286 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l287 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l288 = debug_bus_cmd_payload_data[18];
  assign when_DebugPlugin_l288_1 = debug_bus_cmd_payload_data[26];
  assign when_DebugPlugin_l308 = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign when_DebugPlugin_l311 = ((|{writeBack_arbitration_isValid,memory_arbitration_isValid}) == 1'b0);
  assign when_DebugPlugin_l324 = (DebugPlugin_stepIt && IBusCachedPlugin_incomingInstruction);
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign when_DebugPlugin_l344 = (DebugPlugin_haltIt || DebugPlugin_stepIt);
  assign cpu_dbg = {
    /* [95:80] */ IBusCachedPlugin_fetchPc_pc[31:16],
    /* [79]    */ execute_arbitration_haltItself,
    /* [78]    */ when_DBusCachedPlugin_l395,
    /* [77]    */ when_DBusCachedPlugin_l411,
    /* [76]    */ dataCache_1_io_cpu_execute_haltIt,
    /* [75]    */ io_cpu_flush_isStall,
    /* [74]    */ when_CsrPlugin_l1519,
    /* [73]    */ when_CsrPlugin_l1521,
    /* [72]    */ execute_CsrPlugin_wfiWake,
    /* [71]    */ execute_CsrPlugin_blockedBySideEffects,
    /* [70]    */ dBus_cmd_valid,
    /* [69]    */ dBus_cmd_ready,
    /* [68]    */ dBus_rsp_valid,
    /* [67]    */ CsrPlugin_inWfi,
    /* [66:64] */ execute_ENV_CTRL,
    /* [63:32] */ execute_INSTRUCTION,
    /* [31]    */ DebugPlugin_resetIt_regNext,
    /* [30]    */ DebugPlugin_haltIt,
    /* [29]    */ DebugPlugin_stepIt,
    /* [28]    */ IBusCachedPlugin_fetcherHalt,
    /* [27]    */ IBusCachedPlugin_fetchPc_booted,
    /* [26]    */ IBusCachedPlugin_fetchPc_output_valid,
    /* [25]    */ IBusCachedPlugin_fetchPc_output_ready,
    /* [24]    */ iBus_cmd_valid,
    /* [23]    */ iBus_cmd_ready,
    /* [22]    */ iBusAvalon_waitRequestn,
    /* [21]    */ iBusAvalon_read,
    /* [20]    */ iBus_rsp_valid,
    /* [19]    */ IBusCachedPlugin_incomingInstruction,
    /* [18]    */ execute_arbitration_isValid,
    /* [17]    */ memory_arbitration_isValid,
    /* [16]    */ writeBack_arbitration_isValid,
    /* [15:0]  */ IBusCachedPlugin_fetchPc_pc[15:0]
  };
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign switch_Misc_l245_1 = execute_INSTRUCTION[14 : 12];
  always @(*) begin
    case(switch_Misc_l245_1)
      3'b000 : begin
        _zz_execute_BRANCH_COND_RESULT = execute_BranchPlugin_eq;
      end
      3'b001 : begin
        _zz_execute_BRANCH_COND_RESULT = (! execute_BranchPlugin_eq);
      end
      3'b101 : begin
        _zz_execute_BRANCH_COND_RESULT = (! execute_SRC_LESS);
      end
      3'b111 : begin
        _zz_execute_BRANCH_COND_RESULT = (! execute_SRC_LESS);
      end
      default : begin
        _zz_execute_BRANCH_COND_RESULT = execute_SRC_LESS;
      end
    endcase
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b0;
      end
      BranchCtrlEnum_JAL : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b1;
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b1;
      end
      default : begin
        _zz_execute_BRANCH_COND_RESULT_1 = _zz_execute_BRANCH_COND_RESULT;
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_missAlignedTarget = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_BranchPlugin_missAlignedTarget_1[19] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[18] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[17] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[16] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[15] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[14] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[13] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[12] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[11] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[10] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[9] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[8] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[7] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[6] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[5] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[4] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[3] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[2] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[1] = _zz_execute_BranchPlugin_missAlignedTarget;
    _zz_execute_BranchPlugin_missAlignedTarget_1[0] = _zz_execute_BranchPlugin_missAlignedTarget;
  end

  assign _zz_execute_BranchPlugin_missAlignedTarget_2 = _zz__zz_execute_BranchPlugin_missAlignedTarget_2[19];
  always @(*) begin
    _zz_execute_BranchPlugin_missAlignedTarget_3[10] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[9] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[8] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[7] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[6] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[5] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[4] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[3] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[2] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[1] = _zz_execute_BranchPlugin_missAlignedTarget_2;
    _zz_execute_BranchPlugin_missAlignedTarget_3[0] = _zz_execute_BranchPlugin_missAlignedTarget_2;
  end

  assign _zz_execute_BranchPlugin_missAlignedTarget_4 = _zz__zz_execute_BranchPlugin_missAlignedTarget_4[11];
  always @(*) begin
    _zz_execute_BranchPlugin_missAlignedTarget_5[18] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[17] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[16] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[15] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[14] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[13] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[12] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[11] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[10] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[9] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[8] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[7] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[6] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[5] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[4] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[3] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[2] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[1] = _zz_execute_BranchPlugin_missAlignedTarget_4;
    _zz_execute_BranchPlugin_missAlignedTarget_5[0] = _zz_execute_BranchPlugin_missAlignedTarget_4;
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JALR : begin
        _zz_execute_BranchPlugin_missAlignedTarget_6 = (_zz__zz_execute_BranchPlugin_missAlignedTarget_6[1] ^ execute_RS1[1]);
      end
      BranchCtrlEnum_JAL : begin
        _zz_execute_BranchPlugin_missAlignedTarget_6 = _zz__zz_execute_BranchPlugin_missAlignedTarget_6_1[1];
      end
      default : begin
        _zz_execute_BranchPlugin_missAlignedTarget_6 = _zz__zz_execute_BranchPlugin_missAlignedTarget_6_2[1];
      end
    endcase
  end

  assign execute_BranchPlugin_missAlignedTarget = (execute_BRANCH_COND_RESULT && _zz_execute_BranchPlugin_missAlignedTarget_6);
  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_branch_src2 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_1[19] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[18] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[17] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[16] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[15] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[14] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[13] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[12] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[11] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[10] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[9] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[8] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[7] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[6] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[5] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[4] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[3] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[2] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[1] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[0] = _zz_execute_BranchPlugin_branch_src2;
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JALR : begin
        execute_BranchPlugin_branch_src2 = {_zz_execute_BranchPlugin_branch_src2_1,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src2 = ((execute_BRANCH_CTRL == BranchCtrlEnum_JAL) ? {{_zz_execute_BranchPlugin_branch_src2_3,{{{_zz_execute_BranchPlugin_branch_src2_6,_zz_execute_BranchPlugin_branch_src2_7},_zz_execute_BranchPlugin_branch_src2_8},execute_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_execute_BranchPlugin_branch_src2_5,{{{_zz_execute_BranchPlugin_branch_src2_9,_zz_execute_BranchPlugin_branch_src2_10},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
        if(execute_PREDICTION_HAD_BRANCHED1) begin
          execute_BranchPlugin_branch_src2 = {29'd0, _zz_execute_BranchPlugin_branch_src2_11};
        end
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_branch_src2_2 = _zz__zz_execute_BranchPlugin_branch_src2_2[19];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_3[10] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[9] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[8] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[7] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[6] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[5] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[4] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[3] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[2] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[1] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[0] = _zz_execute_BranchPlugin_branch_src2_2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_4 = _zz__zz_execute_BranchPlugin_branch_src2_4[11];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_5[18] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[17] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[16] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[15] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[14] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[13] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[12] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[11] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[10] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[9] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[8] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[7] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[6] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[5] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[4] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[3] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[2] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[1] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[0] = _zz_execute_BranchPlugin_branch_src2_4;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  assign BranchPlugin_branchExceptionPort_valid = (memory_arbitration_isValid && (memory_BRANCH_DO && memory_BRANCH_CALC[1]));
  assign BranchPlugin_branchExceptionPort_payload_code = 4'b0000;
  assign BranchPlugin_branchExceptionPort_payload_badAddr = memory_BRANCH_CALC;
  assign IBusCachedPlugin_decodePrediction_rsp_wasWrong = BranchPlugin_jumpInterface_valid;
  always @(*) begin
    CsrPlugin_privilege = _zz_CsrPlugin_privilege;
    if(CsrPlugin_forceMachineWire) begin
      CsrPlugin_privilege = 2'b11;
    end
  end

  assign CsrPlugin_misa_base = 2'b01;
  assign CsrPlugin_misa_extensions = 26'h0041101;
  assign CsrPlugin_mcounteren_IR = 1'b1;
  assign CsrPlugin_mcounteren_CY = 1'b1;
  assign CsrPlugin_scounteren_IR = 1'b1;
  assign CsrPlugin_scounteren_CY = 1'b1;
  assign CsrPlugin_sip_SEIP_OR = (CsrPlugin_sip_SEIP_SOFT || CsrPlugin_sip_SEIP_INPUT);
  always @(*) begin
    CsrPlugin_redoInterface_valid = 1'b0;
    if(CsrPlugin_rescheduleLogic_rescheduleNext) begin
      CsrPlugin_redoInterface_valid = 1'b1;
    end
  end

  assign CsrPlugin_redoInterface_payload = decode_PC;
  always @(*) begin
    CsrPlugin_rescheduleLogic_rescheduleNext = 1'b0;
    if(when_CsrPlugin_l1153) begin
      CsrPlugin_rescheduleLogic_rescheduleNext = 1'b1;
    end
    if(execute_CsrPlugin_csr_384) begin
      if(execute_CsrPlugin_writeInstruction) begin
        CsrPlugin_rescheduleLogic_rescheduleNext = 1'b1;
      end
    end
  end

  assign when_CsrPlugin_l1153 = (execute_arbitration_isValid && execute_RESCHEDULE_NEXT);
  assign _zz_when_CsrPlugin_l1302 = (CsrPlugin_sip_STIP && CsrPlugin_sie_STIE);
  assign _zz_when_CsrPlugin_l1302_1 = (CsrPlugin_sip_SSIP && CsrPlugin_sie_SSIE);
  assign _zz_when_CsrPlugin_l1302_2 = (CsrPlugin_sip_SEIP_OR && CsrPlugin_sie_SEIE);
  assign _zz_when_CsrPlugin_l1302_3 = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_when_CsrPlugin_l1302_4 = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_when_CsrPlugin_l1302_5 = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b11;
    case(CsrPlugin_exceptionPortCtrl_exceptionContext_code)
      4'b0000 : begin
        if(when_CsrPlugin_l1216) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b0001 : begin
        if(when_CsrPlugin_l1216_1) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b0010 : begin
        if(when_CsrPlugin_l1216_2) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b0011 : begin
        if(when_CsrPlugin_l1216_3) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b0100 : begin
        if(when_CsrPlugin_l1216_4) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b0101 : begin
        if(when_CsrPlugin_l1216_5) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b0110 : begin
        if(when_CsrPlugin_l1216_6) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b0111 : begin
        if(when_CsrPlugin_l1216_7) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b1000 : begin
        if(when_CsrPlugin_l1216_8) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b1001 : begin
        if(when_CsrPlugin_l1216_9) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b1100 : begin
        if(when_CsrPlugin_l1216_10) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b1101 : begin
        if(when_CsrPlugin_l1216_11) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      4'b1111 : begin
        if(when_CsrPlugin_l1216_12) begin
          CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b01;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_CsrPlugin_l1216 = ((1'b1 && CsrPlugin_medeleg_IAM) && (! 1'b0));
  assign when_CsrPlugin_l1216_1 = ((1'b1 && CsrPlugin_medeleg_IAF) && (! 1'b0));
  assign when_CsrPlugin_l1216_2 = ((1'b1 && CsrPlugin_medeleg_II) && (! 1'b0));
  assign when_CsrPlugin_l1216_3 = ((1'b1 && CsrPlugin_medeleg_BP) && (! 1'b0));
  assign when_CsrPlugin_l1216_4 = ((1'b1 && CsrPlugin_medeleg_LAM) && (! 1'b0));
  assign when_CsrPlugin_l1216_5 = ((1'b1 && CsrPlugin_medeleg_LAF) && (! 1'b0));
  assign when_CsrPlugin_l1216_6 = ((1'b1 && CsrPlugin_medeleg_SAM) && (! 1'b0));
  assign when_CsrPlugin_l1216_7 = ((1'b1 && CsrPlugin_medeleg_SAF) && (! 1'b0));
  assign when_CsrPlugin_l1216_8 = ((1'b1 && CsrPlugin_medeleg_EU) && (! 1'b0));
  assign when_CsrPlugin_l1216_9 = ((1'b1 && CsrPlugin_medeleg_ES) && (! 1'b0));
  assign when_CsrPlugin_l1216_10 = ((1'b1 && CsrPlugin_medeleg_IPF) && (! 1'b0));
  assign when_CsrPlugin_l1216_11 = ((1'b1 && CsrPlugin_medeleg_LPF) && (! 1'b0));
  assign when_CsrPlugin_l1216_12 = ((1'b1 && CsrPlugin_medeleg_SPF) && (! 1'b0));
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code = {decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid};
  assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1[0];
  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
    if(_zz_when) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
    end
    if(decode_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(BranchPlugin_branchExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(DBusCachedPlugin_exceptionBus_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1;
    end
    if(writeBack_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign when_CsrPlugin_l1259 = (! decode_arbitration_isStuck);
  assign when_CsrPlugin_l1259_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1259_2 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l1259_3 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l1272 = (|{CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}});
  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  assign when_CsrPlugin_l1296 = ((CsrPlugin_sstatus_SIE && (CsrPlugin_privilege == 2'b01)) || (CsrPlugin_privilege < 2'b01));
  assign when_CsrPlugin_l1296_1 = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < 2'b11));
  assign when_CsrPlugin_l1302 = ((_zz_when_CsrPlugin_l1302 && (1'b1 && CsrPlugin_mideleg_ST)) && (! 1'b0));
  assign when_CsrPlugin_l1302_1 = ((_zz_when_CsrPlugin_l1302_1 && (1'b1 && CsrPlugin_mideleg_SS)) && (! 1'b0));
  assign when_CsrPlugin_l1302_2 = ((_zz_when_CsrPlugin_l1302_2 && (1'b1 && CsrPlugin_mideleg_SE)) && (! 1'b0));
  assign when_CsrPlugin_l1302_3 = ((_zz_when_CsrPlugin_l1302 && 1'b1) && (! (|CsrPlugin_mideleg_ST)));
  assign when_CsrPlugin_l1302_4 = ((_zz_when_CsrPlugin_l1302_1 && 1'b1) && (! (|CsrPlugin_mideleg_SS)));
  assign when_CsrPlugin_l1302_5 = ((_zz_when_CsrPlugin_l1302_2 && 1'b1) && (! (|CsrPlugin_mideleg_SE)));
  assign when_CsrPlugin_l1302_6 = ((_zz_when_CsrPlugin_l1302_3 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l1302_7 = ((_zz_when_CsrPlugin_l1302_4 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l1302_8 = ((_zz_when_CsrPlugin_l1302_5 && 1'b1) && (! 1'b0));
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  assign CsrPlugin_pipelineLiberator_active = ((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts) && decode_arbitration_isValid);
  assign when_CsrPlugin_l1335 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1335_1 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l1335_2 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l1340 = ((! CsrPlugin_pipelineLiberator_active) || decode_arbitration_removeIt);
  always @(*) begin
    CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2;
    if(when_CsrPlugin_l1346) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign when_CsrPlugin_l1346 = (|{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}});
  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts);
  always @(*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
    if(CsrPlugin_hadException) begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @(*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code;
    if(CsrPlugin_hadException) begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  assign CsrPlugin_trapCauseEbreakDebug = 1'b0;
  always @(*) begin
    CsrPlugin_xtvec_mode = 2'bxx;
    case(CsrPlugin_targetPrivilege)
      2'b01 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_stvec_mode;
      end
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_xtvec_base = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(CsrPlugin_targetPrivilege)
      2'b01 : begin
        CsrPlugin_xtvec_base = CsrPlugin_stvec_base;
      end
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign CsrPlugin_trapEnterDebug = 1'b0;
  assign when_CsrPlugin_l1390 = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign when_CsrPlugin_l1398 = (! CsrPlugin_trapEnterDebug);
  assign when_CsrPlugin_l1456 = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET));
  assign switch_CsrPlugin_l1460 = writeBack_INSTRUCTION[29 : 28];
  assign when_CsrPlugin_l1468 = (CsrPlugin_mstatus_MPP < 2'b11);
  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign when_CsrPlugin_l1519 = (execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_WFI));
  assign when_CsrPlugin_l1521 = (! execute_CsrPlugin_wfiWake);
  assign when_CsrPlugin_l1527 = (|{(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == EnvCtrlEnum_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == EnvCtrlEnum_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET))}});
  assign execute_CsrPlugin_blockedBySideEffects = ((|{writeBack_arbitration_isValid,memory_arbitration_isValid}) || 1'b0);
  always @(*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    if(execute_CsrPlugin_csr_768) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_256) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_384) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_3857) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3858) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3859) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3860) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_769) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_836) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_772) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_773) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_833) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_832) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_834) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_835) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_770) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_771) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_3073) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3201) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_774) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_262) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_324) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_260) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_261) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_321) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_320) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_322) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_323) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_784) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(CsrPlugin_csrMapping_allowCsrSignal) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(when_CsrPlugin_l1719) begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(when_CsrPlugin_l1725) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if(when_CsrPlugin_l1547) begin
      if(when_CsrPlugin_l1548) begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @(*) begin
    CsrPlugin_selfException_valid = 1'b0;
    if(when_CsrPlugin_l1540) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(when_CsrPlugin_l1555) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(when_CsrPlugin_l1565) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_selfException_payload_code = 4'bxxxx;
    if(when_CsrPlugin_l1540) begin
      CsrPlugin_selfException_payload_code = 4'b0010;
    end
    if(when_CsrPlugin_l1555) begin
      case(CsrPlugin_privilege)
        2'b00 : begin
          CsrPlugin_selfException_payload_code = 4'b1000;
        end
        2'b01 : begin
          CsrPlugin_selfException_payload_code = 4'b1001;
        end
        default : begin
          CsrPlugin_selfException_payload_code = 4'b1011;
        end
      endcase
    end
    if(when_CsrPlugin_l1565) begin
      CsrPlugin_selfException_payload_code = 4'b0011;
    end
  end

  assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
  assign when_CsrPlugin_l1540 = (execute_CsrPlugin_illegalAccess || execute_CsrPlugin_illegalInstruction);
  assign when_CsrPlugin_l1547 = (execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_XRET));
  assign when_CsrPlugin_l1548 = (CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]);
  assign when_CsrPlugin_l1555 = (execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_ECALL));
  assign when_CsrPlugin_l1565 = ((execute_arbitration_isValid && (execute_ENV_CTRL == EnvCtrlEnum_EBREAK)) && CsrPlugin_allowEbreakException);
  always @(*) begin
    execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
    if(when_CsrPlugin_l1719) begin
      execute_CsrPlugin_writeInstruction = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
    if(when_CsrPlugin_l1719) begin
      execute_CsrPlugin_readInstruction = 1'b0;
    end
  end

  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && (! execute_arbitration_isStuck));
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_arbitration_isStuck));
  assign CsrPlugin_csrMapping_hazardFree = (! execute_CsrPlugin_blockedBySideEffects);
  always @(*) begin
    execute_CsrPlugin_readToWriteData = CsrPlugin_csrMapping_readDataSignal;
    if(execute_CsrPlugin_csr_836) begin
      execute_CsrPlugin_readToWriteData[9 : 9] = CsrPlugin_sip_SEIP_SOFT;
    end
    if(execute_CsrPlugin_csr_324) begin
      execute_CsrPlugin_readToWriteData[9 : 9] = CsrPlugin_sip_SEIP_SOFT;
    end
  end

  assign switch_Misc_l245_2 = execute_INSTRUCTION[13];
  always @(*) begin
    case(switch_Misc_l245_2)
      1'b0 : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = execute_SRC1;
      end
      default : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign CsrPlugin_csrMapping_writeDataSignal = _zz_CsrPlugin_csrMapping_writeDataSignal;
  assign when_CsrPlugin_l1587 = (execute_arbitration_isValid && execute_IS_CSR);
  assign when_CsrPlugin_l1591 = (execute_arbitration_isValid && (execute_IS_CSR || execute_RESCHEDULE_NEXT));
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign when_Pipeline_l124 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_1 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_2 = ((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack));
  assign when_Pipeline_l124_3 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_4 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_5 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_6 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_7 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_8 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_9 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_10 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_SRC1_CTRL_1 = decode_SRC1_CTRL;
  assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1;
  assign when_Pipeline_l124_11 = (! execute_arbitration_isStuck);
  assign _zz_execute_SRC1_CTRL = decode_to_execute_SRC1_CTRL;
  assign when_Pipeline_l124_12 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_13 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_14 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_15 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL;
  assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1;
  assign when_Pipeline_l124_16 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL;
  assign _zz_decode_to_execute_SRC2_CTRL_1 = decode_SRC2_CTRL;
  assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1;
  assign when_Pipeline_l124_17 = (! execute_arbitration_isStuck);
  assign _zz_execute_SRC2_CTRL = decode_to_execute_SRC2_CTRL;
  assign when_Pipeline_l124_18 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_19 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_20 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_21 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_22 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_23 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_24 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_25 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_26 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_27 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_28 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_29 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_30 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_31 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_32 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_33 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL;
  assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1;
  assign when_Pipeline_l124_34 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL;
  assign _zz_execute_to_memory_SHIFT_CTRL_1 = execute_SHIFT_CTRL;
  assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1;
  assign when_Pipeline_l124_35 = (! execute_arbitration_isStuck);
  assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL;
  assign when_Pipeline_l124_36 = (! memory_arbitration_isStuck);
  assign _zz_memory_SHIFT_CTRL = execute_to_memory_SHIFT_CTRL;
  assign when_Pipeline_l124_37 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_38 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_39 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_40 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_41 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_42 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_43 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ENV_CTRL_1 = decode_ENV_CTRL;
  assign _zz_execute_to_memory_ENV_CTRL_1 = execute_ENV_CTRL;
  assign _zz_memory_to_writeBack_ENV_CTRL_1 = memory_ENV_CTRL;
  assign _zz_decode_ENV_CTRL = _zz_decode_ENV_CTRL_1;
  assign when_Pipeline_l124_44 = (! execute_arbitration_isStuck);
  assign _zz_execute_ENV_CTRL = decode_to_execute_ENV_CTRL;
  assign when_Pipeline_l124_45 = (! memory_arbitration_isStuck);
  assign _zz_memory_ENV_CTRL = execute_to_memory_ENV_CTRL;
  assign when_Pipeline_l124_46 = (! writeBack_arbitration_isStuck);
  assign _zz_writeBack_ENV_CTRL = memory_to_writeBack_ENV_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL;
  assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL;
  assign when_Pipeline_l124_47 = (! execute_arbitration_isStuck);
  assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL;
  assign when_Pipeline_l124_48 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_49 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_50 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_51 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_52 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_53 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_54 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_55 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_56 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_57 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_58 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_59 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_60 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_61 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_62 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_63 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_64 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_65 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_66 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_67 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_68 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_69 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_70 = (! writeBack_arbitration_isStuck);
  assign decode_arbitration_isFlushed = ((|{writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}}) || (|{writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}}));
  assign execute_arbitration_isFlushed = ((|{writeBack_arbitration_flushNext,memory_arbitration_flushNext}) || (|{writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}}));
  assign memory_arbitration_isFlushed = ((|writeBack_arbitration_flushNext) || (|{writeBack_arbitration_flushIt,memory_arbitration_flushIt}));
  assign writeBack_arbitration_isFlushed = (1'b0 || (|writeBack_arbitration_flushIt));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign when_Pipeline_l151 = ((! execute_arbitration_isStuck) || execute_arbitration_removeIt);
  assign when_Pipeline_l154 = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign when_Pipeline_l151_1 = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  assign when_Pipeline_l154_1 = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign when_Pipeline_l151_2 = ((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt);
  assign when_Pipeline_l154_2 = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  always @(*) begin
    DebugPlugin_injectionPort_ready = 1'b0;
    case(IBusCachedPlugin_injector_port_state)
      3'b100 : begin
        DebugPlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign when_Fetcher_l391 = (! decode_arbitration_isStuck);
  assign when_CsrPlugin_l1669 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_2 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_3 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_4 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_5 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_6 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_7 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_8 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_9 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_10 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_11 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_12 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_13 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_14 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_15 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_16 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_17 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_18 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_19 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_20 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_21 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_22 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_23 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_24 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_25 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_26 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_27 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1669_28 = (! execute_arbitration_isStuck);
  assign switch_CsrPlugin_l1031 = CsrPlugin_csrMapping_writeDataSignal[12 : 11];
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit = 32'h0;
    if(execute_CsrPlugin_csr_768) begin
      _zz_CsrPlugin_csrMapping_readDataInit[19 : 19] = MmuPlugin_status_mxr;
      _zz_CsrPlugin_csrMapping_readDataInit[18 : 18] = MmuPlugin_status_sum;
      _zz_CsrPlugin_csrMapping_readDataInit[17 : 17] = MmuPlugin_status_mprv;
      _zz_CsrPlugin_csrMapping_readDataInit[7 : 7] = CsrPlugin_mstatus_MPIE;
      _zz_CsrPlugin_csrMapping_readDataInit[3 : 3] = CsrPlugin_mstatus_MIE;
      _zz_CsrPlugin_csrMapping_readDataInit[12 : 11] = CsrPlugin_mstatus_MPP;
      _zz_CsrPlugin_csrMapping_readDataInit[8 : 8] = CsrPlugin_sstatus_SPP;
      _zz_CsrPlugin_csrMapping_readDataInit[5 : 5] = CsrPlugin_sstatus_SPIE;
      _zz_CsrPlugin_csrMapping_readDataInit[1 : 1] = CsrPlugin_sstatus_SIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_1 = 32'h0;
    if(execute_CsrPlugin_csr_256) begin
      _zz_CsrPlugin_csrMapping_readDataInit_1[19 : 19] = MmuPlugin_status_mxr;
      _zz_CsrPlugin_csrMapping_readDataInit_1[18 : 18] = MmuPlugin_status_sum;
      _zz_CsrPlugin_csrMapping_readDataInit_1[17 : 17] = MmuPlugin_status_mprv;
      _zz_CsrPlugin_csrMapping_readDataInit_1[8 : 8] = CsrPlugin_sstatus_SPP;
      _zz_CsrPlugin_csrMapping_readDataInit_1[5 : 5] = CsrPlugin_sstatus_SPIE;
      _zz_CsrPlugin_csrMapping_readDataInit_1[1 : 1] = CsrPlugin_sstatus_SIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_2 = 32'h0;
    if(execute_CsrPlugin_csr_384) begin
      _zz_CsrPlugin_csrMapping_readDataInit_2[31 : 31] = MmuPlugin_satp_mode;
      _zz_CsrPlugin_csrMapping_readDataInit_2[30 : 22] = MmuPlugin_satp_asid;
      _zz_CsrPlugin_csrMapping_readDataInit_2[21 : 0] = MmuPlugin_satp_ppn;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_3 = 32'h0;
    if(execute_CsrPlugin_csr_769) begin
      _zz_CsrPlugin_csrMapping_readDataInit_3[31 : 30] = CsrPlugin_misa_base;
      _zz_CsrPlugin_csrMapping_readDataInit_3[25 : 0] = CsrPlugin_misa_extensions;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_4 = 32'h0;
    if(execute_CsrPlugin_csr_836) begin
      _zz_CsrPlugin_csrMapping_readDataInit_4[11 : 11] = CsrPlugin_mip_MEIP;
      _zz_CsrPlugin_csrMapping_readDataInit_4[7 : 7] = CsrPlugin_mip_MTIP;
      _zz_CsrPlugin_csrMapping_readDataInit_4[3 : 3] = CsrPlugin_mip_MSIP;
      _zz_CsrPlugin_csrMapping_readDataInit_4[5 : 5] = CsrPlugin_sip_STIP;
      _zz_CsrPlugin_csrMapping_readDataInit_4[1 : 1] = CsrPlugin_sip_SSIP;
      _zz_CsrPlugin_csrMapping_readDataInit_4[9 : 9] = CsrPlugin_sip_SEIP_OR;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_5 = 32'h0;
    if(execute_CsrPlugin_csr_772) begin
      _zz_CsrPlugin_csrMapping_readDataInit_5[11 : 11] = CsrPlugin_mie_MEIE;
      _zz_CsrPlugin_csrMapping_readDataInit_5[7 : 7] = CsrPlugin_mie_MTIE;
      _zz_CsrPlugin_csrMapping_readDataInit_5[3 : 3] = CsrPlugin_mie_MSIE;
      _zz_CsrPlugin_csrMapping_readDataInit_5[9 : 9] = CsrPlugin_sie_SEIE;
      _zz_CsrPlugin_csrMapping_readDataInit_5[5 : 5] = CsrPlugin_sie_STIE;
      _zz_CsrPlugin_csrMapping_readDataInit_5[1 : 1] = CsrPlugin_sie_SSIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_6 = 32'h0;
    if(execute_CsrPlugin_csr_773) begin
      _zz_CsrPlugin_csrMapping_readDataInit_6[31 : 2] = CsrPlugin_mtvec_base;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_7 = 32'h0;
    if(execute_CsrPlugin_csr_833) begin
      _zz_CsrPlugin_csrMapping_readDataInit_7[31 : 0] = CsrPlugin_mepc;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_8 = 32'h0;
    if(execute_CsrPlugin_csr_832) begin
      _zz_CsrPlugin_csrMapping_readDataInit_8[31 : 0] = CsrPlugin_mscratch;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_9 = 32'h0;
    if(execute_CsrPlugin_csr_834) begin
      _zz_CsrPlugin_csrMapping_readDataInit_9[31 : 31] = CsrPlugin_mcause_interrupt;
      _zz_CsrPlugin_csrMapping_readDataInit_9[3 : 0] = CsrPlugin_mcause_exceptionCode;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_10 = 32'h0;
    if(execute_CsrPlugin_csr_835) begin
      _zz_CsrPlugin_csrMapping_readDataInit_10[31 : 0] = CsrPlugin_mtval;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_11 = 32'h0;
    if(execute_CsrPlugin_csr_770) begin
      _zz_CsrPlugin_csrMapping_readDataInit_11[0 : 0] = CsrPlugin_medeleg_IAM;
      _zz_CsrPlugin_csrMapping_readDataInit_11[1 : 1] = CsrPlugin_medeleg_IAF;
      _zz_CsrPlugin_csrMapping_readDataInit_11[2 : 2] = CsrPlugin_medeleg_II;
      _zz_CsrPlugin_csrMapping_readDataInit_11[3 : 3] = CsrPlugin_medeleg_BP;
      _zz_CsrPlugin_csrMapping_readDataInit_11[4 : 4] = CsrPlugin_medeleg_LAM;
      _zz_CsrPlugin_csrMapping_readDataInit_11[5 : 5] = CsrPlugin_medeleg_LAF;
      _zz_CsrPlugin_csrMapping_readDataInit_11[6 : 6] = CsrPlugin_medeleg_SAM;
      _zz_CsrPlugin_csrMapping_readDataInit_11[7 : 7] = CsrPlugin_medeleg_SAF;
      _zz_CsrPlugin_csrMapping_readDataInit_11[8 : 8] = CsrPlugin_medeleg_EU;
      _zz_CsrPlugin_csrMapping_readDataInit_11[9 : 9] = CsrPlugin_medeleg_ES;
      _zz_CsrPlugin_csrMapping_readDataInit_11[12 : 12] = CsrPlugin_medeleg_IPF;
      _zz_CsrPlugin_csrMapping_readDataInit_11[13 : 13] = CsrPlugin_medeleg_LPF;
      _zz_CsrPlugin_csrMapping_readDataInit_11[15 : 15] = CsrPlugin_medeleg_SPF;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_12 = 32'h0;
    if(execute_CsrPlugin_csr_771) begin
      _zz_CsrPlugin_csrMapping_readDataInit_12[9 : 9] = CsrPlugin_mideleg_SE;
      _zz_CsrPlugin_csrMapping_readDataInit_12[5 : 5] = CsrPlugin_mideleg_ST;
      _zz_CsrPlugin_csrMapping_readDataInit_12[1 : 1] = CsrPlugin_mideleg_SS;
    end
  end

  assign when_CsrPlugin_l1076 = ((CsrPlugin_privilege < 2'b11) && (! CsrPlugin_mcounteren_TM));
  assign when_CsrPlugin_l1077 = ((CsrPlugin_privilege < 2'b01) && (! CsrPlugin_scounteren_TM));
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_13 = 32'h0;
    if(execute_CsrPlugin_csr_3073) begin
      _zz_CsrPlugin_csrMapping_readDataInit_13[31 : 0] = utime[31 : 0];
    end
  end

  assign when_CsrPlugin_l1076_1 = ((CsrPlugin_privilege < 2'b11) && (! CsrPlugin_mcounteren_TM));
  assign when_CsrPlugin_l1077_1 = ((CsrPlugin_privilege < 2'b01) && (! CsrPlugin_scounteren_TM));
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_14 = 32'h0;
    if(execute_CsrPlugin_csr_3201) begin
      _zz_CsrPlugin_csrMapping_readDataInit_14[31 : 0] = utime[63 : 32];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_15 = 32'h0;
    if(execute_CsrPlugin_csr_774) begin
      _zz_CsrPlugin_csrMapping_readDataInit_15[1 : 1] = CsrPlugin_mcounteren_TM;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_16 = 32'h0;
    if(execute_CsrPlugin_csr_262) begin
      _zz_CsrPlugin_csrMapping_readDataInit_16[1 : 1] = CsrPlugin_scounteren_TM;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_17 = 32'h0;
    if(execute_CsrPlugin_csr_324) begin
      _zz_CsrPlugin_csrMapping_readDataInit_17[5 : 5] = CsrPlugin_sip_STIP;
      _zz_CsrPlugin_csrMapping_readDataInit_17[1 : 1] = CsrPlugin_sip_SSIP;
      _zz_CsrPlugin_csrMapping_readDataInit_17[9 : 9] = CsrPlugin_sip_SEIP_OR;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_18 = 32'h0;
    if(execute_CsrPlugin_csr_260) begin
      _zz_CsrPlugin_csrMapping_readDataInit_18[9 : 9] = CsrPlugin_sie_SEIE;
      _zz_CsrPlugin_csrMapping_readDataInit_18[5 : 5] = CsrPlugin_sie_STIE;
      _zz_CsrPlugin_csrMapping_readDataInit_18[1 : 1] = CsrPlugin_sie_SSIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_19 = 32'h0;
    if(execute_CsrPlugin_csr_261) begin
      _zz_CsrPlugin_csrMapping_readDataInit_19[31 : 2] = CsrPlugin_stvec_base;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_20 = 32'h0;
    if(execute_CsrPlugin_csr_321) begin
      _zz_CsrPlugin_csrMapping_readDataInit_20[31 : 0] = CsrPlugin_sepc;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_21 = 32'h0;
    if(execute_CsrPlugin_csr_320) begin
      _zz_CsrPlugin_csrMapping_readDataInit_21[31 : 0] = CsrPlugin_sscratch;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_22 = 32'h0;
    if(execute_CsrPlugin_csr_322) begin
      _zz_CsrPlugin_csrMapping_readDataInit_22[31 : 31] = CsrPlugin_scause_interrupt;
      _zz_CsrPlugin_csrMapping_readDataInit_22[3 : 0] = CsrPlugin_scause_exceptionCode;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_23 = 32'h0;
    if(execute_CsrPlugin_csr_323) begin
      _zz_CsrPlugin_csrMapping_readDataInit_23[31 : 0] = CsrPlugin_stval;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_24 = 32'h0;
    if(execute_CsrPlugin_csr_784) begin
      _zz_CsrPlugin_csrMapping_readDataInit_24[31 : 0] = 32'h0;
    end
  end

  assign CsrPlugin_csrMapping_readDataInit = (((((_zz_CsrPlugin_csrMapping_readDataInit | _zz_CsrPlugin_csrMapping_readDataInit_1) | (_zz_CsrPlugin_csrMapping_readDataInit_2 | _zz_CsrPlugin_csrMapping_readDataInit_25)) | ((_zz_CsrPlugin_csrMapping_readDataInit_26 | _zz_CsrPlugin_csrMapping_readDataInit_27) | (_zz_CsrPlugin_csrMapping_readDataInit_28 | _zz_CsrPlugin_csrMapping_readDataInit_3))) | (((_zz_CsrPlugin_csrMapping_readDataInit_4 | _zz_CsrPlugin_csrMapping_readDataInit_5) | (_zz_CsrPlugin_csrMapping_readDataInit_6 | _zz_CsrPlugin_csrMapping_readDataInit_7)) | ((_zz_CsrPlugin_csrMapping_readDataInit_8 | _zz_CsrPlugin_csrMapping_readDataInit_9) | (_zz_CsrPlugin_csrMapping_readDataInit_10 | _zz_CsrPlugin_csrMapping_readDataInit_11)))) | ((((_zz_CsrPlugin_csrMapping_readDataInit_12 | _zz_CsrPlugin_csrMapping_readDataInit_13) | (_zz_CsrPlugin_csrMapping_readDataInit_14 | _zz_CsrPlugin_csrMapping_readDataInit_15)) | ((_zz_CsrPlugin_csrMapping_readDataInit_16 | _zz_CsrPlugin_csrMapping_readDataInit_17) | (_zz_CsrPlugin_csrMapping_readDataInit_18 | _zz_CsrPlugin_csrMapping_readDataInit_19))) | (((_zz_CsrPlugin_csrMapping_readDataInit_20 | _zz_CsrPlugin_csrMapping_readDataInit_21) | (_zz_CsrPlugin_csrMapping_readDataInit_22 | _zz_CsrPlugin_csrMapping_readDataInit_23)) | _zz_CsrPlugin_csrMapping_readDataInit_24)));
  assign when_CsrPlugin_l1702 = ((execute_arbitration_isValid && execute_IS_CSR) && (({execute_CsrPlugin_csrAddress[11 : 2],2'b00} == 12'h3a0) || ({execute_CsrPlugin_csrAddress[11 : 4],4'b0000} == 12'h3b0)));
  assign _zz_when_CsrPlugin_l1709 = (execute_CsrPlugin_csrAddress & 12'hf60);
  assign when_CsrPlugin_l1709 = (((execute_arbitration_isValid && execute_IS_CSR) && (5'h03 <= execute_CsrPlugin_csrAddress[4 : 0])) && (((_zz_when_CsrPlugin_l1709 == 12'hb00) || (((_zz_when_CsrPlugin_l1709 == 12'hc00) && (! execute_CsrPlugin_writeInstruction)) && (CsrPlugin_privilege == 2'b11))) || ((execute_CsrPlugin_csrAddress & 12'hfe0) == 12'h320)));
  always @(*) begin
    when_CsrPlugin_l1719 = CsrPlugin_csrMapping_doForceFailCsr;
    if(when_CsrPlugin_l1717) begin
      when_CsrPlugin_l1719 = 1'b1;
    end
  end

  assign when_CsrPlugin_l1717 = (CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]);
  assign when_CsrPlugin_l1725 = ((! execute_arbitration_isValid) || (! execute_IS_CSR));
  assign iBusAvalon_read = iBus_cmd_valid;
  assign iBusAvalon_burstCount = 4'b1000;
  assign iBusAvalon_address = iBus_cmd_payload_address;
  assign iBus_cmd_ready = iBusAvalon_waitRequestn;
  assign iBus_rsp_valid = iBusAvalon_readDataValid;
  assign iBus_rsp_payload_data = iBusAvalon_readData;
  assign iBus_rsp_payload_error = (iBusAvalon_response != Response_OKAY);
  assign dBusAvalon_read = (dBus_cmd_valid && (! dBus_cmd_payload_wr));
  assign dBusAvalon_write = (dBus_cmd_valid && dBus_cmd_payload_wr);
  assign dBusAvalon_address = {dBus_cmd_payload_address[31 : 2],2'b00};
  assign dBusAvalon_burstCount = ((dBus_cmd_payload_size == 3'b101) ? 4'b1000 : 4'b0001);
  assign dBusAvalon_byteEnable = dBus_cmd_payload_mask;
  assign dBusAvalon_writeData = dBus_cmd_payload_data;
  assign dBus_cmd_ready = dBusAvalon_waitRequestn;
  assign dBus_rsp_valid = dBusAvalon_readDataValid;
  assign dBus_rsp_payload_data = dBusAvalon_readData;
  assign dBus_rsp_payload_error = (dBusAvalon_response != Response_OKAY);
  assign debug_bus_cmd_valid = systemDebugger_1_io_mem_cmd_valid;
  assign debug_bus_cmd_payload_wr = systemDebugger_1_io_mem_cmd_payload_wr;
  assign debug_bus_cmd_payload_data = systemDebugger_1_io_mem_cmd_payload_data;
  assign debug_bus_cmd_payload_address = systemDebugger_1_io_mem_cmd_payload_address[7:0];
  assign debug_bus_cmd_fire = (debug_bus_cmd_valid && debug_bus_cmd_ready);
  assign jtag_tdo = jtagBridge_1_io_jtag_tdo;
  assign timerInterrupt = clintCtrl_io_timerInterrupt[0];
  assign softwareInterrupt = clintCtrl_io_softwareInterrupt[0];
  assign externalInterrupt = plicCtrl_io_targets[0];
  assign externalInterruptS = plicCtrl_io_targets[1];
  assign utime = clintCtrl_io_time;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      IBusCachedPlugin_fetchPc_pcReg <= 32'h0;
      IBusCachedPlugin_fetchPc_correctionReg <= 1'b0;
      IBusCachedPlugin_fetchPc_booted <= 1'b0;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid <= 1'b0;
      _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusCachedPlugin_rspCounter <= 32'h0;
      io_mem_cmd_rValidN <= 1'b1;
      io_mem_cmd_s2mPipe_rValid <= 1'b0;
      dBus_rsp_regNext_valid <= 1'b0;
      DBusCachedPlugin_rspCounter <= 32'h0;
      MmuPlugin_status_sum <= 1'b0;
      MmuPlugin_status_mxr <= 1'b0;
      MmuPlugin_status_mprv <= 1'b0;
      MmuPlugin_satp_mode <= 1'b0;
      MmuPlugin_ports_0_cache_0_valid <= 1'b0;
      MmuPlugin_ports_0_cache_1_valid <= 1'b0;
      MmuPlugin_ports_0_cache_2_valid <= 1'b0;
      MmuPlugin_ports_0_cache_3_valid <= 1'b0;
      MmuPlugin_ports_0_dirty <= 1'b0;
      MmuPlugin_ports_0_entryToReplace_value <= 2'b00;
      MmuPlugin_ports_1_cache_0_valid <= 1'b0;
      MmuPlugin_ports_1_cache_1_valid <= 1'b0;
      MmuPlugin_ports_1_cache_2_valid <= 1'b0;
      MmuPlugin_ports_1_cache_3_valid <= 1'b0;
      MmuPlugin_ports_1_dirty <= 1'b0;
      MmuPlugin_ports_1_entryToReplace_value <= 2'b00;
      MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_IDLE;
      MmuPlugin_shared_dBusRspStaged_valid <= 1'b0;
      _zz_10 <= 1'b1;
      memory_DivPlugin_div_counter_value <= 6'h0;
      HazardSimplePlugin_writeBackBuffer_valid <= 1'b0;
      _zz_CsrPlugin_privilege <= 2'b11;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= 2'b11;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_mcycle <= 64'h0;
      CsrPlugin_minstret <= 64'h0;
      CsrPlugin_medeleg_IAM <= 1'b0;
      CsrPlugin_medeleg_IAF <= 1'b0;
      CsrPlugin_medeleg_II <= 1'b0;
      CsrPlugin_medeleg_BP <= 1'b0;
      CsrPlugin_medeleg_LAM <= 1'b0;
      CsrPlugin_medeleg_LAF <= 1'b0;
      CsrPlugin_medeleg_SAM <= 1'b0;
      CsrPlugin_medeleg_SAF <= 1'b0;
      CsrPlugin_medeleg_EU <= 1'b0;
      CsrPlugin_medeleg_ES <= 1'b0;
      CsrPlugin_medeleg_IPF <= 1'b0;
      CsrPlugin_medeleg_LPF <= 1'b0;
      CsrPlugin_medeleg_SPF <= 1'b0;
      CsrPlugin_mideleg_ST <= 1'b0;
      CsrPlugin_mideleg_SE <= 1'b0;
      CsrPlugin_mideleg_SS <= 1'b0;
      CsrPlugin_mcounteren_TM <= 1'b1;
      CsrPlugin_scounteren_TM <= 1'b1;
      CsrPlugin_sstatus_SIE <= 1'b0;
      CsrPlugin_sstatus_SPIE <= 1'b0;
      CsrPlugin_sstatus_SPP <= 1'b1;
      CsrPlugin_sip_SEIP_SOFT <= 1'b0;
      CsrPlugin_sip_STIP <= 1'b0;
      CsrPlugin_sip_SSIP <= 1'b0;
      CsrPlugin_sie_SEIE <= 1'b0;
      CsrPlugin_sie_STIE <= 1'b0;
      CsrPlugin_sie_SSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_lastStageWasWfi <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      IBusCachedPlugin_injector_port_state <= 3'b000;
      execute_to_memory_IS_DBUS_SHARING <= 1'b0;
      memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
    end else begin
      if(IBusCachedPlugin_fetchPc_correction) begin
        IBusCachedPlugin_fetchPc_correctionReg <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_output_fire) begin
        IBusCachedPlugin_fetchPc_correctionReg <= 1'b0;
      end
      IBusCachedPlugin_fetchPc_booted <= 1'b1;
      if(when_Fetcher_l133) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusCachedPlugin_fetchPc_output_fire) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(when_Fetcher_l133_1) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(when_Fetcher_l160) begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      if(IBusCachedPlugin_iBusRsp_flush) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_ready) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid <= (IBusCachedPlugin_iBusRsp_stages_0_output_toEvent_valid && (! 1'b0));
      end
      if(IBusCachedPlugin_iBusRsp_flush) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_stages_1_output_ready) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_valid <= (IBusCachedPlugin_iBusRsp_stages_1_output_valid && (! IBusCachedPlugin_iBusRsp_flush));
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if(when_Fetcher_l331) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(when_Fetcher_l331_1) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(when_Fetcher_l331_2) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(when_Fetcher_l331_3) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(when_Fetcher_l331_4) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
      end
      if(IBusCachedPlugin_fetchPc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(iBus_rsp_valid) begin
        IBusCachedPlugin_rspCounter <= (IBusCachedPlugin_rspCounter + 32'h00000001);
      end
      if(dataCache_1_io_mem_cmd_valid) begin
        io_mem_cmd_rValidN <= 1'b0;
      end
      if(io_mem_cmd_s2mPipe_ready) begin
        io_mem_cmd_rValidN <= 1'b1;
      end
      if(io_mem_cmd_s2mPipe_ready) begin
        io_mem_cmd_s2mPipe_rValid <= io_mem_cmd_s2mPipe_valid;
      end
      dBus_rsp_regNext_valid <= dBus_rsp_valid;
      if(dBus_rsp_valid) begin
        DBusCachedPlugin_rspCounter <= (DBusCachedPlugin_rspCounter + 32'h00000001);
      end
      if(CsrPlugin_xretAwayFromMachine) begin
        MmuPlugin_status_mprv <= 1'b0;
      end
      if(when_MmuPlugin_l117) begin
        MmuPlugin_ports_0_dirty <= 1'b0;
      end
      MmuPlugin_ports_0_entryToReplace_value <= MmuPlugin_ports_0_entryToReplace_valueNext;
      if(contextSwitching) begin
        if(MmuPlugin_ports_0_cache_0_exception) begin
          MmuPlugin_ports_0_cache_0_valid <= 1'b0;
        end
        if(MmuPlugin_ports_0_cache_1_exception) begin
          MmuPlugin_ports_0_cache_1_valid <= 1'b0;
        end
        if(MmuPlugin_ports_0_cache_2_exception) begin
          MmuPlugin_ports_0_cache_2_valid <= 1'b0;
        end
        if(MmuPlugin_ports_0_cache_3_exception) begin
          MmuPlugin_ports_0_cache_3_valid <= 1'b0;
        end
      end
      if(when_MmuPlugin_l117_1) begin
        MmuPlugin_ports_1_dirty <= 1'b0;
      end
      MmuPlugin_ports_1_entryToReplace_value <= MmuPlugin_ports_1_entryToReplace_valueNext;
      if(contextSwitching) begin
        if(MmuPlugin_ports_1_cache_0_exception) begin
          MmuPlugin_ports_1_cache_0_valid <= 1'b0;
        end
        if(MmuPlugin_ports_1_cache_1_exception) begin
          MmuPlugin_ports_1_cache_1_valid <= 1'b0;
        end
        if(MmuPlugin_ports_1_cache_2_exception) begin
          MmuPlugin_ports_1_cache_2_valid <= 1'b0;
        end
        if(MmuPlugin_ports_1_cache_3_exception) begin
          MmuPlugin_ports_1_cache_3_valid <= 1'b0;
        end
      end
      MmuPlugin_shared_dBusRspStaged_valid <= MmuPlugin_dBusAccess_rsp_valid;
      case(MmuPlugin_shared_state_1)
        MmuPlugin_shared_State_IDLE : begin
          if(when_MmuPlugin_l223) begin
            MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L1_CMD;
          end
        end
        MmuPlugin_shared_State_L1_CMD : begin
          if(MmuPlugin_dBusAccess_cmd_ready) begin
            MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L1_RSP;
          end
        end
        MmuPlugin_shared_State_L1_RSP : begin
          if(MmuPlugin_shared_dBusRspStaged_valid) begin
            MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L0_CMD;
            if(when_MmuPlugin_l250) begin
              MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_IDLE;
            end
            if(MmuPlugin_shared_dBusRspStaged_payload_redo) begin
              MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L1_CMD;
            end
          end
        end
        MmuPlugin_shared_State_L0_CMD : begin
          if(MmuPlugin_dBusAccess_cmd_ready) begin
            MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L0_RSP;
          end
        end
        default : begin
          if(MmuPlugin_shared_dBusRspStaged_valid) begin
            MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_IDLE;
            if(MmuPlugin_shared_dBusRspStaged_payload_redo) begin
              MmuPlugin_shared_state_1 <= MmuPlugin_shared_State_L0_CMD;
            end
          end
        end
      endcase
      if(when_MmuPlugin_l279) begin
        if(when_MmuPlugin_l281) begin
          MmuPlugin_ports_0_dirty <= 1'b1;
          if(when_MmuPlugin_l287) begin
            MmuPlugin_ports_0_cache_0_valid <= 1'b1;
          end
          if(when_MmuPlugin_l287_1) begin
            MmuPlugin_ports_0_cache_1_valid <= 1'b1;
          end
          if(when_MmuPlugin_l287_2) begin
            MmuPlugin_ports_0_cache_2_valid <= 1'b1;
          end
          if(when_MmuPlugin_l287_3) begin
            MmuPlugin_ports_0_cache_3_valid <= 1'b1;
          end
        end
        if(when_MmuPlugin_l281_1) begin
          MmuPlugin_ports_1_dirty <= 1'b1;
          if(when_MmuPlugin_l287_4) begin
            MmuPlugin_ports_1_cache_0_valid <= 1'b1;
          end
          if(when_MmuPlugin_l287_5) begin
            MmuPlugin_ports_1_cache_1_valid <= 1'b1;
          end
          if(when_MmuPlugin_l287_6) begin
            MmuPlugin_ports_1_cache_2_valid <= 1'b1;
          end
          if(when_MmuPlugin_l287_7) begin
            MmuPlugin_ports_1_cache_3_valid <= 1'b1;
          end
        end
      end
      if(when_MmuPlugin_l311) begin
        MmuPlugin_ports_0_cache_0_valid <= 1'b0;
        MmuPlugin_ports_0_cache_1_valid <= 1'b0;
        MmuPlugin_ports_0_cache_2_valid <= 1'b0;
        MmuPlugin_ports_0_cache_3_valid <= 1'b0;
        MmuPlugin_ports_1_cache_0_valid <= 1'b0;
        MmuPlugin_ports_1_cache_1_valid <= 1'b0;
        MmuPlugin_ports_1_cache_2_valid <= 1'b0;
        MmuPlugin_ports_1_cache_3_valid <= 1'b0;
      end
      _zz_10 <= 1'b0;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid;
      CsrPlugin_mcycle <= (CsrPlugin_mcycle + 64'h0000000000000001);
      if(writeBack_arbitration_isFiring) begin
        CsrPlugin_minstret <= (CsrPlugin_minstret + 64'h0000000000000001);
      end
      if(when_CsrPlugin_l1259) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
      end
      if(when_CsrPlugin_l1259_1) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if(when_CsrPlugin_l1259_2) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if(when_CsrPlugin_l1259_3) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_interrupt_valid <= 1'b0;
      if(when_CsrPlugin_l1296) begin
        if(when_CsrPlugin_l1302) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_1) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_2) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      if(when_CsrPlugin_l1296_1) begin
        if(when_CsrPlugin_l1302_3) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_4) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_5) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_6) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_7) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l1302_8) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      CsrPlugin_lastStageWasWfi <= (writeBack_arbitration_isFiring && (writeBack_ENV_CTRL == EnvCtrlEnum_WFI));
      if(CsrPlugin_pipelineLiberator_active) begin
        if(when_CsrPlugin_l1335) begin
          CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1;
        end
        if(when_CsrPlugin_l1335_1) begin
          CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0;
        end
        if(when_CsrPlugin_l1335_2) begin
          CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1;
        end
      end
      if(when_CsrPlugin_l1340) begin
        CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      end
      if(CsrPlugin_interruptJump) begin
        CsrPlugin_interrupt_valid <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(when_CsrPlugin_l1390) begin
        if(when_CsrPlugin_l1398) begin
          _zz_CsrPlugin_privilege <= CsrPlugin_targetPrivilege;
          case(CsrPlugin_targetPrivilege)
            2'b01 : begin
              CsrPlugin_sstatus_SIE <= 1'b0;
              CsrPlugin_sstatus_SPIE <= CsrPlugin_sstatus_SIE;
              CsrPlugin_sstatus_SPP <= CsrPlugin_privilege[0 : 0];
            end
            2'b11 : begin
              CsrPlugin_mstatus_MIE <= 1'b0;
              CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
              CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
            end
            default : begin
            end
          endcase
        end
      end
      if(when_CsrPlugin_l1456) begin
        case(switch_CsrPlugin_l1460)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= 2'b00;
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
            _zz_CsrPlugin_privilege <= CsrPlugin_mstatus_MPP;
          end
          2'b01 : begin
            CsrPlugin_sstatus_SPP <= 1'b0;
            CsrPlugin_sstatus_SIE <= CsrPlugin_sstatus_SPIE;
            CsrPlugin_sstatus_SPIE <= 1'b1;
            _zz_CsrPlugin_privilege <= {1'b0,CsrPlugin_sstatus_SPP};
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= ((|{_zz_when_CsrPlugin_l1302_5,{_zz_when_CsrPlugin_l1302_4,{_zz_when_CsrPlugin_l1302_3,{_zz_when_CsrPlugin_l1302_2,{_zz_when_CsrPlugin_l1302_1,_zz_when_CsrPlugin_l1302}}}}}) || CsrPlugin_thirdPartyWake);
      if(when_Pipeline_l124_58) begin
        execute_to_memory_IS_DBUS_SHARING <= execute_IS_DBUS_SHARING;
      end
      if(when_Pipeline_l124_59) begin
        memory_to_writeBack_IS_DBUS_SHARING <= memory_IS_DBUS_SHARING;
      end
      if(when_Pipeline_l151) begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154) begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(when_Pipeline_l151_1) begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_1) begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(when_Pipeline_l151_2) begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_2) begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(IBusCachedPlugin_injector_port_state)
        3'b000 : begin
          if(DebugPlugin_injectionPort_valid) begin
            IBusCachedPlugin_injector_port_state <= 3'b001;
          end
        end
        3'b001 : begin
          IBusCachedPlugin_injector_port_state <= 3'b010;
        end
        3'b010 : begin
          IBusCachedPlugin_injector_port_state <= 3'b011;
        end
        3'b011 : begin
          if(when_Fetcher_l391) begin
            IBusCachedPlugin_injector_port_state <= 3'b100;
          end
        end
        3'b100 : begin
          IBusCachedPlugin_injector_port_state <= 3'b000;
        end
        default : begin
        end
      endcase
      if(MmuPlugin_dBusAccess_rsp_valid) begin
        memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
      end
      if(MmuPlugin_dBusAccess_rsp_valid) begin
        memory_to_writeBack_IS_DBUS_SHARING <= 1'b0;
      end
      if(execute_CsrPlugin_csr_768) begin
        if(execute_CsrPlugin_writeEnable) begin
          MmuPlugin_status_mxr <= CsrPlugin_csrMapping_writeDataSignal[19];
          MmuPlugin_status_sum <= CsrPlugin_csrMapping_writeDataSignal[18];
          MmuPlugin_status_mprv <= CsrPlugin_csrMapping_writeDataSignal[17];
          CsrPlugin_mstatus_MPIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mstatus_MIE <= CsrPlugin_csrMapping_writeDataSignal[3];
          case(switch_CsrPlugin_l1031)
            2'b11 : begin
              CsrPlugin_mstatus_MPP <= 2'b11;
            end
            2'b01 : begin
              CsrPlugin_mstatus_MPP <= 2'b01;
            end
            2'b00 : begin
              CsrPlugin_mstatus_MPP <= 2'b00;
            end
            default : begin
            end
          endcase
          CsrPlugin_sstatus_SPP <= CsrPlugin_csrMapping_writeDataSignal[8 : 8];
          CsrPlugin_sstatus_SPIE <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_sstatus_SIE <= CsrPlugin_csrMapping_writeDataSignal[1];
        end
      end
      if(execute_CsrPlugin_csr_256) begin
        if(execute_CsrPlugin_writeEnable) begin
          MmuPlugin_status_mxr <= CsrPlugin_csrMapping_writeDataSignal[19];
          MmuPlugin_status_sum <= CsrPlugin_csrMapping_writeDataSignal[18];
          MmuPlugin_status_mprv <= CsrPlugin_csrMapping_writeDataSignal[17];
          CsrPlugin_sstatus_SPP <= CsrPlugin_csrMapping_writeDataSignal[8 : 8];
          CsrPlugin_sstatus_SPIE <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_sstatus_SIE <= CsrPlugin_csrMapping_writeDataSignal[1];
        end
      end
      if(execute_CsrPlugin_csr_384) begin
        if(execute_CsrPlugin_writeEnable) begin
          MmuPlugin_satp_mode <= CsrPlugin_csrMapping_writeDataSignal[31];
          MmuPlugin_ports_0_cache_0_valid <= 1'b0;
          MmuPlugin_ports_0_cache_1_valid <= 1'b0;
          MmuPlugin_ports_0_cache_2_valid <= 1'b0;
          MmuPlugin_ports_0_cache_3_valid <= 1'b0;
          MmuPlugin_ports_1_cache_0_valid <= 1'b0;
          MmuPlugin_ports_1_cache_1_valid <= 1'b0;
          MmuPlugin_ports_1_cache_2_valid <= 1'b0;
          MmuPlugin_ports_1_cache_3_valid <= 1'b0;
        end
      end
      if(execute_CsrPlugin_csr_836) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_sip_STIP <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_sip_SSIP <= CsrPlugin_csrMapping_writeDataSignal[1];
          CsrPlugin_sip_SEIP_SOFT <= CsrPlugin_csrMapping_writeDataSignal[9];
        end
      end
      if(execute_CsrPlugin_csr_772) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mie_MEIE <= CsrPlugin_csrMapping_writeDataSignal[11];
          CsrPlugin_mie_MTIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mie_MSIE <= CsrPlugin_csrMapping_writeDataSignal[3];
          CsrPlugin_sie_SEIE <= CsrPlugin_csrMapping_writeDataSignal[9];
          CsrPlugin_sie_STIE <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_sie_SSIE <= CsrPlugin_csrMapping_writeDataSignal[1];
        end
      end
      if(execute_CsrPlugin_csr_770) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_medeleg_IAM <= CsrPlugin_csrMapping_writeDataSignal[0];
          CsrPlugin_medeleg_IAF <= CsrPlugin_csrMapping_writeDataSignal[1];
          CsrPlugin_medeleg_II <= CsrPlugin_csrMapping_writeDataSignal[2];
          CsrPlugin_medeleg_BP <= CsrPlugin_csrMapping_writeDataSignal[3];
          CsrPlugin_medeleg_LAM <= CsrPlugin_csrMapping_writeDataSignal[4];
          CsrPlugin_medeleg_LAF <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_medeleg_SAM <= CsrPlugin_csrMapping_writeDataSignal[6];
          CsrPlugin_medeleg_SAF <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_medeleg_EU <= CsrPlugin_csrMapping_writeDataSignal[8];
          CsrPlugin_medeleg_ES <= CsrPlugin_csrMapping_writeDataSignal[9];
          CsrPlugin_medeleg_IPF <= CsrPlugin_csrMapping_writeDataSignal[12];
          CsrPlugin_medeleg_LPF <= CsrPlugin_csrMapping_writeDataSignal[13];
          CsrPlugin_medeleg_SPF <= CsrPlugin_csrMapping_writeDataSignal[15];
        end
      end
      if(execute_CsrPlugin_csr_771) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mideleg_SE <= CsrPlugin_csrMapping_writeDataSignal[9];
          CsrPlugin_mideleg_ST <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_mideleg_SS <= CsrPlugin_csrMapping_writeDataSignal[1];
        end
      end
      if(execute_CsrPlugin_csr_774) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mcounteren_TM <= CsrPlugin_csrMapping_writeDataSignal[1];
        end
      end
      if(execute_CsrPlugin_csr_262) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_scounteren_TM <= CsrPlugin_csrMapping_writeDataSignal[1];
        end
      end
      if(execute_CsrPlugin_csr_324) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_sip_STIP <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_sip_SSIP <= CsrPlugin_csrMapping_writeDataSignal[1];
          CsrPlugin_sip_SEIP_SOFT <= CsrPlugin_csrMapping_writeDataSignal[9];
        end
      end
      if(execute_CsrPlugin_csr_260) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_sie_SEIE <= CsrPlugin_csrMapping_writeDataSignal[9];
          CsrPlugin_sie_STIE <= CsrPlugin_csrMapping_writeDataSignal[5];
          CsrPlugin_sie_SSIE <= CsrPlugin_csrMapping_writeDataSignal[1];
        end
      end
    end
  end

  always @(posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_1_output_ready) begin
      _zz_IBusCachedPlugin_iBusRsp_stages_1_output_m2sPipe_payload <= IBusCachedPlugin_iBusRsp_stages_1_output_payload;
    end
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready) begin
      IBusCachedPlugin_s1_tightlyCoupledHit <= IBusCachedPlugin_s0_tightlyCoupledHit;
    end
    if(IBusCachedPlugin_iBusRsp_stages_2_input_ready) begin
      IBusCachedPlugin_s2_tightlyCoupledHit <= IBusCachedPlugin_s1_tightlyCoupledHit;
    end
    if(io_mem_cmd_rValidN) begin
      io_mem_cmd_rData_wr <= dataCache_1_io_mem_cmd_payload_wr;
      io_mem_cmd_rData_uncached <= dataCache_1_io_mem_cmd_payload_uncached;
      io_mem_cmd_rData_address <= dataCache_1_io_mem_cmd_payload_address;
      io_mem_cmd_rData_data <= dataCache_1_io_mem_cmd_payload_data;
      io_mem_cmd_rData_mask <= dataCache_1_io_mem_cmd_payload_mask;
      io_mem_cmd_rData_size <= dataCache_1_io_mem_cmd_payload_size;
      io_mem_cmd_rData_last <= dataCache_1_io_mem_cmd_payload_last;
    end
    if(io_mem_cmd_s2mPipe_ready) begin
      io_mem_cmd_s2mPipe_rData_wr <= io_mem_cmd_s2mPipe_payload_wr;
      io_mem_cmd_s2mPipe_rData_uncached <= io_mem_cmd_s2mPipe_payload_uncached;
      io_mem_cmd_s2mPipe_rData_address <= io_mem_cmd_s2mPipe_payload_address;
      io_mem_cmd_s2mPipe_rData_data <= io_mem_cmd_s2mPipe_payload_data;
      io_mem_cmd_s2mPipe_rData_mask <= io_mem_cmd_s2mPipe_payload_mask;
      io_mem_cmd_s2mPipe_rData_size <= io_mem_cmd_s2mPipe_payload_size;
      io_mem_cmd_s2mPipe_rData_last <= io_mem_cmd_s2mPipe_payload_last;
    end
    dBus_rsp_regNext_payload_last <= dBus_rsp_payload_last;
    dBus_rsp_regNext_payload_data <= dBus_rsp_payload_data;
    dBus_rsp_regNext_payload_error <= dBus_rsp_payload_error;
    if(when_MmuPlugin_l124) begin
      MmuPlugin_ports_0_requireMmuLockup <= MmuPlugin_ports_0_requireMmuLockupCalc;
    end
    if(when_MmuPlugin_l124_1) begin
      MmuPlugin_ports_0_cacheHits <= MmuPlugin_ports_0_cacheHitsCalc;
    end
    if(when_MmuPlugin_l124_2) begin
      MmuPlugin_ports_1_requireMmuLockup <= MmuPlugin_ports_1_requireMmuLockupCalc;
    end
    if(when_MmuPlugin_l124_3) begin
      MmuPlugin_ports_1_cacheHits <= MmuPlugin_ports_1_cacheHitsCalc;
    end
    MmuPlugin_shared_dBusRspStaged_payload_data <= MmuPlugin_dBusAccess_rsp_payload_data;
    MmuPlugin_shared_dBusRspStaged_payload_error <= MmuPlugin_dBusAccess_rsp_payload_error;
    MmuPlugin_shared_dBusRspStaged_payload_redo <= MmuPlugin_dBusAccess_rsp_payload_redo;
    if(when_MmuPlugin_l211) begin
      MmuPlugin_shared_pteBuffer_V <= MmuPlugin_shared_dBusRsp_pte_V;
      MmuPlugin_shared_pteBuffer_R <= MmuPlugin_shared_dBusRsp_pte_R;
      MmuPlugin_shared_pteBuffer_W <= MmuPlugin_shared_dBusRsp_pte_W;
      MmuPlugin_shared_pteBuffer_X <= MmuPlugin_shared_dBusRsp_pte_X;
      MmuPlugin_shared_pteBuffer_U <= MmuPlugin_shared_dBusRsp_pte_U;
      MmuPlugin_shared_pteBuffer_G <= MmuPlugin_shared_dBusRsp_pte_G;
      MmuPlugin_shared_pteBuffer_A <= MmuPlugin_shared_dBusRsp_pte_A;
      MmuPlugin_shared_pteBuffer_D <= MmuPlugin_shared_dBusRsp_pte_D;
      MmuPlugin_shared_pteBuffer_RSW <= MmuPlugin_shared_dBusRsp_pte_RSW;
      MmuPlugin_shared_pteBuffer_PPN0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
      MmuPlugin_shared_pteBuffer_PPN1 <= MmuPlugin_shared_dBusRsp_pte_PPN1;
    end
    case(MmuPlugin_shared_state_1)
      MmuPlugin_shared_State_IDLE : begin
        if(when_MmuPlugin_l223) begin
          MmuPlugin_shared_portSortedOh <= MmuPlugin_shared_refills;
          MmuPlugin_shared_vpn_1 <= _zz_MmuPlugin_shared_vpn_0[31 : 22];
          MmuPlugin_shared_vpn_0 <= _zz_MmuPlugin_shared_vpn_0[21 : 12];
        end
      end
      MmuPlugin_shared_State_L1_CMD : begin
      end
      MmuPlugin_shared_State_L1_RSP : begin
      end
      MmuPlugin_shared_State_L0_CMD : begin
      end
      default : begin
      end
    endcase
    if(when_MmuPlugin_l279) begin
      if(when_MmuPlugin_l281) begin
        if(when_MmuPlugin_l287) begin
          MmuPlugin_ports_0_cache_0_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_0_cache_0_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_0_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_0_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_0_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_0_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_0_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_0_cache_0_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_0_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_0_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
        if(when_MmuPlugin_l287_1) begin
          MmuPlugin_ports_0_cache_1_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_0_cache_1_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_1_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_1_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_1_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_1_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_1_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_0_cache_1_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_1_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_1_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
        if(when_MmuPlugin_l287_2) begin
          MmuPlugin_ports_0_cache_2_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_0_cache_2_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_2_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_2_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_2_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_2_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_2_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_0_cache_2_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_2_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_2_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
        if(when_MmuPlugin_l287_3) begin
          MmuPlugin_ports_0_cache_3_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_0_cache_3_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_0_cache_3_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_0_cache_3_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_0_cache_3_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_0_cache_3_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_0_cache_3_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_0_cache_3_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_0_cache_3_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_0_cache_3_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
      end
      if(when_MmuPlugin_l281_1) begin
        if(when_MmuPlugin_l287_4) begin
          MmuPlugin_ports_1_cache_0_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_1_cache_0_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_0_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_0_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_0_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_0_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_0_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_1_cache_0_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_0_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_0_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
        if(when_MmuPlugin_l287_5) begin
          MmuPlugin_ports_1_cache_1_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_1_cache_1_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_1_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_1_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_1_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_1_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_1_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_1_cache_1_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_1_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_1_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
        if(when_MmuPlugin_l287_6) begin
          MmuPlugin_ports_1_cache_2_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_1_cache_2_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_2_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_2_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_2_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_2_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_2_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_1_cache_2_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_2_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_2_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
        if(when_MmuPlugin_l287_7) begin
          MmuPlugin_ports_1_cache_3_exception <= ((MmuPlugin_shared_dBusRsp_exception || ((MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP) && (MmuPlugin_shared_dBusRsp_pte_PPN0 != 10'h0))) || (! MmuPlugin_shared_dBusRsp_pte_A));
          MmuPlugin_ports_1_cache_3_virtualAddress_0 <= MmuPlugin_shared_vpn_0;
          MmuPlugin_ports_1_cache_3_virtualAddress_1 <= MmuPlugin_shared_vpn_1;
          MmuPlugin_ports_1_cache_3_physicalAddress_0 <= MmuPlugin_shared_dBusRsp_pte_PPN0;
          MmuPlugin_ports_1_cache_3_physicalAddress_1 <= MmuPlugin_shared_dBusRsp_pte_PPN1[9 : 0];
          MmuPlugin_ports_1_cache_3_allowRead <= MmuPlugin_shared_dBusRsp_pte_R;
          MmuPlugin_ports_1_cache_3_allowWrite <= (MmuPlugin_shared_dBusRsp_pte_W && MmuPlugin_shared_dBusRsp_pte_D);
          MmuPlugin_ports_1_cache_3_allowExecute <= MmuPlugin_shared_dBusRsp_pte_X;
          MmuPlugin_ports_1_cache_3_allowUser <= MmuPlugin_shared_dBusRsp_pte_U;
          MmuPlugin_ports_1_cache_3_superPage <= (MmuPlugin_shared_state_1 == MmuPlugin_shared_State_L1_RSP);
        end
      end
    end
    if(when_MulDivIterativePlugin_l126) begin
      memory_DivPlugin_div_done <= 1'b1;
    end
    if(when_MulDivIterativePlugin_l126_1) begin
      memory_DivPlugin_div_done <= 1'b0;
    end
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l132) begin
        memory_DivPlugin_rs1[31 : 0] <= memory_DivPlugin_div_stage_0_outNumerator;
        memory_DivPlugin_accumulator[31 : 0] <= memory_DivPlugin_div_stage_0_outRemainder;
        if(when_MulDivIterativePlugin_l151) begin
          memory_DivPlugin_div_result <= _zz_memory_DivPlugin_div_result_1[31:0];
        end
      end
    end
    if(when_MulDivIterativePlugin_l162) begin
      memory_DivPlugin_accumulator <= 65'h0;
      memory_DivPlugin_rs1 <= ((_zz_memory_DivPlugin_rs1 ? (~ _zz_memory_DivPlugin_rs1_1) : _zz_memory_DivPlugin_rs1_1) + _zz_memory_DivPlugin_rs1_2);
      memory_DivPlugin_rs2 <= ((_zz_memory_DivPlugin_rs2 ? (~ execute_RS2) : execute_RS2) + _zz_memory_DivPlugin_rs2_1);
      memory_DivPlugin_div_needRevert <= ((_zz_memory_DivPlugin_rs1 ^ (_zz_memory_DivPlugin_rs2 && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == 32'h0) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address;
    HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data;
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_sip_SEIP_INPUT <= externalInterruptS;
    if(_zz_when) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_code : decodeExceptionPort_payload_code);
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_badAddr : decodeExceptionPort_payload_badAddr);
    end
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
    end
    if(BranchPlugin_branchExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= BranchPlugin_branchExceptionPort_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= BranchPlugin_branchExceptionPort_payload_badAddr;
    end
    if(DBusCachedPlugin_exceptionBus_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= DBusCachedPlugin_exceptionBus_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= DBusCachedPlugin_exceptionBus_payload_badAddr;
    end
    if(when_CsrPlugin_l1296) begin
      if(when_CsrPlugin_l1302) begin
        CsrPlugin_interrupt_code <= 4'b0101;
        CsrPlugin_interrupt_targetPrivilege <= 2'b01;
      end
      if(when_CsrPlugin_l1302_1) begin
        CsrPlugin_interrupt_code <= 4'b0001;
        CsrPlugin_interrupt_targetPrivilege <= 2'b01;
      end
      if(when_CsrPlugin_l1302_2) begin
        CsrPlugin_interrupt_code <= 4'b1001;
        CsrPlugin_interrupt_targetPrivilege <= 2'b01;
      end
    end
    if(when_CsrPlugin_l1296_1) begin
      if(when_CsrPlugin_l1302_3) begin
        CsrPlugin_interrupt_code <= 4'b0101;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l1302_4) begin
        CsrPlugin_interrupt_code <= 4'b0001;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l1302_5) begin
        CsrPlugin_interrupt_code <= 4'b1001;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l1302_6) begin
        CsrPlugin_interrupt_code <= 4'b0111;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l1302_7) begin
        CsrPlugin_interrupt_code <= 4'b0011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l1302_8) begin
        CsrPlugin_interrupt_code <= 4'b1011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
    end
    if(when_CsrPlugin_l1390) begin
      if(when_CsrPlugin_l1398) begin
        case(CsrPlugin_targetPrivilege)
          2'b01 : begin
            CsrPlugin_scause_interrupt <= (! CsrPlugin_hadException);
            CsrPlugin_scause_exceptionCode <= CsrPlugin_trapCause;
            CsrPlugin_sepc <= writeBack_PC;
            if(CsrPlugin_hadException) begin
              CsrPlugin_stval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
            end
          end
          2'b11 : begin
            CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
            CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
            CsrPlugin_mepc <= writeBack_PC;
            if(CsrPlugin_hadException) begin
              CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
            end
          end
          default : begin
          end
        endcase
      end
    end
    if(when_Pipeline_l124) begin
      decode_to_execute_PC <= decode_PC;
    end
    if(when_Pipeline_l124_1) begin
      execute_to_memory_PC <= _zz_execute_to_memory_PC;
    end
    if(when_Pipeline_l124_2) begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if(when_Pipeline_l124_3) begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if(when_Pipeline_l124_4) begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if(when_Pipeline_l124_5) begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
    end
    if(when_Pipeline_l124_6) begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_decode_to_execute_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_7) begin
      execute_to_memory_FORMAL_PC_NEXT <= _zz_execute_to_memory_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_8) begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_memory_to_writeBack_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_9) begin
      decode_to_execute_MEMORY_FORCE_CONSTISTENCY <= decode_MEMORY_FORCE_CONSTISTENCY;
    end
    if(when_Pipeline_l124_10) begin
      decode_to_execute_RESCHEDULE_NEXT <= decode_RESCHEDULE_NEXT;
    end
    if(when_Pipeline_l124_11) begin
      decode_to_execute_SRC1_CTRL <= _zz_decode_to_execute_SRC1_CTRL;
    end
    if(when_Pipeline_l124_12) begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if(when_Pipeline_l124_13) begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_14) begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_15) begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_16) begin
      decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL;
    end
    if(when_Pipeline_l124_17) begin
      decode_to_execute_SRC2_CTRL <= _zz_decode_to_execute_SRC2_CTRL;
    end
    if(when_Pipeline_l124_18) begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_19) begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_20) begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_21) begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if(when_Pipeline_l124_22) begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_23) begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_24) begin
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
    end
    if(when_Pipeline_l124_25) begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
    end
    if(when_Pipeline_l124_26) begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
    end
    if(when_Pipeline_l124_27) begin
      decode_to_execute_MEMORY_LRSC <= decode_MEMORY_LRSC;
    end
    if(when_Pipeline_l124_28) begin
      execute_to_memory_MEMORY_LRSC <= execute_MEMORY_LRSC;
    end
    if(when_Pipeline_l124_29) begin
      memory_to_writeBack_MEMORY_LRSC <= memory_MEMORY_LRSC;
    end
    if(when_Pipeline_l124_30) begin
      decode_to_execute_MEMORY_AMO <= decode_MEMORY_AMO;
    end
    if(when_Pipeline_l124_31) begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
    end
    if(when_Pipeline_l124_32) begin
      decode_to_execute_IS_SFENCE_VMA2 <= decode_IS_SFENCE_VMA2;
    end
    if(when_Pipeline_l124_33) begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if(when_Pipeline_l124_34) begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL;
    end
    if(when_Pipeline_l124_35) begin
      decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_36) begin
      execute_to_memory_SHIFT_CTRL <= _zz_execute_to_memory_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_37) begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if(when_Pipeline_l124_38) begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if(when_Pipeline_l124_39) begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if(when_Pipeline_l124_40) begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if(when_Pipeline_l124_41) begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if(when_Pipeline_l124_42) begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if(when_Pipeline_l124_43) begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if(when_Pipeline_l124_44) begin
      decode_to_execute_ENV_CTRL <= _zz_decode_to_execute_ENV_CTRL;
    end
    if(when_Pipeline_l124_45) begin
      execute_to_memory_ENV_CTRL <= _zz_execute_to_memory_ENV_CTRL;
    end
    if(when_Pipeline_l124_46) begin
      memory_to_writeBack_ENV_CTRL <= _zz_memory_to_writeBack_ENV_CTRL;
    end
    if(when_Pipeline_l124_47) begin
      decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL;
    end
    if(when_Pipeline_l124_48) begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if(when_Pipeline_l124_49) begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if(when_Pipeline_l124_50) begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if(when_Pipeline_l124_51) begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if(when_Pipeline_l124_52) begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if(when_Pipeline_l124_53) begin
      decode_to_execute_PREDICTION_HAD_BRANCHED1 <= decode_PREDICTION_HAD_BRANCHED1;
    end
    if(when_Pipeline_l124_54) begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if(when_Pipeline_l124_55) begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if(when_Pipeline_l124_56) begin
      execute_to_memory_MEMORY_STORE_DATA_RF <= execute_MEMORY_STORE_DATA_RF;
    end
    if(when_Pipeline_l124_57) begin
      memory_to_writeBack_MEMORY_STORE_DATA_RF <= memory_MEMORY_STORE_DATA_RF;
    end
    if(when_Pipeline_l124_60) begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_decode_RS2;
    end
    if(when_Pipeline_l124_61) begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_decode_RS2_1;
    end
    if(when_Pipeline_l124_62) begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if(when_Pipeline_l124_63) begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if(when_Pipeline_l124_64) begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if(when_Pipeline_l124_65) begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if(when_Pipeline_l124_66) begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if(when_Pipeline_l124_67) begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if(when_Pipeline_l124_68) begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if(when_Pipeline_l124_69) begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if(when_Pipeline_l124_70) begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if(when_CsrPlugin_l1669) begin
      execute_CsrPlugin_csr_768 <= (decode_INSTRUCTION[31 : 20] == 12'h300);
    end
    if(when_CsrPlugin_l1669_1) begin
      execute_CsrPlugin_csr_256 <= (decode_INSTRUCTION[31 : 20] == 12'h100);
    end
    if(when_CsrPlugin_l1669_2) begin
      execute_CsrPlugin_csr_384 <= (decode_INSTRUCTION[31 : 20] == 12'h180);
    end
    if(when_CsrPlugin_l1669_3) begin
      execute_CsrPlugin_csr_3857 <= (decode_INSTRUCTION[31 : 20] == 12'hf11);
    end
    if(when_CsrPlugin_l1669_4) begin
      execute_CsrPlugin_csr_3858 <= (decode_INSTRUCTION[31 : 20] == 12'hf12);
    end
    if(when_CsrPlugin_l1669_5) begin
      execute_CsrPlugin_csr_3859 <= (decode_INSTRUCTION[31 : 20] == 12'hf13);
    end
    if(when_CsrPlugin_l1669_6) begin
      execute_CsrPlugin_csr_3860 <= (decode_INSTRUCTION[31 : 20] == 12'hf14);
    end
    if(when_CsrPlugin_l1669_7) begin
      execute_CsrPlugin_csr_769 <= (decode_INSTRUCTION[31 : 20] == 12'h301);
    end
    if(when_CsrPlugin_l1669_8) begin
      execute_CsrPlugin_csr_836 <= (decode_INSTRUCTION[31 : 20] == 12'h344);
    end
    if(when_CsrPlugin_l1669_9) begin
      execute_CsrPlugin_csr_772 <= (decode_INSTRUCTION[31 : 20] == 12'h304);
    end
    if(when_CsrPlugin_l1669_10) begin
      execute_CsrPlugin_csr_773 <= (decode_INSTRUCTION[31 : 20] == 12'h305);
    end
    if(when_CsrPlugin_l1669_11) begin
      execute_CsrPlugin_csr_833 <= (decode_INSTRUCTION[31 : 20] == 12'h341);
    end
    if(when_CsrPlugin_l1669_12) begin
      execute_CsrPlugin_csr_832 <= (decode_INSTRUCTION[31 : 20] == 12'h340);
    end
    if(when_CsrPlugin_l1669_13) begin
      execute_CsrPlugin_csr_834 <= (decode_INSTRUCTION[31 : 20] == 12'h342);
    end
    if(when_CsrPlugin_l1669_14) begin
      execute_CsrPlugin_csr_835 <= (decode_INSTRUCTION[31 : 20] == 12'h343);
    end
    if(when_CsrPlugin_l1669_15) begin
      execute_CsrPlugin_csr_770 <= (decode_INSTRUCTION[31 : 20] == 12'h302);
    end
    if(when_CsrPlugin_l1669_16) begin
      execute_CsrPlugin_csr_771 <= (decode_INSTRUCTION[31 : 20] == 12'h303);
    end
    if(when_CsrPlugin_l1669_17) begin
      execute_CsrPlugin_csr_3073 <= (decode_INSTRUCTION[31 : 20] == 12'hc01);
    end
    if(when_CsrPlugin_l1669_18) begin
      execute_CsrPlugin_csr_3201 <= (decode_INSTRUCTION[31 : 20] == 12'hc81);
    end
    if(when_CsrPlugin_l1669_19) begin
      execute_CsrPlugin_csr_774 <= (decode_INSTRUCTION[31 : 20] == 12'h306);
    end
    if(when_CsrPlugin_l1669_20) begin
      execute_CsrPlugin_csr_262 <= (decode_INSTRUCTION[31 : 20] == 12'h106);
    end
    if(when_CsrPlugin_l1669_21) begin
      execute_CsrPlugin_csr_324 <= (decode_INSTRUCTION[31 : 20] == 12'h144);
    end
    if(when_CsrPlugin_l1669_22) begin
      execute_CsrPlugin_csr_260 <= (decode_INSTRUCTION[31 : 20] == 12'h104);
    end
    if(when_CsrPlugin_l1669_23) begin
      execute_CsrPlugin_csr_261 <= (decode_INSTRUCTION[31 : 20] == 12'h105);
    end
    if(when_CsrPlugin_l1669_24) begin
      execute_CsrPlugin_csr_321 <= (decode_INSTRUCTION[31 : 20] == 12'h141);
    end
    if(when_CsrPlugin_l1669_25) begin
      execute_CsrPlugin_csr_320 <= (decode_INSTRUCTION[31 : 20] == 12'h140);
    end
    if(when_CsrPlugin_l1669_26) begin
      execute_CsrPlugin_csr_322 <= (decode_INSTRUCTION[31 : 20] == 12'h142);
    end
    if(when_CsrPlugin_l1669_27) begin
      execute_CsrPlugin_csr_323 <= (decode_INSTRUCTION[31 : 20] == 12'h143);
    end
    if(when_CsrPlugin_l1669_28) begin
      execute_CsrPlugin_csr_784 <= (decode_INSTRUCTION[31 : 20] == 12'h310);
    end
    if(execute_CsrPlugin_csr_384) begin
      if(execute_CsrPlugin_writeEnable) begin
        MmuPlugin_satp_asid <= CsrPlugin_csrMapping_writeDataSignal[30 : 22];
        MmuPlugin_satp_ppn <= CsrPlugin_csrMapping_writeDataSignal[21 : 0];
      end
    end
    if(execute_CsrPlugin_csr_836) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mip_MSIP <= CsrPlugin_csrMapping_writeDataSignal[3];
      end
    end
    if(execute_CsrPlugin_csr_773) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mtvec_base <= CsrPlugin_csrMapping_writeDataSignal[31 : 2];
      end
    end
    if(execute_CsrPlugin_csr_833) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mepc <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_832) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mscratch <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_261) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_stvec_base <= CsrPlugin_csrMapping_writeDataSignal[31 : 2];
      end
    end
    if(execute_CsrPlugin_csr_321) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_sepc <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_320) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_sscratch <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_322) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_scause_interrupt <= CsrPlugin_csrMapping_writeDataSignal[31];
        CsrPlugin_scause_exceptionCode <= CsrPlugin_csrMapping_writeDataSignal[3 : 0];
      end
    end
    if(execute_CsrPlugin_csr_323) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_stval <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
  end

  always @(posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready) begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipBusy <= ((|{writeBack_arbitration_isValid,{memory_arbitration_isValid,{execute_arbitration_isValid,decode_arbitration_isValid}}}) || IBusCachedPlugin_incomingInstruction);
    if(writeBack_arbitration_isValid) begin
      DebugPlugin_busReadDataReg <= _zz_decode_RS2_2;
    end
    _zz_when_DebugPlugin_l257 <= debug_bus_cmd_payload_address[2];
    if(when_DebugPlugin_l308) begin
      DebugPlugin_busReadDataReg <= execute_PC;
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt;
  end

  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_godmode <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
      DebugPlugin_debugUsed <= 1'b0;
      DebugPlugin_disableEbreak <= 1'b0;
      debug_bus_cmd_fire_regNext <= 1'b0;
    end else begin
      if(when_DebugPlugin_l238) begin
        DebugPlugin_godmode <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        DebugPlugin_debugUsed <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        case(switch_DebugPlugin_l280)
          6'h0 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(when_DebugPlugin_l284) begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(when_DebugPlugin_l284_1) begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(when_DebugPlugin_l285) begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(when_DebugPlugin_l285_1) begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(when_DebugPlugin_l286) begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
              if(when_DebugPlugin_l287) begin
                DebugPlugin_godmode <= 1'b0;
              end
              if(when_DebugPlugin_l288) begin
                DebugPlugin_disableEbreak <= 1'b1;
              end
              if(when_DebugPlugin_l288_1) begin
                DebugPlugin_disableEbreak <= 1'b0;
              end
            end
          end
          default : begin
          end
        endcase
      end
      if(when_DebugPlugin_l308) begin
        if(when_DebugPlugin_l311) begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(when_DebugPlugin_l324) begin
        if(decode_arbitration_isValid) begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
      debug_bus_cmd_fire_regNext <= debug_bus_cmd_fire;
    end
  end


endmodule

module SystemDebugger (
  input  wire          io_remote_cmd_valid,
  output wire          io_remote_cmd_ready,
  input  wire          io_remote_cmd_payload_last,
  input  wire [0:0]    io_remote_cmd_payload_fragment,
  output wire          io_remote_rsp_valid,
  input  wire          io_remote_rsp_ready,
  output wire          io_remote_rsp_payload_error,
  output wire [31:0]   io_remote_rsp_payload_data,
  output wire          io_mem_cmd_valid,
  input  wire          io_mem_cmd_ready,
  output wire [31:0]   io_mem_cmd_payload_address,
  output wire [31:0]   io_mem_cmd_payload_data,
  output wire          io_mem_cmd_payload_wr,
  output wire [1:0]    io_mem_cmd_payload_size,
  input  wire          io_mem_rsp_valid,
  input  wire [31:0]   io_mem_rsp_payload,
  input  wire          clk,
  input  wire          debugReset
);

  reg        [66:0]   dispatcher_dataShifter;
  reg                 dispatcher_dataLoaded;
  reg        [7:0]    dispatcher_headerShifter;
  wire       [7:0]    dispatcher_header;
  reg                 dispatcher_headerLoaded;
  reg        [2:0]    dispatcher_counter;
  wire                when_Fragment_l358;
  wire                when_Fragment_l361;
  wire       [66:0]   _zz_io_mem_cmd_payload_address;
  wire                io_mem_cmd_isStall;
  wire                when_Fragment_l384;

  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign when_Fragment_l358 = (dispatcher_headerLoaded == 1'b0);
  assign when_Fragment_l361 = (dispatcher_counter == 3'b111);
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_io_mem_cmd_payload_address = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_io_mem_cmd_payload_address[31 : 0];
  assign io_mem_cmd_payload_data = _zz_io_mem_cmd_payload_address[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_io_mem_cmd_payload_address[64];
  assign io_mem_cmd_payload_size = _zz_io_mem_cmd_payload_address[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == 8'h0));
  assign io_mem_cmd_isStall = (io_mem_cmd_valid && (! io_mem_cmd_ready));
  assign when_Fragment_l384 = ((dispatcher_headerLoaded && dispatcher_dataLoaded) && (! io_mem_cmd_isStall));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= 3'b000;
    end else begin
      if(io_remote_cmd_valid) begin
        if(when_Fragment_l358) begin
          dispatcher_counter <= (dispatcher_counter + 3'b001);
          if(when_Fragment_l361) begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last) begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= 3'b000;
        end
      end
      if(when_Fragment_l384) begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(io_remote_cmd_valid) begin
      if(when_Fragment_l358) begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1'd1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1'd1);
      end
    end
  end


endmodule

module JtagBridge (
  input  wire          io_jtag_tms,
  input  wire          io_jtag_tdi,
  output wire          io_jtag_tdo,
  input  wire          io_jtag_tck,
  output wire          io_remote_cmd_valid,
  input  wire          io_remote_cmd_ready,
  output wire          io_remote_cmd_payload_last,
  output wire [0:0]    io_remote_cmd_payload_fragment,
  input  wire          io_remote_rsp_valid,
  output wire          io_remote_rsp_ready,
  input  wire          io_remote_rsp_payload_error,
  input  wire [31:0]   io_remote_rsp_payload_data,
  input  wire          clk,
  input  wire          debugReset
);
  localparam JtagState_RESET = 4'd0;
  localparam JtagState_IDLE = 4'd1;
  localparam JtagState_IR_SELECT = 4'd2;
  localparam JtagState_IR_CAPTURE = 4'd3;
  localparam JtagState_IR_SHIFT = 4'd4;
  localparam JtagState_IR_EXIT1 = 4'd5;
  localparam JtagState_IR_PAUSE = 4'd6;
  localparam JtagState_IR_EXIT2 = 4'd7;
  localparam JtagState_IR_UPDATE = 4'd8;
  localparam JtagState_DR_SELECT = 4'd9;
  localparam JtagState_DR_CAPTURE = 4'd10;
  localparam JtagState_DR_SHIFT = 4'd11;
  localparam JtagState_DR_EXIT1 = 4'd12;
  localparam JtagState_DR_PAUSE = 4'd13;
  localparam JtagState_DR_EXIT2 = 4'd14;
  localparam JtagState_DR_UPDATE = 4'd15;

  wire                flowCCUnsafeByToggle_1_io_output_valid;
  wire                flowCCUnsafeByToggle_1_io_output_payload_last;
  wire       [0:0]    flowCCUnsafeByToggle_1_io_output_payload_fragment;
  wire       [3:0]    _zz_jtag_tap_isBypass;
  wire       [1:0]    _zz_jtag_tap_instructionShift;
  wire                system_cmd_valid;
  wire                system_cmd_payload_last;
  wire       [0:0]    system_cmd_payload_fragment;
  wire                system_cmd_toStream_valid;
  wire                system_cmd_toStream_ready;
  wire                system_cmd_toStream_payload_last;
  wire       [0:0]    system_cmd_toStream_payload_fragment;
  (* async_reg = "true" *) reg                 system_rsp_valid;
  (* async_reg = "true" *) reg                 system_rsp_payload_error;
  (* async_reg = "true" *) reg        [31:0]   system_rsp_payload_data;
  wire                io_remote_rsp_fire;
  reg        [3:0]    jtag_tap_fsm_stateNext;
  reg        [3:0]    jtag_tap_fsm_state;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_1;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_2;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_3;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_4;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_5;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_6;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_7;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_8;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_9;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_10;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_11;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_12;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_13;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_14;
  wire       [3:0]    _zz_jtag_tap_fsm_stateNext_15;
  reg        [3:0]    jtag_tap_instruction;
  reg        [3:0]    jtag_tap_instructionShift;
  reg                 jtag_tap_bypass;
  reg                 jtag_tap_tdoUnbufferd;
  reg                 jtag_tap_tdoDr;
  wire                jtag_tap_tdoIr;
  wire                jtag_tap_isBypass;
  reg                 jtag_tap_tdoUnbufferd_regNext;
  wire                jtag_idcodeArea_ctrl_tdi;
  wire                jtag_idcodeArea_ctrl_enable;
  wire                jtag_idcodeArea_ctrl_capture;
  wire                jtag_idcodeArea_ctrl_shift;
  wire                jtag_idcodeArea_ctrl_update;
  wire                jtag_idcodeArea_ctrl_reset;
  wire                jtag_idcodeArea_ctrl_tdo;
  reg        [31:0]   jtag_idcodeArea_shifter;
  wire                when_JtagTap_l121;
  wire                jtag_writeArea_ctrl_tdi;
  wire                jtag_writeArea_ctrl_enable;
  wire                jtag_writeArea_ctrl_capture;
  wire                jtag_writeArea_ctrl_shift;
  wire                jtag_writeArea_ctrl_update;
  wire                jtag_writeArea_ctrl_reset;
  wire                jtag_writeArea_ctrl_tdo;
  wire                jtag_writeArea_source_valid;
  wire                jtag_writeArea_source_payload_last;
  wire       [0:0]    jtag_writeArea_source_payload_fragment;
  reg                 jtag_writeArea_valid;
  reg                 jtag_writeArea_data;
  wire                jtag_readArea_ctrl_tdi;
  wire                jtag_readArea_ctrl_enable;
  wire                jtag_readArea_ctrl_capture;
  wire                jtag_readArea_ctrl_shift;
  wire                jtag_readArea_ctrl_update;
  wire                jtag_readArea_ctrl_reset;
  wire                jtag_readArea_ctrl_tdo;
  reg        [33:0]   jtag_readArea_full_shifter;
  `ifndef SYNTHESIS
  reg [79:0] jtag_tap_fsm_stateNext_string;
  reg [79:0] jtag_tap_fsm_state_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_1_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_2_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_3_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_4_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_5_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_6_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_7_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_8_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_9_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_10_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_11_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_12_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_13_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_14_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_15_string;
  `endif


  assign _zz_jtag_tap_isBypass = jtag_tap_instruction;
  assign _zz_jtag_tap_instructionShift = 2'b01;
  FlowCCUnsafeByToggle flowCCUnsafeByToggle_1 (
    .io_input_valid             (jtag_writeArea_source_valid                      ), //i
    .io_input_payload_last      (jtag_writeArea_source_payload_last               ), //i
    .io_input_payload_fragment  (jtag_writeArea_source_payload_fragment           ), //i
    .io_output_valid            (flowCCUnsafeByToggle_1_io_output_valid           ), //o
    .io_output_payload_last     (flowCCUnsafeByToggle_1_io_output_payload_last    ), //o
    .io_output_payload_fragment (flowCCUnsafeByToggle_1_io_output_payload_fragment), //o
    .io_jtag_tck                (io_jtag_tck                                      ), //i
    .clk                        (clk                                              ), //i
    .debugReset                 (debugReset                                       )  //i
  );
  initial begin
  `ifndef SYNTHESIS
    jtag_tap_fsm_state = {$urandom};
  `endif
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(jtag_tap_fsm_stateNext)
      JtagState_RESET : jtag_tap_fsm_stateNext_string = "RESET     ";
      JtagState_IDLE : jtag_tap_fsm_stateNext_string = "IDLE      ";
      JtagState_IR_SELECT : jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      JtagState_DR_SELECT : jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(jtag_tap_fsm_state)
      JtagState_RESET : jtag_tap_fsm_state_string = "RESET     ";
      JtagState_IDLE : jtag_tap_fsm_state_string = "IDLE      ";
      JtagState_IR_SELECT : jtag_tap_fsm_state_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : jtag_tap_fsm_state_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : jtag_tap_fsm_state_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : jtag_tap_fsm_state_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : jtag_tap_fsm_state_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : jtag_tap_fsm_state_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : jtag_tap_fsm_state_string = "IR_UPDATE ";
      JtagState_DR_SELECT : jtag_tap_fsm_state_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : jtag_tap_fsm_state_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : jtag_tap_fsm_state_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : jtag_tap_fsm_state_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : jtag_tap_fsm_state_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : jtag_tap_fsm_state_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : jtag_tap_fsm_state_string = "DR_UPDATE ";
      default : jtag_tap_fsm_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_1)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_1_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_1_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_1_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_1_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_1_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_1_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_1_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_1_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_1_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_1_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_1_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_1_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_1_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_1_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_1_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_1_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_1_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_2)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_2_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_2_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_2_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_2_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_2_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_2_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_2_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_2_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_2_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_2_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_2_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_2_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_2_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_2_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_2_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_2_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_2_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_3)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_3_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_3_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_3_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_3_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_3_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_3_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_3_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_3_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_3_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_3_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_3_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_3_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_3_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_3_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_3_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_3_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_3_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_4)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_4_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_4_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_4_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_4_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_4_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_4_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_4_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_4_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_4_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_4_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_4_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_4_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_4_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_4_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_4_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_4_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_4_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_5)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_5_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_5_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_5_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_5_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_5_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_5_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_5_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_5_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_5_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_5_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_5_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_5_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_5_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_5_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_5_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_5_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_5_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_6)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_6_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_6_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_6_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_6_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_6_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_6_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_6_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_6_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_6_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_6_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_6_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_6_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_6_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_6_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_6_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_6_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_6_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_7)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_7_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_7_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_7_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_7_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_7_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_7_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_7_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_7_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_7_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_7_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_7_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_7_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_7_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_7_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_7_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_7_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_7_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_8)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_8_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_8_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_8_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_8_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_8_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_8_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_8_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_8_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_8_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_8_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_8_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_8_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_8_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_8_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_8_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_8_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_8_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_9)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_9_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_9_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_9_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_9_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_9_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_9_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_9_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_9_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_9_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_9_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_9_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_9_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_9_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_9_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_9_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_9_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_9_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_10)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_10_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_10_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_10_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_10_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_10_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_10_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_10_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_10_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_10_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_10_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_10_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_10_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_10_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_10_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_10_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_10_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_10_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_11)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_11_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_11_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_11_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_11_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_11_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_11_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_11_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_11_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_11_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_11_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_11_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_11_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_11_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_11_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_11_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_11_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_11_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_12)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_12_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_12_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_12_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_12_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_12_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_12_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_12_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_12_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_12_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_12_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_12_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_12_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_12_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_12_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_12_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_12_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_12_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_13)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_13_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_13_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_13_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_13_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_13_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_13_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_13_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_13_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_13_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_13_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_13_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_13_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_13_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_13_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_13_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_13_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_13_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_14)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_14_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_14_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_14_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_14_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_14_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_14_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_14_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_14_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_14_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_14_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_14_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_14_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_14_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_14_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_14_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_14_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_14_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext_15)
      JtagState_RESET : _zz_jtag_tap_fsm_stateNext_15_string = "RESET     ";
      JtagState_IDLE : _zz_jtag_tap_fsm_stateNext_15_string = "IDLE      ";
      JtagState_IR_SELECT : _zz_jtag_tap_fsm_stateNext_15_string = "IR_SELECT ";
      JtagState_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_15_string = "IR_CAPTURE";
      JtagState_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_15_string = "IR_SHIFT  ";
      JtagState_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_15_string = "IR_EXIT1  ";
      JtagState_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_15_string = "IR_PAUSE  ";
      JtagState_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_15_string = "IR_EXIT2  ";
      JtagState_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_15_string = "IR_UPDATE ";
      JtagState_DR_SELECT : _zz_jtag_tap_fsm_stateNext_15_string = "DR_SELECT ";
      JtagState_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_15_string = "DR_CAPTURE";
      JtagState_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_15_string = "DR_SHIFT  ";
      JtagState_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_15_string = "DR_EXIT1  ";
      JtagState_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_15_string = "DR_PAUSE  ";
      JtagState_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_15_string = "DR_EXIT2  ";
      JtagState_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_15_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_15_string = "??????????";
    endcase
  end
  `endif

  assign system_cmd_toStream_valid = system_cmd_valid;
  assign system_cmd_toStream_payload_last = system_cmd_payload_last;
  assign system_cmd_toStream_payload_fragment = system_cmd_payload_fragment;
  assign io_remote_cmd_valid = system_cmd_toStream_valid;
  assign system_cmd_toStream_ready = io_remote_cmd_ready;
  assign io_remote_cmd_payload_last = system_cmd_toStream_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_toStream_payload_fragment;
  assign io_remote_rsp_fire = (io_remote_rsp_valid && io_remote_rsp_ready);
  assign io_remote_rsp_ready = 1'b1;
  assign _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? JtagState_RESET : JtagState_IDLE);
  always @(*) begin
    case(jtag_tap_fsm_state)
      JtagState_RESET : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext;
      end
      JtagState_IDLE : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_1;
      end
      JtagState_IR_SELECT : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_2;
      end
      JtagState_IR_CAPTURE : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_3;
      end
      JtagState_IR_SHIFT : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_4;
      end
      JtagState_IR_EXIT1 : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_5;
      end
      JtagState_IR_PAUSE : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_6;
      end
      JtagState_IR_EXIT2 : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_7;
      end
      JtagState_IR_UPDATE : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_8;
      end
      JtagState_DR_SELECT : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_9;
      end
      JtagState_DR_CAPTURE : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_10;
      end
      JtagState_DR_SHIFT : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_11;
      end
      JtagState_DR_EXIT1 : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_12;
      end
      JtagState_DR_PAUSE : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_13;
      end
      JtagState_DR_EXIT2 : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_14;
      end
      JtagState_DR_UPDATE : begin
        jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext_15;
      end
      default : begin
      end
    endcase
  end

  assign _zz_jtag_tap_fsm_stateNext_1 = (io_jtag_tms ? JtagState_DR_SELECT : JtagState_IDLE);
  assign _zz_jtag_tap_fsm_stateNext_2 = (io_jtag_tms ? JtagState_RESET : JtagState_IR_CAPTURE);
  assign _zz_jtag_tap_fsm_stateNext_3 = (io_jtag_tms ? JtagState_IR_EXIT1 : JtagState_IR_SHIFT);
  assign _zz_jtag_tap_fsm_stateNext_4 = (io_jtag_tms ? JtagState_IR_EXIT1 : JtagState_IR_SHIFT);
  assign _zz_jtag_tap_fsm_stateNext_5 = (io_jtag_tms ? JtagState_IR_UPDATE : JtagState_IR_PAUSE);
  assign _zz_jtag_tap_fsm_stateNext_6 = (io_jtag_tms ? JtagState_IR_EXIT2 : JtagState_IR_PAUSE);
  assign _zz_jtag_tap_fsm_stateNext_7 = (io_jtag_tms ? JtagState_IR_UPDATE : JtagState_IR_SHIFT);
  assign _zz_jtag_tap_fsm_stateNext_8 = (io_jtag_tms ? JtagState_DR_SELECT : JtagState_IDLE);
  assign _zz_jtag_tap_fsm_stateNext_9 = (io_jtag_tms ? JtagState_IR_SELECT : JtagState_DR_CAPTURE);
  assign _zz_jtag_tap_fsm_stateNext_10 = (io_jtag_tms ? JtagState_DR_EXIT1 : JtagState_DR_SHIFT);
  assign _zz_jtag_tap_fsm_stateNext_11 = (io_jtag_tms ? JtagState_DR_EXIT1 : JtagState_DR_SHIFT);
  assign _zz_jtag_tap_fsm_stateNext_12 = (io_jtag_tms ? JtagState_DR_UPDATE : JtagState_DR_PAUSE);
  assign _zz_jtag_tap_fsm_stateNext_13 = (io_jtag_tms ? JtagState_DR_EXIT2 : JtagState_DR_PAUSE);
  assign _zz_jtag_tap_fsm_stateNext_14 = (io_jtag_tms ? JtagState_DR_UPDATE : JtagState_DR_SHIFT);
  assign _zz_jtag_tap_fsm_stateNext_15 = (io_jtag_tms ? JtagState_DR_SELECT : JtagState_IDLE);
  always @(*) begin
    jtag_tap_tdoUnbufferd = jtag_tap_bypass;
    case(jtag_tap_fsm_state)
      JtagState_IR_SHIFT : begin
        jtag_tap_tdoUnbufferd = jtag_tap_tdoIr;
      end
      JtagState_DR_SHIFT : begin
        if(jtag_tap_isBypass) begin
          jtag_tap_tdoUnbufferd = jtag_tap_bypass;
        end else begin
          jtag_tap_tdoUnbufferd = jtag_tap_tdoDr;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    jtag_tap_tdoDr = 1'b0;
    if(jtag_idcodeArea_ctrl_enable) begin
      jtag_tap_tdoDr = jtag_idcodeArea_ctrl_tdo;
    end
    if(jtag_writeArea_ctrl_enable) begin
      jtag_tap_tdoDr = jtag_writeArea_ctrl_tdo;
    end
    if(jtag_readArea_ctrl_enable) begin
      jtag_tap_tdoDr = jtag_readArea_ctrl_tdo;
    end
  end

  assign jtag_tap_tdoIr = jtag_tap_instructionShift[0];
  assign jtag_tap_isBypass = ($signed(_zz_jtag_tap_isBypass) == $signed(4'b1111));
  assign io_jtag_tdo = jtag_tap_tdoUnbufferd_regNext;
  assign jtag_idcodeArea_ctrl_tdo = jtag_idcodeArea_shifter[0];
  assign jtag_idcodeArea_ctrl_tdi = io_jtag_tdi;
  assign jtag_idcodeArea_ctrl_enable = (jtag_tap_instruction == 4'b0001);
  assign jtag_idcodeArea_ctrl_capture = (jtag_tap_fsm_state == JtagState_DR_CAPTURE);
  assign jtag_idcodeArea_ctrl_shift = (jtag_tap_fsm_state == JtagState_DR_SHIFT);
  assign jtag_idcodeArea_ctrl_update = (jtag_tap_fsm_state == JtagState_DR_UPDATE);
  assign jtag_idcodeArea_ctrl_reset = (jtag_tap_fsm_state == JtagState_RESET);
  assign when_JtagTap_l121 = (jtag_tap_fsm_state == JtagState_RESET);
  assign jtag_writeArea_source_valid = jtag_writeArea_valid;
  assign jtag_writeArea_source_payload_last = (! (jtag_writeArea_ctrl_enable && jtag_writeArea_ctrl_shift));
  assign jtag_writeArea_source_payload_fragment[0] = jtag_writeArea_data;
  assign system_cmd_valid = flowCCUnsafeByToggle_1_io_output_valid;
  assign system_cmd_payload_last = flowCCUnsafeByToggle_1_io_output_payload_last;
  assign system_cmd_payload_fragment = flowCCUnsafeByToggle_1_io_output_payload_fragment;
  assign jtag_writeArea_ctrl_tdo = 1'b0;
  assign jtag_writeArea_ctrl_tdi = io_jtag_tdi;
  assign jtag_writeArea_ctrl_enable = (jtag_tap_instruction == 4'b0010);
  assign jtag_writeArea_ctrl_capture = (jtag_tap_fsm_state == JtagState_DR_CAPTURE);
  assign jtag_writeArea_ctrl_shift = (jtag_tap_fsm_state == JtagState_DR_SHIFT);
  assign jtag_writeArea_ctrl_update = (jtag_tap_fsm_state == JtagState_DR_UPDATE);
  assign jtag_writeArea_ctrl_reset = (jtag_tap_fsm_state == JtagState_RESET);
  assign jtag_readArea_ctrl_tdo = jtag_readArea_full_shifter[0];
  assign jtag_readArea_ctrl_tdi = io_jtag_tdi;
  assign jtag_readArea_ctrl_enable = (jtag_tap_instruction == 4'b0011);
  assign jtag_readArea_ctrl_capture = (jtag_tap_fsm_state == JtagState_DR_CAPTURE);
  assign jtag_readArea_ctrl_shift = (jtag_tap_fsm_state == JtagState_DR_SHIFT);
  assign jtag_readArea_ctrl_update = (jtag_tap_fsm_state == JtagState_DR_UPDATE);
  assign jtag_readArea_ctrl_reset = (jtag_tap_fsm_state == JtagState_RESET);
  always @(posedge clk) begin
    if(io_remote_cmd_valid) begin
      system_rsp_valid <= 1'b0;
    end
    if(io_remote_rsp_fire) begin
      system_rsp_valid <= 1'b1;
      system_rsp_payload_error <= io_remote_rsp_payload_error;
      system_rsp_payload_data <= io_remote_rsp_payload_data;
    end
  end

  always @(posedge io_jtag_tck) begin
    jtag_tap_fsm_state <= jtag_tap_fsm_stateNext;
    jtag_tap_bypass <= io_jtag_tdi;
    case(jtag_tap_fsm_state)
      JtagState_IR_CAPTURE : begin
        jtag_tap_instructionShift <= {2'd0, _zz_jtag_tap_instructionShift};
      end
      JtagState_IR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1'd1);
      end
      JtagState_IR_UPDATE : begin
        jtag_tap_instruction <= jtag_tap_instructionShift;
      end
      JtagState_DR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1'd1);
      end
      default : begin
      end
    endcase
    if(jtag_idcodeArea_ctrl_enable) begin
      if(jtag_idcodeArea_ctrl_shift) begin
        jtag_idcodeArea_shifter <= ({jtag_idcodeArea_ctrl_tdi,jtag_idcodeArea_shifter} >>> 1'd1);
      end
    end
    if(jtag_idcodeArea_ctrl_capture) begin
      jtag_idcodeArea_shifter <= 32'h10001fff;
    end
    if(when_JtagTap_l121) begin
      jtag_tap_instruction <= 4'b0001;
    end
    jtag_writeArea_valid <= (jtag_writeArea_ctrl_enable && jtag_writeArea_ctrl_shift);
    jtag_writeArea_data <= jtag_writeArea_ctrl_tdi;
    if(jtag_readArea_ctrl_enable) begin
      if(jtag_readArea_ctrl_capture) begin
        jtag_readArea_full_shifter <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if(jtag_readArea_ctrl_shift) begin
        jtag_readArea_full_shifter <= ({jtag_readArea_ctrl_tdi,jtag_readArea_full_shifter} >>> 1'd1);
      end
    end
  end

  always @(negedge io_jtag_tck) begin
    jtag_tap_tdoUnbufferd_regNext <= jtag_tap_tdoUnbufferd;
  end


endmodule

module DataCache (
  input  wire          io_cpu_execute_isValid,
  input  wire [31:0]   io_cpu_execute_address,
  output reg           io_cpu_execute_haltIt,
  input  wire          io_cpu_execute_args_wr,
  input  wire [1:0]    io_cpu_execute_args_size,
  input  wire          io_cpu_execute_args_isLrsc,
  input  wire          io_cpu_execute_args_isAmo,
  input  wire          io_cpu_execute_args_amoCtrl_swap,
  input  wire [2:0]    io_cpu_execute_args_amoCtrl_alu,
  input  wire          io_cpu_execute_args_totalyConsistent,
  output wire          io_cpu_execute_refilling,
  input  wire          io_cpu_memory_isValid,
  input  wire          io_cpu_memory_isStuck,
  output wire          io_cpu_memory_isWrite,
  input  wire [31:0]   io_cpu_memory_address,
  input  wire [31:0]   io_cpu_memory_mmuRsp_physicalAddress,
  input  wire          io_cpu_memory_mmuRsp_isIoAccess,
  input  wire          io_cpu_memory_mmuRsp_isPaging,
  input  wire          io_cpu_memory_mmuRsp_allowRead,
  input  wire          io_cpu_memory_mmuRsp_allowWrite,
  input  wire          io_cpu_memory_mmuRsp_allowExecute,
  input  wire          io_cpu_memory_mmuRsp_exception,
  input  wire          io_cpu_memory_mmuRsp_refilling,
  input  wire          io_cpu_memory_mmuRsp_bypassTranslation,
  input  wire          io_cpu_memory_mmuRsp_ways_0_sel,
  input  wire [31:0]   io_cpu_memory_mmuRsp_ways_0_physical,
  input  wire          io_cpu_memory_mmuRsp_ways_1_sel,
  input  wire [31:0]   io_cpu_memory_mmuRsp_ways_1_physical,
  input  wire          io_cpu_memory_mmuRsp_ways_2_sel,
  input  wire [31:0]   io_cpu_memory_mmuRsp_ways_2_physical,
  input  wire          io_cpu_memory_mmuRsp_ways_3_sel,
  input  wire [31:0]   io_cpu_memory_mmuRsp_ways_3_physical,
  input  wire          io_cpu_writeBack_isValid,
  input  wire          io_cpu_writeBack_isStuck,
  input  wire          io_cpu_writeBack_isFiring,
  input  wire          io_cpu_writeBack_isUser,
  output reg           io_cpu_writeBack_haltIt,
  output wire          io_cpu_writeBack_isWrite,
  input  wire [31:0]   io_cpu_writeBack_storeData,
  output reg  [31:0]   io_cpu_writeBack_data,
  input  wire [31:0]   io_cpu_writeBack_address,
  output wire          io_cpu_writeBack_mmuException,
  output wire          io_cpu_writeBack_unalignedAccess,
  output reg           io_cpu_writeBack_accessError,
  output wire          io_cpu_writeBack_keepMemRspData,
  input  wire          io_cpu_writeBack_fence_SW,
  input  wire          io_cpu_writeBack_fence_SR,
  input  wire          io_cpu_writeBack_fence_SO,
  input  wire          io_cpu_writeBack_fence_SI,
  input  wire          io_cpu_writeBack_fence_PW,
  input  wire          io_cpu_writeBack_fence_PR,
  input  wire          io_cpu_writeBack_fence_PO,
  input  wire          io_cpu_writeBack_fence_PI,
  input  wire [3:0]    io_cpu_writeBack_fence_FM,
  output wire          io_cpu_writeBack_exclusiveOk,
  output reg           io_cpu_redo,
  input  wire          io_cpu_flush_valid,
  output wire          io_cpu_flush_ready,
  input  wire          io_cpu_flush_payload_singleLine,
  input  wire [6:0]    io_cpu_flush_payload_lineId,
  output wire          io_cpu_writesPending,
  output reg           io_mem_cmd_valid,
  input  wire          io_mem_cmd_ready,
  output reg           io_mem_cmd_payload_wr,
  output wire          io_mem_cmd_payload_uncached,
  output reg  [31:0]   io_mem_cmd_payload_address,
  output wire [31:0]   io_mem_cmd_payload_data,
  output wire [3:0]    io_mem_cmd_payload_mask,
  output reg  [2:0]    io_mem_cmd_payload_size,
  output wire          io_mem_cmd_payload_last,
  input  wire          io_mem_rsp_valid,
  input  wire          io_mem_rsp_payload_last,
  input  wire [31:0]   io_mem_rsp_payload_data,
  input  wire          io_mem_rsp_payload_error,
  input  wire          clk,
  input  wire          reset
);

  reg        [21:0]   ways_0_tags_spinal_port0;
  reg        [31:0]   ways_0_data_spinal_port0;
  wire       [21:0]   _zz_ways_0_tags_port;
  wire       [31:0]   _zz_stageB_amo_addSub;
  wire       [31:0]   _zz_stageB_amo_addSub_1;
  wire       [31:0]   _zz_stageB_amo_addSub_2;
  wire       [31:0]   _zz_stageB_amo_addSub_3;
  wire       [31:0]   _zz_stageB_amo_addSub_4;
  wire       [1:0]    _zz_stageB_amo_addSub_5;
  wire       [0:0]    _zz_when;
  wire       [2:0]    _zz_loader_counter_valueNext;
  wire       [0:0]    _zz_loader_counter_valueNext_1;
  wire       [1:0]    _zz_loader_waysAllocator;
  reg                 _zz_1;
  reg                 _zz_2;
  wire                haltCpu;
  reg                 tagsReadCmd_valid;
  reg        [6:0]    tagsReadCmd_payload;
  reg                 tagsWriteCmd_valid;
  reg        [0:0]    tagsWriteCmd_payload_way;
  reg        [6:0]    tagsWriteCmd_payload_address;
  reg                 tagsWriteCmd_payload_data_valid;
  reg                 tagsWriteCmd_payload_data_error;
  reg        [19:0]   tagsWriteCmd_payload_data_address;
  reg                 tagsWriteLastCmd_valid;
  reg        [0:0]    tagsWriteLastCmd_payload_way;
  reg        [6:0]    tagsWriteLastCmd_payload_address;
  reg                 tagsWriteLastCmd_payload_data_valid;
  reg                 tagsWriteLastCmd_payload_data_error;
  reg        [19:0]   tagsWriteLastCmd_payload_data_address;
  reg                 dataReadCmd_valid;
  reg        [9:0]    dataReadCmd_payload;
  reg                 dataWriteCmd_valid;
  reg        [0:0]    dataWriteCmd_payload_way;
  reg        [9:0]    dataWriteCmd_payload_address;
  reg        [31:0]   dataWriteCmd_payload_data;
  reg        [3:0]    dataWriteCmd_payload_mask;
  wire                _zz_ways_0_tagsReadRsp_valid;
  wire                ways_0_tagsReadRsp_valid;
  wire                ways_0_tagsReadRsp_error;
  wire       [19:0]   ways_0_tagsReadRsp_address;
  wire       [21:0]   _zz_ways_0_tagsReadRsp_valid_1;
  wire                _zz_ways_0_dataReadRspMem;
  wire       [31:0]   ways_0_dataReadRspMem;
  wire       [31:0]   ways_0_dataReadRsp;
  wire                when_DataCache_l646;
  wire                when_DataCache_l649;
  wire                when_DataCache_l668;
  wire                rspSync;
  wire                rspLast;
  reg                 memCmdSent;
  wire                io_mem_cmd_fire;
  wire                when_DataCache_l690;
  reg        [3:0]    _zz_stage0_mask;
  wire       [3:0]    stage0_mask;
  wire       [0:0]    stage0_dataColisions;
  wire       [0:0]    stage0_wayInvalidate;
  wire                when_DataCache_l777;
  reg                 stageA_request_wr;
  reg        [1:0]    stageA_request_size;
  reg                 stageA_request_isLrsc;
  reg                 stageA_request_isAmo;
  reg                 stageA_request_amoCtrl_swap;
  reg        [2:0]    stageA_request_amoCtrl_alu;
  reg                 stageA_request_totalyConsistent;
  wire                when_DataCache_l777_1;
  reg        [3:0]    stageA_mask;
  wire       [0:0]    stageA_wayHits;
  wire                when_DataCache_l777_2;
  reg        [0:0]    stageA_wayInvalidate;
  wire                when_DataCache_l777_3;
  reg        [0:0]    stage0_dataColisions_regNextWhen;
  wire       [0:0]    _zz_stageA_dataColisions;
  wire       [0:0]    stageA_dataColisions;
  wire                when_DataCache_l828;
  reg                 stageB_request_wr;
  reg        [1:0]    stageB_request_size;
  reg                 stageB_request_isLrsc;
  reg                 stageB_request_isAmo;
  reg                 stageB_request_amoCtrl_swap;
  reg        [2:0]    stageB_request_amoCtrl_alu;
  reg                 stageB_request_totalyConsistent;
  reg                 stageB_mmuRspFreeze;
  wire                when_DataCache_l830;
  reg        [31:0]   stageB_mmuRsp_physicalAddress;
  reg                 stageB_mmuRsp_isIoAccess;
  reg                 stageB_mmuRsp_isPaging;
  reg                 stageB_mmuRsp_allowRead;
  reg                 stageB_mmuRsp_allowWrite;
  reg                 stageB_mmuRsp_allowExecute;
  reg                 stageB_mmuRsp_exception;
  reg                 stageB_mmuRsp_refilling;
  reg                 stageB_mmuRsp_bypassTranslation;
  reg                 stageB_mmuRsp_ways_0_sel;
  reg        [31:0]   stageB_mmuRsp_ways_0_physical;
  reg                 stageB_mmuRsp_ways_1_sel;
  reg        [31:0]   stageB_mmuRsp_ways_1_physical;
  reg                 stageB_mmuRsp_ways_2_sel;
  reg        [31:0]   stageB_mmuRsp_ways_2_physical;
  reg                 stageB_mmuRsp_ways_3_sel;
  reg        [31:0]   stageB_mmuRsp_ways_3_physical;
  wire                when_DataCache_l827;
  reg                 stageB_tagsReadRsp_0_valid;
  reg                 stageB_tagsReadRsp_0_error;
  reg        [19:0]   stageB_tagsReadRsp_0_address;
  wire                when_DataCache_l827_1;
  reg        [31:0]   stageB_dataReadRsp_0;
  wire                when_DataCache_l826;
  reg        [0:0]    stageB_wayInvalidate;
  wire                stageB_consistancyHazard;
  wire                when_DataCache_l826_1;
  reg        [0:0]    stageB_dataColisions;
  wire                when_DataCache_l826_2;
  reg                 stageB_unaligned;
  wire                when_DataCache_l826_3;
  reg        [0:0]    stageB_waysHitsBeforeInvalidate;
  wire       [0:0]    stageB_waysHits;
  wire                stageB_waysHit;
  wire       [31:0]   stageB_dataMux;
  wire                when_DataCache_l826_4;
  reg        [3:0]    stageB_mask;
  reg                 stageB_loaderValid;
  wire       [31:0]   stageB_ioMemRspMuxed;
  reg                 stageB_flusher_waitDone;
  wire                stageB_flusher_hold;
  reg        [7:0]    stageB_flusher_counter;
  wire                when_DataCache_l856;
  wire                when_DataCache_l862;
  wire                when_DataCache_l864;
  reg                 stageB_flusher_start;
  wire                when_DataCache_l878;
  reg                 stageB_lrSc_reserved;
  wire                when_DataCache_l886;
  wire                stageB_isExternalLsrc;
  wire                stageB_isExternalAmo;
  reg        [31:0]   stageB_requestDataBypass;
  wire                stageB_amo_compare;
  wire                stageB_amo_unsigned;
  wire       [31:0]   stageB_amo_addSub;
  wire                stageB_amo_less;
  wire                stageB_amo_selectRf;
  wire       [2:0]    switch_Misc_l245;
  reg        [31:0]   stageB_amo_result;
  reg        [31:0]   stageB_amo_resultReg;
  reg                 stageB_amo_internal_resultRegValid;
  reg                 stageB_cpuWriteToCache;
  wire                when_DataCache_l932;
  wire                stageB_badPermissions;
  wire                stageB_loadStoreFault;
  wire                stageB_bypassCache;
  wire                when_DataCache_l1001;
  wire                when_DataCache_l1005;
  wire                when_DataCache_l1010;
  wire                when_DataCache_l1015;
  wire                when_DataCache_l1018;
  wire                when_DataCache_l1026;
  wire                when_DataCache_l1031;
  wire                when_DataCache_l1038;
  wire                when_DataCache_l997;
  wire                when_DataCache_l1073;
  wire                when_DataCache_l1082;
  reg                 loader_valid;
  reg                 loader_counter_willIncrement;
  wire                loader_counter_willClear;
  reg        [2:0]    loader_counter_valueNext;
  reg        [2:0]    loader_counter_value;
  wire                loader_counter_willOverflowIfInc;
  wire                loader_counter_willOverflow;
  reg        [0:0]    loader_waysAllocator;
  reg                 loader_error;
  wire                loader_kill;
  reg                 loader_killReg;
  wire                when_DataCache_l1098;
  wire                loader_done;
  wire                when_DataCache_l1126;
  reg                 loader_valid_regNext;
  wire                when_DataCache_l1130;
  wire                when_DataCache_l1133;
  reg [21:0] ways_0_tags [0:127];
  reg [7:0] ways_0_data_symbol0 [0:1023];
  reg [7:0] ways_0_data_symbol1 [0:1023];
  reg [7:0] ways_0_data_symbol2 [0:1023];
  reg [7:0] ways_0_data_symbol3 [0:1023];
  reg [7:0] _zz_ways_0_datasymbol_read;
  reg [7:0] _zz_ways_0_datasymbol_read_1;
  reg [7:0] _zz_ways_0_datasymbol_read_2;
  reg [7:0] _zz_ways_0_datasymbol_read_3;

  assign _zz_stageB_amo_addSub = ($signed(_zz_stageB_amo_addSub_1) + $signed(_zz_stageB_amo_addSub_4));
  assign _zz_stageB_amo_addSub_1 = ($signed(_zz_stageB_amo_addSub_2) + $signed(_zz_stageB_amo_addSub_3));
  assign _zz_stageB_amo_addSub_2 = io_cpu_writeBack_storeData[31 : 0];
  assign _zz_stageB_amo_addSub_3 = (stageB_amo_compare ? (~ stageB_dataMux[31 : 0]) : stageB_dataMux[31 : 0]);
  assign _zz_stageB_amo_addSub_5 = (stageB_amo_compare ? 2'b01 : 2'b00);
  assign _zz_stageB_amo_addSub_4 = {{30{_zz_stageB_amo_addSub_5[1]}}, _zz_stageB_amo_addSub_5};
  assign _zz_when = 1'b1;
  assign _zz_loader_counter_valueNext_1 = loader_counter_willIncrement;
  assign _zz_loader_counter_valueNext = {2'd0, _zz_loader_counter_valueNext_1};
  assign _zz_loader_waysAllocator = {loader_waysAllocator,loader_waysAllocator[0]};
  assign _zz_ways_0_tags_port = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_error,tagsWriteCmd_payload_data_valid}};
  always @(posedge clk) begin
    if(_zz_ways_0_tagsReadRsp_valid) begin
      ways_0_tags_spinal_port0 <= ways_0_tags[tagsReadCmd_payload];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[tagsWriteCmd_payload_address] <= _zz_ways_0_tags_port;
    end
  end

  always @(*) begin
    ways_0_data_spinal_port0 = {_zz_ways_0_datasymbol_read_3, _zz_ways_0_datasymbol_read_2, _zz_ways_0_datasymbol_read_1, _zz_ways_0_datasymbol_read};
  end
  always @(posedge clk) begin
    if(_zz_ways_0_dataReadRspMem) begin
      _zz_ways_0_datasymbol_read <= ways_0_data_symbol0[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_1 <= ways_0_data_symbol1[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_2 <= ways_0_data_symbol2[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_3 <= ways_0_data_symbol3[dataReadCmd_payload];
    end
  end

  always @(posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_1) begin
      ways_0_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_1) begin
      ways_0_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_1) begin
      ways_0_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_1) begin
      ways_0_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(when_DataCache_l649) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(when_DataCache_l646) begin
      _zz_2 = 1'b1;
    end
  end

  assign haltCpu = 1'b0;
  assign _zz_ways_0_tagsReadRsp_valid = (tagsReadCmd_valid && (! io_cpu_memory_isStuck));
  assign _zz_ways_0_tagsReadRsp_valid_1 = ways_0_tags_spinal_port0;
  assign ways_0_tagsReadRsp_valid = _zz_ways_0_tagsReadRsp_valid_1[0];
  assign ways_0_tagsReadRsp_error = _zz_ways_0_tagsReadRsp_valid_1[1];
  assign ways_0_tagsReadRsp_address = _zz_ways_0_tagsReadRsp_valid_1[21 : 2];
  assign _zz_ways_0_dataReadRspMem = (dataReadCmd_valid && (! io_cpu_memory_isStuck));
  assign ways_0_dataReadRspMem = ways_0_data_spinal_port0;
  assign ways_0_dataReadRsp = ways_0_dataReadRspMem[31 : 0];
  assign when_DataCache_l646 = (tagsWriteCmd_valid && tagsWriteCmd_payload_way[0]);
  assign when_DataCache_l649 = (dataWriteCmd_valid && dataWriteCmd_payload_way[0]);
  always @(*) begin
    tagsReadCmd_valid = 1'b0;
    if(when_DataCache_l668) begin
      tagsReadCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    tagsReadCmd_payload = 7'bxxxxxxx;
    if(when_DataCache_l668) begin
      tagsReadCmd_payload = io_cpu_execute_address[11 : 5];
    end
  end

  always @(*) begin
    dataReadCmd_valid = 1'b0;
    if(when_DataCache_l668) begin
      dataReadCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    dataReadCmd_payload = 10'bxxxxxxxxxx;
    if(when_DataCache_l668) begin
      dataReadCmd_payload = io_cpu_execute_address[11 : 2];
    end
  end

  always @(*) begin
    tagsWriteCmd_valid = 1'b0;
    if(when_DataCache_l856) begin
      tagsWriteCmd_valid = 1'b1;
    end
    if(io_cpu_writeBack_isValid) begin
      if(when_DataCache_l1073) begin
        tagsWriteCmd_valid = 1'b0;
      end
    end
    if(loader_done) begin
      tagsWriteCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_way = 1'bx;
    if(when_DataCache_l856) begin
      tagsWriteCmd_payload_way = 1'b1;
    end
    if(loader_done) begin
      tagsWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_address = 7'bxxxxxxx;
    if(when_DataCache_l856) begin
      tagsWriteCmd_payload_address = stageB_flusher_counter[6:0];
    end
    if(loader_done) begin
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_valid = 1'bx;
    if(when_DataCache_l856) begin
      tagsWriteCmd_payload_data_valid = 1'b0;
    end
    if(loader_done) begin
      tagsWriteCmd_payload_data_valid = (! (loader_kill || loader_killReg));
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_error = 1'bx;
    if(loader_done) begin
      tagsWriteCmd_payload_data_error = (loader_error || (io_mem_rsp_valid && io_mem_rsp_payload_error));
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_address = 20'bxxxxxxxxxxxxxxxxxxxx;
    if(loader_done) begin
      tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31 : 12];
    end
  end

  always @(*) begin
    dataWriteCmd_valid = 1'b0;
    if(stageB_cpuWriteToCache) begin
      if(when_DataCache_l932) begin
        dataWriteCmd_valid = 1'b1;
      end
    end
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l997) begin
          if(when_DataCache_l1010) begin
            if(stageB_request_isAmo) begin
              if(when_DataCache_l1018) begin
                dataWriteCmd_valid = 1'b0;
              end
            end
            if(when_DataCache_l1031) begin
              dataWriteCmd_valid = 1'b0;
            end
          end
        end
      end
    end
    if(io_cpu_writeBack_isValid) begin
      if(when_DataCache_l1073) begin
        dataWriteCmd_valid = 1'b0;
      end
    end
    if(when_DataCache_l1098) begin
      dataWriteCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_way = 1'bx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_way = stageB_waysHits;
    end
    if(when_DataCache_l1098) begin
      dataWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_address = 10'bxxxxxxxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 2];
    end
    if(when_DataCache_l1098) begin
      dataWriteCmd_payload_address = {stageB_mmuRsp_physicalAddress[11 : 5],loader_counter_value};
    end
  end

  always @(*) begin
    dataWriteCmd_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_data[31 : 0] = stageB_requestDataBypass;
    end
    if(when_DataCache_l1098) begin
      dataWriteCmd_payload_data = io_mem_rsp_payload_data;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_mask = 4'bxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_mask = 4'b0000;
      if(_zz_when[0]) begin
        dataWriteCmd_payload_mask[3 : 0] = stageB_mask;
      end
    end
    if(when_DataCache_l1098) begin
      dataWriteCmd_payload_mask = 4'b1111;
    end
  end

  assign when_DataCache_l668 = (io_cpu_execute_isValid && (! io_cpu_memory_isStuck));
  always @(*) begin
    io_cpu_execute_haltIt = 1'b0;
    if(when_DataCache_l856) begin
      io_cpu_execute_haltIt = 1'b1;
    end
  end

  assign rspSync = 1'b1;
  assign rspLast = 1'b1;
  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready);
  assign when_DataCache_l690 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    _zz_stage0_mask = 4'bxxxx;
    case(io_cpu_execute_args_size)
      2'b00 : begin
        _zz_stage0_mask = 4'b0001;
      end
      2'b01 : begin
        _zz_stage0_mask = 4'b0011;
      end
      2'b10 : begin
        _zz_stage0_mask = 4'b1111;
      end
      default : begin
      end
    endcase
  end

  assign stage0_mask = (_zz_stage0_mask <<< io_cpu_execute_address[1 : 0]);
  assign stage0_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == io_cpu_execute_address[11 : 2])) && ((stage0_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000));
  assign stage0_wayInvalidate = 1'b0;
  assign when_DataCache_l777 = (! io_cpu_memory_isStuck);
  assign when_DataCache_l777_1 = (! io_cpu_memory_isStuck);
  assign io_cpu_memory_isWrite = stageA_request_wr;
  assign stageA_wayHits = ((io_cpu_memory_mmuRsp_physicalAddress[31 : 12] == ways_0_tagsReadRsp_address) && ways_0_tagsReadRsp_valid);
  assign when_DataCache_l777_2 = (! io_cpu_memory_isStuck);
  assign when_DataCache_l777_3 = (! io_cpu_memory_isStuck);
  assign _zz_stageA_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == io_cpu_memory_address[11 : 2])) && ((stageA_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000));
  assign stageA_dataColisions = (stage0_dataColisions_regNextWhen | _zz_stageA_dataColisions);
  assign when_DataCache_l828 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    stageB_mmuRspFreeze = 1'b0;
    if(when_DataCache_l1133) begin
      stageB_mmuRspFreeze = 1'b1;
    end
  end

  assign when_DataCache_l830 = ((! io_cpu_writeBack_isStuck) && (! stageB_mmuRspFreeze));
  assign when_DataCache_l827 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l827_1 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l826 = (! io_cpu_writeBack_isStuck);
  assign stageB_consistancyHazard = 1'b0;
  assign when_DataCache_l826_1 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l826_2 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l826_3 = (! io_cpu_writeBack_isStuck);
  assign stageB_waysHits = (stageB_waysHitsBeforeInvalidate & (~ stageB_wayInvalidate));
  assign stageB_waysHit = (|stageB_waysHits);
  assign stageB_dataMux = stageB_dataReadRsp_0;
  assign when_DataCache_l826_4 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    stageB_loaderValid = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l997) begin
          if(!when_DataCache_l1010) begin
            if(io_mem_cmd_ready) begin
              stageB_loaderValid = 1'b1;
            end
          end
        end
      end
    end
    if(io_cpu_writeBack_isValid) begin
      if(when_DataCache_l1073) begin
        stageB_loaderValid = 1'b0;
      end
    end
  end

  assign stageB_ioMemRspMuxed = io_mem_rsp_payload_data[31 : 0];
  always @(*) begin
    io_cpu_writeBack_haltIt = 1'b1;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l997) begin
          if(when_DataCache_l1001) begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
          if(when_DataCache_l1005) begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
        end else begin
          if(when_DataCache_l1010) begin
            if(when_DataCache_l1015) begin
              io_cpu_writeBack_haltIt = 1'b0;
            end
            if(stageB_request_isAmo) begin
              if(when_DataCache_l1018) begin
                io_cpu_writeBack_haltIt = 1'b1;
              end
            end
            if(when_DataCache_l1031) begin
              io_cpu_writeBack_haltIt = 1'b0;
            end
          end
        end
      end
    end
    if(io_cpu_writeBack_isValid) begin
      if(when_DataCache_l1073) begin
        io_cpu_writeBack_haltIt = 1'b0;
      end
    end
  end

  assign stageB_flusher_hold = 1'b0;
  assign when_DataCache_l856 = (! stageB_flusher_counter[7]);
  assign when_DataCache_l862 = (! stageB_flusher_hold);
  assign when_DataCache_l864 = (io_cpu_flush_valid && io_cpu_flush_payload_singleLine);
  assign io_cpu_flush_ready = (stageB_flusher_waitDone && stageB_flusher_counter[7]);
  assign when_DataCache_l878 = (io_cpu_flush_valid && io_cpu_flush_payload_singleLine);
  assign when_DataCache_l886 = (io_cpu_writeBack_isValid && io_cpu_writeBack_isFiring);
  assign stageB_isExternalLsrc = 1'b0;
  assign stageB_isExternalAmo = 1'b0;
  always @(*) begin
    stageB_requestDataBypass = io_cpu_writeBack_storeData;
    if(stageB_request_isAmo) begin
      stageB_requestDataBypass[31 : 0] = stageB_amo_resultReg;
    end
  end

  assign stageB_amo_compare = stageB_request_amoCtrl_alu[2];
  assign stageB_amo_unsigned = (stageB_request_amoCtrl_alu[2 : 1] == 2'b11);
  assign stageB_amo_addSub = _zz_stageB_amo_addSub;
  assign stageB_amo_less = ((io_cpu_writeBack_storeData[31] == stageB_dataMux[31]) ? stageB_amo_addSub[31] : (stageB_amo_unsigned ? stageB_dataMux[31] : io_cpu_writeBack_storeData[31]));
  assign stageB_amo_selectRf = (stageB_request_amoCtrl_swap ? 1'b1 : (stageB_request_amoCtrl_alu[0] ^ stageB_amo_less));
  assign switch_Misc_l245 = (stageB_request_amoCtrl_alu | {stageB_request_amoCtrl_swap,2'b00});
  always @(*) begin
    case(switch_Misc_l245)
      3'b000 : begin
        stageB_amo_result = stageB_amo_addSub;
      end
      3'b001 : begin
        stageB_amo_result = (io_cpu_writeBack_storeData[31 : 0] ^ stageB_dataMux[31 : 0]);
      end
      3'b010 : begin
        stageB_amo_result = (io_cpu_writeBack_storeData[31 : 0] | stageB_dataMux[31 : 0]);
      end
      3'b011 : begin
        stageB_amo_result = (io_cpu_writeBack_storeData[31 : 0] & stageB_dataMux[31 : 0]);
      end
      default : begin
        stageB_amo_result = (stageB_amo_selectRf ? io_cpu_writeBack_storeData[31 : 0] : stageB_dataMux[31 : 0]);
      end
    endcase
  end

  always @(*) begin
    stageB_cpuWriteToCache = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l997) begin
          if(when_DataCache_l1010) begin
            stageB_cpuWriteToCache = 1'b1;
          end
        end
      end
    end
  end

  assign when_DataCache_l932 = (stageB_request_wr && stageB_waysHit);
  assign stageB_badPermissions = (((! stageB_mmuRsp_allowWrite) && stageB_request_wr) || ((! stageB_mmuRsp_allowRead) && ((! stageB_request_wr) || stageB_request_isAmo)));
  assign stageB_loadStoreFault = (io_cpu_writeBack_isValid && (stageB_mmuRsp_exception || stageB_badPermissions));
  always @(*) begin
    io_cpu_redo = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l997) begin
          if(when_DataCache_l1010) begin
            if(when_DataCache_l1026) begin
              io_cpu_redo = 1'b1;
            end
          end
        end
      end
    end
    if(io_cpu_writeBack_isValid) begin
      if(when_DataCache_l1082) begin
        io_cpu_redo = 1'b1;
      end
    end
    if(when_DataCache_l1130) begin
      io_cpu_redo = 1'b1;
    end
  end

  always @(*) begin
    io_cpu_writeBack_accessError = 1'b0;
    if(stageB_bypassCache) begin
      io_cpu_writeBack_accessError = ((((! stageB_request_wr) && 1'b1) && io_mem_rsp_valid) && io_mem_rsp_payload_error);
    end else begin
      io_cpu_writeBack_accessError = (((stageB_waysHits & stageB_tagsReadRsp_0_error) != 1'b0) || (stageB_loadStoreFault && (! stageB_mmuRsp_isPaging)));
    end
  end

  assign io_cpu_writeBack_mmuException = (stageB_loadStoreFault && stageB_mmuRsp_isPaging);
  assign io_cpu_writeBack_unalignedAccess = (io_cpu_writeBack_isValid && stageB_unaligned);
  assign io_cpu_writeBack_isWrite = stageB_request_wr;
  always @(*) begin
    io_mem_cmd_valid = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l997) begin
          io_mem_cmd_valid = (! memCmdSent);
          if(when_DataCache_l1005) begin
            io_mem_cmd_valid = 1'b0;
          end
        end else begin
          if(when_DataCache_l1010) begin
            if(stageB_request_wr) begin
              io_mem_cmd_valid = 1'b1;
            end
            if(stageB_request_isAmo) begin
              if(when_DataCache_l1018) begin
                io_mem_cmd_valid = 1'b0;
              end
            end
            if(when_DataCache_l1026) begin
              io_mem_cmd_valid = 1'b0;
            end
            if(when_DataCache_l1031) begin
              io_mem_cmd_valid = 1'b0;
            end
          end else begin
            if(when_DataCache_l1038) begin
              io_mem_cmd_valid = 1'b1;
            end
          end
        end
      end
    end
    if(io_cpu_writeBack_isValid) begin
      if(when_DataCache_l1073) begin
        io_mem_cmd_valid = 1'b0;
      end
    end
  end

  always @(*) begin
    io_mem_cmd_payload_address = stageB_mmuRsp_physicalAddress;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l997) begin
          if(!when_DataCache_l1010) begin
            io_mem_cmd_payload_address[4 : 0] = 5'h0;
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_last = 1'b1;
  always @(*) begin
    io_mem_cmd_payload_wr = stageB_request_wr;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l997) begin
          if(!when_DataCache_l1010) begin
            io_mem_cmd_payload_wr = 1'b0;
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_mask = stageB_mask;
  assign io_mem_cmd_payload_data = stageB_requestDataBypass;
  assign io_mem_cmd_payload_uncached = stageB_mmuRsp_isIoAccess;
  always @(*) begin
    io_mem_cmd_payload_size = {1'd0, stageB_request_size};
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l997) begin
          if(!when_DataCache_l1010) begin
            io_mem_cmd_payload_size = 3'b101;
          end
        end
      end
    end
  end

  assign stageB_bypassCache = ((stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc) || stageB_isExternalAmo);
  assign io_cpu_writeBack_keepMemRspData = 1'b0;
  assign when_DataCache_l1001 = ((! stageB_request_wr) ? (io_mem_rsp_valid && rspSync) : io_mem_cmd_ready);
  assign when_DataCache_l1005 = (stageB_request_isLrsc && (! stageB_lrSc_reserved));
  assign when_DataCache_l1010 = (stageB_waysHit || (stageB_request_wr && (! stageB_request_isAmo)));
  assign when_DataCache_l1015 = ((! stageB_request_wr) || io_mem_cmd_ready);
  assign when_DataCache_l1018 = (! stageB_amo_internal_resultRegValid);
  assign when_DataCache_l1026 = (((! stageB_request_wr) || stageB_request_isAmo) && ((stageB_dataColisions & stageB_waysHits) != 1'b0));
  assign when_DataCache_l1031 = (stageB_request_isLrsc && (! stageB_lrSc_reserved));
  assign when_DataCache_l1038 = (! memCmdSent);
  assign when_DataCache_l997 = (stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc);
  always @(*) begin
    if(stageB_bypassCache) begin
      io_cpu_writeBack_data = stageB_ioMemRspMuxed;
    end else begin
      io_cpu_writeBack_data = stageB_dataMux;
    end
  end

  assign io_cpu_writeBack_exclusiveOk = stageB_lrSc_reserved;
  assign when_DataCache_l1073 = ((((stageB_consistancyHazard || stageB_mmuRsp_refilling) || io_cpu_writeBack_accessError) || io_cpu_writeBack_mmuException) || io_cpu_writeBack_unalignedAccess);
  assign when_DataCache_l1082 = (stageB_mmuRsp_refilling || stageB_consistancyHazard);
  always @(*) begin
    loader_counter_willIncrement = 1'b0;
    if(when_DataCache_l1098) begin
      loader_counter_willIncrement = 1'b1;
    end
  end

  assign loader_counter_willClear = 1'b0;
  assign loader_counter_willOverflowIfInc = (loader_counter_value == 3'b111);
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement);
  always @(*) begin
    loader_counter_valueNext = (loader_counter_value + _zz_loader_counter_valueNext);
    if(loader_counter_willClear) begin
      loader_counter_valueNext = 3'b000;
    end
  end

  assign loader_kill = 1'b0;
  assign when_DataCache_l1098 = ((loader_valid && io_mem_rsp_valid) && rspLast);
  assign loader_done = loader_counter_willOverflow;
  assign when_DataCache_l1126 = (! loader_valid);
  assign when_DataCache_l1130 = (loader_valid && (! loader_valid_regNext));
  assign io_cpu_execute_refilling = loader_valid;
  assign when_DataCache_l1133 = (stageB_loaderValid || loader_valid);
  always @(posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
    tagsWriteLastCmd_payload_way <= tagsWriteCmd_payload_way;
    tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
    tagsWriteLastCmd_payload_data_valid <= tagsWriteCmd_payload_data_valid;
    tagsWriteLastCmd_payload_data_error <= tagsWriteCmd_payload_data_error;
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
    if(when_DataCache_l777) begin
      stageA_request_wr <= io_cpu_execute_args_wr;
      stageA_request_size <= io_cpu_execute_args_size;
      stageA_request_isLrsc <= io_cpu_execute_args_isLrsc;
      stageA_request_isAmo <= io_cpu_execute_args_isAmo;
      stageA_request_amoCtrl_swap <= io_cpu_execute_args_amoCtrl_swap;
      stageA_request_amoCtrl_alu <= io_cpu_execute_args_amoCtrl_alu;
      stageA_request_totalyConsistent <= io_cpu_execute_args_totalyConsistent;
    end
    if(when_DataCache_l777_1) begin
      stageA_mask <= stage0_mask;
    end
    if(when_DataCache_l777_2) begin
      stageA_wayInvalidate <= stage0_wayInvalidate;
    end
    if(when_DataCache_l777_3) begin
      stage0_dataColisions_regNextWhen <= stage0_dataColisions;
    end
    if(when_DataCache_l828) begin
      stageB_request_wr <= stageA_request_wr;
      stageB_request_size <= stageA_request_size;
      stageB_request_isLrsc <= stageA_request_isLrsc;
      stageB_request_isAmo <= stageA_request_isAmo;
      stageB_request_amoCtrl_swap <= stageA_request_amoCtrl_swap;
      stageB_request_amoCtrl_alu <= stageA_request_amoCtrl_alu;
      stageB_request_totalyConsistent <= stageA_request_totalyConsistent;
    end
    if(when_DataCache_l830) begin
      stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuRsp_physicalAddress;
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuRsp_isIoAccess;
      stageB_mmuRsp_isPaging <= io_cpu_memory_mmuRsp_isPaging;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuRsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuRsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuRsp_allowExecute;
      stageB_mmuRsp_exception <= io_cpu_memory_mmuRsp_exception;
      stageB_mmuRsp_refilling <= io_cpu_memory_mmuRsp_refilling;
      stageB_mmuRsp_bypassTranslation <= io_cpu_memory_mmuRsp_bypassTranslation;
      stageB_mmuRsp_ways_0_sel <= io_cpu_memory_mmuRsp_ways_0_sel;
      stageB_mmuRsp_ways_0_physical <= io_cpu_memory_mmuRsp_ways_0_physical;
      stageB_mmuRsp_ways_1_sel <= io_cpu_memory_mmuRsp_ways_1_sel;
      stageB_mmuRsp_ways_1_physical <= io_cpu_memory_mmuRsp_ways_1_physical;
      stageB_mmuRsp_ways_2_sel <= io_cpu_memory_mmuRsp_ways_2_sel;
      stageB_mmuRsp_ways_2_physical <= io_cpu_memory_mmuRsp_ways_2_physical;
      stageB_mmuRsp_ways_3_sel <= io_cpu_memory_mmuRsp_ways_3_sel;
      stageB_mmuRsp_ways_3_physical <= io_cpu_memory_mmuRsp_ways_3_physical;
    end
    if(when_DataCache_l827) begin
      stageB_tagsReadRsp_0_valid <= ways_0_tagsReadRsp_valid;
      stageB_tagsReadRsp_0_error <= ways_0_tagsReadRsp_error;
      stageB_tagsReadRsp_0_address <= ways_0_tagsReadRsp_address;
    end
    if(when_DataCache_l827_1) begin
      stageB_dataReadRsp_0 <= ways_0_dataReadRsp;
    end
    if(when_DataCache_l826) begin
      stageB_wayInvalidate <= stageA_wayInvalidate;
    end
    if(when_DataCache_l826_1) begin
      stageB_dataColisions <= stageA_dataColisions;
    end
    if(when_DataCache_l826_2) begin
      stageB_unaligned <= (|{((stageA_request_size == 2'b10) && (io_cpu_memory_address[1 : 0] != 2'b00)),((stageA_request_size == 2'b01) && (io_cpu_memory_address[0 : 0] != 1'b0))});
    end
    if(when_DataCache_l826_3) begin
      stageB_waysHitsBeforeInvalidate <= stageA_wayHits;
    end
    if(when_DataCache_l826_4) begin
      stageB_mask <= stageA_mask;
    end
    stageB_amo_internal_resultRegValid <= io_cpu_writeBack_isStuck;
    stageB_amo_resultReg <= stageB_amo_result;
    loader_valid_regNext <= loader_valid;
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      memCmdSent <= 1'b0;
      stageB_flusher_waitDone <= 1'b0;
      stageB_flusher_counter <= 8'h0;
      stageB_flusher_start <= 1'b1;
      stageB_lrSc_reserved <= 1'b0;
      loader_valid <= 1'b0;
      loader_counter_value <= 3'b000;
      loader_waysAllocator <= 1'b1;
      loader_error <= 1'b0;
      loader_killReg <= 1'b0;
    end else begin
      if(io_mem_cmd_fire) begin
        memCmdSent <= 1'b1;
      end
      if(when_DataCache_l690) begin
        memCmdSent <= 1'b0;
      end
      if(io_cpu_flush_ready) begin
        stageB_flusher_waitDone <= 1'b0;
      end
      if(when_DataCache_l856) begin
        if(when_DataCache_l862) begin
          stageB_flusher_counter <= (stageB_flusher_counter + 8'h01);
          if(when_DataCache_l864) begin
            stageB_flusher_counter[7] <= 1'b1;
          end
        end
      end
      stageB_flusher_start <= (((((((! stageB_flusher_waitDone) && (! stageB_flusher_start)) && io_cpu_flush_valid) && (! io_cpu_execute_isValid)) && (! io_cpu_memory_isValid)) && (! io_cpu_writeBack_isValid)) && (! io_cpu_redo));
      if(stageB_flusher_start) begin
        stageB_flusher_waitDone <= 1'b1;
        stageB_flusher_counter <= 8'h0;
        if(when_DataCache_l878) begin
          stageB_flusher_counter <= {1'b0,io_cpu_flush_payload_lineId};
        end
      end
      if(when_DataCache_l886) begin
        if(stageB_request_isLrsc) begin
          stageB_lrSc_reserved <= 1'b1;
        end
        if(stageB_request_wr) begin
          stageB_lrSc_reserved <= 1'b0;
        end
      end
      if(io_cpu_writeBack_isValid) begin
        if(when_DataCache_l1073) begin
          stageB_lrSc_reserved <= stageB_lrSc_reserved;
        end
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))); // DataCache.scala:L1085
        `else
          if(!(! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))) begin
            $display("ERROR writeBack stuck by another plugin is not allowed"); // DataCache.scala:L1085
          end
        `endif
      `endif
      if(stageB_loaderValid) begin
        loader_valid <= 1'b1;
      end
      loader_counter_value <= loader_counter_valueNext;
      if(loader_kill) begin
        loader_killReg <= 1'b1;
      end
      if(when_DataCache_l1098) begin
        loader_error <= (loader_error || io_mem_rsp_payload_error);
      end
      if(loader_done) begin
        loader_valid <= 1'b0;
        loader_error <= 1'b0;
        loader_killReg <= 1'b0;
      end
      if(when_DataCache_l1126) begin
        loader_waysAllocator <= _zz_loader_waysAllocator[0:0];
      end
    end
  end


endmodule

module InstructionCache (
  input  wire          io_flush,
  input  wire          io_cpu_prefetch_isValid,
  output reg           io_cpu_prefetch_haltIt,
  input  wire [31:0]   io_cpu_prefetch_pc,
  input  wire          io_cpu_fetch_isValid,
  input  wire          io_cpu_fetch_isStuck,
  input  wire          io_cpu_fetch_isRemoved,
  input  wire [31:0]   io_cpu_fetch_pc,
  output wire [31:0]   io_cpu_fetch_data,
  input  wire [31:0]   io_cpu_fetch_mmuRsp_physicalAddress,
  input  wire          io_cpu_fetch_mmuRsp_isIoAccess,
  input  wire          io_cpu_fetch_mmuRsp_isPaging,
  input  wire          io_cpu_fetch_mmuRsp_allowRead,
  input  wire          io_cpu_fetch_mmuRsp_allowWrite,
  input  wire          io_cpu_fetch_mmuRsp_allowExecute,
  input  wire          io_cpu_fetch_mmuRsp_exception,
  input  wire          io_cpu_fetch_mmuRsp_refilling,
  input  wire          io_cpu_fetch_mmuRsp_bypassTranslation,
  input  wire          io_cpu_fetch_mmuRsp_ways_0_sel,
  input  wire [31:0]   io_cpu_fetch_mmuRsp_ways_0_physical,
  input  wire          io_cpu_fetch_mmuRsp_ways_1_sel,
  input  wire [31:0]   io_cpu_fetch_mmuRsp_ways_1_physical,
  input  wire          io_cpu_fetch_mmuRsp_ways_2_sel,
  input  wire [31:0]   io_cpu_fetch_mmuRsp_ways_2_physical,
  input  wire          io_cpu_fetch_mmuRsp_ways_3_sel,
  input  wire [31:0]   io_cpu_fetch_mmuRsp_ways_3_physical,
  output wire [31:0]   io_cpu_fetch_physicalAddress,
  input  wire          io_cpu_decode_isValid,
  input  wire          io_cpu_decode_isStuck,
  input  wire [31:0]   io_cpu_decode_pc,
  output wire [31:0]   io_cpu_decode_physicalAddress,
  output wire [31:0]   io_cpu_decode_data,
  output wire          io_cpu_decode_cacheMiss,
  output wire          io_cpu_decode_error,
  output wire          io_cpu_decode_mmuRefilling,
  output wire          io_cpu_decode_mmuException,
  input  wire          io_cpu_decode_isUser,
  input  wire          io_cpu_fill_valid,
  input  wire [31:0]   io_cpu_fill_payload,
  output wire          io_mem_cmd_valid,
  input  wire          io_mem_cmd_ready,
  output wire [31:0]   io_mem_cmd_payload_address,
  output wire [2:0]    io_mem_cmd_payload_size,
  input  wire          io_mem_rsp_valid,
  input  wire [31:0]   io_mem_rsp_payload_data,
  input  wire          io_mem_rsp_payload_error,
  input  wire [2:0]    _zz_when_Fetcher_l411,
  input  wire [31:0]   _zz_decodeStage_hit_data_1,
  input  wire          clk,
  input  wire          reset
);

  reg        [31:0]   banks_0_spinal_port1;
  reg        [21:0]   ways_0_tags_spinal_port1;
  wire       [21:0]   _zz_ways_0_tags_port;
  reg                 _zz_1;
  reg                 _zz_2;
  reg                 lineLoader_fire;
  reg                 lineLoader_valid;
  (* keep , syn_keep *) reg        [31:0]   lineLoader_address /* synthesis syn_keep = 1 */ ;
  reg                 lineLoader_hadError;
  reg                 lineLoader_flushPending;
  reg        [7:0]    lineLoader_flushCounter;
  wire                when_InstructionCache_l339;
  reg                 _zz_when_InstructionCache_l343;
  wire                when_InstructionCache_l343;
  wire                when_InstructionCache_l352;
  reg                 lineLoader_cmdSent;
  wire                io_mem_cmd_fire;
  wire                when_Utils_l593;
  reg                 lineLoader_wayToAllocate_willIncrement;
  wire                lineLoader_wayToAllocate_willClear;
  wire                lineLoader_wayToAllocate_willOverflowIfInc;
  wire                lineLoader_wayToAllocate_willOverflow;
  (* keep , syn_keep *) reg        [2:0]    lineLoader_wordIndex /* synthesis syn_keep = 1 */ ;
  wire                lineLoader_write_tag_0_valid;
  wire       [6:0]    lineLoader_write_tag_0_payload_address;
  wire                lineLoader_write_tag_0_payload_data_valid;
  wire                lineLoader_write_tag_0_payload_data_error;
  wire       [19:0]   lineLoader_write_tag_0_payload_data_address;
  wire                lineLoader_write_data_0_valid;
  wire       [9:0]    lineLoader_write_data_0_payload_address;
  wire       [31:0]   lineLoader_write_data_0_payload_data;
  wire                when_InstructionCache_l402;
  wire       [9:0]    _zz_fetchStage_read_banksValue_0_dataMem;
  wire                _zz_fetchStage_read_banksValue_0_dataMem_1;
  wire       [31:0]   fetchStage_read_banksValue_0_dataMem;
  wire       [31:0]   fetchStage_read_banksValue_0_data;
  wire       [6:0]    _zz_fetchStage_read_waysValues_0_tag_valid;
  wire                _zz_fetchStage_read_waysValues_0_tag_valid_1;
  wire                fetchStage_read_waysValues_0_tag_valid;
  wire                fetchStage_read_waysValues_0_tag_error;
  wire       [19:0]   fetchStage_read_waysValues_0_tag_address;
  wire       [21:0]   _zz_fetchStage_read_waysValues_0_tag_valid_2;
  wire                when_InstructionCache_l460;
  reg        [31:0]   decodeStage_mmuRsp_physicalAddress;
  reg                 decodeStage_mmuRsp_isIoAccess;
  reg                 decodeStage_mmuRsp_isPaging;
  reg                 decodeStage_mmuRsp_allowRead;
  reg                 decodeStage_mmuRsp_allowWrite;
  reg                 decodeStage_mmuRsp_allowExecute;
  reg                 decodeStage_mmuRsp_exception;
  reg                 decodeStage_mmuRsp_refilling;
  reg                 decodeStage_mmuRsp_bypassTranslation;
  reg                 decodeStage_mmuRsp_ways_0_sel;
  reg        [31:0]   decodeStage_mmuRsp_ways_0_physical;
  reg                 decodeStage_mmuRsp_ways_1_sel;
  reg        [31:0]   decodeStage_mmuRsp_ways_1_physical;
  reg                 decodeStage_mmuRsp_ways_2_sel;
  reg        [31:0]   decodeStage_mmuRsp_ways_2_physical;
  reg                 decodeStage_mmuRsp_ways_3_sel;
  reg        [31:0]   decodeStage_mmuRsp_ways_3_physical;
  wire                when_InstructionCache_l460_1;
  reg                 decodeStage_hit_tags_0_valid;
  reg                 decodeStage_hit_tags_0_error;
  reg        [19:0]   decodeStage_hit_tags_0_address;
  wire                decodeStage_hit_hits_0;
  wire                decodeStage_hit_valid;
  wire                when_InstructionCache_l460_2;
  reg        [31:0]   _zz_decodeStage_hit_data;
  wire       [31:0]   decodeStage_hit_data;
  wire                when_Fetcher_l411;
  reg [31:0] banks_0 [0:1023];
  reg [21:0] ways_0_tags [0:127];

  assign _zz_ways_0_tags_port = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @(posedge clk) begin
    if(_zz_1) begin
      banks_0[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @(posedge clk) begin
    if(_zz_fetchStage_read_banksValue_0_dataMem_1) begin
      banks_0_spinal_port1 <= banks_0[_zz_fetchStage_read_banksValue_0_dataMem];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_ways_0_tags_port;
    end
  end

  always @(posedge clk) begin
    if(_zz_fetchStage_read_waysValues_0_tag_valid_1) begin
      ways_0_tags_spinal_port1 <= ways_0_tags[_zz_fetchStage_read_waysValues_0_tag_valid];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(lineLoader_write_data_0_valid) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(lineLoader_write_tag_0_valid) begin
      _zz_2 = 1'b1;
    end
  end

  always @(*) begin
    lineLoader_fire = 1'b0;
    if(io_mem_rsp_valid) begin
      if(when_InstructionCache_l402) begin
        lineLoader_fire = 1'b1;
      end
    end
  end

  always @(*) begin
    io_cpu_prefetch_haltIt = (lineLoader_valid || lineLoader_flushPending);
    if(when_InstructionCache_l339) begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(when_InstructionCache_l343) begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(io_flush) begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
  end

  assign when_InstructionCache_l339 = (! lineLoader_flushCounter[7]);
  assign when_InstructionCache_l343 = (! _zz_when_InstructionCache_l343);
  assign when_InstructionCache_l352 = (lineLoader_flushPending && (! (lineLoader_valid || io_cpu_fetch_isValid)));
  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready);
  assign io_mem_cmd_valid = (lineLoader_valid && (! lineLoader_cmdSent));
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],5'h0};
  assign io_mem_cmd_payload_size = 3'b101;
  assign when_Utils_l593 = (! lineLoader_valid);
  always @(*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0;
    if(when_Utils_l593) begin
      lineLoader_wayToAllocate_willIncrement = 1'b1;
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0;
  assign lineLoader_wayToAllocate_willOverflowIfInc = 1'b1;
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement);
  assign lineLoader_write_tag_0_valid = ((1'b1 && lineLoader_fire) || (! lineLoader_flushCounter[7]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[7];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 12];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && 1'b1);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign when_InstructionCache_l402 = (lineLoader_wordIndex == 3'b111);
  assign _zz_fetchStage_read_banksValue_0_dataMem = io_cpu_prefetch_pc[11 : 2];
  assign _zz_fetchStage_read_banksValue_0_dataMem_1 = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_banksValue_0_dataMem = banks_0_spinal_port1;
  assign fetchStage_read_banksValue_0_data = fetchStage_read_banksValue_0_dataMem[31 : 0];
  assign _zz_fetchStage_read_waysValues_0_tag_valid = io_cpu_prefetch_pc[11 : 5];
  assign _zz_fetchStage_read_waysValues_0_tag_valid_1 = (! io_cpu_fetch_isStuck);
  assign _zz_fetchStage_read_waysValues_0_tag_valid_2 = ways_0_tags_spinal_port1;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_fetchStage_read_waysValues_0_tag_valid_2[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_fetchStage_read_waysValues_0_tag_valid_2[1];
  assign fetchStage_read_waysValues_0_tag_address = _zz_fetchStage_read_waysValues_0_tag_valid_2[21 : 2];
  assign io_cpu_fetch_data = fetchStage_read_banksValue_0_data;
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuRsp_physicalAddress;
  assign when_InstructionCache_l460 = (! io_cpu_decode_isStuck);
  assign when_InstructionCache_l460_1 = (! io_cpu_decode_isStuck);
  assign decodeStage_hit_hits_0 = (decodeStage_hit_tags_0_valid && (decodeStage_hit_tags_0_address == decodeStage_mmuRsp_physicalAddress[31 : 12]));
  assign decodeStage_hit_valid = (|decodeStage_hit_hits_0);
  assign when_InstructionCache_l460_2 = (! io_cpu_decode_isStuck);
  assign decodeStage_hit_data = _zz_decodeStage_hit_data;
  assign io_cpu_decode_data = decodeStage_hit_data;
  assign io_cpu_decode_cacheMiss = (! decodeStage_hit_valid);
  assign io_cpu_decode_error = (decodeStage_hit_tags_0_error || ((! decodeStage_mmuRsp_isPaging) && (decodeStage_mmuRsp_exception || (! decodeStage_mmuRsp_allowExecute))));
  assign io_cpu_decode_mmuRefilling = decodeStage_mmuRsp_refilling;
  assign io_cpu_decode_mmuException = (((! decodeStage_mmuRsp_refilling) && decodeStage_mmuRsp_isPaging) && (decodeStage_mmuRsp_exception || (! decodeStage_mmuRsp_allowExecute)));
  assign io_cpu_decode_physicalAddress = decodeStage_mmuRsp_physicalAddress;
  assign when_Fetcher_l411 = (_zz_when_Fetcher_l411 != 3'b000);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushPending <= 1'b1;
      lineLoader_cmdSent <= 1'b0;
      lineLoader_wordIndex <= 3'b000;
    end else begin
      if(lineLoader_fire) begin
        lineLoader_valid <= 1'b0;
      end
      if(lineLoader_fire) begin
        lineLoader_hadError <= 1'b0;
      end
      if(io_cpu_fill_valid) begin
        lineLoader_valid <= 1'b1;
      end
      if(io_flush) begin
        lineLoader_flushPending <= 1'b1;
      end
      if(when_InstructionCache_l352) begin
        lineLoader_flushPending <= 1'b0;
      end
      if(io_mem_cmd_fire) begin
        lineLoader_cmdSent <= 1'b1;
      end
      if(lineLoader_fire) begin
        lineLoader_cmdSent <= 1'b0;
      end
      if(io_mem_rsp_valid) begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + 3'b001);
        if(io_mem_rsp_payload_error) begin
          lineLoader_hadError <= 1'b1;
        end
      end
    end
  end

  always @(posedge clk) begin
    if(io_cpu_fill_valid) begin
      lineLoader_address <= io_cpu_fill_payload;
    end
    if(when_InstructionCache_l339) begin
      lineLoader_flushCounter <= (lineLoader_flushCounter + 8'h01);
    end
    _zz_when_InstructionCache_l343 <= lineLoader_flushCounter[7];
    if(when_InstructionCache_l352) begin
      lineLoader_flushCounter <= 8'h0;
    end
    if(when_InstructionCache_l460) begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuRsp_physicalAddress;
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuRsp_isIoAccess;
      decodeStage_mmuRsp_isPaging <= io_cpu_fetch_mmuRsp_isPaging;
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuRsp_allowRead;
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuRsp_allowWrite;
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuRsp_allowExecute;
      decodeStage_mmuRsp_exception <= io_cpu_fetch_mmuRsp_exception;
      decodeStage_mmuRsp_refilling <= io_cpu_fetch_mmuRsp_refilling;
      decodeStage_mmuRsp_bypassTranslation <= io_cpu_fetch_mmuRsp_bypassTranslation;
      decodeStage_mmuRsp_ways_0_sel <= io_cpu_fetch_mmuRsp_ways_0_sel;
      decodeStage_mmuRsp_ways_0_physical <= io_cpu_fetch_mmuRsp_ways_0_physical;
      decodeStage_mmuRsp_ways_1_sel <= io_cpu_fetch_mmuRsp_ways_1_sel;
      decodeStage_mmuRsp_ways_1_physical <= io_cpu_fetch_mmuRsp_ways_1_physical;
      decodeStage_mmuRsp_ways_2_sel <= io_cpu_fetch_mmuRsp_ways_2_sel;
      decodeStage_mmuRsp_ways_2_physical <= io_cpu_fetch_mmuRsp_ways_2_physical;
      decodeStage_mmuRsp_ways_3_sel <= io_cpu_fetch_mmuRsp_ways_3_sel;
      decodeStage_mmuRsp_ways_3_physical <= io_cpu_fetch_mmuRsp_ways_3_physical;
    end
    if(when_InstructionCache_l460_1) begin
      decodeStage_hit_tags_0_valid <= fetchStage_read_waysValues_0_tag_valid;
      decodeStage_hit_tags_0_error <= fetchStage_read_waysValues_0_tag_error;
      decodeStage_hit_tags_0_address <= fetchStage_read_waysValues_0_tag_address;
    end
    if(when_InstructionCache_l460_2) begin
      _zz_decodeStage_hit_data <= fetchStage_read_banksValue_0_data;
    end
    if(when_Fetcher_l411) begin
      _zz_decodeStage_hit_data <= _zz_decodeStage_hit_data_1;
    end
  end


endmodule

module AlvxApb (
  input  wire [19:0]   io_apb_PADDR,
  input  wire [0:0]    io_apb_PSEL,
  input  wire          io_apb_PENABLE,
  output wire          io_apb_PREADY,
  input  wire          io_apb_PWRITE,
  input  wire [31:0]   io_apb_PWDATA,
  output wire [31:0]   io_apb_PRDATA,
  output wire          io_apb_PSLVERROR,
  output wire          io_uart_txd,
  input  wire          io_uart_rxd,
  output reg  [5:0]    io_leds,
  input  wire [3:0]    io_keys,
  output reg  [31:0]   io_ext1,
  output reg  [31:0]   io_ext2,
  output wire          io_sd_sclk,
  output wire          io_sd_mosi,
  input  wire          io_sd_miso,
  output wire          io_sd_ncs,
  output wire          io_irq_uart,
  output wire          io_irq_spi,
  output wire          io_irq_key,
  input  wire          io_pix_clk,
  input  wire          io_pix_reset,
  output wire          io_vid_mem_read,
  input  wire          io_vid_mem_waitRequestn,
  output wire [29:0]   io_vid_mem_address,
  output wire [3:0]    io_vid_mem_burstCount,
  input  wire          io_vid_mem_readDataValid,
  input  wire [31:0]   io_vid_mem_readData,
  output wire [9:0]    io_tmds0,
  output wire [9:0]    io_tmds1,
  output wire [9:0]    io_tmds2,
  output wire [3:0]    io_vid_status,
  input  wire          clk,
  input  wire          reset
);

  wire       [3:0]    gpioLed_io_apb_PADDR;
  reg        [5:0]    gpioLed_io_gpio_read;
  wire       [3:0]    gpioKey_io_apb_PADDR;
  reg        [3:0]    gpioKey_io_gpio_read;
  wire       [3:0]    gpioExt1_io_apb_PADDR;
  reg        [31:0]   gpioExt1_io_gpio_read;
  wire       [3:0]    gpioExt2_io_apb_PADDR;
  reg        [31:0]   gpioExt2_io_gpio_read;
  wire       [4:0]    uart_io_apb_PADDR;
  wire       [7:0]    spi_io_apb_PADDR;
  wire                video_dma_io_mem_cmd_ready;
  wire                video_pixArea_ctrl_io_softReset;
  wire       [1:0]    video_pixArea_encB_io_CD;
  wire                gpioLed_io_apb_PREADY;
  wire       [31:0]   gpioLed_io_apb_PRDATA;
  wire                gpioLed_io_apb_PSLVERROR;
  wire       [5:0]    gpioLed_io_gpio_write;
  wire       [5:0]    gpioLed_io_gpio_writeEnable;
  wire       [5:0]    gpioLed_io_value;
  wire                gpioKey_io_apb_PREADY;
  wire       [31:0]   gpioKey_io_apb_PRDATA;
  wire                gpioKey_io_apb_PSLVERROR;
  wire       [3:0]    gpioKey_io_gpio_write;
  wire       [3:0]    gpioKey_io_gpio_writeEnable;
  wire       [3:0]    gpioKey_io_value;
  wire                gpioExt1_io_apb_PREADY;
  wire       [31:0]   gpioExt1_io_apb_PRDATA;
  wire                gpioExt1_io_apb_PSLVERROR;
  wire       [31:0]   gpioExt1_io_gpio_write;
  wire       [31:0]   gpioExt1_io_gpio_writeEnable;
  wire       [31:0]   gpioExt1_io_value;
  wire                gpioExt2_io_apb_PREADY;
  wire       [31:0]   gpioExt2_io_apb_PRDATA;
  wire                gpioExt2_io_apb_PSLVERROR;
  wire       [31:0]   gpioExt2_io_gpio_write;
  wire       [31:0]   gpioExt2_io_gpio_writeEnable;
  wire       [31:0]   gpioExt2_io_value;
  wire                uart_io_apb_PREADY;
  wire       [31:0]   uart_io_apb_PRDATA;
  wire                uart_io_uart_txd;
  wire                uart_io_interrupt;
  wire                spi_io_apb_PREADY;
  wire       [31:0]   spi_io_apb_PRDATA;
  wire                spi_io_spi_sclk;
  wire                spi_io_spi_mosi;
  wire       [0:0]    spi_io_spi_ss;
  wire                spi_io_interrupt;
  wire                video_dma_io_busy;
  wire                video_dma_io_mem_cmd_valid;
  wire       [24:0]   video_dma_io_mem_cmd_payload;
  wire                video_dma_io_frame_valid;
  wire                video_dma_io_frame_payload_last;
  wire       [31:0]   video_dma_io_frame_payload_fragment;
  wire                video_enable_buffercc_io_dataOut;
  wire                video_pixArea_ctrl_io_frameStart;
  wire                video_pixArea_ctrl_io_pixels_ready;
  wire                video_pixArea_ctrl_io_vga_vSync;
  wire                video_pixArea_ctrl_io_vga_hSync;
  wire                video_pixArea_ctrl_io_vga_colorEn;
  wire       [7:0]    video_pixArea_ctrl_io_vga_color_r;
  wire       [7:0]    video_pixArea_ctrl_io_vga_color_g;
  wire       [7:0]    video_pixArea_ctrl_io_vga_color_b;
  wire                video_pixArea_ctrl_io_error;
  wire       [9:0]    video_pixArea_encB_io_TMDS;
  wire       [9:0]    video_pixArea_encG_io_TMDS;
  wire       [9:0]    video_pixArea_encR_io_TMDS;
  wire                video_pixArea_frameTgl_buffercc_io_dataOut;
  wire                video_pixArea_errTgl_buffercc_io_dataOut;
  wire                io_apb_decoder_io_input_PREADY;
  wire       [31:0]   io_apb_decoder_io_input_PRDATA;
  wire                io_apb_decoder_io_input_PSLVERROR;
  wire       [19:0]   io_apb_decoder_io_output_PADDR;
  wire       [7:0]    io_apb_decoder_io_output_PSEL;
  wire                io_apb_decoder_io_output_PENABLE;
  wire                io_apb_decoder_io_output_PWRITE;
  wire       [31:0]   io_apb_decoder_io_output_PWDATA;
  wire                apb3Router_1_io_input_PREADY;
  wire       [31:0]   apb3Router_1_io_input_PRDATA;
  wire                apb3Router_1_io_input_PSLVERROR;
  wire       [19:0]   apb3Router_1_io_outputs_0_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_0_PSEL;
  wire                apb3Router_1_io_outputs_0_PENABLE;
  wire                apb3Router_1_io_outputs_0_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_0_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_1_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_1_PSEL;
  wire                apb3Router_1_io_outputs_1_PENABLE;
  wire                apb3Router_1_io_outputs_1_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_1_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_2_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_2_PSEL;
  wire                apb3Router_1_io_outputs_2_PENABLE;
  wire                apb3Router_1_io_outputs_2_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_2_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_3_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_3_PSEL;
  wire                apb3Router_1_io_outputs_3_PENABLE;
  wire                apb3Router_1_io_outputs_3_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_3_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_4_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_4_PSEL;
  wire                apb3Router_1_io_outputs_4_PENABLE;
  wire                apb3Router_1_io_outputs_4_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_4_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_5_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_5_PSEL;
  wire                apb3Router_1_io_outputs_5_PENABLE;
  wire                apb3Router_1_io_outputs_5_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_5_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_6_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_6_PSEL;
  wire                apb3Router_1_io_outputs_6_PENABLE;
  wire                apb3Router_1_io_outputs_6_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_6_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_7_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_7_PSEL;
  wire                apb3Router_1_io_outputs_7_PENABLE;
  wire                apb3Router_1_io_outputs_7_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_7_PWDATA;
  wire       [2:0]    _zz_video_rspBeat_valueNext;
  wire       [0:0]    _zz_video_rspBeat_valueNext_1;
  reg        [3:0]    keys_d;
  reg                 keyFlag;
  wire                when_AlvxApb_l130;
  wire       [11:0]   sysid_apb_PADDR;
  wire       [0:0]    sysid_apb_PSEL;
  wire                sysid_apb_PENABLE;
  wire                sysid_apb_PREADY;
  wire                sysid_apb_PWRITE;
  wire       [31:0]   sysid_apb_PWDATA;
  reg        [31:0]   sysid_apb_PRDATA;
  wire                sysid_apb_PSLVERROR;
  wire                sysid_factory_readErrorFlag;
  wire                sysid_factory_writeErrorFlag;
  wire                sysid_factory_askWrite;
  wire                sysid_factory_askRead;
  wire                sysid_factory_doWrite;
  wire                sysid_factory_doRead;
  reg                 video_enable;
  reg        [24:0]   video_base;
  reg        [17:0]   video_size;
  reg                 video_underRun;
  reg                 video_startReq;
  reg                 video_rspBeat_willIncrement;
  wire                video_rspBeat_willClear;
  reg        [2:0]    video_rspBeat_valueNext;
  reg        [2:0]    video_rspBeat_value;
  wire                video_rspBeat_willOverflowIfInc;
  wire                video_rspBeat_willOverflow;
  wire                video_pixArea_enPix;
  wire                video_pixArea_rgbFrag_last;
  wire       [7:0]    video_pixArea_rgbFrag_fragment_r;
  wire       [7:0]    video_pixArea_rgbFrag_fragment_g;
  wire       [7:0]    video_pixArea_rgbFrag_fragment_b;
  wire       [23:0]   _zz_video_pixArea_rgbFrag_fragment_r;
  wire                video_dma_io_frame_translated_valid;
  wire                video_dma_io_frame_translated_ready;
  wire                video_dma_io_frame_translated_payload_last;
  wire       [7:0]    video_dma_io_frame_translated_payload_fragment_r;
  wire       [7:0]    video_dma_io_frame_translated_payload_fragment_g;
  wire       [7:0]    video_dma_io_frame_translated_payload_fragment_b;
  reg                 _zz_when_VgaCtrl_l334;
  reg                 _zz_when_VgaCtrl_l334_1;
  reg                 _zz_when_VgaCtrl_l335;
  wire                video_dma_io_frame_translated_fire;
  reg                 video_dma_io_frame_translated_payload_first;
  wire                when_VgaCtrl_l323;
  wire                video_dma_io_frame_translated_translated_valid;
  wire                video_dma_io_frame_translated_translated_ready;
  wire       [7:0]    video_dma_io_frame_translated_translated_payload_r;
  wire       [7:0]    video_dma_io_frame_translated_translated_payload_g;
  wire       [7:0]    video_dma_io_frame_translated_translated_payload_b;
  wire                _zz_video_dma_io_frame_translated_translated_ready;
  wire                video_dma_io_frame_translated_translated_haltWhen_valid;
  wire                video_dma_io_frame_translated_translated_haltWhen_ready;
  wire       [7:0]    video_dma_io_frame_translated_translated_haltWhen_payload_r;
  wire       [7:0]    video_dma_io_frame_translated_translated_haltWhen_payload_g;
  wire       [7:0]    video_dma_io_frame_translated_translated_haltWhen_payload_b;
  wire                when_VgaCtrl_l330;
  wire                when_VgaCtrl_l334;
  wire                when_VgaCtrl_l335;
  reg                 video_pixArea_frameTgl;
  reg                 video_pixArea_errTgl;
  wire                video_frameTglD;
  reg                 video_frameTglQ;
  wire                video_errTglD;
  reg                 video_errTglQ;
  reg                 video_enQ;
  wire                when_AlvxApb_l242;
  wire                when_AlvxApb_l245;
  wire       [11:0]   video_regs_apb_PADDR;
  wire       [0:0]    video_regs_apb_PSEL;
  wire                video_regs_apb_PENABLE;
  wire                video_regs_apb_PREADY;
  wire                video_regs_apb_PWRITE;
  wire       [31:0]   video_regs_apb_PWDATA;
  reg        [31:0]   video_regs_apb_PRDATA;
  wire                video_regs_apb_PSLVERROR;
  wire                video_regs_factory_readErrorFlag;
  wire                video_regs_factory_writeErrorFlag;
  wire                video_regs_factory_askWrite;
  wire                video_regs_factory_askRead;
  wire                video_regs_factory_doWrite;
  wire                video_regs_factory_doRead;
  reg        [24:0]   video_base_driver;
  reg        [17:0]   video_size_driver;
  reg                 video_enable_driver;

  assign _zz_video_rspBeat_valueNext_1 = video_rspBeat_willIncrement;
  assign _zz_video_rspBeat_valueNext = {2'd0, _zz_video_rspBeat_valueNext_1};
  Apb3Gpio gpioLed (
    .io_apb_PADDR        (gpioLed_io_apb_PADDR[3:0]             ), //i
    .io_apb_PSEL         (apb3Router_1_io_outputs_0_PSEL        ), //i
    .io_apb_PENABLE      (apb3Router_1_io_outputs_0_PENABLE     ), //i
    .io_apb_PREADY       (gpioLed_io_apb_PREADY                 ), //o
    .io_apb_PWRITE       (apb3Router_1_io_outputs_0_PWRITE      ), //i
    .io_apb_PWDATA       (apb3Router_1_io_outputs_0_PWDATA[31:0]), //i
    .io_apb_PRDATA       (gpioLed_io_apb_PRDATA[31:0]           ), //o
    .io_apb_PSLVERROR    (gpioLed_io_apb_PSLVERROR              ), //o
    .io_gpio_read        (gpioLed_io_gpio_read[5:0]             ), //i
    .io_gpio_write       (gpioLed_io_gpio_write[5:0]            ), //o
    .io_gpio_writeEnable (gpioLed_io_gpio_writeEnable[5:0]      ), //o
    .io_value            (gpioLed_io_value[5:0]                 ), //o
    .clk                 (clk                                   ), //i
    .reset               (reset                                 )  //i
  );
  Apb3Gpio_1 gpioKey (
    .io_apb_PADDR        (gpioKey_io_apb_PADDR[3:0]             ), //i
    .io_apb_PSEL         (apb3Router_1_io_outputs_1_PSEL        ), //i
    .io_apb_PENABLE      (apb3Router_1_io_outputs_1_PENABLE     ), //i
    .io_apb_PREADY       (gpioKey_io_apb_PREADY                 ), //o
    .io_apb_PWRITE       (apb3Router_1_io_outputs_1_PWRITE      ), //i
    .io_apb_PWDATA       (apb3Router_1_io_outputs_1_PWDATA[31:0]), //i
    .io_apb_PRDATA       (gpioKey_io_apb_PRDATA[31:0]           ), //o
    .io_apb_PSLVERROR    (gpioKey_io_apb_PSLVERROR              ), //o
    .io_gpio_read        (gpioKey_io_gpio_read[3:0]             ), //i
    .io_gpio_write       (gpioKey_io_gpio_write[3:0]            ), //o
    .io_gpio_writeEnable (gpioKey_io_gpio_writeEnable[3:0]      ), //o
    .io_value            (gpioKey_io_value[3:0]                 ), //o
    .clk                 (clk                                   ), //i
    .reset               (reset                                 )  //i
  );
  Apb3Gpio_2 gpioExt1 (
    .io_apb_PADDR        (gpioExt1_io_apb_PADDR[3:0]            ), //i
    .io_apb_PSEL         (apb3Router_1_io_outputs_2_PSEL        ), //i
    .io_apb_PENABLE      (apb3Router_1_io_outputs_2_PENABLE     ), //i
    .io_apb_PREADY       (gpioExt1_io_apb_PREADY                ), //o
    .io_apb_PWRITE       (apb3Router_1_io_outputs_2_PWRITE      ), //i
    .io_apb_PWDATA       (apb3Router_1_io_outputs_2_PWDATA[31:0]), //i
    .io_apb_PRDATA       (gpioExt1_io_apb_PRDATA[31:0]          ), //o
    .io_apb_PSLVERROR    (gpioExt1_io_apb_PSLVERROR             ), //o
    .io_gpio_read        (gpioExt1_io_gpio_read[31:0]           ), //i
    .io_gpio_write       (gpioExt1_io_gpio_write[31:0]          ), //o
    .io_gpio_writeEnable (gpioExt1_io_gpio_writeEnable[31:0]    ), //o
    .io_value            (gpioExt1_io_value[31:0]               ), //o
    .clk                 (clk                                   ), //i
    .reset               (reset                                 )  //i
  );
  Apb3Gpio_2 gpioExt2 (
    .io_apb_PADDR        (gpioExt2_io_apb_PADDR[3:0]            ), //i
    .io_apb_PSEL         (apb3Router_1_io_outputs_3_PSEL        ), //i
    .io_apb_PENABLE      (apb3Router_1_io_outputs_3_PENABLE     ), //i
    .io_apb_PREADY       (gpioExt2_io_apb_PREADY                ), //o
    .io_apb_PWRITE       (apb3Router_1_io_outputs_3_PWRITE      ), //i
    .io_apb_PWDATA       (apb3Router_1_io_outputs_3_PWDATA[31:0]), //i
    .io_apb_PRDATA       (gpioExt2_io_apb_PRDATA[31:0]          ), //o
    .io_apb_PSLVERROR    (gpioExt2_io_apb_PSLVERROR             ), //o
    .io_gpio_read        (gpioExt2_io_gpio_read[31:0]           ), //i
    .io_gpio_write       (gpioExt2_io_gpio_write[31:0]          ), //o
    .io_gpio_writeEnable (gpioExt2_io_gpio_writeEnable[31:0]    ), //o
    .io_value            (gpioExt2_io_value[31:0]               ), //o
    .clk                 (clk                                   ), //i
    .reset               (reset                                 )  //i
  );
  Apb3UartCtrl uart (
    .io_apb_PADDR   (uart_io_apb_PADDR[4:0]                ), //i
    .io_apb_PSEL    (apb3Router_1_io_outputs_4_PSEL        ), //i
    .io_apb_PENABLE (apb3Router_1_io_outputs_4_PENABLE     ), //i
    .io_apb_PREADY  (uart_io_apb_PREADY                    ), //o
    .io_apb_PWRITE  (apb3Router_1_io_outputs_4_PWRITE      ), //i
    .io_apb_PWDATA  (apb3Router_1_io_outputs_4_PWDATA[31:0]), //i
    .io_apb_PRDATA  (uart_io_apb_PRDATA[31:0]              ), //o
    .io_uart_txd    (uart_io_uart_txd                      ), //o
    .io_uart_rxd    (io_uart_rxd                           ), //i
    .io_interrupt   (uart_io_interrupt                     ), //o
    .clk            (clk                                   ), //i
    .reset          (reset                                 )  //i
  );
  Apb3SpiMasterCtrl spi (
    .io_apb_PADDR   (spi_io_apb_PADDR[7:0]                 ), //i
    .io_apb_PSEL    (apb3Router_1_io_outputs_5_PSEL        ), //i
    .io_apb_PENABLE (apb3Router_1_io_outputs_5_PENABLE     ), //i
    .io_apb_PREADY  (spi_io_apb_PREADY                     ), //o
    .io_apb_PWRITE  (apb3Router_1_io_outputs_5_PWRITE      ), //i
    .io_apb_PWDATA  (apb3Router_1_io_outputs_5_PWDATA[31:0]), //i
    .io_apb_PRDATA  (spi_io_apb_PRDATA[31:0]               ), //o
    .io_spi_ss      (spi_io_spi_ss                         ), //o
    .io_spi_sclk    (spi_io_spi_sclk                       ), //o
    .io_spi_mosi    (spi_io_spi_mosi                       ), //o
    .io_spi_miso    (io_sd_miso                            ), //i
    .io_interrupt   (spi_io_interrupt                      ), //o
    .clk            (clk                                   ), //i
    .reset          (reset                                 )  //i
  );
  VideoDma video_dma (
    .io_start                    (video_startReq                           ), //i
    .io_busy                     (video_dma_io_busy                        ), //o
    .io_base                     (video_base[24:0]                         ), //i
    .io_size                     (video_size[17:0]                         ), //i
    .io_mem_cmd_valid            (video_dma_io_mem_cmd_valid               ), //o
    .io_mem_cmd_ready            (video_dma_io_mem_cmd_ready               ), //i
    .io_mem_cmd_payload          (video_dma_io_mem_cmd_payload[24:0]       ), //o
    .io_mem_rsp_valid            (io_vid_mem_readDataValid                 ), //i
    .io_mem_rsp_payload_last     (video_rspBeat_willOverflow               ), //i
    .io_mem_rsp_payload_fragment (io_vid_mem_readData[31:0]                ), //i
    .io_frame_valid              (video_dma_io_frame_valid                 ), //o
    .io_frame_ready              (video_dma_io_frame_translated_ready      ), //i
    .io_frame_payload_last       (video_dma_io_frame_payload_last          ), //o
    .io_frame_payload_fragment   (video_dma_io_frame_payload_fragment[31:0]), //o
    .clk                         (clk                                      ), //i
    .reset                       (reset                                    ), //i
    .io_pix_clk                  (io_pix_clk                               ), //i
    .io_pix_reset                (io_pix_reset                             )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_9 video_enable_buffercc (
    .io_dataIn    (video_enable                    ), //i
    .io_dataOut   (video_enable_buffercc_io_dataOut), //o
    .io_pix_clk   (io_pix_clk                      ), //i
    .io_pix_reset (io_pix_reset                    )  //i
  );
  VgaCtrl video_pixArea_ctrl (
    .io_softReset            (video_pixArea_ctrl_io_softReset                                 ), //i
    .io_timings_h_syncStart  (12'h05f                                                         ), //i
    .io_timings_h_syncEnd    (12'h31f                                                         ), //i
    .io_timings_h_colorStart (12'h08f                                                         ), //i
    .io_timings_h_colorEnd   (12'h30f                                                         ), //i
    .io_timings_h_polarity   (1'b0                                                            ), //i
    .io_timings_v_syncStart  (12'h001                                                         ), //i
    .io_timings_v_syncEnd    (12'h20c                                                         ), //i
    .io_timings_v_colorStart (12'h022                                                         ), //i
    .io_timings_v_colorEnd   (12'h202                                                         ), //i
    .io_timings_v_polarity   (1'b0                                                            ), //i
    .io_frameStart           (video_pixArea_ctrl_io_frameStart                                ), //o
    .io_pixels_valid         (video_dma_io_frame_translated_translated_haltWhen_valid         ), //i
    .io_pixels_ready         (video_pixArea_ctrl_io_pixels_ready                              ), //o
    .io_pixels_payload_r     (video_dma_io_frame_translated_translated_haltWhen_payload_r[7:0]), //i
    .io_pixels_payload_g     (video_dma_io_frame_translated_translated_haltWhen_payload_g[7:0]), //i
    .io_pixels_payload_b     (video_dma_io_frame_translated_translated_haltWhen_payload_b[7:0]), //i
    .io_vga_vSync            (video_pixArea_ctrl_io_vga_vSync                                 ), //o
    .io_vga_hSync            (video_pixArea_ctrl_io_vga_hSync                                 ), //o
    .io_vga_colorEn          (video_pixArea_ctrl_io_vga_colorEn                               ), //o
    .io_vga_color_r          (video_pixArea_ctrl_io_vga_color_r[7:0]                          ), //o
    .io_vga_color_g          (video_pixArea_ctrl_io_vga_color_g[7:0]                          ), //o
    .io_vga_color_b          (video_pixArea_ctrl_io_vga_color_b[7:0]                          ), //o
    .io_error                (video_pixArea_ctrl_io_error                                     ), //o
    .io_pix_clk              (io_pix_clk                                                      ), //i
    .io_pix_reset            (io_pix_reset                                                    )  //i
  );
  TmdsEncoder video_pixArea_encB (
    .io_VD        (video_pixArea_ctrl_io_vga_color_b[7:0]), //i
    .io_CD        (video_pixArea_encB_io_CD[1:0]         ), //i
    .io_VDE       (video_pixArea_ctrl_io_vga_colorEn     ), //i
    .io_TMDS      (video_pixArea_encB_io_TMDS[9:0]       ), //o
    .io_pix_clk   (io_pix_clk                            ), //i
    .io_pix_reset (io_pix_reset                          )  //i
  );
  TmdsEncoder video_pixArea_encG (
    .io_VD        (video_pixArea_ctrl_io_vga_color_g[7:0]), //i
    .io_CD        (2'b00                                 ), //i
    .io_VDE       (video_pixArea_ctrl_io_vga_colorEn     ), //i
    .io_TMDS      (video_pixArea_encG_io_TMDS[9:0]       ), //o
    .io_pix_clk   (io_pix_clk                            ), //i
    .io_pix_reset (io_pix_reset                          )  //i
  );
  TmdsEncoder video_pixArea_encR (
    .io_VD        (video_pixArea_ctrl_io_vga_color_r[7:0]), //i
    .io_CD        (2'b00                                 ), //i
    .io_VDE       (video_pixArea_ctrl_io_vga_colorEn     ), //i
    .io_TMDS      (video_pixArea_encR_io_TMDS[9:0]       ), //o
    .io_pix_clk   (io_pix_clk                            ), //i
    .io_pix_reset (io_pix_reset                          )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_10 video_pixArea_frameTgl_buffercc (
    .io_dataIn  (video_pixArea_frameTgl                    ), //i
    .io_dataOut (video_pixArea_frameTgl_buffercc_io_dataOut), //o
    .clk        (clk                                       ), //i
    .reset      (reset                                     )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_10 video_pixArea_errTgl_buffercc (
    .io_dataIn  (video_pixArea_errTgl                    ), //i
    .io_dataOut (video_pixArea_errTgl_buffercc_io_dataOut), //o
    .clk        (clk                                     ), //i
    .reset      (reset                                   )  //i
  );
  Apb3Decoder io_apb_decoder (
    .io_input_PADDR      (io_apb_PADDR[19:0]                   ), //i
    .io_input_PSEL       (io_apb_PSEL                          ), //i
    .io_input_PENABLE    (io_apb_PENABLE                       ), //i
    .io_input_PREADY     (io_apb_decoder_io_input_PREADY       ), //o
    .io_input_PWRITE     (io_apb_PWRITE                        ), //i
    .io_input_PWDATA     (io_apb_PWDATA[31:0]                  ), //i
    .io_input_PRDATA     (io_apb_decoder_io_input_PRDATA[31:0] ), //o
    .io_input_PSLVERROR  (io_apb_decoder_io_input_PSLVERROR    ), //o
    .io_output_PADDR     (io_apb_decoder_io_output_PADDR[19:0] ), //o
    .io_output_PSEL      (io_apb_decoder_io_output_PSEL[7:0]   ), //o
    .io_output_PENABLE   (io_apb_decoder_io_output_PENABLE     ), //o
    .io_output_PREADY    (apb3Router_1_io_input_PREADY         ), //i
    .io_output_PWRITE    (io_apb_decoder_io_output_PWRITE      ), //o
    .io_output_PWDATA    (io_apb_decoder_io_output_PWDATA[31:0]), //o
    .io_output_PRDATA    (apb3Router_1_io_input_PRDATA[31:0]   ), //i
    .io_output_PSLVERROR (apb3Router_1_io_input_PSLVERROR      )  //i
  );
  Apb3Router apb3Router_1 (
    .io_input_PADDR         (io_apb_decoder_io_output_PADDR[19:0]  ), //i
    .io_input_PSEL          (io_apb_decoder_io_output_PSEL[7:0]    ), //i
    .io_input_PENABLE       (io_apb_decoder_io_output_PENABLE      ), //i
    .io_input_PREADY        (apb3Router_1_io_input_PREADY          ), //o
    .io_input_PWRITE        (io_apb_decoder_io_output_PWRITE       ), //i
    .io_input_PWDATA        (io_apb_decoder_io_output_PWDATA[31:0] ), //i
    .io_input_PRDATA        (apb3Router_1_io_input_PRDATA[31:0]    ), //o
    .io_input_PSLVERROR     (apb3Router_1_io_input_PSLVERROR       ), //o
    .io_outputs_0_PADDR     (apb3Router_1_io_outputs_0_PADDR[19:0] ), //o
    .io_outputs_0_PSEL      (apb3Router_1_io_outputs_0_PSEL        ), //o
    .io_outputs_0_PENABLE   (apb3Router_1_io_outputs_0_PENABLE     ), //o
    .io_outputs_0_PREADY    (gpioLed_io_apb_PREADY                 ), //i
    .io_outputs_0_PWRITE    (apb3Router_1_io_outputs_0_PWRITE      ), //o
    .io_outputs_0_PWDATA    (apb3Router_1_io_outputs_0_PWDATA[31:0]), //o
    .io_outputs_0_PRDATA    (gpioLed_io_apb_PRDATA[31:0]           ), //i
    .io_outputs_0_PSLVERROR (gpioLed_io_apb_PSLVERROR              ), //i
    .io_outputs_1_PADDR     (apb3Router_1_io_outputs_1_PADDR[19:0] ), //o
    .io_outputs_1_PSEL      (apb3Router_1_io_outputs_1_PSEL        ), //o
    .io_outputs_1_PENABLE   (apb3Router_1_io_outputs_1_PENABLE     ), //o
    .io_outputs_1_PREADY    (gpioKey_io_apb_PREADY                 ), //i
    .io_outputs_1_PWRITE    (apb3Router_1_io_outputs_1_PWRITE      ), //o
    .io_outputs_1_PWDATA    (apb3Router_1_io_outputs_1_PWDATA[31:0]), //o
    .io_outputs_1_PRDATA    (gpioKey_io_apb_PRDATA[31:0]           ), //i
    .io_outputs_1_PSLVERROR (gpioKey_io_apb_PSLVERROR              ), //i
    .io_outputs_2_PADDR     (apb3Router_1_io_outputs_2_PADDR[19:0] ), //o
    .io_outputs_2_PSEL      (apb3Router_1_io_outputs_2_PSEL        ), //o
    .io_outputs_2_PENABLE   (apb3Router_1_io_outputs_2_PENABLE     ), //o
    .io_outputs_2_PREADY    (gpioExt1_io_apb_PREADY                ), //i
    .io_outputs_2_PWRITE    (apb3Router_1_io_outputs_2_PWRITE      ), //o
    .io_outputs_2_PWDATA    (apb3Router_1_io_outputs_2_PWDATA[31:0]), //o
    .io_outputs_2_PRDATA    (gpioExt1_io_apb_PRDATA[31:0]          ), //i
    .io_outputs_2_PSLVERROR (gpioExt1_io_apb_PSLVERROR             ), //i
    .io_outputs_3_PADDR     (apb3Router_1_io_outputs_3_PADDR[19:0] ), //o
    .io_outputs_3_PSEL      (apb3Router_1_io_outputs_3_PSEL        ), //o
    .io_outputs_3_PENABLE   (apb3Router_1_io_outputs_3_PENABLE     ), //o
    .io_outputs_3_PREADY    (gpioExt2_io_apb_PREADY                ), //i
    .io_outputs_3_PWRITE    (apb3Router_1_io_outputs_3_PWRITE      ), //o
    .io_outputs_3_PWDATA    (apb3Router_1_io_outputs_3_PWDATA[31:0]), //o
    .io_outputs_3_PRDATA    (gpioExt2_io_apb_PRDATA[31:0]          ), //i
    .io_outputs_3_PSLVERROR (gpioExt2_io_apb_PSLVERROR             ), //i
    .io_outputs_4_PADDR     (apb3Router_1_io_outputs_4_PADDR[19:0] ), //o
    .io_outputs_4_PSEL      (apb3Router_1_io_outputs_4_PSEL        ), //o
    .io_outputs_4_PENABLE   (apb3Router_1_io_outputs_4_PENABLE     ), //o
    .io_outputs_4_PREADY    (uart_io_apb_PREADY                    ), //i
    .io_outputs_4_PWRITE    (apb3Router_1_io_outputs_4_PWRITE      ), //o
    .io_outputs_4_PWDATA    (apb3Router_1_io_outputs_4_PWDATA[31:0]), //o
    .io_outputs_4_PRDATA    (uart_io_apb_PRDATA[31:0]              ), //i
    .io_outputs_4_PSLVERROR (1'b0                                  ), //i
    .io_outputs_5_PADDR     (apb3Router_1_io_outputs_5_PADDR[19:0] ), //o
    .io_outputs_5_PSEL      (apb3Router_1_io_outputs_5_PSEL        ), //o
    .io_outputs_5_PENABLE   (apb3Router_1_io_outputs_5_PENABLE     ), //o
    .io_outputs_5_PREADY    (spi_io_apb_PREADY                     ), //i
    .io_outputs_5_PWRITE    (apb3Router_1_io_outputs_5_PWRITE      ), //o
    .io_outputs_5_PWDATA    (apb3Router_1_io_outputs_5_PWDATA[31:0]), //o
    .io_outputs_5_PRDATA    (spi_io_apb_PRDATA[31:0]               ), //i
    .io_outputs_5_PSLVERROR (1'b0                                  ), //i
    .io_outputs_6_PADDR     (apb3Router_1_io_outputs_6_PADDR[19:0] ), //o
    .io_outputs_6_PSEL      (apb3Router_1_io_outputs_6_PSEL        ), //o
    .io_outputs_6_PENABLE   (apb3Router_1_io_outputs_6_PENABLE     ), //o
    .io_outputs_6_PREADY    (sysid_apb_PREADY                      ), //i
    .io_outputs_6_PWRITE    (apb3Router_1_io_outputs_6_PWRITE      ), //o
    .io_outputs_6_PWDATA    (apb3Router_1_io_outputs_6_PWDATA[31:0]), //o
    .io_outputs_6_PRDATA    (sysid_apb_PRDATA[31:0]                ), //i
    .io_outputs_6_PSLVERROR (sysid_apb_PSLVERROR                   ), //i
    .io_outputs_7_PADDR     (apb3Router_1_io_outputs_7_PADDR[19:0] ), //o
    .io_outputs_7_PSEL      (apb3Router_1_io_outputs_7_PSEL        ), //o
    .io_outputs_7_PENABLE   (apb3Router_1_io_outputs_7_PENABLE     ), //o
    .io_outputs_7_PREADY    (video_regs_apb_PREADY                 ), //i
    .io_outputs_7_PWRITE    (apb3Router_1_io_outputs_7_PWRITE      ), //o
    .io_outputs_7_PWDATA    (apb3Router_1_io_outputs_7_PWDATA[31:0]), //o
    .io_outputs_7_PRDATA    (video_regs_apb_PRDATA[31:0]           ), //i
    .io_outputs_7_PSLVERROR (video_regs_apb_PSLVERROR              ), //i
    .clk                    (clk                                   ), //i
    .reset                  (reset                                 )  //i
  );
  always @(*) begin
    io_leds[0] = gpioLed_io_gpio_write[0];
    io_leds[1] = gpioLed_io_gpio_write[1];
    io_leds[2] = gpioLed_io_gpio_write[2];
    io_leds[3] = gpioLed_io_gpio_write[3];
    io_leds[4] = gpioLed_io_gpio_write[4];
    io_leds[5] = gpioLed_io_gpio_write[5];
  end

  always @(*) begin
    gpioLed_io_gpio_read[0] = io_leds[0];
    gpioLed_io_gpio_read[1] = io_leds[1];
    gpioLed_io_gpio_read[2] = io_leds[2];
    gpioLed_io_gpio_read[3] = io_leds[3];
    gpioLed_io_gpio_read[4] = io_leds[4];
    gpioLed_io_gpio_read[5] = io_leds[5];
  end

  always @(*) begin
    gpioKey_io_gpio_read[0] = io_keys[0];
    gpioKey_io_gpio_read[1] = io_keys[1];
    gpioKey_io_gpio_read[2] = io_keys[2];
    gpioKey_io_gpio_read[3] = io_keys[3];
  end

  always @(*) begin
    io_ext1[0] = gpioExt1_io_gpio_write[0];
    io_ext1[1] = gpioExt1_io_gpio_write[1];
    io_ext1[2] = gpioExt1_io_gpio_write[2];
    io_ext1[3] = gpioExt1_io_gpio_write[3];
    io_ext1[4] = gpioExt1_io_gpio_write[4];
    io_ext1[5] = gpioExt1_io_gpio_write[5];
    io_ext1[6] = gpioExt1_io_gpio_write[6];
    io_ext1[7] = gpioExt1_io_gpio_write[7];
    io_ext1[8] = gpioExt1_io_gpio_write[8];
    io_ext1[9] = gpioExt1_io_gpio_write[9];
    io_ext1[10] = gpioExt1_io_gpio_write[10];
    io_ext1[11] = gpioExt1_io_gpio_write[11];
    io_ext1[12] = gpioExt1_io_gpio_write[12];
    io_ext1[13] = gpioExt1_io_gpio_write[13];
    io_ext1[14] = gpioExt1_io_gpio_write[14];
    io_ext1[15] = gpioExt1_io_gpio_write[15];
    io_ext1[16] = gpioExt1_io_gpio_write[16];
    io_ext1[17] = gpioExt1_io_gpio_write[17];
    io_ext1[18] = gpioExt1_io_gpio_write[18];
    io_ext1[19] = gpioExt1_io_gpio_write[19];
    io_ext1[20] = gpioExt1_io_gpio_write[20];
    io_ext1[21] = gpioExt1_io_gpio_write[21];
    io_ext1[22] = gpioExt1_io_gpio_write[22];
    io_ext1[23] = gpioExt1_io_gpio_write[23];
    io_ext1[24] = gpioExt1_io_gpio_write[24];
    io_ext1[25] = gpioExt1_io_gpio_write[25];
    io_ext1[26] = gpioExt1_io_gpio_write[26];
    io_ext1[27] = gpioExt1_io_gpio_write[27];
    io_ext1[28] = gpioExt1_io_gpio_write[28];
    io_ext1[29] = gpioExt1_io_gpio_write[29];
    io_ext1[30] = gpioExt1_io_gpio_write[30];
    io_ext1[31] = gpioExt1_io_gpio_write[31];
  end

  always @(*) begin
    gpioExt1_io_gpio_read[0] = io_ext1[0];
    gpioExt1_io_gpio_read[1] = io_ext1[1];
    gpioExt1_io_gpio_read[2] = io_ext1[2];
    gpioExt1_io_gpio_read[3] = io_ext1[3];
    gpioExt1_io_gpio_read[4] = io_ext1[4];
    gpioExt1_io_gpio_read[5] = io_ext1[5];
    gpioExt1_io_gpio_read[6] = io_ext1[6];
    gpioExt1_io_gpio_read[7] = io_ext1[7];
    gpioExt1_io_gpio_read[8] = io_ext1[8];
    gpioExt1_io_gpio_read[9] = io_ext1[9];
    gpioExt1_io_gpio_read[10] = io_ext1[10];
    gpioExt1_io_gpio_read[11] = io_ext1[11];
    gpioExt1_io_gpio_read[12] = io_ext1[12];
    gpioExt1_io_gpio_read[13] = io_ext1[13];
    gpioExt1_io_gpio_read[14] = io_ext1[14];
    gpioExt1_io_gpio_read[15] = io_ext1[15];
    gpioExt1_io_gpio_read[16] = io_ext1[16];
    gpioExt1_io_gpio_read[17] = io_ext1[17];
    gpioExt1_io_gpio_read[18] = io_ext1[18];
    gpioExt1_io_gpio_read[19] = io_ext1[19];
    gpioExt1_io_gpio_read[20] = io_ext1[20];
    gpioExt1_io_gpio_read[21] = io_ext1[21];
    gpioExt1_io_gpio_read[22] = io_ext1[22];
    gpioExt1_io_gpio_read[23] = io_ext1[23];
    gpioExt1_io_gpio_read[24] = io_ext1[24];
    gpioExt1_io_gpio_read[25] = io_ext1[25];
    gpioExt1_io_gpio_read[26] = io_ext1[26];
    gpioExt1_io_gpio_read[27] = io_ext1[27];
    gpioExt1_io_gpio_read[28] = io_ext1[28];
    gpioExt1_io_gpio_read[29] = io_ext1[29];
    gpioExt1_io_gpio_read[30] = io_ext1[30];
    gpioExt1_io_gpio_read[31] = io_ext1[31];
  end

  always @(*) begin
    io_ext2[0] = gpioExt2_io_gpio_write[0];
    io_ext2[1] = gpioExt2_io_gpio_write[1];
    io_ext2[2] = gpioExt2_io_gpio_write[2];
    io_ext2[3] = gpioExt2_io_gpio_write[3];
    io_ext2[4] = gpioExt2_io_gpio_write[4];
    io_ext2[5] = gpioExt2_io_gpio_write[5];
    io_ext2[6] = gpioExt2_io_gpio_write[6];
    io_ext2[7] = gpioExt2_io_gpio_write[7];
    io_ext2[8] = gpioExt2_io_gpio_write[8];
    io_ext2[9] = gpioExt2_io_gpio_write[9];
    io_ext2[10] = gpioExt2_io_gpio_write[10];
    io_ext2[11] = gpioExt2_io_gpio_write[11];
    io_ext2[12] = gpioExt2_io_gpio_write[12];
    io_ext2[13] = gpioExt2_io_gpio_write[13];
    io_ext2[14] = gpioExt2_io_gpio_write[14];
    io_ext2[15] = gpioExt2_io_gpio_write[15];
    io_ext2[16] = gpioExt2_io_gpio_write[16];
    io_ext2[17] = gpioExt2_io_gpio_write[17];
    io_ext2[18] = gpioExt2_io_gpio_write[18];
    io_ext2[19] = gpioExt2_io_gpio_write[19];
    io_ext2[20] = gpioExt2_io_gpio_write[20];
    io_ext2[21] = gpioExt2_io_gpio_write[21];
    io_ext2[22] = gpioExt2_io_gpio_write[22];
    io_ext2[23] = gpioExt2_io_gpio_write[23];
    io_ext2[24] = gpioExt2_io_gpio_write[24];
    io_ext2[25] = gpioExt2_io_gpio_write[25];
    io_ext2[26] = gpioExt2_io_gpio_write[26];
    io_ext2[27] = gpioExt2_io_gpio_write[27];
    io_ext2[28] = gpioExt2_io_gpio_write[28];
    io_ext2[29] = gpioExt2_io_gpio_write[29];
    io_ext2[30] = gpioExt2_io_gpio_write[30];
    io_ext2[31] = gpioExt2_io_gpio_write[31];
  end

  always @(*) begin
    gpioExt2_io_gpio_read[0] = io_ext2[0];
    gpioExt2_io_gpio_read[1] = io_ext2[1];
    gpioExt2_io_gpio_read[2] = io_ext2[2];
    gpioExt2_io_gpio_read[3] = io_ext2[3];
    gpioExt2_io_gpio_read[4] = io_ext2[4];
    gpioExt2_io_gpio_read[5] = io_ext2[5];
    gpioExt2_io_gpio_read[6] = io_ext2[6];
    gpioExt2_io_gpio_read[7] = io_ext2[7];
    gpioExt2_io_gpio_read[8] = io_ext2[8];
    gpioExt2_io_gpio_read[9] = io_ext2[9];
    gpioExt2_io_gpio_read[10] = io_ext2[10];
    gpioExt2_io_gpio_read[11] = io_ext2[11];
    gpioExt2_io_gpio_read[12] = io_ext2[12];
    gpioExt2_io_gpio_read[13] = io_ext2[13];
    gpioExt2_io_gpio_read[14] = io_ext2[14];
    gpioExt2_io_gpio_read[15] = io_ext2[15];
    gpioExt2_io_gpio_read[16] = io_ext2[16];
    gpioExt2_io_gpio_read[17] = io_ext2[17];
    gpioExt2_io_gpio_read[18] = io_ext2[18];
    gpioExt2_io_gpio_read[19] = io_ext2[19];
    gpioExt2_io_gpio_read[20] = io_ext2[20];
    gpioExt2_io_gpio_read[21] = io_ext2[21];
    gpioExt2_io_gpio_read[22] = io_ext2[22];
    gpioExt2_io_gpio_read[23] = io_ext2[23];
    gpioExt2_io_gpio_read[24] = io_ext2[24];
    gpioExt2_io_gpio_read[25] = io_ext2[25];
    gpioExt2_io_gpio_read[26] = io_ext2[26];
    gpioExt2_io_gpio_read[27] = io_ext2[27];
    gpioExt2_io_gpio_read[28] = io_ext2[28];
    gpioExt2_io_gpio_read[29] = io_ext2[29];
    gpioExt2_io_gpio_read[30] = io_ext2[30];
    gpioExt2_io_gpio_read[31] = io_ext2[31];
  end

  assign io_uart_txd = uart_io_uart_txd;
  assign io_irq_uart = uart_io_interrupt;
  assign io_sd_sclk = spi_io_spi_sclk;
  assign io_sd_mosi = spi_io_spi_mosi;
  assign io_sd_ncs = spi_io_spi_ss[0];
  assign io_irq_spi = spi_io_interrupt;
  assign when_AlvxApb_l130 = (io_keys != keys_d);
  assign io_irq_key = keyFlag;
  assign sysid_factory_readErrorFlag = 1'b0;
  assign sysid_factory_writeErrorFlag = 1'b0;
  assign sysid_apb_PREADY = 1'b1;
  always @(*) begin
    sysid_apb_PRDATA = 32'h0;
    case(sysid_apb_PADDR)
      12'h0 : begin
        sysid_apb_PRDATA[31 : 0] = 32'h4c565830;
      end
      12'h004 : begin
        sysid_apb_PRDATA[31 : 0] = 32'h0135289d;
      end
      12'h008 : begin
        sysid_apb_PRDATA[31 : 0] = 32'h0000007d;
      end
      12'h00c : begin
        sysid_apb_PRDATA[0 : 0] = keyFlag;
      end
      default : begin
      end
    endcase
  end

  assign sysid_factory_askWrite = ((sysid_apb_PSEL[0] && sysid_apb_PENABLE) && sysid_apb_PWRITE);
  assign sysid_factory_askRead = ((sysid_apb_PSEL[0] && sysid_apb_PENABLE) && (! sysid_apb_PWRITE));
  assign sysid_factory_doWrite = (((sysid_apb_PSEL[0] && sysid_apb_PENABLE) && sysid_apb_PREADY) && sysid_apb_PWRITE);
  assign sysid_factory_doRead = (((sysid_apb_PSEL[0] && sysid_apb_PENABLE) && sysid_apb_PREADY) && (! sysid_apb_PWRITE));
  assign sysid_apb_PSLVERROR = ((sysid_factory_doWrite && sysid_factory_writeErrorFlag) || (sysid_factory_doRead && sysid_factory_readErrorFlag));
  assign io_vid_mem_read = video_dma_io_mem_cmd_valid;
  assign io_vid_mem_address = ({5'd0,video_dma_io_mem_cmd_payload} <<< 3'd5);
  assign io_vid_mem_burstCount = 4'b1000;
  assign video_dma_io_mem_cmd_ready = (io_vid_mem_read && io_vid_mem_waitRequestn);
  always @(*) begin
    video_rspBeat_willIncrement = 1'b0;
    if(io_vid_mem_readDataValid) begin
      video_rspBeat_willIncrement = 1'b1;
    end
  end

  assign video_rspBeat_willClear = 1'b0;
  assign video_rspBeat_willOverflowIfInc = (video_rspBeat_value == 3'b111);
  assign video_rspBeat_willOverflow = (video_rspBeat_willOverflowIfInc && video_rspBeat_willIncrement);
  always @(*) begin
    video_rspBeat_valueNext = (video_rspBeat_value + _zz_video_rspBeat_valueNext);
    if(video_rspBeat_willClear) begin
      video_rspBeat_valueNext = 3'b000;
    end
  end

  assign video_pixArea_enPix = video_enable_buffercc_io_dataOut;
  assign video_pixArea_ctrl_io_softReset = (! video_pixArea_enPix);
  assign video_pixArea_rgbFrag_last = video_dma_io_frame_payload_last;
  assign _zz_video_pixArea_rgbFrag_fragment_r = {{video_dma_io_frame_payload_fragment[7 : 0],video_dma_io_frame_payload_fragment[15 : 8]},video_dma_io_frame_payload_fragment[23 : 16]};
  assign video_pixArea_rgbFrag_fragment_r = _zz_video_pixArea_rgbFrag_fragment_r[7 : 0];
  assign video_pixArea_rgbFrag_fragment_g = _zz_video_pixArea_rgbFrag_fragment_r[15 : 8];
  assign video_pixArea_rgbFrag_fragment_b = _zz_video_pixArea_rgbFrag_fragment_r[23 : 16];
  assign video_dma_io_frame_translated_valid = video_dma_io_frame_valid;
  assign video_dma_io_frame_translated_payload_last = video_pixArea_rgbFrag_last;
  assign video_dma_io_frame_translated_payload_fragment_r = video_pixArea_rgbFrag_fragment_r;
  assign video_dma_io_frame_translated_payload_fragment_g = video_pixArea_rgbFrag_fragment_g;
  assign video_dma_io_frame_translated_payload_fragment_b = video_pixArea_rgbFrag_fragment_b;
  assign video_dma_io_frame_translated_fire = (video_dma_io_frame_translated_valid && video_dma_io_frame_translated_ready);
  assign when_VgaCtrl_l323 = (video_dma_io_frame_translated_fire && video_dma_io_frame_translated_payload_first);
  assign video_dma_io_frame_translated_translated_valid = video_dma_io_frame_translated_valid;
  assign video_dma_io_frame_translated_ready = video_dma_io_frame_translated_translated_ready;
  assign video_dma_io_frame_translated_translated_payload_r = video_dma_io_frame_translated_payload_fragment_r;
  assign video_dma_io_frame_translated_translated_payload_g = video_dma_io_frame_translated_payload_fragment_g;
  assign video_dma_io_frame_translated_translated_payload_b = video_dma_io_frame_translated_payload_fragment_b;
  assign _zz_video_dma_io_frame_translated_translated_ready = (! (_zz_when_VgaCtrl_l334_1 && (! _zz_when_VgaCtrl_l334)));
  assign video_dma_io_frame_translated_translated_haltWhen_valid = (video_dma_io_frame_translated_translated_valid && _zz_video_dma_io_frame_translated_translated_ready);
  assign video_dma_io_frame_translated_translated_ready = (video_dma_io_frame_translated_translated_haltWhen_ready && _zz_video_dma_io_frame_translated_translated_ready);
  assign video_dma_io_frame_translated_translated_haltWhen_payload_r = video_dma_io_frame_translated_translated_payload_r;
  assign video_dma_io_frame_translated_translated_haltWhen_payload_g = video_dma_io_frame_translated_translated_payload_g;
  assign video_dma_io_frame_translated_translated_haltWhen_payload_b = video_dma_io_frame_translated_translated_payload_b;
  assign video_dma_io_frame_translated_translated_haltWhen_ready = video_pixArea_ctrl_io_pixels_ready;
  assign when_VgaCtrl_l330 = (video_dma_io_frame_translated_fire && video_dma_io_frame_translated_payload_last);
  assign when_VgaCtrl_l334 = ((! _zz_when_VgaCtrl_l334_1) && (! _zz_when_VgaCtrl_l334));
  assign when_VgaCtrl_l335 = ((video_pixArea_ctrl_io_error || 1'b0) || ((_zz_when_VgaCtrl_l335 && video_dma_io_frame_translated_valid) && (! video_dma_io_frame_translated_payload_first)));
  assign video_pixArea_encB_io_CD = {video_pixArea_ctrl_io_vga_vSync,video_pixArea_ctrl_io_vga_hSync};
  assign io_tmds0 = video_pixArea_encB_io_TMDS;
  assign io_tmds1 = video_pixArea_encG_io_TMDS;
  assign io_tmds2 = video_pixArea_encR_io_TMDS;
  assign video_frameTglD = video_pixArea_frameTgl_buffercc_io_dataOut;
  assign video_errTglD = video_pixArea_errTgl_buffercc_io_dataOut;
  assign when_AlvxApb_l242 = ((video_enable && (! video_enQ)) || ((video_enable && (! video_dma_io_busy)) && (video_frameTglD != video_frameTglQ)));
  assign when_AlvxApb_l245 = (video_errTglD != video_errTglQ);
  assign io_vid_status = {{{1'b0,video_dma_io_busy},video_underRun},video_enable};
  assign video_regs_factory_readErrorFlag = 1'b0;
  assign video_regs_factory_writeErrorFlag = 1'b0;
  assign video_regs_apb_PREADY = 1'b1;
  always @(*) begin
    video_regs_apb_PRDATA = 32'h0;
    case(video_regs_apb_PADDR)
      12'h0 : begin
        video_regs_apb_PRDATA[24 : 0] = video_base_driver;
      end
      12'h004 : begin
        video_regs_apb_PRDATA[17 : 0] = video_size_driver;
      end
      12'h008 : begin
        video_regs_apb_PRDATA[0 : 0] = video_enable_driver;
      end
      12'h00c : begin
        video_regs_apb_PRDATA[1 : 0] = {video_dma_io_busy,video_underRun};
      end
      default : begin
      end
    endcase
  end

  assign video_regs_factory_askWrite = ((video_regs_apb_PSEL[0] && video_regs_apb_PENABLE) && video_regs_apb_PWRITE);
  assign video_regs_factory_askRead = ((video_regs_apb_PSEL[0] && video_regs_apb_PENABLE) && (! video_regs_apb_PWRITE));
  assign video_regs_factory_doWrite = (((video_regs_apb_PSEL[0] && video_regs_apb_PENABLE) && video_regs_apb_PREADY) && video_regs_apb_PWRITE);
  assign video_regs_factory_doRead = (((video_regs_apb_PSEL[0] && video_regs_apb_PENABLE) && video_regs_apb_PREADY) && (! video_regs_apb_PWRITE));
  assign video_regs_apb_PSLVERROR = ((video_regs_factory_doWrite && video_regs_factory_writeErrorFlag) || (video_regs_factory_doRead && video_regs_factory_readErrorFlag));
  assign io_apb_PREADY = io_apb_decoder_io_input_PREADY;
  assign io_apb_PRDATA = io_apb_decoder_io_input_PRDATA;
  assign io_apb_PSLVERROR = io_apb_decoder_io_input_PSLVERROR;
  assign gpioLed_io_apb_PADDR = apb3Router_1_io_outputs_0_PADDR[3:0];
  assign gpioKey_io_apb_PADDR = apb3Router_1_io_outputs_1_PADDR[3:0];
  assign gpioExt1_io_apb_PADDR = apb3Router_1_io_outputs_2_PADDR[3:0];
  assign gpioExt2_io_apb_PADDR = apb3Router_1_io_outputs_3_PADDR[3:0];
  assign uart_io_apb_PADDR = apb3Router_1_io_outputs_4_PADDR[4:0];
  assign spi_io_apb_PADDR = apb3Router_1_io_outputs_5_PADDR[7:0];
  assign sysid_apb_PADDR = apb3Router_1_io_outputs_6_PADDR[11:0];
  assign sysid_apb_PSEL = apb3Router_1_io_outputs_6_PSEL;
  assign sysid_apb_PENABLE = apb3Router_1_io_outputs_6_PENABLE;
  assign sysid_apb_PWRITE = apb3Router_1_io_outputs_6_PWRITE;
  assign sysid_apb_PWDATA = apb3Router_1_io_outputs_6_PWDATA;
  assign video_regs_apb_PADDR = apb3Router_1_io_outputs_7_PADDR[11:0];
  assign video_regs_apb_PSEL = apb3Router_1_io_outputs_7_PSEL;
  assign video_regs_apb_PENABLE = apb3Router_1_io_outputs_7_PENABLE;
  assign video_regs_apb_PWRITE = apb3Router_1_io_outputs_7_PWRITE;
  assign video_regs_apb_PWDATA = apb3Router_1_io_outputs_7_PWDATA;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      keys_d <= 4'b1111;
      keyFlag <= 1'b0;
      video_enable <= 1'b0;
      video_base <= 25'h0c00000;
      video_size <= 18'h095ff;
      video_underRun <= 1'b0;
      video_startReq <= 1'b0;
      video_rspBeat_value <= 3'b000;
    end else begin
      keys_d <= io_keys;
      if(when_AlvxApb_l130) begin
        keyFlag <= 1'b1;
      end
      video_startReq <= 1'b0;
      video_rspBeat_value <= video_rspBeat_valueNext;
      if(when_AlvxApb_l242) begin
        video_startReq <= 1'b1;
      end
      if(when_AlvxApb_l245) begin
        video_underRun <= 1'b1;
      end
      video_base <= video_base_driver;
      video_size <= video_size_driver;
      video_enable <= video_enable_driver;
      case(sysid_apb_PADDR)
        12'h00c : begin
          if(sysid_factory_doWrite) begin
            keyFlag <= 1'b0;
          end
        end
        default : begin
        end
      endcase
      case(video_regs_apb_PADDR)
        12'h00c : begin
          if(video_regs_factory_doWrite) begin
            video_underRun <= 1'b0;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge io_pix_clk or posedge io_pix_reset) begin
    if(io_pix_reset) begin
      _zz_when_VgaCtrl_l334 <= 1'b0;
      _zz_when_VgaCtrl_l334_1 <= 1'b0;
      video_dma_io_frame_translated_payload_first <= 1'b1;
      video_pixArea_frameTgl <= 1'b0;
      video_pixArea_errTgl <= 1'b0;
    end else begin
      if(video_dma_io_frame_translated_fire) begin
        video_dma_io_frame_translated_payload_first <= video_dma_io_frame_translated_payload_last;
      end
      if(video_pixArea_ctrl_io_frameStart) begin
        _zz_when_VgaCtrl_l334_1 <= 1'b0;
      end
      if(when_VgaCtrl_l330) begin
        _zz_when_VgaCtrl_l334 <= 1'b0;
        _zz_when_VgaCtrl_l334_1 <= _zz_when_VgaCtrl_l334;
      end
      if(when_VgaCtrl_l334) begin
        if(when_VgaCtrl_l335) begin
          _zz_when_VgaCtrl_l334 <= 1'b1;
        end
      end
      if(video_pixArea_ctrl_io_frameStart) begin
        video_pixArea_frameTgl <= (! video_pixArea_frameTgl);
      end
      if(video_pixArea_ctrl_io_error) begin
        video_pixArea_errTgl <= (! video_pixArea_errTgl);
      end
    end
  end

  always @(posedge io_pix_clk) begin
    if(video_pixArea_ctrl_io_frameStart) begin
      _zz_when_VgaCtrl_l335 <= 1'b1;
    end
    if(when_VgaCtrl_l323) begin
      _zz_when_VgaCtrl_l335 <= 1'b0;
    end
  end

  always @(posedge clk) begin
    video_frameTglQ <= video_frameTglD;
    video_errTglQ <= video_errTglD;
    video_enQ <= video_enable;
    case(video_regs_apb_PADDR)
      12'h0 : begin
        if(video_regs_factory_doWrite) begin
          video_base_driver <= video_regs_apb_PWDATA[24 : 0];
        end
      end
      12'h004 : begin
        if(video_regs_factory_doWrite) begin
          video_size_driver <= video_regs_apb_PWDATA[17 : 0];
        end
      end
      12'h008 : begin
        if(video_regs_factory_doWrite) begin
          video_enable_driver <= video_regs_apb_PWDATA[0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module AxiLite4Plic (
  input  wire          io_bus_aw_valid,
  output wire          io_bus_aw_ready,
  input  wire [21:0]   io_bus_aw_payload_addr,
  input  wire [2:0]    io_bus_aw_payload_prot,
  input  wire          io_bus_w_valid,
  output wire          io_bus_w_ready,
  input  wire [31:0]   io_bus_w_payload_data,
  input  wire [3:0]    io_bus_w_payload_strb,
  output wire          io_bus_b_valid,
  input  wire          io_bus_b_ready,
  output wire [1:0]    io_bus_b_payload_resp,
  input  wire          io_bus_ar_valid,
  output wire          io_bus_ar_ready,
  input  wire [21:0]   io_bus_ar_payload_addr,
  input  wire [2:0]    io_bus_ar_payload_prot,
  output wire          io_bus_r_valid,
  input  wire          io_bus_r_ready,
  output wire [31:0]   io_bus_r_payload_data,
  output wire [1:0]    io_bus_r_payload_resp,
  input  wire [30:0]   io_sources,
  output wire [1:0]    io_targets,
  input  wire          clk,
  input  wire          reset
);

  wire       [4:0]    _zz_targets_0_bestRequest_id_82;
  wire       [4:0]    _zz_targets_0_bestRequest_id_83;
  wire       [4:0]    _zz_targets_0_bestRequest_id_84;
  wire       [4:0]    _zz_targets_0_bestRequest_id_85;
  wire       [4:0]    _zz_targets_0_bestRequest_id_86;
  wire       [4:0]    _zz_targets_0_bestRequest_id_87;
  wire       [4:0]    _zz_targets_0_bestRequest_id_88;
  wire       [4:0]    _zz_targets_0_bestRequest_id_89;
  wire       [4:0]    _zz_targets_0_bestRequest_id_90;
  wire       [4:0]    _zz_targets_0_bestRequest_id_91;
  wire       [4:0]    _zz_targets_0_bestRequest_id_92;
  wire       [4:0]    _zz_targets_0_bestRequest_id_93;
  wire       [4:0]    _zz_targets_0_bestRequest_id_94;
  wire       [4:0]    _zz_targets_0_bestRequest_id_95;
  wire       [4:0]    _zz_targets_0_bestRequest_id_96;
  wire       [4:0]    _zz_targets_0_bestRequest_id_97;
  wire       [4:0]    _zz_targets_1_bestRequest_id_82;
  wire       [4:0]    _zz_targets_1_bestRequest_id_83;
  wire       [4:0]    _zz_targets_1_bestRequest_id_84;
  wire       [4:0]    _zz_targets_1_bestRequest_id_85;
  wire       [4:0]    _zz_targets_1_bestRequest_id_86;
  wire       [4:0]    _zz_targets_1_bestRequest_id_87;
  wire       [4:0]    _zz_targets_1_bestRequest_id_88;
  wire       [4:0]    _zz_targets_1_bestRequest_id_89;
  wire       [4:0]    _zz_targets_1_bestRequest_id_90;
  wire       [4:0]    _zz_targets_1_bestRequest_id_91;
  wire       [4:0]    _zz_targets_1_bestRequest_id_92;
  wire       [4:0]    _zz_targets_1_bestRequest_id_93;
  wire       [4:0]    _zz_targets_1_bestRequest_id_94;
  wire       [4:0]    _zz_targets_1_bestRequest_id_95;
  wire       [4:0]    _zz_targets_1_bestRequest_id_96;
  wire       [4:0]    _zz_targets_1_bestRequest_id_97;
  wire                _zz_gateways_0_ip;
  wire                _zz_gateways_1_ip;
  wire                _zz_gateways_2_ip;
  wire                _zz_gateways_3_ip;
  wire                _zz_gateways_4_ip;
  wire                _zz_gateways_5_ip;
  wire                _zz_gateways_6_ip;
  wire                _zz_gateways_7_ip;
  wire                _zz_gateways_8_ip;
  wire                _zz_gateways_9_ip;
  wire                _zz_gateways_10_ip;
  wire                _zz_gateways_11_ip;
  wire                _zz_gateways_12_ip;
  wire                _zz_gateways_13_ip;
  wire                _zz_gateways_14_ip;
  wire                _zz_gateways_15_ip;
  wire                _zz_gateways_16_ip;
  wire                _zz_gateways_17_ip;
  wire                _zz_gateways_18_ip;
  wire                _zz_gateways_19_ip;
  wire                _zz_gateways_20_ip;
  wire                _zz_gateways_21_ip;
  wire                _zz_gateways_22_ip;
  wire                _zz_gateways_23_ip;
  wire                _zz_gateways_24_ip;
  wire                _zz_gateways_25_ip;
  wire                _zz_gateways_26_ip;
  wire                _zz_gateways_27_ip;
  wire                _zz_gateways_28_ip;
  wire                _zz_gateways_29_ip;
  wire                _zz_gateways_30_ip;
  wire       [1:0]    gateways_0_priority;
  reg                 gateways_0_ip;
  reg                 gateways_0_waitCompletion;
  wire                when_PlicGateway_l21;
  wire       [1:0]    gateways_1_priority;
  reg                 gateways_1_ip;
  reg                 gateways_1_waitCompletion;
  wire                when_PlicGateway_l21_1;
  wire       [1:0]    gateways_2_priority;
  reg                 gateways_2_ip;
  reg                 gateways_2_waitCompletion;
  wire                when_PlicGateway_l21_2;
  wire       [1:0]    gateways_3_priority;
  reg                 gateways_3_ip;
  reg                 gateways_3_waitCompletion;
  wire                when_PlicGateway_l21_3;
  wire       [1:0]    gateways_4_priority;
  reg                 gateways_4_ip;
  reg                 gateways_4_waitCompletion;
  wire                when_PlicGateway_l21_4;
  wire       [1:0]    gateways_5_priority;
  reg                 gateways_5_ip;
  reg                 gateways_5_waitCompletion;
  wire                when_PlicGateway_l21_5;
  wire       [1:0]    gateways_6_priority;
  reg                 gateways_6_ip;
  reg                 gateways_6_waitCompletion;
  wire                when_PlicGateway_l21_6;
  wire       [1:0]    gateways_7_priority;
  reg                 gateways_7_ip;
  reg                 gateways_7_waitCompletion;
  wire                when_PlicGateway_l21_7;
  wire       [1:0]    gateways_8_priority;
  reg                 gateways_8_ip;
  reg                 gateways_8_waitCompletion;
  wire                when_PlicGateway_l21_8;
  wire       [1:0]    gateways_9_priority;
  reg                 gateways_9_ip;
  reg                 gateways_9_waitCompletion;
  wire                when_PlicGateway_l21_9;
  wire       [1:0]    gateways_10_priority;
  reg                 gateways_10_ip;
  reg                 gateways_10_waitCompletion;
  wire                when_PlicGateway_l21_10;
  wire       [1:0]    gateways_11_priority;
  reg                 gateways_11_ip;
  reg                 gateways_11_waitCompletion;
  wire                when_PlicGateway_l21_11;
  wire       [1:0]    gateways_12_priority;
  reg                 gateways_12_ip;
  reg                 gateways_12_waitCompletion;
  wire                when_PlicGateway_l21_12;
  wire       [1:0]    gateways_13_priority;
  reg                 gateways_13_ip;
  reg                 gateways_13_waitCompletion;
  wire                when_PlicGateway_l21_13;
  wire       [1:0]    gateways_14_priority;
  reg                 gateways_14_ip;
  reg                 gateways_14_waitCompletion;
  wire                when_PlicGateway_l21_14;
  wire       [1:0]    gateways_15_priority;
  reg                 gateways_15_ip;
  reg                 gateways_15_waitCompletion;
  wire                when_PlicGateway_l21_15;
  wire       [1:0]    gateways_16_priority;
  reg                 gateways_16_ip;
  reg                 gateways_16_waitCompletion;
  wire                when_PlicGateway_l21_16;
  wire       [1:0]    gateways_17_priority;
  reg                 gateways_17_ip;
  reg                 gateways_17_waitCompletion;
  wire                when_PlicGateway_l21_17;
  wire       [1:0]    gateways_18_priority;
  reg                 gateways_18_ip;
  reg                 gateways_18_waitCompletion;
  wire                when_PlicGateway_l21_18;
  wire       [1:0]    gateways_19_priority;
  reg                 gateways_19_ip;
  reg                 gateways_19_waitCompletion;
  wire                when_PlicGateway_l21_19;
  wire       [1:0]    gateways_20_priority;
  reg                 gateways_20_ip;
  reg                 gateways_20_waitCompletion;
  wire                when_PlicGateway_l21_20;
  wire       [1:0]    gateways_21_priority;
  reg                 gateways_21_ip;
  reg                 gateways_21_waitCompletion;
  wire                when_PlicGateway_l21_21;
  wire       [1:0]    gateways_22_priority;
  reg                 gateways_22_ip;
  reg                 gateways_22_waitCompletion;
  wire                when_PlicGateway_l21_22;
  wire       [1:0]    gateways_23_priority;
  reg                 gateways_23_ip;
  reg                 gateways_23_waitCompletion;
  wire                when_PlicGateway_l21_23;
  wire       [1:0]    gateways_24_priority;
  reg                 gateways_24_ip;
  reg                 gateways_24_waitCompletion;
  wire                when_PlicGateway_l21_24;
  wire       [1:0]    gateways_25_priority;
  reg                 gateways_25_ip;
  reg                 gateways_25_waitCompletion;
  wire                when_PlicGateway_l21_25;
  wire       [1:0]    gateways_26_priority;
  reg                 gateways_26_ip;
  reg                 gateways_26_waitCompletion;
  wire                when_PlicGateway_l21_26;
  wire       [1:0]    gateways_27_priority;
  reg                 gateways_27_ip;
  reg                 gateways_27_waitCompletion;
  wire                when_PlicGateway_l21_27;
  wire       [1:0]    gateways_28_priority;
  reg                 gateways_28_ip;
  reg                 gateways_28_waitCompletion;
  wire                when_PlicGateway_l21_28;
  wire       [1:0]    gateways_29_priority;
  reg                 gateways_29_ip;
  reg                 gateways_29_waitCompletion;
  wire                when_PlicGateway_l21_29;
  wire       [1:0]    gateways_30_priority;
  reg                 gateways_30_ip;
  reg                 gateways_30_waitCompletion;
  wire                when_PlicGateway_l21_30;
  wire                targets_0_ie_0;
  wire                targets_0_ie_1;
  wire                targets_0_ie_2;
  wire                targets_0_ie_3;
  wire                targets_0_ie_4;
  wire                targets_0_ie_5;
  wire                targets_0_ie_6;
  wire                targets_0_ie_7;
  wire                targets_0_ie_8;
  wire                targets_0_ie_9;
  wire                targets_0_ie_10;
  wire                targets_0_ie_11;
  wire                targets_0_ie_12;
  wire                targets_0_ie_13;
  wire                targets_0_ie_14;
  wire                targets_0_ie_15;
  wire                targets_0_ie_16;
  wire                targets_0_ie_17;
  wire                targets_0_ie_18;
  wire                targets_0_ie_19;
  wire                targets_0_ie_20;
  wire                targets_0_ie_21;
  wire                targets_0_ie_22;
  wire                targets_0_ie_23;
  wire                targets_0_ie_24;
  wire                targets_0_ie_25;
  wire                targets_0_ie_26;
  wire                targets_0_ie_27;
  wire                targets_0_ie_28;
  wire                targets_0_ie_29;
  wire                targets_0_ie_30;
  wire       [1:0]    targets_0_threshold;
  wire       [1:0]    targets_0_requests_0_priority;
  wire       [4:0]    targets_0_requests_0_id;
  wire                targets_0_requests_0_valid;
  wire       [1:0]    targets_0_requests_1_priority;
  wire       [4:0]    targets_0_requests_1_id;
  wire                targets_0_requests_1_valid;
  wire       [1:0]    targets_0_requests_2_priority;
  wire       [4:0]    targets_0_requests_2_id;
  wire                targets_0_requests_2_valid;
  wire       [1:0]    targets_0_requests_3_priority;
  wire       [4:0]    targets_0_requests_3_id;
  wire                targets_0_requests_3_valid;
  wire       [1:0]    targets_0_requests_4_priority;
  wire       [4:0]    targets_0_requests_4_id;
  wire                targets_0_requests_4_valid;
  wire       [1:0]    targets_0_requests_5_priority;
  wire       [4:0]    targets_0_requests_5_id;
  wire                targets_0_requests_5_valid;
  wire       [1:0]    targets_0_requests_6_priority;
  wire       [4:0]    targets_0_requests_6_id;
  wire                targets_0_requests_6_valid;
  wire       [1:0]    targets_0_requests_7_priority;
  wire       [4:0]    targets_0_requests_7_id;
  wire                targets_0_requests_7_valid;
  wire       [1:0]    targets_0_requests_8_priority;
  wire       [4:0]    targets_0_requests_8_id;
  wire                targets_0_requests_8_valid;
  wire       [1:0]    targets_0_requests_9_priority;
  wire       [4:0]    targets_0_requests_9_id;
  wire                targets_0_requests_9_valid;
  wire       [1:0]    targets_0_requests_10_priority;
  wire       [4:0]    targets_0_requests_10_id;
  wire                targets_0_requests_10_valid;
  wire       [1:0]    targets_0_requests_11_priority;
  wire       [4:0]    targets_0_requests_11_id;
  wire                targets_0_requests_11_valid;
  wire       [1:0]    targets_0_requests_12_priority;
  wire       [4:0]    targets_0_requests_12_id;
  wire                targets_0_requests_12_valid;
  wire       [1:0]    targets_0_requests_13_priority;
  wire       [4:0]    targets_0_requests_13_id;
  wire                targets_0_requests_13_valid;
  wire       [1:0]    targets_0_requests_14_priority;
  wire       [4:0]    targets_0_requests_14_id;
  wire                targets_0_requests_14_valid;
  wire       [1:0]    targets_0_requests_15_priority;
  wire       [4:0]    targets_0_requests_15_id;
  wire                targets_0_requests_15_valid;
  wire       [1:0]    targets_0_requests_16_priority;
  wire       [4:0]    targets_0_requests_16_id;
  wire                targets_0_requests_16_valid;
  wire       [1:0]    targets_0_requests_17_priority;
  wire       [4:0]    targets_0_requests_17_id;
  wire                targets_0_requests_17_valid;
  wire       [1:0]    targets_0_requests_18_priority;
  wire       [4:0]    targets_0_requests_18_id;
  wire                targets_0_requests_18_valid;
  wire       [1:0]    targets_0_requests_19_priority;
  wire       [4:0]    targets_0_requests_19_id;
  wire                targets_0_requests_19_valid;
  wire       [1:0]    targets_0_requests_20_priority;
  wire       [4:0]    targets_0_requests_20_id;
  wire                targets_0_requests_20_valid;
  wire       [1:0]    targets_0_requests_21_priority;
  wire       [4:0]    targets_0_requests_21_id;
  wire                targets_0_requests_21_valid;
  wire       [1:0]    targets_0_requests_22_priority;
  wire       [4:0]    targets_0_requests_22_id;
  wire                targets_0_requests_22_valid;
  wire       [1:0]    targets_0_requests_23_priority;
  wire       [4:0]    targets_0_requests_23_id;
  wire                targets_0_requests_23_valid;
  wire       [1:0]    targets_0_requests_24_priority;
  wire       [4:0]    targets_0_requests_24_id;
  wire                targets_0_requests_24_valid;
  wire       [1:0]    targets_0_requests_25_priority;
  wire       [4:0]    targets_0_requests_25_id;
  wire                targets_0_requests_25_valid;
  wire       [1:0]    targets_0_requests_26_priority;
  wire       [4:0]    targets_0_requests_26_id;
  wire                targets_0_requests_26_valid;
  wire       [1:0]    targets_0_requests_27_priority;
  wire       [4:0]    targets_0_requests_27_id;
  wire                targets_0_requests_27_valid;
  wire       [1:0]    targets_0_requests_28_priority;
  wire       [4:0]    targets_0_requests_28_id;
  wire                targets_0_requests_28_valid;
  wire       [1:0]    targets_0_requests_29_priority;
  wire       [4:0]    targets_0_requests_29_id;
  wire                targets_0_requests_29_valid;
  wire       [1:0]    targets_0_requests_30_priority;
  wire       [4:0]    targets_0_requests_30_id;
  wire                targets_0_requests_30_valid;
  wire       [1:0]    targets_0_requests_31_priority;
  wire       [4:0]    targets_0_requests_31_id;
  wire                targets_0_requests_31_valid;
  wire                _zz_targets_0_bestRequest_id;
  wire       [1:0]    _zz_targets_0_bestRequest_id_1;
  wire                _zz_targets_0_bestRequest_id_2;
  wire                _zz_targets_0_bestRequest_id_3;
  wire       [1:0]    _zz_targets_0_bestRequest_id_4;
  wire                _zz_targets_0_bestRequest_id_5;
  wire                _zz_targets_0_bestRequest_id_6;
  wire       [1:0]    _zz_targets_0_bestRequest_id_7;
  wire                _zz_targets_0_bestRequest_id_8;
  wire                _zz_targets_0_bestRequest_id_9;
  wire       [1:0]    _zz_targets_0_bestRequest_id_10;
  wire                _zz_targets_0_bestRequest_id_11;
  wire                _zz_targets_0_bestRequest_id_12;
  wire       [1:0]    _zz_targets_0_bestRequest_id_13;
  wire                _zz_targets_0_bestRequest_id_14;
  wire                _zz_targets_0_bestRequest_id_15;
  wire       [1:0]    _zz_targets_0_bestRequest_id_16;
  wire                _zz_targets_0_bestRequest_id_17;
  wire                _zz_targets_0_bestRequest_id_18;
  wire       [1:0]    _zz_targets_0_bestRequest_id_19;
  wire                _zz_targets_0_bestRequest_id_20;
  wire                _zz_targets_0_bestRequest_id_21;
  wire       [1:0]    _zz_targets_0_bestRequest_id_22;
  wire                _zz_targets_0_bestRequest_id_23;
  wire                _zz_targets_0_bestRequest_id_24;
  wire       [1:0]    _zz_targets_0_bestRequest_id_25;
  wire                _zz_targets_0_bestRequest_id_26;
  wire                _zz_targets_0_bestRequest_id_27;
  wire       [1:0]    _zz_targets_0_bestRequest_id_28;
  wire                _zz_targets_0_bestRequest_id_29;
  wire                _zz_targets_0_bestRequest_id_30;
  wire       [1:0]    _zz_targets_0_bestRequest_id_31;
  wire                _zz_targets_0_bestRequest_id_32;
  wire                _zz_targets_0_bestRequest_id_33;
  wire       [1:0]    _zz_targets_0_bestRequest_id_34;
  wire                _zz_targets_0_bestRequest_id_35;
  wire                _zz_targets_0_bestRequest_id_36;
  wire       [1:0]    _zz_targets_0_bestRequest_id_37;
  wire                _zz_targets_0_bestRequest_id_38;
  wire                _zz_targets_0_bestRequest_id_39;
  wire       [1:0]    _zz_targets_0_bestRequest_id_40;
  wire                _zz_targets_0_bestRequest_id_41;
  wire                _zz_targets_0_bestRequest_id_42;
  wire       [1:0]    _zz_targets_0_bestRequest_id_43;
  wire                _zz_targets_0_bestRequest_id_44;
  wire                _zz_targets_0_bestRequest_id_45;
  wire       [1:0]    _zz_targets_0_bestRequest_id_46;
  wire                _zz_targets_0_bestRequest_id_47;
  wire                _zz_targets_0_bestRequest_id_48;
  wire       [1:0]    _zz_targets_0_bestRequest_id_49;
  wire                _zz_targets_0_bestRequest_id_50;
  wire                _zz_targets_0_bestRequest_id_51;
  wire       [1:0]    _zz_targets_0_bestRequest_id_52;
  wire                _zz_targets_0_bestRequest_id_53;
  wire                _zz_targets_0_bestRequest_id_54;
  wire       [1:0]    _zz_targets_0_bestRequest_id_55;
  wire                _zz_targets_0_bestRequest_id_56;
  wire                _zz_targets_0_bestRequest_id_57;
  wire       [1:0]    _zz_targets_0_bestRequest_id_58;
  wire                _zz_targets_0_bestRequest_id_59;
  wire                _zz_targets_0_bestRequest_id_60;
  wire       [1:0]    _zz_targets_0_bestRequest_id_61;
  wire                _zz_targets_0_bestRequest_id_62;
  wire                _zz_targets_0_bestRequest_id_63;
  wire       [1:0]    _zz_targets_0_bestRequest_id_64;
  wire                _zz_targets_0_bestRequest_id_65;
  wire                _zz_targets_0_bestRequest_id_66;
  wire       [1:0]    _zz_targets_0_bestRequest_id_67;
  wire                _zz_targets_0_bestRequest_id_68;
  wire                _zz_targets_0_bestRequest_id_69;
  wire       [1:0]    _zz_targets_0_bestRequest_id_70;
  wire                _zz_targets_0_bestRequest_id_71;
  wire                _zz_targets_0_bestRequest_id_72;
  wire       [1:0]    _zz_targets_0_bestRequest_priority;
  wire                _zz_targets_0_bestRequest_id_73;
  wire                _zz_targets_0_bestRequest_id_74;
  wire       [1:0]    _zz_targets_0_bestRequest_priority_1;
  wire                _zz_targets_0_bestRequest_id_75;
  wire                _zz_targets_0_bestRequest_id_76;
  wire       [1:0]    _zz_targets_0_bestRequest_priority_2;
  wire                _zz_targets_0_bestRequest_id_77;
  wire                _zz_targets_0_bestRequest_id_78;
  wire       [1:0]    _zz_targets_0_bestRequest_priority_3;
  wire                _zz_targets_0_bestRequest_id_79;
  wire                _zz_targets_0_bestRequest_id_80;
  wire       [1:0]    _zz_targets_0_bestRequest_priority_4;
  wire                _zz_targets_0_bestRequest_valid;
  wire                _zz_targets_0_bestRequest_id_81;
  wire       [1:0]    _zz_targets_0_bestRequest_priority_5;
  wire                _zz_targets_0_bestRequest_valid_1;
  wire                _zz_targets_0_bestRequest_priority_6;
  reg        [1:0]    targets_0_bestRequest_priority;
  reg        [4:0]    targets_0_bestRequest_id;
  reg                 targets_0_bestRequest_valid;
  wire                targets_0_iep;
  wire       [4:0]    targets_0_claim;
  wire                targets_1_ie_0;
  wire                targets_1_ie_1;
  wire                targets_1_ie_2;
  wire                targets_1_ie_3;
  wire                targets_1_ie_4;
  wire                targets_1_ie_5;
  wire                targets_1_ie_6;
  wire                targets_1_ie_7;
  wire                targets_1_ie_8;
  wire                targets_1_ie_9;
  wire                targets_1_ie_10;
  wire                targets_1_ie_11;
  wire                targets_1_ie_12;
  wire                targets_1_ie_13;
  wire                targets_1_ie_14;
  wire                targets_1_ie_15;
  wire                targets_1_ie_16;
  wire                targets_1_ie_17;
  wire                targets_1_ie_18;
  wire                targets_1_ie_19;
  wire                targets_1_ie_20;
  wire                targets_1_ie_21;
  wire                targets_1_ie_22;
  wire                targets_1_ie_23;
  wire                targets_1_ie_24;
  wire                targets_1_ie_25;
  wire                targets_1_ie_26;
  wire                targets_1_ie_27;
  wire                targets_1_ie_28;
  wire                targets_1_ie_29;
  wire                targets_1_ie_30;
  wire       [1:0]    targets_1_threshold;
  wire       [1:0]    targets_1_requests_0_priority;
  wire       [4:0]    targets_1_requests_0_id;
  wire                targets_1_requests_0_valid;
  wire       [1:0]    targets_1_requests_1_priority;
  wire       [4:0]    targets_1_requests_1_id;
  wire                targets_1_requests_1_valid;
  wire       [1:0]    targets_1_requests_2_priority;
  wire       [4:0]    targets_1_requests_2_id;
  wire                targets_1_requests_2_valid;
  wire       [1:0]    targets_1_requests_3_priority;
  wire       [4:0]    targets_1_requests_3_id;
  wire                targets_1_requests_3_valid;
  wire       [1:0]    targets_1_requests_4_priority;
  wire       [4:0]    targets_1_requests_4_id;
  wire                targets_1_requests_4_valid;
  wire       [1:0]    targets_1_requests_5_priority;
  wire       [4:0]    targets_1_requests_5_id;
  wire                targets_1_requests_5_valid;
  wire       [1:0]    targets_1_requests_6_priority;
  wire       [4:0]    targets_1_requests_6_id;
  wire                targets_1_requests_6_valid;
  wire       [1:0]    targets_1_requests_7_priority;
  wire       [4:0]    targets_1_requests_7_id;
  wire                targets_1_requests_7_valid;
  wire       [1:0]    targets_1_requests_8_priority;
  wire       [4:0]    targets_1_requests_8_id;
  wire                targets_1_requests_8_valid;
  wire       [1:0]    targets_1_requests_9_priority;
  wire       [4:0]    targets_1_requests_9_id;
  wire                targets_1_requests_9_valid;
  wire       [1:0]    targets_1_requests_10_priority;
  wire       [4:0]    targets_1_requests_10_id;
  wire                targets_1_requests_10_valid;
  wire       [1:0]    targets_1_requests_11_priority;
  wire       [4:0]    targets_1_requests_11_id;
  wire                targets_1_requests_11_valid;
  wire       [1:0]    targets_1_requests_12_priority;
  wire       [4:0]    targets_1_requests_12_id;
  wire                targets_1_requests_12_valid;
  wire       [1:0]    targets_1_requests_13_priority;
  wire       [4:0]    targets_1_requests_13_id;
  wire                targets_1_requests_13_valid;
  wire       [1:0]    targets_1_requests_14_priority;
  wire       [4:0]    targets_1_requests_14_id;
  wire                targets_1_requests_14_valid;
  wire       [1:0]    targets_1_requests_15_priority;
  wire       [4:0]    targets_1_requests_15_id;
  wire                targets_1_requests_15_valid;
  wire       [1:0]    targets_1_requests_16_priority;
  wire       [4:0]    targets_1_requests_16_id;
  wire                targets_1_requests_16_valid;
  wire       [1:0]    targets_1_requests_17_priority;
  wire       [4:0]    targets_1_requests_17_id;
  wire                targets_1_requests_17_valid;
  wire       [1:0]    targets_1_requests_18_priority;
  wire       [4:0]    targets_1_requests_18_id;
  wire                targets_1_requests_18_valid;
  wire       [1:0]    targets_1_requests_19_priority;
  wire       [4:0]    targets_1_requests_19_id;
  wire                targets_1_requests_19_valid;
  wire       [1:0]    targets_1_requests_20_priority;
  wire       [4:0]    targets_1_requests_20_id;
  wire                targets_1_requests_20_valid;
  wire       [1:0]    targets_1_requests_21_priority;
  wire       [4:0]    targets_1_requests_21_id;
  wire                targets_1_requests_21_valid;
  wire       [1:0]    targets_1_requests_22_priority;
  wire       [4:0]    targets_1_requests_22_id;
  wire                targets_1_requests_22_valid;
  wire       [1:0]    targets_1_requests_23_priority;
  wire       [4:0]    targets_1_requests_23_id;
  wire                targets_1_requests_23_valid;
  wire       [1:0]    targets_1_requests_24_priority;
  wire       [4:0]    targets_1_requests_24_id;
  wire                targets_1_requests_24_valid;
  wire       [1:0]    targets_1_requests_25_priority;
  wire       [4:0]    targets_1_requests_25_id;
  wire                targets_1_requests_25_valid;
  wire       [1:0]    targets_1_requests_26_priority;
  wire       [4:0]    targets_1_requests_26_id;
  wire                targets_1_requests_26_valid;
  wire       [1:0]    targets_1_requests_27_priority;
  wire       [4:0]    targets_1_requests_27_id;
  wire                targets_1_requests_27_valid;
  wire       [1:0]    targets_1_requests_28_priority;
  wire       [4:0]    targets_1_requests_28_id;
  wire                targets_1_requests_28_valid;
  wire       [1:0]    targets_1_requests_29_priority;
  wire       [4:0]    targets_1_requests_29_id;
  wire                targets_1_requests_29_valid;
  wire       [1:0]    targets_1_requests_30_priority;
  wire       [4:0]    targets_1_requests_30_id;
  wire                targets_1_requests_30_valid;
  wire       [1:0]    targets_1_requests_31_priority;
  wire       [4:0]    targets_1_requests_31_id;
  wire                targets_1_requests_31_valid;
  wire                _zz_targets_1_bestRequest_id;
  wire       [1:0]    _zz_targets_1_bestRequest_id_1;
  wire                _zz_targets_1_bestRequest_id_2;
  wire                _zz_targets_1_bestRequest_id_3;
  wire       [1:0]    _zz_targets_1_bestRequest_id_4;
  wire                _zz_targets_1_bestRequest_id_5;
  wire                _zz_targets_1_bestRequest_id_6;
  wire       [1:0]    _zz_targets_1_bestRequest_id_7;
  wire                _zz_targets_1_bestRequest_id_8;
  wire                _zz_targets_1_bestRequest_id_9;
  wire       [1:0]    _zz_targets_1_bestRequest_id_10;
  wire                _zz_targets_1_bestRequest_id_11;
  wire                _zz_targets_1_bestRequest_id_12;
  wire       [1:0]    _zz_targets_1_bestRequest_id_13;
  wire                _zz_targets_1_bestRequest_id_14;
  wire                _zz_targets_1_bestRequest_id_15;
  wire       [1:0]    _zz_targets_1_bestRequest_id_16;
  wire                _zz_targets_1_bestRequest_id_17;
  wire                _zz_targets_1_bestRequest_id_18;
  wire       [1:0]    _zz_targets_1_bestRequest_id_19;
  wire                _zz_targets_1_bestRequest_id_20;
  wire                _zz_targets_1_bestRequest_id_21;
  wire       [1:0]    _zz_targets_1_bestRequest_id_22;
  wire                _zz_targets_1_bestRequest_id_23;
  wire                _zz_targets_1_bestRequest_id_24;
  wire       [1:0]    _zz_targets_1_bestRequest_id_25;
  wire                _zz_targets_1_bestRequest_id_26;
  wire                _zz_targets_1_bestRequest_id_27;
  wire       [1:0]    _zz_targets_1_bestRequest_id_28;
  wire                _zz_targets_1_bestRequest_id_29;
  wire                _zz_targets_1_bestRequest_id_30;
  wire       [1:0]    _zz_targets_1_bestRequest_id_31;
  wire                _zz_targets_1_bestRequest_id_32;
  wire                _zz_targets_1_bestRequest_id_33;
  wire       [1:0]    _zz_targets_1_bestRequest_id_34;
  wire                _zz_targets_1_bestRequest_id_35;
  wire                _zz_targets_1_bestRequest_id_36;
  wire       [1:0]    _zz_targets_1_bestRequest_id_37;
  wire                _zz_targets_1_bestRequest_id_38;
  wire                _zz_targets_1_bestRequest_id_39;
  wire       [1:0]    _zz_targets_1_bestRequest_id_40;
  wire                _zz_targets_1_bestRequest_id_41;
  wire                _zz_targets_1_bestRequest_id_42;
  wire       [1:0]    _zz_targets_1_bestRequest_id_43;
  wire                _zz_targets_1_bestRequest_id_44;
  wire                _zz_targets_1_bestRequest_id_45;
  wire       [1:0]    _zz_targets_1_bestRequest_id_46;
  wire                _zz_targets_1_bestRequest_id_47;
  wire                _zz_targets_1_bestRequest_id_48;
  wire       [1:0]    _zz_targets_1_bestRequest_id_49;
  wire                _zz_targets_1_bestRequest_id_50;
  wire                _zz_targets_1_bestRequest_id_51;
  wire       [1:0]    _zz_targets_1_bestRequest_id_52;
  wire                _zz_targets_1_bestRequest_id_53;
  wire                _zz_targets_1_bestRequest_id_54;
  wire       [1:0]    _zz_targets_1_bestRequest_id_55;
  wire                _zz_targets_1_bestRequest_id_56;
  wire                _zz_targets_1_bestRequest_id_57;
  wire       [1:0]    _zz_targets_1_bestRequest_id_58;
  wire                _zz_targets_1_bestRequest_id_59;
  wire                _zz_targets_1_bestRequest_id_60;
  wire       [1:0]    _zz_targets_1_bestRequest_id_61;
  wire                _zz_targets_1_bestRequest_id_62;
  wire                _zz_targets_1_bestRequest_id_63;
  wire       [1:0]    _zz_targets_1_bestRequest_id_64;
  wire                _zz_targets_1_bestRequest_id_65;
  wire                _zz_targets_1_bestRequest_id_66;
  wire       [1:0]    _zz_targets_1_bestRequest_id_67;
  wire                _zz_targets_1_bestRequest_id_68;
  wire                _zz_targets_1_bestRequest_id_69;
  wire       [1:0]    _zz_targets_1_bestRequest_id_70;
  wire                _zz_targets_1_bestRequest_id_71;
  wire                _zz_targets_1_bestRequest_id_72;
  wire       [1:0]    _zz_targets_1_bestRequest_priority;
  wire                _zz_targets_1_bestRequest_id_73;
  wire                _zz_targets_1_bestRequest_id_74;
  wire       [1:0]    _zz_targets_1_bestRequest_priority_1;
  wire                _zz_targets_1_bestRequest_id_75;
  wire                _zz_targets_1_bestRequest_id_76;
  wire       [1:0]    _zz_targets_1_bestRequest_priority_2;
  wire                _zz_targets_1_bestRequest_id_77;
  wire                _zz_targets_1_bestRequest_id_78;
  wire       [1:0]    _zz_targets_1_bestRequest_priority_3;
  wire                _zz_targets_1_bestRequest_id_79;
  wire                _zz_targets_1_bestRequest_id_80;
  wire       [1:0]    _zz_targets_1_bestRequest_priority_4;
  wire                _zz_targets_1_bestRequest_valid;
  wire                _zz_targets_1_bestRequest_id_81;
  wire       [1:0]    _zz_targets_1_bestRequest_priority_5;
  wire                _zz_targets_1_bestRequest_valid_1;
  wire                _zz_targets_1_bestRequest_priority_6;
  reg        [1:0]    targets_1_bestRequest_priority;
  reg        [4:0]    targets_1_bestRequest_id;
  reg                 targets_1_bestRequest_valid;
  wire                targets_1_iep;
  wire       [4:0]    targets_1_claim;
  wire                bus_readErrorFlag;
  wire                bus_writeErrorFlag;
  reg                 bus_readHaltRequest;
  wire                bus_writeHaltRequest;
  wire                bus_writeJoinEvent_valid;
  wire                bus_writeJoinEvent_ready;
  wire                bus_writeOccur;
  reg        [1:0]    bus_writeRsp_resp;
  wire                bus_writeJoinEvent_translated_valid;
  wire                bus_writeJoinEvent_translated_ready;
  wire       [1:0]    bus_writeJoinEvent_translated_payload_resp;
  wire                _zz_bus_writeJoinEvent_translated_ready;
  wire                bus_writeJoinEvent_translated_haltWhen_valid;
  wire                bus_writeJoinEvent_translated_haltWhen_ready;
  wire       [1:0]    bus_writeJoinEvent_translated_haltWhen_payload_resp;
  wire                bus_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  wire                bus_writeJoinEvent_translated_haltWhen_halfPipe_ready;
  wire       [1:0]    bus_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  reg                 bus_writeJoinEvent_translated_haltWhen_rValid;
  wire                bus_writeJoinEvent_translated_haltWhen_halfPipe_fire;
  reg        [1:0]    bus_writeJoinEvent_translated_haltWhen_rData_resp;
  wire                bus_readDataStage_valid;
  wire                bus_readDataStage_ready;
  wire       [21:0]   bus_readDataStage_payload_addr;
  wire       [2:0]    bus_readDataStage_payload_prot;
  reg                 io_bus_ar_rValid;
  wire                bus_readDataStage_fire;
  reg        [21:0]   io_bus_ar_rData_addr;
  reg        [2:0]    io_bus_ar_rData_prot;
  reg        [31:0]   bus_readRsp_data;
  reg        [1:0]    bus_readRsp_resp;
  wire                _zz_bus_readDataStage_ready;
  wire                bus_readDataStage_haltWhen_valid;
  wire                bus_readDataStage_haltWhen_ready;
  wire       [21:0]   bus_readDataStage_haltWhen_payload_addr;
  wire       [2:0]    bus_readDataStage_haltWhen_payload_prot;
  wire                bus_readDataStage_haltWhen_translated_valid;
  wire                bus_readDataStage_haltWhen_translated_ready;
  wire       [31:0]   bus_readDataStage_haltWhen_translated_payload_data;
  wire       [1:0]    bus_readDataStage_haltWhen_translated_payload_resp;
  wire       [21:0]   bus_readAddressMasked;
  wire       [21:0]   bus_writeAddressMasked;
  wire                bus_readOccur;
  reg        [1:0]    gateways_0_priority_driver;
  reg        [1:0]    gateways_1_priority_driver;
  reg        [1:0]    gateways_2_priority_driver;
  reg        [1:0]    gateways_3_priority_driver;
  reg        [1:0]    gateways_4_priority_driver;
  reg        [1:0]    gateways_5_priority_driver;
  reg        [1:0]    gateways_6_priority_driver;
  reg        [1:0]    gateways_7_priority_driver;
  reg        [1:0]    gateways_8_priority_driver;
  reg        [1:0]    gateways_9_priority_driver;
  reg        [1:0]    gateways_10_priority_driver;
  reg        [1:0]    gateways_11_priority_driver;
  reg        [1:0]    gateways_12_priority_driver;
  reg        [1:0]    gateways_13_priority_driver;
  reg        [1:0]    gateways_14_priority_driver;
  reg        [1:0]    gateways_15_priority_driver;
  reg        [1:0]    gateways_16_priority_driver;
  reg        [1:0]    gateways_17_priority_driver;
  reg        [1:0]    gateways_18_priority_driver;
  reg        [1:0]    gateways_19_priority_driver;
  reg        [1:0]    gateways_20_priority_driver;
  reg        [1:0]    gateways_21_priority_driver;
  reg        [1:0]    gateways_22_priority_driver;
  reg        [1:0]    gateways_23_priority_driver;
  reg        [1:0]    gateways_24_priority_driver;
  reg        [1:0]    gateways_25_priority_driver;
  reg        [1:0]    gateways_26_priority_driver;
  reg        [1:0]    gateways_27_priority_driver;
  reg        [1:0]    gateways_28_priority_driver;
  reg        [1:0]    gateways_29_priority_driver;
  reg        [1:0]    gateways_30_priority_driver;
  reg                 mapping_claim_valid;
  reg        [4:0]    mapping_claim_payload;
  reg                 mapping_completion_valid;
  reg        [4:0]    mapping_completion_payload;
  reg                 mapping_coherencyStall_willIncrement;
  wire                mapping_coherencyStall_willClear;
  reg        [0:0]    mapping_coherencyStall_valueNext;
  reg        [0:0]    mapping_coherencyStall_value;
  wire                mapping_coherencyStall_willOverflowIfInc;
  wire                mapping_coherencyStall_willOverflow;
  wire                when_PlicMapper_l122;
  reg        [1:0]    targets_0_threshold_driver;
  reg                 mapping_targetMapping_0_targetCompletion_valid;
  wire       [4:0]    mapping_targetMapping_0_targetCompletion_payload;
  reg                 targets_0_ie_0_driver;
  reg                 targets_0_ie_1_driver;
  reg                 targets_0_ie_2_driver;
  reg                 targets_0_ie_3_driver;
  reg                 targets_0_ie_4_driver;
  reg                 targets_0_ie_5_driver;
  reg                 targets_0_ie_6_driver;
  reg                 targets_0_ie_7_driver;
  reg                 targets_0_ie_8_driver;
  reg                 targets_0_ie_9_driver;
  reg                 targets_0_ie_10_driver;
  reg                 targets_0_ie_11_driver;
  reg                 targets_0_ie_12_driver;
  reg                 targets_0_ie_13_driver;
  reg                 targets_0_ie_14_driver;
  reg                 targets_0_ie_15_driver;
  reg                 targets_0_ie_16_driver;
  reg                 targets_0_ie_17_driver;
  reg                 targets_0_ie_18_driver;
  reg                 targets_0_ie_19_driver;
  reg                 targets_0_ie_20_driver;
  reg                 targets_0_ie_21_driver;
  reg                 targets_0_ie_22_driver;
  reg                 targets_0_ie_23_driver;
  reg                 targets_0_ie_24_driver;
  reg                 targets_0_ie_25_driver;
  reg                 targets_0_ie_26_driver;
  reg                 targets_0_ie_27_driver;
  reg                 targets_0_ie_28_driver;
  reg                 targets_0_ie_29_driver;
  reg                 targets_0_ie_30_driver;
  reg        [1:0]    targets_1_threshold_driver;
  reg                 mapping_targetMapping_1_targetCompletion_valid;
  wire       [4:0]    mapping_targetMapping_1_targetCompletion_payload;
  reg                 targets_1_ie_0_driver;
  reg                 targets_1_ie_1_driver;
  reg                 targets_1_ie_2_driver;
  reg                 targets_1_ie_3_driver;
  reg                 targets_1_ie_4_driver;
  reg                 targets_1_ie_5_driver;
  reg                 targets_1_ie_6_driver;
  reg                 targets_1_ie_7_driver;
  reg                 targets_1_ie_8_driver;
  reg                 targets_1_ie_9_driver;
  reg                 targets_1_ie_10_driver;
  reg                 targets_1_ie_11_driver;
  reg                 targets_1_ie_12_driver;
  reg                 targets_1_ie_13_driver;
  reg                 targets_1_ie_14_driver;
  reg                 targets_1_ie_15_driver;
  reg                 targets_1_ie_16_driver;
  reg                 targets_1_ie_17_driver;
  reg                 targets_1_ie_18_driver;
  reg                 targets_1_ie_19_driver;
  reg                 targets_1_ie_20_driver;
  reg                 targets_1_ie_21_driver;
  reg                 targets_1_ie_22_driver;
  reg                 targets_1_ie_23_driver;
  reg                 targets_1_ie_24_driver;
  reg                 targets_1_ie_25_driver;
  reg                 targets_1_ie_26_driver;
  reg                 targets_1_ie_27_driver;
  reg                 targets_1_ie_28_driver;
  reg                 targets_1_ie_29_driver;
  reg                 targets_1_ie_30_driver;
  wire                when_AxiLite4SlaveFactory_l68;
  wire                when_AxiLite4SlaveFactory_l86;

  assign _zz_targets_0_bestRequest_id_82 = (_zz_targets_0_bestRequest_id ? targets_0_requests_0_id : targets_0_requests_1_id);
  assign _zz_targets_0_bestRequest_id_83 = (_zz_targets_0_bestRequest_id_3 ? targets_0_requests_2_id : targets_0_requests_3_id);
  assign _zz_targets_0_bestRequest_id_84 = (_zz_targets_0_bestRequest_id_6 ? targets_0_requests_4_id : targets_0_requests_5_id);
  assign _zz_targets_0_bestRequest_id_85 = (_zz_targets_0_bestRequest_id_9 ? targets_0_requests_6_id : targets_0_requests_7_id);
  assign _zz_targets_0_bestRequest_id_86 = (_zz_targets_0_bestRequest_id_12 ? targets_0_requests_8_id : targets_0_requests_9_id);
  assign _zz_targets_0_bestRequest_id_87 = (_zz_targets_0_bestRequest_id_15 ? targets_0_requests_10_id : targets_0_requests_11_id);
  assign _zz_targets_0_bestRequest_id_88 = (_zz_targets_0_bestRequest_id_18 ? targets_0_requests_12_id : targets_0_requests_13_id);
  assign _zz_targets_0_bestRequest_id_89 = (_zz_targets_0_bestRequest_id_21 ? targets_0_requests_14_id : targets_0_requests_15_id);
  assign _zz_targets_0_bestRequest_id_90 = (_zz_targets_0_bestRequest_id_24 ? targets_0_requests_16_id : targets_0_requests_17_id);
  assign _zz_targets_0_bestRequest_id_91 = (_zz_targets_0_bestRequest_id_27 ? targets_0_requests_18_id : targets_0_requests_19_id);
  assign _zz_targets_0_bestRequest_id_92 = (_zz_targets_0_bestRequest_id_30 ? targets_0_requests_20_id : targets_0_requests_21_id);
  assign _zz_targets_0_bestRequest_id_93 = (_zz_targets_0_bestRequest_id_33 ? targets_0_requests_22_id : targets_0_requests_23_id);
  assign _zz_targets_0_bestRequest_id_94 = (_zz_targets_0_bestRequest_id_36 ? targets_0_requests_24_id : targets_0_requests_25_id);
  assign _zz_targets_0_bestRequest_id_95 = (_zz_targets_0_bestRequest_id_39 ? targets_0_requests_26_id : targets_0_requests_27_id);
  assign _zz_targets_0_bestRequest_id_96 = (_zz_targets_0_bestRequest_id_42 ? targets_0_requests_28_id : targets_0_requests_29_id);
  assign _zz_targets_0_bestRequest_id_97 = (_zz_targets_0_bestRequest_id_45 ? targets_0_requests_30_id : targets_0_requests_31_id);
  assign _zz_targets_1_bestRequest_id_82 = (_zz_targets_1_bestRequest_id ? targets_1_requests_0_id : targets_1_requests_1_id);
  assign _zz_targets_1_bestRequest_id_83 = (_zz_targets_1_bestRequest_id_3 ? targets_1_requests_2_id : targets_1_requests_3_id);
  assign _zz_targets_1_bestRequest_id_84 = (_zz_targets_1_bestRequest_id_6 ? targets_1_requests_4_id : targets_1_requests_5_id);
  assign _zz_targets_1_bestRequest_id_85 = (_zz_targets_1_bestRequest_id_9 ? targets_1_requests_6_id : targets_1_requests_7_id);
  assign _zz_targets_1_bestRequest_id_86 = (_zz_targets_1_bestRequest_id_12 ? targets_1_requests_8_id : targets_1_requests_9_id);
  assign _zz_targets_1_bestRequest_id_87 = (_zz_targets_1_bestRequest_id_15 ? targets_1_requests_10_id : targets_1_requests_11_id);
  assign _zz_targets_1_bestRequest_id_88 = (_zz_targets_1_bestRequest_id_18 ? targets_1_requests_12_id : targets_1_requests_13_id);
  assign _zz_targets_1_bestRequest_id_89 = (_zz_targets_1_bestRequest_id_21 ? targets_1_requests_14_id : targets_1_requests_15_id);
  assign _zz_targets_1_bestRequest_id_90 = (_zz_targets_1_bestRequest_id_24 ? targets_1_requests_16_id : targets_1_requests_17_id);
  assign _zz_targets_1_bestRequest_id_91 = (_zz_targets_1_bestRequest_id_27 ? targets_1_requests_18_id : targets_1_requests_19_id);
  assign _zz_targets_1_bestRequest_id_92 = (_zz_targets_1_bestRequest_id_30 ? targets_1_requests_20_id : targets_1_requests_21_id);
  assign _zz_targets_1_bestRequest_id_93 = (_zz_targets_1_bestRequest_id_33 ? targets_1_requests_22_id : targets_1_requests_23_id);
  assign _zz_targets_1_bestRequest_id_94 = (_zz_targets_1_bestRequest_id_36 ? targets_1_requests_24_id : targets_1_requests_25_id);
  assign _zz_targets_1_bestRequest_id_95 = (_zz_targets_1_bestRequest_id_39 ? targets_1_requests_26_id : targets_1_requests_27_id);
  assign _zz_targets_1_bestRequest_id_96 = (_zz_targets_1_bestRequest_id_42 ? targets_1_requests_28_id : targets_1_requests_29_id);
  assign _zz_targets_1_bestRequest_id_97 = (_zz_targets_1_bestRequest_id_45 ? targets_1_requests_30_id : targets_1_requests_31_id);
  assign _zz_gateways_0_ip = io_sources[0];
  assign _zz_gateways_1_ip = io_sources[1];
  assign _zz_gateways_2_ip = io_sources[2];
  assign _zz_gateways_3_ip = io_sources[3];
  assign _zz_gateways_4_ip = io_sources[4];
  assign _zz_gateways_5_ip = io_sources[5];
  assign _zz_gateways_6_ip = io_sources[6];
  assign _zz_gateways_7_ip = io_sources[7];
  assign _zz_gateways_8_ip = io_sources[8];
  assign _zz_gateways_9_ip = io_sources[9];
  assign _zz_gateways_10_ip = io_sources[10];
  assign _zz_gateways_11_ip = io_sources[11];
  assign _zz_gateways_12_ip = io_sources[12];
  assign _zz_gateways_13_ip = io_sources[13];
  assign _zz_gateways_14_ip = io_sources[14];
  assign _zz_gateways_15_ip = io_sources[15];
  assign _zz_gateways_16_ip = io_sources[16];
  assign _zz_gateways_17_ip = io_sources[17];
  assign _zz_gateways_18_ip = io_sources[18];
  assign _zz_gateways_19_ip = io_sources[19];
  assign _zz_gateways_20_ip = io_sources[20];
  assign _zz_gateways_21_ip = io_sources[21];
  assign _zz_gateways_22_ip = io_sources[22];
  assign _zz_gateways_23_ip = io_sources[23];
  assign _zz_gateways_24_ip = io_sources[24];
  assign _zz_gateways_25_ip = io_sources[25];
  assign _zz_gateways_26_ip = io_sources[26];
  assign _zz_gateways_27_ip = io_sources[27];
  assign _zz_gateways_28_ip = io_sources[28];
  assign _zz_gateways_29_ip = io_sources[29];
  assign _zz_gateways_30_ip = io_sources[30];
  assign when_PlicGateway_l21 = (! gateways_0_waitCompletion);
  assign when_PlicGateway_l21_1 = (! gateways_1_waitCompletion);
  assign when_PlicGateway_l21_2 = (! gateways_2_waitCompletion);
  assign when_PlicGateway_l21_3 = (! gateways_3_waitCompletion);
  assign when_PlicGateway_l21_4 = (! gateways_4_waitCompletion);
  assign when_PlicGateway_l21_5 = (! gateways_5_waitCompletion);
  assign when_PlicGateway_l21_6 = (! gateways_6_waitCompletion);
  assign when_PlicGateway_l21_7 = (! gateways_7_waitCompletion);
  assign when_PlicGateway_l21_8 = (! gateways_8_waitCompletion);
  assign when_PlicGateway_l21_9 = (! gateways_9_waitCompletion);
  assign when_PlicGateway_l21_10 = (! gateways_10_waitCompletion);
  assign when_PlicGateway_l21_11 = (! gateways_11_waitCompletion);
  assign when_PlicGateway_l21_12 = (! gateways_12_waitCompletion);
  assign when_PlicGateway_l21_13 = (! gateways_13_waitCompletion);
  assign when_PlicGateway_l21_14 = (! gateways_14_waitCompletion);
  assign when_PlicGateway_l21_15 = (! gateways_15_waitCompletion);
  assign when_PlicGateway_l21_16 = (! gateways_16_waitCompletion);
  assign when_PlicGateway_l21_17 = (! gateways_17_waitCompletion);
  assign when_PlicGateway_l21_18 = (! gateways_18_waitCompletion);
  assign when_PlicGateway_l21_19 = (! gateways_19_waitCompletion);
  assign when_PlicGateway_l21_20 = (! gateways_20_waitCompletion);
  assign when_PlicGateway_l21_21 = (! gateways_21_waitCompletion);
  assign when_PlicGateway_l21_22 = (! gateways_22_waitCompletion);
  assign when_PlicGateway_l21_23 = (! gateways_23_waitCompletion);
  assign when_PlicGateway_l21_24 = (! gateways_24_waitCompletion);
  assign when_PlicGateway_l21_25 = (! gateways_25_waitCompletion);
  assign when_PlicGateway_l21_26 = (! gateways_26_waitCompletion);
  assign when_PlicGateway_l21_27 = (! gateways_27_waitCompletion);
  assign when_PlicGateway_l21_28 = (! gateways_28_waitCompletion);
  assign when_PlicGateway_l21_29 = (! gateways_29_waitCompletion);
  assign when_PlicGateway_l21_30 = (! gateways_30_waitCompletion);
  assign targets_0_requests_0_priority = 2'b00;
  assign targets_0_requests_0_id = 5'h0;
  assign targets_0_requests_0_valid = 1'b1;
  assign targets_0_requests_1_priority = gateways_0_priority;
  assign targets_0_requests_1_id = 5'h01;
  assign targets_0_requests_1_valid = (gateways_0_ip && targets_0_ie_0);
  assign targets_0_requests_2_priority = gateways_1_priority;
  assign targets_0_requests_2_id = 5'h02;
  assign targets_0_requests_2_valid = (gateways_1_ip && targets_0_ie_1);
  assign targets_0_requests_3_priority = gateways_2_priority;
  assign targets_0_requests_3_id = 5'h03;
  assign targets_0_requests_3_valid = (gateways_2_ip && targets_0_ie_2);
  assign targets_0_requests_4_priority = gateways_3_priority;
  assign targets_0_requests_4_id = 5'h04;
  assign targets_0_requests_4_valid = (gateways_3_ip && targets_0_ie_3);
  assign targets_0_requests_5_priority = gateways_4_priority;
  assign targets_0_requests_5_id = 5'h05;
  assign targets_0_requests_5_valid = (gateways_4_ip && targets_0_ie_4);
  assign targets_0_requests_6_priority = gateways_5_priority;
  assign targets_0_requests_6_id = 5'h06;
  assign targets_0_requests_6_valid = (gateways_5_ip && targets_0_ie_5);
  assign targets_0_requests_7_priority = gateways_6_priority;
  assign targets_0_requests_7_id = 5'h07;
  assign targets_0_requests_7_valid = (gateways_6_ip && targets_0_ie_6);
  assign targets_0_requests_8_priority = gateways_7_priority;
  assign targets_0_requests_8_id = 5'h08;
  assign targets_0_requests_8_valid = (gateways_7_ip && targets_0_ie_7);
  assign targets_0_requests_9_priority = gateways_8_priority;
  assign targets_0_requests_9_id = 5'h09;
  assign targets_0_requests_9_valid = (gateways_8_ip && targets_0_ie_8);
  assign targets_0_requests_10_priority = gateways_9_priority;
  assign targets_0_requests_10_id = 5'h0a;
  assign targets_0_requests_10_valid = (gateways_9_ip && targets_0_ie_9);
  assign targets_0_requests_11_priority = gateways_10_priority;
  assign targets_0_requests_11_id = 5'h0b;
  assign targets_0_requests_11_valid = (gateways_10_ip && targets_0_ie_10);
  assign targets_0_requests_12_priority = gateways_11_priority;
  assign targets_0_requests_12_id = 5'h0c;
  assign targets_0_requests_12_valid = (gateways_11_ip && targets_0_ie_11);
  assign targets_0_requests_13_priority = gateways_12_priority;
  assign targets_0_requests_13_id = 5'h0d;
  assign targets_0_requests_13_valid = (gateways_12_ip && targets_0_ie_12);
  assign targets_0_requests_14_priority = gateways_13_priority;
  assign targets_0_requests_14_id = 5'h0e;
  assign targets_0_requests_14_valid = (gateways_13_ip && targets_0_ie_13);
  assign targets_0_requests_15_priority = gateways_14_priority;
  assign targets_0_requests_15_id = 5'h0f;
  assign targets_0_requests_15_valid = (gateways_14_ip && targets_0_ie_14);
  assign targets_0_requests_16_priority = gateways_15_priority;
  assign targets_0_requests_16_id = 5'h10;
  assign targets_0_requests_16_valid = (gateways_15_ip && targets_0_ie_15);
  assign targets_0_requests_17_priority = gateways_16_priority;
  assign targets_0_requests_17_id = 5'h11;
  assign targets_0_requests_17_valid = (gateways_16_ip && targets_0_ie_16);
  assign targets_0_requests_18_priority = gateways_17_priority;
  assign targets_0_requests_18_id = 5'h12;
  assign targets_0_requests_18_valid = (gateways_17_ip && targets_0_ie_17);
  assign targets_0_requests_19_priority = gateways_18_priority;
  assign targets_0_requests_19_id = 5'h13;
  assign targets_0_requests_19_valid = (gateways_18_ip && targets_0_ie_18);
  assign targets_0_requests_20_priority = gateways_19_priority;
  assign targets_0_requests_20_id = 5'h14;
  assign targets_0_requests_20_valid = (gateways_19_ip && targets_0_ie_19);
  assign targets_0_requests_21_priority = gateways_20_priority;
  assign targets_0_requests_21_id = 5'h15;
  assign targets_0_requests_21_valid = (gateways_20_ip && targets_0_ie_20);
  assign targets_0_requests_22_priority = gateways_21_priority;
  assign targets_0_requests_22_id = 5'h16;
  assign targets_0_requests_22_valid = (gateways_21_ip && targets_0_ie_21);
  assign targets_0_requests_23_priority = gateways_22_priority;
  assign targets_0_requests_23_id = 5'h17;
  assign targets_0_requests_23_valid = (gateways_22_ip && targets_0_ie_22);
  assign targets_0_requests_24_priority = gateways_23_priority;
  assign targets_0_requests_24_id = 5'h18;
  assign targets_0_requests_24_valid = (gateways_23_ip && targets_0_ie_23);
  assign targets_0_requests_25_priority = gateways_24_priority;
  assign targets_0_requests_25_id = 5'h19;
  assign targets_0_requests_25_valid = (gateways_24_ip && targets_0_ie_24);
  assign targets_0_requests_26_priority = gateways_25_priority;
  assign targets_0_requests_26_id = 5'h1a;
  assign targets_0_requests_26_valid = (gateways_25_ip && targets_0_ie_25);
  assign targets_0_requests_27_priority = gateways_26_priority;
  assign targets_0_requests_27_id = 5'h1b;
  assign targets_0_requests_27_valid = (gateways_26_ip && targets_0_ie_26);
  assign targets_0_requests_28_priority = gateways_27_priority;
  assign targets_0_requests_28_id = 5'h1c;
  assign targets_0_requests_28_valid = (gateways_27_ip && targets_0_ie_27);
  assign targets_0_requests_29_priority = gateways_28_priority;
  assign targets_0_requests_29_id = 5'h1d;
  assign targets_0_requests_29_valid = (gateways_28_ip && targets_0_ie_28);
  assign targets_0_requests_30_priority = gateways_29_priority;
  assign targets_0_requests_30_id = 5'h1e;
  assign targets_0_requests_30_valid = (gateways_29_ip && targets_0_ie_29);
  assign targets_0_requests_31_priority = gateways_30_priority;
  assign targets_0_requests_31_id = 5'h1f;
  assign targets_0_requests_31_valid = (gateways_30_ip && targets_0_ie_30);
  assign _zz_targets_0_bestRequest_id = ((! targets_0_requests_1_valid) || (targets_0_requests_0_valid && (targets_0_requests_1_priority <= targets_0_requests_0_priority)));
  assign _zz_targets_0_bestRequest_id_1 = (_zz_targets_0_bestRequest_id ? targets_0_requests_0_priority : targets_0_requests_1_priority);
  assign _zz_targets_0_bestRequest_id_2 = (_zz_targets_0_bestRequest_id ? targets_0_requests_0_valid : targets_0_requests_1_valid);
  assign _zz_targets_0_bestRequest_id_3 = ((! targets_0_requests_3_valid) || (targets_0_requests_2_valid && (targets_0_requests_3_priority <= targets_0_requests_2_priority)));
  assign _zz_targets_0_bestRequest_id_4 = (_zz_targets_0_bestRequest_id_3 ? targets_0_requests_2_priority : targets_0_requests_3_priority);
  assign _zz_targets_0_bestRequest_id_5 = (_zz_targets_0_bestRequest_id_3 ? targets_0_requests_2_valid : targets_0_requests_3_valid);
  assign _zz_targets_0_bestRequest_id_6 = ((! targets_0_requests_5_valid) || (targets_0_requests_4_valid && (targets_0_requests_5_priority <= targets_0_requests_4_priority)));
  assign _zz_targets_0_bestRequest_id_7 = (_zz_targets_0_bestRequest_id_6 ? targets_0_requests_4_priority : targets_0_requests_5_priority);
  assign _zz_targets_0_bestRequest_id_8 = (_zz_targets_0_bestRequest_id_6 ? targets_0_requests_4_valid : targets_0_requests_5_valid);
  assign _zz_targets_0_bestRequest_id_9 = ((! targets_0_requests_7_valid) || (targets_0_requests_6_valid && (targets_0_requests_7_priority <= targets_0_requests_6_priority)));
  assign _zz_targets_0_bestRequest_id_10 = (_zz_targets_0_bestRequest_id_9 ? targets_0_requests_6_priority : targets_0_requests_7_priority);
  assign _zz_targets_0_bestRequest_id_11 = (_zz_targets_0_bestRequest_id_9 ? targets_0_requests_6_valid : targets_0_requests_7_valid);
  assign _zz_targets_0_bestRequest_id_12 = ((! targets_0_requests_9_valid) || (targets_0_requests_8_valid && (targets_0_requests_9_priority <= targets_0_requests_8_priority)));
  assign _zz_targets_0_bestRequest_id_13 = (_zz_targets_0_bestRequest_id_12 ? targets_0_requests_8_priority : targets_0_requests_9_priority);
  assign _zz_targets_0_bestRequest_id_14 = (_zz_targets_0_bestRequest_id_12 ? targets_0_requests_8_valid : targets_0_requests_9_valid);
  assign _zz_targets_0_bestRequest_id_15 = ((! targets_0_requests_11_valid) || (targets_0_requests_10_valid && (targets_0_requests_11_priority <= targets_0_requests_10_priority)));
  assign _zz_targets_0_bestRequest_id_16 = (_zz_targets_0_bestRequest_id_15 ? targets_0_requests_10_priority : targets_0_requests_11_priority);
  assign _zz_targets_0_bestRequest_id_17 = (_zz_targets_0_bestRequest_id_15 ? targets_0_requests_10_valid : targets_0_requests_11_valid);
  assign _zz_targets_0_bestRequest_id_18 = ((! targets_0_requests_13_valid) || (targets_0_requests_12_valid && (targets_0_requests_13_priority <= targets_0_requests_12_priority)));
  assign _zz_targets_0_bestRequest_id_19 = (_zz_targets_0_bestRequest_id_18 ? targets_0_requests_12_priority : targets_0_requests_13_priority);
  assign _zz_targets_0_bestRequest_id_20 = (_zz_targets_0_bestRequest_id_18 ? targets_0_requests_12_valid : targets_0_requests_13_valid);
  assign _zz_targets_0_bestRequest_id_21 = ((! targets_0_requests_15_valid) || (targets_0_requests_14_valid && (targets_0_requests_15_priority <= targets_0_requests_14_priority)));
  assign _zz_targets_0_bestRequest_id_22 = (_zz_targets_0_bestRequest_id_21 ? targets_0_requests_14_priority : targets_0_requests_15_priority);
  assign _zz_targets_0_bestRequest_id_23 = (_zz_targets_0_bestRequest_id_21 ? targets_0_requests_14_valid : targets_0_requests_15_valid);
  assign _zz_targets_0_bestRequest_id_24 = ((! targets_0_requests_17_valid) || (targets_0_requests_16_valid && (targets_0_requests_17_priority <= targets_0_requests_16_priority)));
  assign _zz_targets_0_bestRequest_id_25 = (_zz_targets_0_bestRequest_id_24 ? targets_0_requests_16_priority : targets_0_requests_17_priority);
  assign _zz_targets_0_bestRequest_id_26 = (_zz_targets_0_bestRequest_id_24 ? targets_0_requests_16_valid : targets_0_requests_17_valid);
  assign _zz_targets_0_bestRequest_id_27 = ((! targets_0_requests_19_valid) || (targets_0_requests_18_valid && (targets_0_requests_19_priority <= targets_0_requests_18_priority)));
  assign _zz_targets_0_bestRequest_id_28 = (_zz_targets_0_bestRequest_id_27 ? targets_0_requests_18_priority : targets_0_requests_19_priority);
  assign _zz_targets_0_bestRequest_id_29 = (_zz_targets_0_bestRequest_id_27 ? targets_0_requests_18_valid : targets_0_requests_19_valid);
  assign _zz_targets_0_bestRequest_id_30 = ((! targets_0_requests_21_valid) || (targets_0_requests_20_valid && (targets_0_requests_21_priority <= targets_0_requests_20_priority)));
  assign _zz_targets_0_bestRequest_id_31 = (_zz_targets_0_bestRequest_id_30 ? targets_0_requests_20_priority : targets_0_requests_21_priority);
  assign _zz_targets_0_bestRequest_id_32 = (_zz_targets_0_bestRequest_id_30 ? targets_0_requests_20_valid : targets_0_requests_21_valid);
  assign _zz_targets_0_bestRequest_id_33 = ((! targets_0_requests_23_valid) || (targets_0_requests_22_valid && (targets_0_requests_23_priority <= targets_0_requests_22_priority)));
  assign _zz_targets_0_bestRequest_id_34 = (_zz_targets_0_bestRequest_id_33 ? targets_0_requests_22_priority : targets_0_requests_23_priority);
  assign _zz_targets_0_bestRequest_id_35 = (_zz_targets_0_bestRequest_id_33 ? targets_0_requests_22_valid : targets_0_requests_23_valid);
  assign _zz_targets_0_bestRequest_id_36 = ((! targets_0_requests_25_valid) || (targets_0_requests_24_valid && (targets_0_requests_25_priority <= targets_0_requests_24_priority)));
  assign _zz_targets_0_bestRequest_id_37 = (_zz_targets_0_bestRequest_id_36 ? targets_0_requests_24_priority : targets_0_requests_25_priority);
  assign _zz_targets_0_bestRequest_id_38 = (_zz_targets_0_bestRequest_id_36 ? targets_0_requests_24_valid : targets_0_requests_25_valid);
  assign _zz_targets_0_bestRequest_id_39 = ((! targets_0_requests_27_valid) || (targets_0_requests_26_valid && (targets_0_requests_27_priority <= targets_0_requests_26_priority)));
  assign _zz_targets_0_bestRequest_id_40 = (_zz_targets_0_bestRequest_id_39 ? targets_0_requests_26_priority : targets_0_requests_27_priority);
  assign _zz_targets_0_bestRequest_id_41 = (_zz_targets_0_bestRequest_id_39 ? targets_0_requests_26_valid : targets_0_requests_27_valid);
  assign _zz_targets_0_bestRequest_id_42 = ((! targets_0_requests_29_valid) || (targets_0_requests_28_valid && (targets_0_requests_29_priority <= targets_0_requests_28_priority)));
  assign _zz_targets_0_bestRequest_id_43 = (_zz_targets_0_bestRequest_id_42 ? targets_0_requests_28_priority : targets_0_requests_29_priority);
  assign _zz_targets_0_bestRequest_id_44 = (_zz_targets_0_bestRequest_id_42 ? targets_0_requests_28_valid : targets_0_requests_29_valid);
  assign _zz_targets_0_bestRequest_id_45 = ((! targets_0_requests_31_valid) || (targets_0_requests_30_valid && (targets_0_requests_31_priority <= targets_0_requests_30_priority)));
  assign _zz_targets_0_bestRequest_id_46 = (_zz_targets_0_bestRequest_id_45 ? targets_0_requests_30_priority : targets_0_requests_31_priority);
  assign _zz_targets_0_bestRequest_id_47 = (_zz_targets_0_bestRequest_id_45 ? targets_0_requests_30_valid : targets_0_requests_31_valid);
  assign _zz_targets_0_bestRequest_id_48 = ((! _zz_targets_0_bestRequest_id_5) || (_zz_targets_0_bestRequest_id_2 && (_zz_targets_0_bestRequest_id_4 <= _zz_targets_0_bestRequest_id_1)));
  assign _zz_targets_0_bestRequest_id_49 = (_zz_targets_0_bestRequest_id_48 ? _zz_targets_0_bestRequest_id_1 : _zz_targets_0_bestRequest_id_4);
  assign _zz_targets_0_bestRequest_id_50 = (_zz_targets_0_bestRequest_id_48 ? _zz_targets_0_bestRequest_id_2 : _zz_targets_0_bestRequest_id_5);
  assign _zz_targets_0_bestRequest_id_51 = ((! _zz_targets_0_bestRequest_id_11) || (_zz_targets_0_bestRequest_id_8 && (_zz_targets_0_bestRequest_id_10 <= _zz_targets_0_bestRequest_id_7)));
  assign _zz_targets_0_bestRequest_id_52 = (_zz_targets_0_bestRequest_id_51 ? _zz_targets_0_bestRequest_id_7 : _zz_targets_0_bestRequest_id_10);
  assign _zz_targets_0_bestRequest_id_53 = (_zz_targets_0_bestRequest_id_51 ? _zz_targets_0_bestRequest_id_8 : _zz_targets_0_bestRequest_id_11);
  assign _zz_targets_0_bestRequest_id_54 = ((! _zz_targets_0_bestRequest_id_17) || (_zz_targets_0_bestRequest_id_14 && (_zz_targets_0_bestRequest_id_16 <= _zz_targets_0_bestRequest_id_13)));
  assign _zz_targets_0_bestRequest_id_55 = (_zz_targets_0_bestRequest_id_54 ? _zz_targets_0_bestRequest_id_13 : _zz_targets_0_bestRequest_id_16);
  assign _zz_targets_0_bestRequest_id_56 = (_zz_targets_0_bestRequest_id_54 ? _zz_targets_0_bestRequest_id_14 : _zz_targets_0_bestRequest_id_17);
  assign _zz_targets_0_bestRequest_id_57 = ((! _zz_targets_0_bestRequest_id_23) || (_zz_targets_0_bestRequest_id_20 && (_zz_targets_0_bestRequest_id_22 <= _zz_targets_0_bestRequest_id_19)));
  assign _zz_targets_0_bestRequest_id_58 = (_zz_targets_0_bestRequest_id_57 ? _zz_targets_0_bestRequest_id_19 : _zz_targets_0_bestRequest_id_22);
  assign _zz_targets_0_bestRequest_id_59 = (_zz_targets_0_bestRequest_id_57 ? _zz_targets_0_bestRequest_id_20 : _zz_targets_0_bestRequest_id_23);
  assign _zz_targets_0_bestRequest_id_60 = ((! _zz_targets_0_bestRequest_id_29) || (_zz_targets_0_bestRequest_id_26 && (_zz_targets_0_bestRequest_id_28 <= _zz_targets_0_bestRequest_id_25)));
  assign _zz_targets_0_bestRequest_id_61 = (_zz_targets_0_bestRequest_id_60 ? _zz_targets_0_bestRequest_id_25 : _zz_targets_0_bestRequest_id_28);
  assign _zz_targets_0_bestRequest_id_62 = (_zz_targets_0_bestRequest_id_60 ? _zz_targets_0_bestRequest_id_26 : _zz_targets_0_bestRequest_id_29);
  assign _zz_targets_0_bestRequest_id_63 = ((! _zz_targets_0_bestRequest_id_35) || (_zz_targets_0_bestRequest_id_32 && (_zz_targets_0_bestRequest_id_34 <= _zz_targets_0_bestRequest_id_31)));
  assign _zz_targets_0_bestRequest_id_64 = (_zz_targets_0_bestRequest_id_63 ? _zz_targets_0_bestRequest_id_31 : _zz_targets_0_bestRequest_id_34);
  assign _zz_targets_0_bestRequest_id_65 = (_zz_targets_0_bestRequest_id_63 ? _zz_targets_0_bestRequest_id_32 : _zz_targets_0_bestRequest_id_35);
  assign _zz_targets_0_bestRequest_id_66 = ((! _zz_targets_0_bestRequest_id_41) || (_zz_targets_0_bestRequest_id_38 && (_zz_targets_0_bestRequest_id_40 <= _zz_targets_0_bestRequest_id_37)));
  assign _zz_targets_0_bestRequest_id_67 = (_zz_targets_0_bestRequest_id_66 ? _zz_targets_0_bestRequest_id_37 : _zz_targets_0_bestRequest_id_40);
  assign _zz_targets_0_bestRequest_id_68 = (_zz_targets_0_bestRequest_id_66 ? _zz_targets_0_bestRequest_id_38 : _zz_targets_0_bestRequest_id_41);
  assign _zz_targets_0_bestRequest_id_69 = ((! _zz_targets_0_bestRequest_id_47) || (_zz_targets_0_bestRequest_id_44 && (_zz_targets_0_bestRequest_id_46 <= _zz_targets_0_bestRequest_id_43)));
  assign _zz_targets_0_bestRequest_id_70 = (_zz_targets_0_bestRequest_id_69 ? _zz_targets_0_bestRequest_id_43 : _zz_targets_0_bestRequest_id_46);
  assign _zz_targets_0_bestRequest_id_71 = (_zz_targets_0_bestRequest_id_69 ? _zz_targets_0_bestRequest_id_44 : _zz_targets_0_bestRequest_id_47);
  assign _zz_targets_0_bestRequest_id_72 = ((! _zz_targets_0_bestRequest_id_53) || (_zz_targets_0_bestRequest_id_50 && (_zz_targets_0_bestRequest_id_52 <= _zz_targets_0_bestRequest_id_49)));
  assign _zz_targets_0_bestRequest_priority = (_zz_targets_0_bestRequest_id_72 ? _zz_targets_0_bestRequest_id_49 : _zz_targets_0_bestRequest_id_52);
  assign _zz_targets_0_bestRequest_id_73 = (_zz_targets_0_bestRequest_id_72 ? _zz_targets_0_bestRequest_id_50 : _zz_targets_0_bestRequest_id_53);
  assign _zz_targets_0_bestRequest_id_74 = ((! _zz_targets_0_bestRequest_id_59) || (_zz_targets_0_bestRequest_id_56 && (_zz_targets_0_bestRequest_id_58 <= _zz_targets_0_bestRequest_id_55)));
  assign _zz_targets_0_bestRequest_priority_1 = (_zz_targets_0_bestRequest_id_74 ? _zz_targets_0_bestRequest_id_55 : _zz_targets_0_bestRequest_id_58);
  assign _zz_targets_0_bestRequest_id_75 = (_zz_targets_0_bestRequest_id_74 ? _zz_targets_0_bestRequest_id_56 : _zz_targets_0_bestRequest_id_59);
  assign _zz_targets_0_bestRequest_id_76 = ((! _zz_targets_0_bestRequest_id_65) || (_zz_targets_0_bestRequest_id_62 && (_zz_targets_0_bestRequest_id_64 <= _zz_targets_0_bestRequest_id_61)));
  assign _zz_targets_0_bestRequest_priority_2 = (_zz_targets_0_bestRequest_id_76 ? _zz_targets_0_bestRequest_id_61 : _zz_targets_0_bestRequest_id_64);
  assign _zz_targets_0_bestRequest_id_77 = (_zz_targets_0_bestRequest_id_76 ? _zz_targets_0_bestRequest_id_62 : _zz_targets_0_bestRequest_id_65);
  assign _zz_targets_0_bestRequest_id_78 = ((! _zz_targets_0_bestRequest_id_71) || (_zz_targets_0_bestRequest_id_68 && (_zz_targets_0_bestRequest_id_70 <= _zz_targets_0_bestRequest_id_67)));
  assign _zz_targets_0_bestRequest_priority_3 = (_zz_targets_0_bestRequest_id_78 ? _zz_targets_0_bestRequest_id_67 : _zz_targets_0_bestRequest_id_70);
  assign _zz_targets_0_bestRequest_id_79 = (_zz_targets_0_bestRequest_id_78 ? _zz_targets_0_bestRequest_id_68 : _zz_targets_0_bestRequest_id_71);
  assign _zz_targets_0_bestRequest_id_80 = ((! _zz_targets_0_bestRequest_id_75) || (_zz_targets_0_bestRequest_id_73 && (_zz_targets_0_bestRequest_priority_1 <= _zz_targets_0_bestRequest_priority)));
  assign _zz_targets_0_bestRequest_priority_4 = (_zz_targets_0_bestRequest_id_80 ? _zz_targets_0_bestRequest_priority : _zz_targets_0_bestRequest_priority_1);
  assign _zz_targets_0_bestRequest_valid = (_zz_targets_0_bestRequest_id_80 ? _zz_targets_0_bestRequest_id_73 : _zz_targets_0_bestRequest_id_75);
  assign _zz_targets_0_bestRequest_id_81 = ((! _zz_targets_0_bestRequest_id_79) || (_zz_targets_0_bestRequest_id_77 && (_zz_targets_0_bestRequest_priority_3 <= _zz_targets_0_bestRequest_priority_2)));
  assign _zz_targets_0_bestRequest_priority_5 = (_zz_targets_0_bestRequest_id_81 ? _zz_targets_0_bestRequest_priority_2 : _zz_targets_0_bestRequest_priority_3);
  assign _zz_targets_0_bestRequest_valid_1 = (_zz_targets_0_bestRequest_id_81 ? _zz_targets_0_bestRequest_id_77 : _zz_targets_0_bestRequest_id_79);
  assign _zz_targets_0_bestRequest_priority_6 = ((! _zz_targets_0_bestRequest_valid_1) || (_zz_targets_0_bestRequest_valid && (_zz_targets_0_bestRequest_priority_5 <= _zz_targets_0_bestRequest_priority_4)));
  assign targets_0_iep = (targets_0_threshold < targets_0_bestRequest_priority);
  assign targets_0_claim = (targets_0_iep ? targets_0_bestRequest_id : 5'h0);
  assign targets_1_requests_0_priority = 2'b00;
  assign targets_1_requests_0_id = 5'h0;
  assign targets_1_requests_0_valid = 1'b1;
  assign targets_1_requests_1_priority = gateways_0_priority;
  assign targets_1_requests_1_id = 5'h01;
  assign targets_1_requests_1_valid = (gateways_0_ip && targets_1_ie_0);
  assign targets_1_requests_2_priority = gateways_1_priority;
  assign targets_1_requests_2_id = 5'h02;
  assign targets_1_requests_2_valid = (gateways_1_ip && targets_1_ie_1);
  assign targets_1_requests_3_priority = gateways_2_priority;
  assign targets_1_requests_3_id = 5'h03;
  assign targets_1_requests_3_valid = (gateways_2_ip && targets_1_ie_2);
  assign targets_1_requests_4_priority = gateways_3_priority;
  assign targets_1_requests_4_id = 5'h04;
  assign targets_1_requests_4_valid = (gateways_3_ip && targets_1_ie_3);
  assign targets_1_requests_5_priority = gateways_4_priority;
  assign targets_1_requests_5_id = 5'h05;
  assign targets_1_requests_5_valid = (gateways_4_ip && targets_1_ie_4);
  assign targets_1_requests_6_priority = gateways_5_priority;
  assign targets_1_requests_6_id = 5'h06;
  assign targets_1_requests_6_valid = (gateways_5_ip && targets_1_ie_5);
  assign targets_1_requests_7_priority = gateways_6_priority;
  assign targets_1_requests_7_id = 5'h07;
  assign targets_1_requests_7_valid = (gateways_6_ip && targets_1_ie_6);
  assign targets_1_requests_8_priority = gateways_7_priority;
  assign targets_1_requests_8_id = 5'h08;
  assign targets_1_requests_8_valid = (gateways_7_ip && targets_1_ie_7);
  assign targets_1_requests_9_priority = gateways_8_priority;
  assign targets_1_requests_9_id = 5'h09;
  assign targets_1_requests_9_valid = (gateways_8_ip && targets_1_ie_8);
  assign targets_1_requests_10_priority = gateways_9_priority;
  assign targets_1_requests_10_id = 5'h0a;
  assign targets_1_requests_10_valid = (gateways_9_ip && targets_1_ie_9);
  assign targets_1_requests_11_priority = gateways_10_priority;
  assign targets_1_requests_11_id = 5'h0b;
  assign targets_1_requests_11_valid = (gateways_10_ip && targets_1_ie_10);
  assign targets_1_requests_12_priority = gateways_11_priority;
  assign targets_1_requests_12_id = 5'h0c;
  assign targets_1_requests_12_valid = (gateways_11_ip && targets_1_ie_11);
  assign targets_1_requests_13_priority = gateways_12_priority;
  assign targets_1_requests_13_id = 5'h0d;
  assign targets_1_requests_13_valid = (gateways_12_ip && targets_1_ie_12);
  assign targets_1_requests_14_priority = gateways_13_priority;
  assign targets_1_requests_14_id = 5'h0e;
  assign targets_1_requests_14_valid = (gateways_13_ip && targets_1_ie_13);
  assign targets_1_requests_15_priority = gateways_14_priority;
  assign targets_1_requests_15_id = 5'h0f;
  assign targets_1_requests_15_valid = (gateways_14_ip && targets_1_ie_14);
  assign targets_1_requests_16_priority = gateways_15_priority;
  assign targets_1_requests_16_id = 5'h10;
  assign targets_1_requests_16_valid = (gateways_15_ip && targets_1_ie_15);
  assign targets_1_requests_17_priority = gateways_16_priority;
  assign targets_1_requests_17_id = 5'h11;
  assign targets_1_requests_17_valid = (gateways_16_ip && targets_1_ie_16);
  assign targets_1_requests_18_priority = gateways_17_priority;
  assign targets_1_requests_18_id = 5'h12;
  assign targets_1_requests_18_valid = (gateways_17_ip && targets_1_ie_17);
  assign targets_1_requests_19_priority = gateways_18_priority;
  assign targets_1_requests_19_id = 5'h13;
  assign targets_1_requests_19_valid = (gateways_18_ip && targets_1_ie_18);
  assign targets_1_requests_20_priority = gateways_19_priority;
  assign targets_1_requests_20_id = 5'h14;
  assign targets_1_requests_20_valid = (gateways_19_ip && targets_1_ie_19);
  assign targets_1_requests_21_priority = gateways_20_priority;
  assign targets_1_requests_21_id = 5'h15;
  assign targets_1_requests_21_valid = (gateways_20_ip && targets_1_ie_20);
  assign targets_1_requests_22_priority = gateways_21_priority;
  assign targets_1_requests_22_id = 5'h16;
  assign targets_1_requests_22_valid = (gateways_21_ip && targets_1_ie_21);
  assign targets_1_requests_23_priority = gateways_22_priority;
  assign targets_1_requests_23_id = 5'h17;
  assign targets_1_requests_23_valid = (gateways_22_ip && targets_1_ie_22);
  assign targets_1_requests_24_priority = gateways_23_priority;
  assign targets_1_requests_24_id = 5'h18;
  assign targets_1_requests_24_valid = (gateways_23_ip && targets_1_ie_23);
  assign targets_1_requests_25_priority = gateways_24_priority;
  assign targets_1_requests_25_id = 5'h19;
  assign targets_1_requests_25_valid = (gateways_24_ip && targets_1_ie_24);
  assign targets_1_requests_26_priority = gateways_25_priority;
  assign targets_1_requests_26_id = 5'h1a;
  assign targets_1_requests_26_valid = (gateways_25_ip && targets_1_ie_25);
  assign targets_1_requests_27_priority = gateways_26_priority;
  assign targets_1_requests_27_id = 5'h1b;
  assign targets_1_requests_27_valid = (gateways_26_ip && targets_1_ie_26);
  assign targets_1_requests_28_priority = gateways_27_priority;
  assign targets_1_requests_28_id = 5'h1c;
  assign targets_1_requests_28_valid = (gateways_27_ip && targets_1_ie_27);
  assign targets_1_requests_29_priority = gateways_28_priority;
  assign targets_1_requests_29_id = 5'h1d;
  assign targets_1_requests_29_valid = (gateways_28_ip && targets_1_ie_28);
  assign targets_1_requests_30_priority = gateways_29_priority;
  assign targets_1_requests_30_id = 5'h1e;
  assign targets_1_requests_30_valid = (gateways_29_ip && targets_1_ie_29);
  assign targets_1_requests_31_priority = gateways_30_priority;
  assign targets_1_requests_31_id = 5'h1f;
  assign targets_1_requests_31_valid = (gateways_30_ip && targets_1_ie_30);
  assign _zz_targets_1_bestRequest_id = ((! targets_1_requests_1_valid) || (targets_1_requests_0_valid && (targets_1_requests_1_priority <= targets_1_requests_0_priority)));
  assign _zz_targets_1_bestRequest_id_1 = (_zz_targets_1_bestRequest_id ? targets_1_requests_0_priority : targets_1_requests_1_priority);
  assign _zz_targets_1_bestRequest_id_2 = (_zz_targets_1_bestRequest_id ? targets_1_requests_0_valid : targets_1_requests_1_valid);
  assign _zz_targets_1_bestRequest_id_3 = ((! targets_1_requests_3_valid) || (targets_1_requests_2_valid && (targets_1_requests_3_priority <= targets_1_requests_2_priority)));
  assign _zz_targets_1_bestRequest_id_4 = (_zz_targets_1_bestRequest_id_3 ? targets_1_requests_2_priority : targets_1_requests_3_priority);
  assign _zz_targets_1_bestRequest_id_5 = (_zz_targets_1_bestRequest_id_3 ? targets_1_requests_2_valid : targets_1_requests_3_valid);
  assign _zz_targets_1_bestRequest_id_6 = ((! targets_1_requests_5_valid) || (targets_1_requests_4_valid && (targets_1_requests_5_priority <= targets_1_requests_4_priority)));
  assign _zz_targets_1_bestRequest_id_7 = (_zz_targets_1_bestRequest_id_6 ? targets_1_requests_4_priority : targets_1_requests_5_priority);
  assign _zz_targets_1_bestRequest_id_8 = (_zz_targets_1_bestRequest_id_6 ? targets_1_requests_4_valid : targets_1_requests_5_valid);
  assign _zz_targets_1_bestRequest_id_9 = ((! targets_1_requests_7_valid) || (targets_1_requests_6_valid && (targets_1_requests_7_priority <= targets_1_requests_6_priority)));
  assign _zz_targets_1_bestRequest_id_10 = (_zz_targets_1_bestRequest_id_9 ? targets_1_requests_6_priority : targets_1_requests_7_priority);
  assign _zz_targets_1_bestRequest_id_11 = (_zz_targets_1_bestRequest_id_9 ? targets_1_requests_6_valid : targets_1_requests_7_valid);
  assign _zz_targets_1_bestRequest_id_12 = ((! targets_1_requests_9_valid) || (targets_1_requests_8_valid && (targets_1_requests_9_priority <= targets_1_requests_8_priority)));
  assign _zz_targets_1_bestRequest_id_13 = (_zz_targets_1_bestRequest_id_12 ? targets_1_requests_8_priority : targets_1_requests_9_priority);
  assign _zz_targets_1_bestRequest_id_14 = (_zz_targets_1_bestRequest_id_12 ? targets_1_requests_8_valid : targets_1_requests_9_valid);
  assign _zz_targets_1_bestRequest_id_15 = ((! targets_1_requests_11_valid) || (targets_1_requests_10_valid && (targets_1_requests_11_priority <= targets_1_requests_10_priority)));
  assign _zz_targets_1_bestRequest_id_16 = (_zz_targets_1_bestRequest_id_15 ? targets_1_requests_10_priority : targets_1_requests_11_priority);
  assign _zz_targets_1_bestRequest_id_17 = (_zz_targets_1_bestRequest_id_15 ? targets_1_requests_10_valid : targets_1_requests_11_valid);
  assign _zz_targets_1_bestRequest_id_18 = ((! targets_1_requests_13_valid) || (targets_1_requests_12_valid && (targets_1_requests_13_priority <= targets_1_requests_12_priority)));
  assign _zz_targets_1_bestRequest_id_19 = (_zz_targets_1_bestRequest_id_18 ? targets_1_requests_12_priority : targets_1_requests_13_priority);
  assign _zz_targets_1_bestRequest_id_20 = (_zz_targets_1_bestRequest_id_18 ? targets_1_requests_12_valid : targets_1_requests_13_valid);
  assign _zz_targets_1_bestRequest_id_21 = ((! targets_1_requests_15_valid) || (targets_1_requests_14_valid && (targets_1_requests_15_priority <= targets_1_requests_14_priority)));
  assign _zz_targets_1_bestRequest_id_22 = (_zz_targets_1_bestRequest_id_21 ? targets_1_requests_14_priority : targets_1_requests_15_priority);
  assign _zz_targets_1_bestRequest_id_23 = (_zz_targets_1_bestRequest_id_21 ? targets_1_requests_14_valid : targets_1_requests_15_valid);
  assign _zz_targets_1_bestRequest_id_24 = ((! targets_1_requests_17_valid) || (targets_1_requests_16_valid && (targets_1_requests_17_priority <= targets_1_requests_16_priority)));
  assign _zz_targets_1_bestRequest_id_25 = (_zz_targets_1_bestRequest_id_24 ? targets_1_requests_16_priority : targets_1_requests_17_priority);
  assign _zz_targets_1_bestRequest_id_26 = (_zz_targets_1_bestRequest_id_24 ? targets_1_requests_16_valid : targets_1_requests_17_valid);
  assign _zz_targets_1_bestRequest_id_27 = ((! targets_1_requests_19_valid) || (targets_1_requests_18_valid && (targets_1_requests_19_priority <= targets_1_requests_18_priority)));
  assign _zz_targets_1_bestRequest_id_28 = (_zz_targets_1_bestRequest_id_27 ? targets_1_requests_18_priority : targets_1_requests_19_priority);
  assign _zz_targets_1_bestRequest_id_29 = (_zz_targets_1_bestRequest_id_27 ? targets_1_requests_18_valid : targets_1_requests_19_valid);
  assign _zz_targets_1_bestRequest_id_30 = ((! targets_1_requests_21_valid) || (targets_1_requests_20_valid && (targets_1_requests_21_priority <= targets_1_requests_20_priority)));
  assign _zz_targets_1_bestRequest_id_31 = (_zz_targets_1_bestRequest_id_30 ? targets_1_requests_20_priority : targets_1_requests_21_priority);
  assign _zz_targets_1_bestRequest_id_32 = (_zz_targets_1_bestRequest_id_30 ? targets_1_requests_20_valid : targets_1_requests_21_valid);
  assign _zz_targets_1_bestRequest_id_33 = ((! targets_1_requests_23_valid) || (targets_1_requests_22_valid && (targets_1_requests_23_priority <= targets_1_requests_22_priority)));
  assign _zz_targets_1_bestRequest_id_34 = (_zz_targets_1_bestRequest_id_33 ? targets_1_requests_22_priority : targets_1_requests_23_priority);
  assign _zz_targets_1_bestRequest_id_35 = (_zz_targets_1_bestRequest_id_33 ? targets_1_requests_22_valid : targets_1_requests_23_valid);
  assign _zz_targets_1_bestRequest_id_36 = ((! targets_1_requests_25_valid) || (targets_1_requests_24_valid && (targets_1_requests_25_priority <= targets_1_requests_24_priority)));
  assign _zz_targets_1_bestRequest_id_37 = (_zz_targets_1_bestRequest_id_36 ? targets_1_requests_24_priority : targets_1_requests_25_priority);
  assign _zz_targets_1_bestRequest_id_38 = (_zz_targets_1_bestRequest_id_36 ? targets_1_requests_24_valid : targets_1_requests_25_valid);
  assign _zz_targets_1_bestRequest_id_39 = ((! targets_1_requests_27_valid) || (targets_1_requests_26_valid && (targets_1_requests_27_priority <= targets_1_requests_26_priority)));
  assign _zz_targets_1_bestRequest_id_40 = (_zz_targets_1_bestRequest_id_39 ? targets_1_requests_26_priority : targets_1_requests_27_priority);
  assign _zz_targets_1_bestRequest_id_41 = (_zz_targets_1_bestRequest_id_39 ? targets_1_requests_26_valid : targets_1_requests_27_valid);
  assign _zz_targets_1_bestRequest_id_42 = ((! targets_1_requests_29_valid) || (targets_1_requests_28_valid && (targets_1_requests_29_priority <= targets_1_requests_28_priority)));
  assign _zz_targets_1_bestRequest_id_43 = (_zz_targets_1_bestRequest_id_42 ? targets_1_requests_28_priority : targets_1_requests_29_priority);
  assign _zz_targets_1_bestRequest_id_44 = (_zz_targets_1_bestRequest_id_42 ? targets_1_requests_28_valid : targets_1_requests_29_valid);
  assign _zz_targets_1_bestRequest_id_45 = ((! targets_1_requests_31_valid) || (targets_1_requests_30_valid && (targets_1_requests_31_priority <= targets_1_requests_30_priority)));
  assign _zz_targets_1_bestRequest_id_46 = (_zz_targets_1_bestRequest_id_45 ? targets_1_requests_30_priority : targets_1_requests_31_priority);
  assign _zz_targets_1_bestRequest_id_47 = (_zz_targets_1_bestRequest_id_45 ? targets_1_requests_30_valid : targets_1_requests_31_valid);
  assign _zz_targets_1_bestRequest_id_48 = ((! _zz_targets_1_bestRequest_id_5) || (_zz_targets_1_bestRequest_id_2 && (_zz_targets_1_bestRequest_id_4 <= _zz_targets_1_bestRequest_id_1)));
  assign _zz_targets_1_bestRequest_id_49 = (_zz_targets_1_bestRequest_id_48 ? _zz_targets_1_bestRequest_id_1 : _zz_targets_1_bestRequest_id_4);
  assign _zz_targets_1_bestRequest_id_50 = (_zz_targets_1_bestRequest_id_48 ? _zz_targets_1_bestRequest_id_2 : _zz_targets_1_bestRequest_id_5);
  assign _zz_targets_1_bestRequest_id_51 = ((! _zz_targets_1_bestRequest_id_11) || (_zz_targets_1_bestRequest_id_8 && (_zz_targets_1_bestRequest_id_10 <= _zz_targets_1_bestRequest_id_7)));
  assign _zz_targets_1_bestRequest_id_52 = (_zz_targets_1_bestRequest_id_51 ? _zz_targets_1_bestRequest_id_7 : _zz_targets_1_bestRequest_id_10);
  assign _zz_targets_1_bestRequest_id_53 = (_zz_targets_1_bestRequest_id_51 ? _zz_targets_1_bestRequest_id_8 : _zz_targets_1_bestRequest_id_11);
  assign _zz_targets_1_bestRequest_id_54 = ((! _zz_targets_1_bestRequest_id_17) || (_zz_targets_1_bestRequest_id_14 && (_zz_targets_1_bestRequest_id_16 <= _zz_targets_1_bestRequest_id_13)));
  assign _zz_targets_1_bestRequest_id_55 = (_zz_targets_1_bestRequest_id_54 ? _zz_targets_1_bestRequest_id_13 : _zz_targets_1_bestRequest_id_16);
  assign _zz_targets_1_bestRequest_id_56 = (_zz_targets_1_bestRequest_id_54 ? _zz_targets_1_bestRequest_id_14 : _zz_targets_1_bestRequest_id_17);
  assign _zz_targets_1_bestRequest_id_57 = ((! _zz_targets_1_bestRequest_id_23) || (_zz_targets_1_bestRequest_id_20 && (_zz_targets_1_bestRequest_id_22 <= _zz_targets_1_bestRequest_id_19)));
  assign _zz_targets_1_bestRequest_id_58 = (_zz_targets_1_bestRequest_id_57 ? _zz_targets_1_bestRequest_id_19 : _zz_targets_1_bestRequest_id_22);
  assign _zz_targets_1_bestRequest_id_59 = (_zz_targets_1_bestRequest_id_57 ? _zz_targets_1_bestRequest_id_20 : _zz_targets_1_bestRequest_id_23);
  assign _zz_targets_1_bestRequest_id_60 = ((! _zz_targets_1_bestRequest_id_29) || (_zz_targets_1_bestRequest_id_26 && (_zz_targets_1_bestRequest_id_28 <= _zz_targets_1_bestRequest_id_25)));
  assign _zz_targets_1_bestRequest_id_61 = (_zz_targets_1_bestRequest_id_60 ? _zz_targets_1_bestRequest_id_25 : _zz_targets_1_bestRequest_id_28);
  assign _zz_targets_1_bestRequest_id_62 = (_zz_targets_1_bestRequest_id_60 ? _zz_targets_1_bestRequest_id_26 : _zz_targets_1_bestRequest_id_29);
  assign _zz_targets_1_bestRequest_id_63 = ((! _zz_targets_1_bestRequest_id_35) || (_zz_targets_1_bestRequest_id_32 && (_zz_targets_1_bestRequest_id_34 <= _zz_targets_1_bestRequest_id_31)));
  assign _zz_targets_1_bestRequest_id_64 = (_zz_targets_1_bestRequest_id_63 ? _zz_targets_1_bestRequest_id_31 : _zz_targets_1_bestRequest_id_34);
  assign _zz_targets_1_bestRequest_id_65 = (_zz_targets_1_bestRequest_id_63 ? _zz_targets_1_bestRequest_id_32 : _zz_targets_1_bestRequest_id_35);
  assign _zz_targets_1_bestRequest_id_66 = ((! _zz_targets_1_bestRequest_id_41) || (_zz_targets_1_bestRequest_id_38 && (_zz_targets_1_bestRequest_id_40 <= _zz_targets_1_bestRequest_id_37)));
  assign _zz_targets_1_bestRequest_id_67 = (_zz_targets_1_bestRequest_id_66 ? _zz_targets_1_bestRequest_id_37 : _zz_targets_1_bestRequest_id_40);
  assign _zz_targets_1_bestRequest_id_68 = (_zz_targets_1_bestRequest_id_66 ? _zz_targets_1_bestRequest_id_38 : _zz_targets_1_bestRequest_id_41);
  assign _zz_targets_1_bestRequest_id_69 = ((! _zz_targets_1_bestRequest_id_47) || (_zz_targets_1_bestRequest_id_44 && (_zz_targets_1_bestRequest_id_46 <= _zz_targets_1_bestRequest_id_43)));
  assign _zz_targets_1_bestRequest_id_70 = (_zz_targets_1_bestRequest_id_69 ? _zz_targets_1_bestRequest_id_43 : _zz_targets_1_bestRequest_id_46);
  assign _zz_targets_1_bestRequest_id_71 = (_zz_targets_1_bestRequest_id_69 ? _zz_targets_1_bestRequest_id_44 : _zz_targets_1_bestRequest_id_47);
  assign _zz_targets_1_bestRequest_id_72 = ((! _zz_targets_1_bestRequest_id_53) || (_zz_targets_1_bestRequest_id_50 && (_zz_targets_1_bestRequest_id_52 <= _zz_targets_1_bestRequest_id_49)));
  assign _zz_targets_1_bestRequest_priority = (_zz_targets_1_bestRequest_id_72 ? _zz_targets_1_bestRequest_id_49 : _zz_targets_1_bestRequest_id_52);
  assign _zz_targets_1_bestRequest_id_73 = (_zz_targets_1_bestRequest_id_72 ? _zz_targets_1_bestRequest_id_50 : _zz_targets_1_bestRequest_id_53);
  assign _zz_targets_1_bestRequest_id_74 = ((! _zz_targets_1_bestRequest_id_59) || (_zz_targets_1_bestRequest_id_56 && (_zz_targets_1_bestRequest_id_58 <= _zz_targets_1_bestRequest_id_55)));
  assign _zz_targets_1_bestRequest_priority_1 = (_zz_targets_1_bestRequest_id_74 ? _zz_targets_1_bestRequest_id_55 : _zz_targets_1_bestRequest_id_58);
  assign _zz_targets_1_bestRequest_id_75 = (_zz_targets_1_bestRequest_id_74 ? _zz_targets_1_bestRequest_id_56 : _zz_targets_1_bestRequest_id_59);
  assign _zz_targets_1_bestRequest_id_76 = ((! _zz_targets_1_bestRequest_id_65) || (_zz_targets_1_bestRequest_id_62 && (_zz_targets_1_bestRequest_id_64 <= _zz_targets_1_bestRequest_id_61)));
  assign _zz_targets_1_bestRequest_priority_2 = (_zz_targets_1_bestRequest_id_76 ? _zz_targets_1_bestRequest_id_61 : _zz_targets_1_bestRequest_id_64);
  assign _zz_targets_1_bestRequest_id_77 = (_zz_targets_1_bestRequest_id_76 ? _zz_targets_1_bestRequest_id_62 : _zz_targets_1_bestRequest_id_65);
  assign _zz_targets_1_bestRequest_id_78 = ((! _zz_targets_1_bestRequest_id_71) || (_zz_targets_1_bestRequest_id_68 && (_zz_targets_1_bestRequest_id_70 <= _zz_targets_1_bestRequest_id_67)));
  assign _zz_targets_1_bestRequest_priority_3 = (_zz_targets_1_bestRequest_id_78 ? _zz_targets_1_bestRequest_id_67 : _zz_targets_1_bestRequest_id_70);
  assign _zz_targets_1_bestRequest_id_79 = (_zz_targets_1_bestRequest_id_78 ? _zz_targets_1_bestRequest_id_68 : _zz_targets_1_bestRequest_id_71);
  assign _zz_targets_1_bestRequest_id_80 = ((! _zz_targets_1_bestRequest_id_75) || (_zz_targets_1_bestRequest_id_73 && (_zz_targets_1_bestRequest_priority_1 <= _zz_targets_1_bestRequest_priority)));
  assign _zz_targets_1_bestRequest_priority_4 = (_zz_targets_1_bestRequest_id_80 ? _zz_targets_1_bestRequest_priority : _zz_targets_1_bestRequest_priority_1);
  assign _zz_targets_1_bestRequest_valid = (_zz_targets_1_bestRequest_id_80 ? _zz_targets_1_bestRequest_id_73 : _zz_targets_1_bestRequest_id_75);
  assign _zz_targets_1_bestRequest_id_81 = ((! _zz_targets_1_bestRequest_id_79) || (_zz_targets_1_bestRequest_id_77 && (_zz_targets_1_bestRequest_priority_3 <= _zz_targets_1_bestRequest_priority_2)));
  assign _zz_targets_1_bestRequest_priority_5 = (_zz_targets_1_bestRequest_id_81 ? _zz_targets_1_bestRequest_priority_2 : _zz_targets_1_bestRequest_priority_3);
  assign _zz_targets_1_bestRequest_valid_1 = (_zz_targets_1_bestRequest_id_81 ? _zz_targets_1_bestRequest_id_77 : _zz_targets_1_bestRequest_id_79);
  assign _zz_targets_1_bestRequest_priority_6 = ((! _zz_targets_1_bestRequest_valid_1) || (_zz_targets_1_bestRequest_valid && (_zz_targets_1_bestRequest_priority_5 <= _zz_targets_1_bestRequest_priority_4)));
  assign targets_1_iep = (targets_1_threshold < targets_1_bestRequest_priority);
  assign targets_1_claim = (targets_1_iep ? targets_1_bestRequest_id : 5'h0);
  assign io_targets = {targets_1_iep,targets_0_iep};
  assign bus_readErrorFlag = 1'b0;
  assign bus_writeErrorFlag = 1'b0;
  always @(*) begin
    bus_readHaltRequest = 1'b0;
    if(when_PlicMapper_l122) begin
      bus_readHaltRequest = 1'b1;
    end
  end

  assign bus_writeHaltRequest = 1'b0;
  assign bus_writeOccur = (bus_writeJoinEvent_valid && bus_writeJoinEvent_ready);
  assign bus_writeJoinEvent_valid = (io_bus_aw_valid && io_bus_w_valid);
  assign io_bus_aw_ready = bus_writeOccur;
  assign io_bus_w_ready = bus_writeOccur;
  assign bus_writeJoinEvent_translated_valid = bus_writeJoinEvent_valid;
  assign bus_writeJoinEvent_ready = bus_writeJoinEvent_translated_ready;
  assign bus_writeJoinEvent_translated_payload_resp = bus_writeRsp_resp;
  assign _zz_bus_writeJoinEvent_translated_ready = (! bus_writeHaltRequest);
  assign bus_writeJoinEvent_translated_haltWhen_valid = (bus_writeJoinEvent_translated_valid && _zz_bus_writeJoinEvent_translated_ready);
  assign bus_writeJoinEvent_translated_ready = (bus_writeJoinEvent_translated_haltWhen_ready && _zz_bus_writeJoinEvent_translated_ready);
  assign bus_writeJoinEvent_translated_haltWhen_payload_resp = bus_writeJoinEvent_translated_payload_resp;
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_fire = (bus_writeJoinEvent_translated_haltWhen_halfPipe_valid && bus_writeJoinEvent_translated_haltWhen_halfPipe_ready);
  assign bus_writeJoinEvent_translated_haltWhen_ready = (! bus_writeJoinEvent_translated_haltWhen_rValid);
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_valid = bus_writeJoinEvent_translated_haltWhen_rValid;
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp = bus_writeJoinEvent_translated_haltWhen_rData_resp;
  assign io_bus_b_valid = bus_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_ready = io_bus_b_ready;
  assign io_bus_b_payload_resp = bus_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  assign bus_readDataStage_fire = (bus_readDataStage_valid && bus_readDataStage_ready);
  assign io_bus_ar_ready = (! io_bus_ar_rValid);
  assign bus_readDataStage_valid = io_bus_ar_rValid;
  assign bus_readDataStage_payload_addr = io_bus_ar_rData_addr;
  assign bus_readDataStage_payload_prot = io_bus_ar_rData_prot;
  assign _zz_bus_readDataStage_ready = (! bus_readHaltRequest);
  assign bus_readDataStage_haltWhen_valid = (bus_readDataStage_valid && _zz_bus_readDataStage_ready);
  assign bus_readDataStage_ready = (bus_readDataStage_haltWhen_ready && _zz_bus_readDataStage_ready);
  assign bus_readDataStage_haltWhen_payload_addr = bus_readDataStage_payload_addr;
  assign bus_readDataStage_haltWhen_payload_prot = bus_readDataStage_payload_prot;
  assign bus_readDataStage_haltWhen_translated_valid = bus_readDataStage_haltWhen_valid;
  assign bus_readDataStage_haltWhen_ready = bus_readDataStage_haltWhen_translated_ready;
  assign bus_readDataStage_haltWhen_translated_payload_data = bus_readRsp_data;
  assign bus_readDataStage_haltWhen_translated_payload_resp = bus_readRsp_resp;
  assign io_bus_r_valid = bus_readDataStage_haltWhen_translated_valid;
  assign bus_readDataStage_haltWhen_translated_ready = io_bus_r_ready;
  assign io_bus_r_payload_data = bus_readDataStage_haltWhen_translated_payload_data;
  assign io_bus_r_payload_resp = bus_readDataStage_haltWhen_translated_payload_resp;
  always @(*) begin
    if(bus_writeErrorFlag) begin
      bus_writeRsp_resp = 2'b10;
    end else begin
      bus_writeRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    if(bus_readErrorFlag) begin
      bus_readRsp_resp = 2'b10;
    end else begin
      bus_readRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    bus_readRsp_data = 32'h0;
    case(bus_readAddressMasked)
      22'h000004 : begin
        bus_readRsp_data[1 : 0] = gateways_0_priority;
      end
      22'h001000 : begin
        bus_readRsp_data[1 : 1] = gateways_0_ip;
        bus_readRsp_data[2 : 2] = gateways_1_ip;
        bus_readRsp_data[3 : 3] = gateways_2_ip;
        bus_readRsp_data[4 : 4] = gateways_3_ip;
        bus_readRsp_data[5 : 5] = gateways_4_ip;
        bus_readRsp_data[6 : 6] = gateways_5_ip;
        bus_readRsp_data[7 : 7] = gateways_6_ip;
        bus_readRsp_data[8 : 8] = gateways_7_ip;
        bus_readRsp_data[9 : 9] = gateways_8_ip;
        bus_readRsp_data[10 : 10] = gateways_9_ip;
        bus_readRsp_data[11 : 11] = gateways_10_ip;
        bus_readRsp_data[12 : 12] = gateways_11_ip;
        bus_readRsp_data[13 : 13] = gateways_12_ip;
        bus_readRsp_data[14 : 14] = gateways_13_ip;
        bus_readRsp_data[15 : 15] = gateways_14_ip;
        bus_readRsp_data[16 : 16] = gateways_15_ip;
        bus_readRsp_data[17 : 17] = gateways_16_ip;
        bus_readRsp_data[18 : 18] = gateways_17_ip;
        bus_readRsp_data[19 : 19] = gateways_18_ip;
        bus_readRsp_data[20 : 20] = gateways_19_ip;
        bus_readRsp_data[21 : 21] = gateways_20_ip;
        bus_readRsp_data[22 : 22] = gateways_21_ip;
        bus_readRsp_data[23 : 23] = gateways_22_ip;
        bus_readRsp_data[24 : 24] = gateways_23_ip;
        bus_readRsp_data[25 : 25] = gateways_24_ip;
        bus_readRsp_data[26 : 26] = gateways_25_ip;
        bus_readRsp_data[27 : 27] = gateways_26_ip;
        bus_readRsp_data[28 : 28] = gateways_27_ip;
        bus_readRsp_data[29 : 29] = gateways_28_ip;
        bus_readRsp_data[30 : 30] = gateways_29_ip;
        bus_readRsp_data[31 : 31] = gateways_30_ip;
      end
      22'h000008 : begin
        bus_readRsp_data[1 : 0] = gateways_1_priority;
      end
      22'h00000c : begin
        bus_readRsp_data[1 : 0] = gateways_2_priority;
      end
      22'h000010 : begin
        bus_readRsp_data[1 : 0] = gateways_3_priority;
      end
      22'h000014 : begin
        bus_readRsp_data[1 : 0] = gateways_4_priority;
      end
      22'h000018 : begin
        bus_readRsp_data[1 : 0] = gateways_5_priority;
      end
      22'h00001c : begin
        bus_readRsp_data[1 : 0] = gateways_6_priority;
      end
      22'h000020 : begin
        bus_readRsp_data[1 : 0] = gateways_7_priority;
      end
      22'h000024 : begin
        bus_readRsp_data[1 : 0] = gateways_8_priority;
      end
      22'h000028 : begin
        bus_readRsp_data[1 : 0] = gateways_9_priority;
      end
      22'h00002c : begin
        bus_readRsp_data[1 : 0] = gateways_10_priority;
      end
      22'h000030 : begin
        bus_readRsp_data[1 : 0] = gateways_11_priority;
      end
      22'h000034 : begin
        bus_readRsp_data[1 : 0] = gateways_12_priority;
      end
      22'h000038 : begin
        bus_readRsp_data[1 : 0] = gateways_13_priority;
      end
      22'h00003c : begin
        bus_readRsp_data[1 : 0] = gateways_14_priority;
      end
      22'h000040 : begin
        bus_readRsp_data[1 : 0] = gateways_15_priority;
      end
      22'h000044 : begin
        bus_readRsp_data[1 : 0] = gateways_16_priority;
      end
      22'h000048 : begin
        bus_readRsp_data[1 : 0] = gateways_17_priority;
      end
      22'h00004c : begin
        bus_readRsp_data[1 : 0] = gateways_18_priority;
      end
      22'h000050 : begin
        bus_readRsp_data[1 : 0] = gateways_19_priority;
      end
      22'h000054 : begin
        bus_readRsp_data[1 : 0] = gateways_20_priority;
      end
      22'h000058 : begin
        bus_readRsp_data[1 : 0] = gateways_21_priority;
      end
      22'h00005c : begin
        bus_readRsp_data[1 : 0] = gateways_22_priority;
      end
      22'h000060 : begin
        bus_readRsp_data[1 : 0] = gateways_23_priority;
      end
      22'h000064 : begin
        bus_readRsp_data[1 : 0] = gateways_24_priority;
      end
      22'h000068 : begin
        bus_readRsp_data[1 : 0] = gateways_25_priority;
      end
      22'h00006c : begin
        bus_readRsp_data[1 : 0] = gateways_26_priority;
      end
      22'h000070 : begin
        bus_readRsp_data[1 : 0] = gateways_27_priority;
      end
      22'h000074 : begin
        bus_readRsp_data[1 : 0] = gateways_28_priority;
      end
      22'h000078 : begin
        bus_readRsp_data[1 : 0] = gateways_29_priority;
      end
      22'h00007c : begin
        bus_readRsp_data[1 : 0] = gateways_30_priority;
      end
      22'h200000 : begin
        bus_readRsp_data[1 : 0] = targets_0_threshold;
      end
      22'h200004 : begin
        bus_readRsp_data[4 : 0] = targets_0_claim;
      end
      22'h002000 : begin
        bus_readRsp_data[1 : 1] = targets_0_ie_0;
        bus_readRsp_data[2 : 2] = targets_0_ie_1;
        bus_readRsp_data[3 : 3] = targets_0_ie_2;
        bus_readRsp_data[4 : 4] = targets_0_ie_3;
        bus_readRsp_data[5 : 5] = targets_0_ie_4;
        bus_readRsp_data[6 : 6] = targets_0_ie_5;
        bus_readRsp_data[7 : 7] = targets_0_ie_6;
        bus_readRsp_data[8 : 8] = targets_0_ie_7;
        bus_readRsp_data[9 : 9] = targets_0_ie_8;
        bus_readRsp_data[10 : 10] = targets_0_ie_9;
        bus_readRsp_data[11 : 11] = targets_0_ie_10;
        bus_readRsp_data[12 : 12] = targets_0_ie_11;
        bus_readRsp_data[13 : 13] = targets_0_ie_12;
        bus_readRsp_data[14 : 14] = targets_0_ie_13;
        bus_readRsp_data[15 : 15] = targets_0_ie_14;
        bus_readRsp_data[16 : 16] = targets_0_ie_15;
        bus_readRsp_data[17 : 17] = targets_0_ie_16;
        bus_readRsp_data[18 : 18] = targets_0_ie_17;
        bus_readRsp_data[19 : 19] = targets_0_ie_18;
        bus_readRsp_data[20 : 20] = targets_0_ie_19;
        bus_readRsp_data[21 : 21] = targets_0_ie_20;
        bus_readRsp_data[22 : 22] = targets_0_ie_21;
        bus_readRsp_data[23 : 23] = targets_0_ie_22;
        bus_readRsp_data[24 : 24] = targets_0_ie_23;
        bus_readRsp_data[25 : 25] = targets_0_ie_24;
        bus_readRsp_data[26 : 26] = targets_0_ie_25;
        bus_readRsp_data[27 : 27] = targets_0_ie_26;
        bus_readRsp_data[28 : 28] = targets_0_ie_27;
        bus_readRsp_data[29 : 29] = targets_0_ie_28;
        bus_readRsp_data[30 : 30] = targets_0_ie_29;
        bus_readRsp_data[31 : 31] = targets_0_ie_30;
      end
      22'h201000 : begin
        bus_readRsp_data[1 : 0] = targets_1_threshold;
      end
      22'h201004 : begin
        bus_readRsp_data[4 : 0] = targets_1_claim;
      end
      22'h002080 : begin
        bus_readRsp_data[1 : 1] = targets_1_ie_0;
        bus_readRsp_data[2 : 2] = targets_1_ie_1;
        bus_readRsp_data[3 : 3] = targets_1_ie_2;
        bus_readRsp_data[4 : 4] = targets_1_ie_3;
        bus_readRsp_data[5 : 5] = targets_1_ie_4;
        bus_readRsp_data[6 : 6] = targets_1_ie_5;
        bus_readRsp_data[7 : 7] = targets_1_ie_6;
        bus_readRsp_data[8 : 8] = targets_1_ie_7;
        bus_readRsp_data[9 : 9] = targets_1_ie_8;
        bus_readRsp_data[10 : 10] = targets_1_ie_9;
        bus_readRsp_data[11 : 11] = targets_1_ie_10;
        bus_readRsp_data[12 : 12] = targets_1_ie_11;
        bus_readRsp_data[13 : 13] = targets_1_ie_12;
        bus_readRsp_data[14 : 14] = targets_1_ie_13;
        bus_readRsp_data[15 : 15] = targets_1_ie_14;
        bus_readRsp_data[16 : 16] = targets_1_ie_15;
        bus_readRsp_data[17 : 17] = targets_1_ie_16;
        bus_readRsp_data[18 : 18] = targets_1_ie_17;
        bus_readRsp_data[19 : 19] = targets_1_ie_18;
        bus_readRsp_data[20 : 20] = targets_1_ie_19;
        bus_readRsp_data[21 : 21] = targets_1_ie_20;
        bus_readRsp_data[22 : 22] = targets_1_ie_21;
        bus_readRsp_data[23 : 23] = targets_1_ie_22;
        bus_readRsp_data[24 : 24] = targets_1_ie_23;
        bus_readRsp_data[25 : 25] = targets_1_ie_24;
        bus_readRsp_data[26 : 26] = targets_1_ie_25;
        bus_readRsp_data[27 : 27] = targets_1_ie_26;
        bus_readRsp_data[28 : 28] = targets_1_ie_27;
        bus_readRsp_data[29 : 29] = targets_1_ie_28;
        bus_readRsp_data[30 : 30] = targets_1_ie_29;
        bus_readRsp_data[31 : 31] = targets_1_ie_30;
      end
      default : begin
      end
    endcase
  end

  assign bus_readAddressMasked = (bus_readDataStage_payload_addr & (~ 22'h000003));
  assign bus_writeAddressMasked = (io_bus_aw_payload_addr & (~ 22'h000003));
  assign bus_readOccur = (io_bus_r_valid && io_bus_r_ready);
  assign gateways_0_priority = gateways_0_priority_driver;
  assign gateways_1_priority = gateways_1_priority_driver;
  assign gateways_2_priority = gateways_2_priority_driver;
  assign gateways_3_priority = gateways_3_priority_driver;
  assign gateways_4_priority = gateways_4_priority_driver;
  assign gateways_5_priority = gateways_5_priority_driver;
  assign gateways_6_priority = gateways_6_priority_driver;
  assign gateways_7_priority = gateways_7_priority_driver;
  assign gateways_8_priority = gateways_8_priority_driver;
  assign gateways_9_priority = gateways_9_priority_driver;
  assign gateways_10_priority = gateways_10_priority_driver;
  assign gateways_11_priority = gateways_11_priority_driver;
  assign gateways_12_priority = gateways_12_priority_driver;
  assign gateways_13_priority = gateways_13_priority_driver;
  assign gateways_14_priority = gateways_14_priority_driver;
  assign gateways_15_priority = gateways_15_priority_driver;
  assign gateways_16_priority = gateways_16_priority_driver;
  assign gateways_17_priority = gateways_17_priority_driver;
  assign gateways_18_priority = gateways_18_priority_driver;
  assign gateways_19_priority = gateways_19_priority_driver;
  assign gateways_20_priority = gateways_20_priority_driver;
  assign gateways_21_priority = gateways_21_priority_driver;
  assign gateways_22_priority = gateways_22_priority_driver;
  assign gateways_23_priority = gateways_23_priority_driver;
  assign gateways_24_priority = gateways_24_priority_driver;
  assign gateways_25_priority = gateways_25_priority_driver;
  assign gateways_26_priority = gateways_26_priority_driver;
  assign gateways_27_priority = gateways_27_priority_driver;
  assign gateways_28_priority = gateways_28_priority_driver;
  assign gateways_29_priority = gateways_29_priority_driver;
  assign gateways_30_priority = gateways_30_priority_driver;
  always @(*) begin
    mapping_claim_valid = 1'b0;
    case(bus_readAddressMasked)
      22'h200004 : begin
        if(bus_readOccur) begin
          mapping_claim_valid = 1'b1;
        end
      end
      22'h201004 : begin
        if(bus_readOccur) begin
          mapping_claim_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mapping_claim_payload = 5'bxxxxx;
    case(bus_readAddressMasked)
      22'h200004 : begin
        if(bus_readOccur) begin
          mapping_claim_payload = targets_0_claim;
        end
      end
      22'h201004 : begin
        if(bus_readOccur) begin
          mapping_claim_payload = targets_1_claim;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mapping_completion_valid = 1'b0;
    if(mapping_targetMapping_0_targetCompletion_valid) begin
      mapping_completion_valid = 1'b1;
    end
    if(mapping_targetMapping_1_targetCompletion_valid) begin
      mapping_completion_valid = 1'b1;
    end
  end

  always @(*) begin
    mapping_completion_payload = 5'bxxxxx;
    if(mapping_targetMapping_0_targetCompletion_valid) begin
      mapping_completion_payload = mapping_targetMapping_0_targetCompletion_payload;
    end
    if(mapping_targetMapping_1_targetCompletion_valid) begin
      mapping_completion_payload = mapping_targetMapping_1_targetCompletion_payload;
    end
  end

  always @(*) begin
    mapping_coherencyStall_willIncrement = 1'b0;
    if(when_PlicMapper_l122) begin
      mapping_coherencyStall_willIncrement = 1'b1;
    end
    if(when_AxiLite4SlaveFactory_l68) begin
      if(bus_writeJoinEvent_valid) begin
        mapping_coherencyStall_willIncrement = 1'b1;
      end
    end
    if(when_AxiLite4SlaveFactory_l86) begin
      if(bus_readDataStage_valid) begin
        mapping_coherencyStall_willIncrement = 1'b1;
      end
    end
  end

  assign mapping_coherencyStall_willClear = 1'b0;
  assign mapping_coherencyStall_willOverflowIfInc = (mapping_coherencyStall_value == 1'b1);
  assign mapping_coherencyStall_willOverflow = (mapping_coherencyStall_willOverflowIfInc && mapping_coherencyStall_willIncrement);
  always @(*) begin
    mapping_coherencyStall_valueNext = (mapping_coherencyStall_value + mapping_coherencyStall_willIncrement);
    if(mapping_coherencyStall_willClear) begin
      mapping_coherencyStall_valueNext = 1'b0;
    end
  end

  assign when_PlicMapper_l122 = (mapping_coherencyStall_value != 1'b0);
  assign targets_0_threshold = targets_0_threshold_driver;
  always @(*) begin
    mapping_targetMapping_0_targetCompletion_valid = 1'b0;
    case(bus_writeAddressMasked)
      22'h200004 : begin
        if(bus_writeOccur) begin
          mapping_targetMapping_0_targetCompletion_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign targets_0_ie_0 = targets_0_ie_0_driver;
  assign targets_0_ie_1 = targets_0_ie_1_driver;
  assign targets_0_ie_2 = targets_0_ie_2_driver;
  assign targets_0_ie_3 = targets_0_ie_3_driver;
  assign targets_0_ie_4 = targets_0_ie_4_driver;
  assign targets_0_ie_5 = targets_0_ie_5_driver;
  assign targets_0_ie_6 = targets_0_ie_6_driver;
  assign targets_0_ie_7 = targets_0_ie_7_driver;
  assign targets_0_ie_8 = targets_0_ie_8_driver;
  assign targets_0_ie_9 = targets_0_ie_9_driver;
  assign targets_0_ie_10 = targets_0_ie_10_driver;
  assign targets_0_ie_11 = targets_0_ie_11_driver;
  assign targets_0_ie_12 = targets_0_ie_12_driver;
  assign targets_0_ie_13 = targets_0_ie_13_driver;
  assign targets_0_ie_14 = targets_0_ie_14_driver;
  assign targets_0_ie_15 = targets_0_ie_15_driver;
  assign targets_0_ie_16 = targets_0_ie_16_driver;
  assign targets_0_ie_17 = targets_0_ie_17_driver;
  assign targets_0_ie_18 = targets_0_ie_18_driver;
  assign targets_0_ie_19 = targets_0_ie_19_driver;
  assign targets_0_ie_20 = targets_0_ie_20_driver;
  assign targets_0_ie_21 = targets_0_ie_21_driver;
  assign targets_0_ie_22 = targets_0_ie_22_driver;
  assign targets_0_ie_23 = targets_0_ie_23_driver;
  assign targets_0_ie_24 = targets_0_ie_24_driver;
  assign targets_0_ie_25 = targets_0_ie_25_driver;
  assign targets_0_ie_26 = targets_0_ie_26_driver;
  assign targets_0_ie_27 = targets_0_ie_27_driver;
  assign targets_0_ie_28 = targets_0_ie_28_driver;
  assign targets_0_ie_29 = targets_0_ie_29_driver;
  assign targets_0_ie_30 = targets_0_ie_30_driver;
  assign targets_1_threshold = targets_1_threshold_driver;
  always @(*) begin
    mapping_targetMapping_1_targetCompletion_valid = 1'b0;
    case(bus_writeAddressMasked)
      22'h201004 : begin
        if(bus_writeOccur) begin
          mapping_targetMapping_1_targetCompletion_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign targets_1_ie_0 = targets_1_ie_0_driver;
  assign targets_1_ie_1 = targets_1_ie_1_driver;
  assign targets_1_ie_2 = targets_1_ie_2_driver;
  assign targets_1_ie_3 = targets_1_ie_3_driver;
  assign targets_1_ie_4 = targets_1_ie_4_driver;
  assign targets_1_ie_5 = targets_1_ie_5_driver;
  assign targets_1_ie_6 = targets_1_ie_6_driver;
  assign targets_1_ie_7 = targets_1_ie_7_driver;
  assign targets_1_ie_8 = targets_1_ie_8_driver;
  assign targets_1_ie_9 = targets_1_ie_9_driver;
  assign targets_1_ie_10 = targets_1_ie_10_driver;
  assign targets_1_ie_11 = targets_1_ie_11_driver;
  assign targets_1_ie_12 = targets_1_ie_12_driver;
  assign targets_1_ie_13 = targets_1_ie_13_driver;
  assign targets_1_ie_14 = targets_1_ie_14_driver;
  assign targets_1_ie_15 = targets_1_ie_15_driver;
  assign targets_1_ie_16 = targets_1_ie_16_driver;
  assign targets_1_ie_17 = targets_1_ie_17_driver;
  assign targets_1_ie_18 = targets_1_ie_18_driver;
  assign targets_1_ie_19 = targets_1_ie_19_driver;
  assign targets_1_ie_20 = targets_1_ie_20_driver;
  assign targets_1_ie_21 = targets_1_ie_21_driver;
  assign targets_1_ie_22 = targets_1_ie_22_driver;
  assign targets_1_ie_23 = targets_1_ie_23_driver;
  assign targets_1_ie_24 = targets_1_ie_24_driver;
  assign targets_1_ie_25 = targets_1_ie_25_driver;
  assign targets_1_ie_26 = targets_1_ie_26_driver;
  assign targets_1_ie_27 = targets_1_ie_27_driver;
  assign targets_1_ie_28 = targets_1_ie_28_driver;
  assign targets_1_ie_29 = targets_1_ie_29_driver;
  assign targets_1_ie_30 = targets_1_ie_30_driver;
  assign mapping_targetMapping_0_targetCompletion_payload = io_bus_w_payload_data[4 : 0];
  assign mapping_targetMapping_1_targetCompletion_payload = io_bus_w_payload_data[4 : 0];
  assign when_AxiLite4SlaveFactory_l68 = 1'b1;
  assign when_AxiLite4SlaveFactory_l86 = 1'b1;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      gateways_0_ip <= 1'b0;
      gateways_0_waitCompletion <= 1'b0;
      gateways_1_ip <= 1'b0;
      gateways_1_waitCompletion <= 1'b0;
      gateways_2_ip <= 1'b0;
      gateways_2_waitCompletion <= 1'b0;
      gateways_3_ip <= 1'b0;
      gateways_3_waitCompletion <= 1'b0;
      gateways_4_ip <= 1'b0;
      gateways_4_waitCompletion <= 1'b0;
      gateways_5_ip <= 1'b0;
      gateways_5_waitCompletion <= 1'b0;
      gateways_6_ip <= 1'b0;
      gateways_6_waitCompletion <= 1'b0;
      gateways_7_ip <= 1'b0;
      gateways_7_waitCompletion <= 1'b0;
      gateways_8_ip <= 1'b0;
      gateways_8_waitCompletion <= 1'b0;
      gateways_9_ip <= 1'b0;
      gateways_9_waitCompletion <= 1'b0;
      gateways_10_ip <= 1'b0;
      gateways_10_waitCompletion <= 1'b0;
      gateways_11_ip <= 1'b0;
      gateways_11_waitCompletion <= 1'b0;
      gateways_12_ip <= 1'b0;
      gateways_12_waitCompletion <= 1'b0;
      gateways_13_ip <= 1'b0;
      gateways_13_waitCompletion <= 1'b0;
      gateways_14_ip <= 1'b0;
      gateways_14_waitCompletion <= 1'b0;
      gateways_15_ip <= 1'b0;
      gateways_15_waitCompletion <= 1'b0;
      gateways_16_ip <= 1'b0;
      gateways_16_waitCompletion <= 1'b0;
      gateways_17_ip <= 1'b0;
      gateways_17_waitCompletion <= 1'b0;
      gateways_18_ip <= 1'b0;
      gateways_18_waitCompletion <= 1'b0;
      gateways_19_ip <= 1'b0;
      gateways_19_waitCompletion <= 1'b0;
      gateways_20_ip <= 1'b0;
      gateways_20_waitCompletion <= 1'b0;
      gateways_21_ip <= 1'b0;
      gateways_21_waitCompletion <= 1'b0;
      gateways_22_ip <= 1'b0;
      gateways_22_waitCompletion <= 1'b0;
      gateways_23_ip <= 1'b0;
      gateways_23_waitCompletion <= 1'b0;
      gateways_24_ip <= 1'b0;
      gateways_24_waitCompletion <= 1'b0;
      gateways_25_ip <= 1'b0;
      gateways_25_waitCompletion <= 1'b0;
      gateways_26_ip <= 1'b0;
      gateways_26_waitCompletion <= 1'b0;
      gateways_27_ip <= 1'b0;
      gateways_27_waitCompletion <= 1'b0;
      gateways_28_ip <= 1'b0;
      gateways_28_waitCompletion <= 1'b0;
      gateways_29_ip <= 1'b0;
      gateways_29_waitCompletion <= 1'b0;
      gateways_30_ip <= 1'b0;
      gateways_30_waitCompletion <= 1'b0;
      bus_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      io_bus_ar_rValid <= 1'b0;
      gateways_0_priority_driver <= 2'b00;
      gateways_1_priority_driver <= 2'b00;
      gateways_2_priority_driver <= 2'b00;
      gateways_3_priority_driver <= 2'b00;
      gateways_4_priority_driver <= 2'b00;
      gateways_5_priority_driver <= 2'b00;
      gateways_6_priority_driver <= 2'b00;
      gateways_7_priority_driver <= 2'b00;
      gateways_8_priority_driver <= 2'b00;
      gateways_9_priority_driver <= 2'b00;
      gateways_10_priority_driver <= 2'b00;
      gateways_11_priority_driver <= 2'b00;
      gateways_12_priority_driver <= 2'b00;
      gateways_13_priority_driver <= 2'b00;
      gateways_14_priority_driver <= 2'b00;
      gateways_15_priority_driver <= 2'b00;
      gateways_16_priority_driver <= 2'b00;
      gateways_17_priority_driver <= 2'b00;
      gateways_18_priority_driver <= 2'b00;
      gateways_19_priority_driver <= 2'b00;
      gateways_20_priority_driver <= 2'b00;
      gateways_21_priority_driver <= 2'b00;
      gateways_22_priority_driver <= 2'b00;
      gateways_23_priority_driver <= 2'b00;
      gateways_24_priority_driver <= 2'b00;
      gateways_25_priority_driver <= 2'b00;
      gateways_26_priority_driver <= 2'b00;
      gateways_27_priority_driver <= 2'b00;
      gateways_28_priority_driver <= 2'b00;
      gateways_29_priority_driver <= 2'b00;
      gateways_30_priority_driver <= 2'b00;
      mapping_coherencyStall_value <= 1'b0;
      targets_0_threshold_driver <= 2'b00;
      targets_0_ie_0_driver <= 1'b0;
      targets_0_ie_1_driver <= 1'b0;
      targets_0_ie_2_driver <= 1'b0;
      targets_0_ie_3_driver <= 1'b0;
      targets_0_ie_4_driver <= 1'b0;
      targets_0_ie_5_driver <= 1'b0;
      targets_0_ie_6_driver <= 1'b0;
      targets_0_ie_7_driver <= 1'b0;
      targets_0_ie_8_driver <= 1'b0;
      targets_0_ie_9_driver <= 1'b0;
      targets_0_ie_10_driver <= 1'b0;
      targets_0_ie_11_driver <= 1'b0;
      targets_0_ie_12_driver <= 1'b0;
      targets_0_ie_13_driver <= 1'b0;
      targets_0_ie_14_driver <= 1'b0;
      targets_0_ie_15_driver <= 1'b0;
      targets_0_ie_16_driver <= 1'b0;
      targets_0_ie_17_driver <= 1'b0;
      targets_0_ie_18_driver <= 1'b0;
      targets_0_ie_19_driver <= 1'b0;
      targets_0_ie_20_driver <= 1'b0;
      targets_0_ie_21_driver <= 1'b0;
      targets_0_ie_22_driver <= 1'b0;
      targets_0_ie_23_driver <= 1'b0;
      targets_0_ie_24_driver <= 1'b0;
      targets_0_ie_25_driver <= 1'b0;
      targets_0_ie_26_driver <= 1'b0;
      targets_0_ie_27_driver <= 1'b0;
      targets_0_ie_28_driver <= 1'b0;
      targets_0_ie_29_driver <= 1'b0;
      targets_0_ie_30_driver <= 1'b0;
      targets_1_threshold_driver <= 2'b00;
      targets_1_ie_0_driver <= 1'b0;
      targets_1_ie_1_driver <= 1'b0;
      targets_1_ie_2_driver <= 1'b0;
      targets_1_ie_3_driver <= 1'b0;
      targets_1_ie_4_driver <= 1'b0;
      targets_1_ie_5_driver <= 1'b0;
      targets_1_ie_6_driver <= 1'b0;
      targets_1_ie_7_driver <= 1'b0;
      targets_1_ie_8_driver <= 1'b0;
      targets_1_ie_9_driver <= 1'b0;
      targets_1_ie_10_driver <= 1'b0;
      targets_1_ie_11_driver <= 1'b0;
      targets_1_ie_12_driver <= 1'b0;
      targets_1_ie_13_driver <= 1'b0;
      targets_1_ie_14_driver <= 1'b0;
      targets_1_ie_15_driver <= 1'b0;
      targets_1_ie_16_driver <= 1'b0;
      targets_1_ie_17_driver <= 1'b0;
      targets_1_ie_18_driver <= 1'b0;
      targets_1_ie_19_driver <= 1'b0;
      targets_1_ie_20_driver <= 1'b0;
      targets_1_ie_21_driver <= 1'b0;
      targets_1_ie_22_driver <= 1'b0;
      targets_1_ie_23_driver <= 1'b0;
      targets_1_ie_24_driver <= 1'b0;
      targets_1_ie_25_driver <= 1'b0;
      targets_1_ie_26_driver <= 1'b0;
      targets_1_ie_27_driver <= 1'b0;
      targets_1_ie_28_driver <= 1'b0;
      targets_1_ie_29_driver <= 1'b0;
      targets_1_ie_30_driver <= 1'b0;
    end else begin
      if(when_PlicGateway_l21) begin
        gateways_0_ip <= _zz_gateways_0_ip;
        gateways_0_waitCompletion <= _zz_gateways_0_ip;
      end
      if(when_PlicGateway_l21_1) begin
        gateways_1_ip <= _zz_gateways_1_ip;
        gateways_1_waitCompletion <= _zz_gateways_1_ip;
      end
      if(when_PlicGateway_l21_2) begin
        gateways_2_ip <= _zz_gateways_2_ip;
        gateways_2_waitCompletion <= _zz_gateways_2_ip;
      end
      if(when_PlicGateway_l21_3) begin
        gateways_3_ip <= _zz_gateways_3_ip;
        gateways_3_waitCompletion <= _zz_gateways_3_ip;
      end
      if(when_PlicGateway_l21_4) begin
        gateways_4_ip <= _zz_gateways_4_ip;
        gateways_4_waitCompletion <= _zz_gateways_4_ip;
      end
      if(when_PlicGateway_l21_5) begin
        gateways_5_ip <= _zz_gateways_5_ip;
        gateways_5_waitCompletion <= _zz_gateways_5_ip;
      end
      if(when_PlicGateway_l21_6) begin
        gateways_6_ip <= _zz_gateways_6_ip;
        gateways_6_waitCompletion <= _zz_gateways_6_ip;
      end
      if(when_PlicGateway_l21_7) begin
        gateways_7_ip <= _zz_gateways_7_ip;
        gateways_7_waitCompletion <= _zz_gateways_7_ip;
      end
      if(when_PlicGateway_l21_8) begin
        gateways_8_ip <= _zz_gateways_8_ip;
        gateways_8_waitCompletion <= _zz_gateways_8_ip;
      end
      if(when_PlicGateway_l21_9) begin
        gateways_9_ip <= _zz_gateways_9_ip;
        gateways_9_waitCompletion <= _zz_gateways_9_ip;
      end
      if(when_PlicGateway_l21_10) begin
        gateways_10_ip <= _zz_gateways_10_ip;
        gateways_10_waitCompletion <= _zz_gateways_10_ip;
      end
      if(when_PlicGateway_l21_11) begin
        gateways_11_ip <= _zz_gateways_11_ip;
        gateways_11_waitCompletion <= _zz_gateways_11_ip;
      end
      if(when_PlicGateway_l21_12) begin
        gateways_12_ip <= _zz_gateways_12_ip;
        gateways_12_waitCompletion <= _zz_gateways_12_ip;
      end
      if(when_PlicGateway_l21_13) begin
        gateways_13_ip <= _zz_gateways_13_ip;
        gateways_13_waitCompletion <= _zz_gateways_13_ip;
      end
      if(when_PlicGateway_l21_14) begin
        gateways_14_ip <= _zz_gateways_14_ip;
        gateways_14_waitCompletion <= _zz_gateways_14_ip;
      end
      if(when_PlicGateway_l21_15) begin
        gateways_15_ip <= _zz_gateways_15_ip;
        gateways_15_waitCompletion <= _zz_gateways_15_ip;
      end
      if(when_PlicGateway_l21_16) begin
        gateways_16_ip <= _zz_gateways_16_ip;
        gateways_16_waitCompletion <= _zz_gateways_16_ip;
      end
      if(when_PlicGateway_l21_17) begin
        gateways_17_ip <= _zz_gateways_17_ip;
        gateways_17_waitCompletion <= _zz_gateways_17_ip;
      end
      if(when_PlicGateway_l21_18) begin
        gateways_18_ip <= _zz_gateways_18_ip;
        gateways_18_waitCompletion <= _zz_gateways_18_ip;
      end
      if(when_PlicGateway_l21_19) begin
        gateways_19_ip <= _zz_gateways_19_ip;
        gateways_19_waitCompletion <= _zz_gateways_19_ip;
      end
      if(when_PlicGateway_l21_20) begin
        gateways_20_ip <= _zz_gateways_20_ip;
        gateways_20_waitCompletion <= _zz_gateways_20_ip;
      end
      if(when_PlicGateway_l21_21) begin
        gateways_21_ip <= _zz_gateways_21_ip;
        gateways_21_waitCompletion <= _zz_gateways_21_ip;
      end
      if(when_PlicGateway_l21_22) begin
        gateways_22_ip <= _zz_gateways_22_ip;
        gateways_22_waitCompletion <= _zz_gateways_22_ip;
      end
      if(when_PlicGateway_l21_23) begin
        gateways_23_ip <= _zz_gateways_23_ip;
        gateways_23_waitCompletion <= _zz_gateways_23_ip;
      end
      if(when_PlicGateway_l21_24) begin
        gateways_24_ip <= _zz_gateways_24_ip;
        gateways_24_waitCompletion <= _zz_gateways_24_ip;
      end
      if(when_PlicGateway_l21_25) begin
        gateways_25_ip <= _zz_gateways_25_ip;
        gateways_25_waitCompletion <= _zz_gateways_25_ip;
      end
      if(when_PlicGateway_l21_26) begin
        gateways_26_ip <= _zz_gateways_26_ip;
        gateways_26_waitCompletion <= _zz_gateways_26_ip;
      end
      if(when_PlicGateway_l21_27) begin
        gateways_27_ip <= _zz_gateways_27_ip;
        gateways_27_waitCompletion <= _zz_gateways_27_ip;
      end
      if(when_PlicGateway_l21_28) begin
        gateways_28_ip <= _zz_gateways_28_ip;
        gateways_28_waitCompletion <= _zz_gateways_28_ip;
      end
      if(when_PlicGateway_l21_29) begin
        gateways_29_ip <= _zz_gateways_29_ip;
        gateways_29_waitCompletion <= _zz_gateways_29_ip;
      end
      if(when_PlicGateway_l21_30) begin
        gateways_30_ip <= _zz_gateways_30_ip;
        gateways_30_waitCompletion <= _zz_gateways_30_ip;
      end
      if(bus_writeJoinEvent_translated_haltWhen_valid) begin
        bus_writeJoinEvent_translated_haltWhen_rValid <= 1'b1;
      end
      if(bus_writeJoinEvent_translated_haltWhen_halfPipe_fire) begin
        bus_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      end
      if(io_bus_ar_valid) begin
        io_bus_ar_rValid <= 1'b1;
      end
      if(bus_readDataStage_fire) begin
        io_bus_ar_rValid <= 1'b0;
      end
      if(mapping_claim_valid) begin
        case(mapping_claim_payload)
          5'h01 : begin
            gateways_0_ip <= 1'b0;
          end
          5'h02 : begin
            gateways_1_ip <= 1'b0;
          end
          5'h03 : begin
            gateways_2_ip <= 1'b0;
          end
          5'h04 : begin
            gateways_3_ip <= 1'b0;
          end
          5'h05 : begin
            gateways_4_ip <= 1'b0;
          end
          5'h06 : begin
            gateways_5_ip <= 1'b0;
          end
          5'h07 : begin
            gateways_6_ip <= 1'b0;
          end
          5'h08 : begin
            gateways_7_ip <= 1'b0;
          end
          5'h09 : begin
            gateways_8_ip <= 1'b0;
          end
          5'h0a : begin
            gateways_9_ip <= 1'b0;
          end
          5'h0b : begin
            gateways_10_ip <= 1'b0;
          end
          5'h0c : begin
            gateways_11_ip <= 1'b0;
          end
          5'h0d : begin
            gateways_12_ip <= 1'b0;
          end
          5'h0e : begin
            gateways_13_ip <= 1'b0;
          end
          5'h0f : begin
            gateways_14_ip <= 1'b0;
          end
          5'h10 : begin
            gateways_15_ip <= 1'b0;
          end
          5'h11 : begin
            gateways_16_ip <= 1'b0;
          end
          5'h12 : begin
            gateways_17_ip <= 1'b0;
          end
          5'h13 : begin
            gateways_18_ip <= 1'b0;
          end
          5'h14 : begin
            gateways_19_ip <= 1'b0;
          end
          5'h15 : begin
            gateways_20_ip <= 1'b0;
          end
          5'h16 : begin
            gateways_21_ip <= 1'b0;
          end
          5'h17 : begin
            gateways_22_ip <= 1'b0;
          end
          5'h18 : begin
            gateways_23_ip <= 1'b0;
          end
          5'h19 : begin
            gateways_24_ip <= 1'b0;
          end
          5'h1a : begin
            gateways_25_ip <= 1'b0;
          end
          5'h1b : begin
            gateways_26_ip <= 1'b0;
          end
          5'h1c : begin
            gateways_27_ip <= 1'b0;
          end
          5'h1d : begin
            gateways_28_ip <= 1'b0;
          end
          5'h1e : begin
            gateways_29_ip <= 1'b0;
          end
          5'h1f : begin
            gateways_30_ip <= 1'b0;
          end
          default : begin
          end
        endcase
      end
      if(mapping_completion_valid) begin
        case(mapping_completion_payload)
          5'h01 : begin
            gateways_0_waitCompletion <= 1'b0;
          end
          5'h02 : begin
            gateways_1_waitCompletion <= 1'b0;
          end
          5'h03 : begin
            gateways_2_waitCompletion <= 1'b0;
          end
          5'h04 : begin
            gateways_3_waitCompletion <= 1'b0;
          end
          5'h05 : begin
            gateways_4_waitCompletion <= 1'b0;
          end
          5'h06 : begin
            gateways_5_waitCompletion <= 1'b0;
          end
          5'h07 : begin
            gateways_6_waitCompletion <= 1'b0;
          end
          5'h08 : begin
            gateways_7_waitCompletion <= 1'b0;
          end
          5'h09 : begin
            gateways_8_waitCompletion <= 1'b0;
          end
          5'h0a : begin
            gateways_9_waitCompletion <= 1'b0;
          end
          5'h0b : begin
            gateways_10_waitCompletion <= 1'b0;
          end
          5'h0c : begin
            gateways_11_waitCompletion <= 1'b0;
          end
          5'h0d : begin
            gateways_12_waitCompletion <= 1'b0;
          end
          5'h0e : begin
            gateways_13_waitCompletion <= 1'b0;
          end
          5'h0f : begin
            gateways_14_waitCompletion <= 1'b0;
          end
          5'h10 : begin
            gateways_15_waitCompletion <= 1'b0;
          end
          5'h11 : begin
            gateways_16_waitCompletion <= 1'b0;
          end
          5'h12 : begin
            gateways_17_waitCompletion <= 1'b0;
          end
          5'h13 : begin
            gateways_18_waitCompletion <= 1'b0;
          end
          5'h14 : begin
            gateways_19_waitCompletion <= 1'b0;
          end
          5'h15 : begin
            gateways_20_waitCompletion <= 1'b0;
          end
          5'h16 : begin
            gateways_21_waitCompletion <= 1'b0;
          end
          5'h17 : begin
            gateways_22_waitCompletion <= 1'b0;
          end
          5'h18 : begin
            gateways_23_waitCompletion <= 1'b0;
          end
          5'h19 : begin
            gateways_24_waitCompletion <= 1'b0;
          end
          5'h1a : begin
            gateways_25_waitCompletion <= 1'b0;
          end
          5'h1b : begin
            gateways_26_waitCompletion <= 1'b0;
          end
          5'h1c : begin
            gateways_27_waitCompletion <= 1'b0;
          end
          5'h1d : begin
            gateways_28_waitCompletion <= 1'b0;
          end
          5'h1e : begin
            gateways_29_waitCompletion <= 1'b0;
          end
          5'h1f : begin
            gateways_30_waitCompletion <= 1'b0;
          end
          default : begin
          end
        endcase
      end
      mapping_coherencyStall_value <= mapping_coherencyStall_valueNext;
      case(bus_writeAddressMasked)
        22'h000004 : begin
          if(bus_writeOccur) begin
            gateways_0_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000008 : begin
          if(bus_writeOccur) begin
            gateways_1_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00000c : begin
          if(bus_writeOccur) begin
            gateways_2_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000010 : begin
          if(bus_writeOccur) begin
            gateways_3_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000014 : begin
          if(bus_writeOccur) begin
            gateways_4_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000018 : begin
          if(bus_writeOccur) begin
            gateways_5_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00001c : begin
          if(bus_writeOccur) begin
            gateways_6_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000020 : begin
          if(bus_writeOccur) begin
            gateways_7_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000024 : begin
          if(bus_writeOccur) begin
            gateways_8_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000028 : begin
          if(bus_writeOccur) begin
            gateways_9_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00002c : begin
          if(bus_writeOccur) begin
            gateways_10_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000030 : begin
          if(bus_writeOccur) begin
            gateways_11_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000034 : begin
          if(bus_writeOccur) begin
            gateways_12_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000038 : begin
          if(bus_writeOccur) begin
            gateways_13_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00003c : begin
          if(bus_writeOccur) begin
            gateways_14_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000040 : begin
          if(bus_writeOccur) begin
            gateways_15_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000044 : begin
          if(bus_writeOccur) begin
            gateways_16_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000048 : begin
          if(bus_writeOccur) begin
            gateways_17_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00004c : begin
          if(bus_writeOccur) begin
            gateways_18_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000050 : begin
          if(bus_writeOccur) begin
            gateways_19_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000054 : begin
          if(bus_writeOccur) begin
            gateways_20_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000058 : begin
          if(bus_writeOccur) begin
            gateways_21_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00005c : begin
          if(bus_writeOccur) begin
            gateways_22_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000060 : begin
          if(bus_writeOccur) begin
            gateways_23_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000064 : begin
          if(bus_writeOccur) begin
            gateways_24_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000068 : begin
          if(bus_writeOccur) begin
            gateways_25_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00006c : begin
          if(bus_writeOccur) begin
            gateways_26_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000070 : begin
          if(bus_writeOccur) begin
            gateways_27_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000074 : begin
          if(bus_writeOccur) begin
            gateways_28_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000078 : begin
          if(bus_writeOccur) begin
            gateways_29_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00007c : begin
          if(bus_writeOccur) begin
            gateways_30_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h200000 : begin
          if(bus_writeOccur) begin
            targets_0_threshold_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h002000 : begin
          if(bus_writeOccur) begin
            targets_0_ie_0_driver <= io_bus_w_payload_data[1];
            targets_0_ie_1_driver <= io_bus_w_payload_data[2];
            targets_0_ie_2_driver <= io_bus_w_payload_data[3];
            targets_0_ie_3_driver <= io_bus_w_payload_data[4];
            targets_0_ie_4_driver <= io_bus_w_payload_data[5];
            targets_0_ie_5_driver <= io_bus_w_payload_data[6];
            targets_0_ie_6_driver <= io_bus_w_payload_data[7];
            targets_0_ie_7_driver <= io_bus_w_payload_data[8];
            targets_0_ie_8_driver <= io_bus_w_payload_data[9];
            targets_0_ie_9_driver <= io_bus_w_payload_data[10];
            targets_0_ie_10_driver <= io_bus_w_payload_data[11];
            targets_0_ie_11_driver <= io_bus_w_payload_data[12];
            targets_0_ie_12_driver <= io_bus_w_payload_data[13];
            targets_0_ie_13_driver <= io_bus_w_payload_data[14];
            targets_0_ie_14_driver <= io_bus_w_payload_data[15];
            targets_0_ie_15_driver <= io_bus_w_payload_data[16];
            targets_0_ie_16_driver <= io_bus_w_payload_data[17];
            targets_0_ie_17_driver <= io_bus_w_payload_data[18];
            targets_0_ie_18_driver <= io_bus_w_payload_data[19];
            targets_0_ie_19_driver <= io_bus_w_payload_data[20];
            targets_0_ie_20_driver <= io_bus_w_payload_data[21];
            targets_0_ie_21_driver <= io_bus_w_payload_data[22];
            targets_0_ie_22_driver <= io_bus_w_payload_data[23];
            targets_0_ie_23_driver <= io_bus_w_payload_data[24];
            targets_0_ie_24_driver <= io_bus_w_payload_data[25];
            targets_0_ie_25_driver <= io_bus_w_payload_data[26];
            targets_0_ie_26_driver <= io_bus_w_payload_data[27];
            targets_0_ie_27_driver <= io_bus_w_payload_data[28];
            targets_0_ie_28_driver <= io_bus_w_payload_data[29];
            targets_0_ie_29_driver <= io_bus_w_payload_data[30];
            targets_0_ie_30_driver <= io_bus_w_payload_data[31];
          end
        end
        22'h201000 : begin
          if(bus_writeOccur) begin
            targets_1_threshold_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h002080 : begin
          if(bus_writeOccur) begin
            targets_1_ie_0_driver <= io_bus_w_payload_data[1];
            targets_1_ie_1_driver <= io_bus_w_payload_data[2];
            targets_1_ie_2_driver <= io_bus_w_payload_data[3];
            targets_1_ie_3_driver <= io_bus_w_payload_data[4];
            targets_1_ie_4_driver <= io_bus_w_payload_data[5];
            targets_1_ie_5_driver <= io_bus_w_payload_data[6];
            targets_1_ie_6_driver <= io_bus_w_payload_data[7];
            targets_1_ie_7_driver <= io_bus_w_payload_data[8];
            targets_1_ie_8_driver <= io_bus_w_payload_data[9];
            targets_1_ie_9_driver <= io_bus_w_payload_data[10];
            targets_1_ie_10_driver <= io_bus_w_payload_data[11];
            targets_1_ie_11_driver <= io_bus_w_payload_data[12];
            targets_1_ie_12_driver <= io_bus_w_payload_data[13];
            targets_1_ie_13_driver <= io_bus_w_payload_data[14];
            targets_1_ie_14_driver <= io_bus_w_payload_data[15];
            targets_1_ie_15_driver <= io_bus_w_payload_data[16];
            targets_1_ie_16_driver <= io_bus_w_payload_data[17];
            targets_1_ie_17_driver <= io_bus_w_payload_data[18];
            targets_1_ie_18_driver <= io_bus_w_payload_data[19];
            targets_1_ie_19_driver <= io_bus_w_payload_data[20];
            targets_1_ie_20_driver <= io_bus_w_payload_data[21];
            targets_1_ie_21_driver <= io_bus_w_payload_data[22];
            targets_1_ie_22_driver <= io_bus_w_payload_data[23];
            targets_1_ie_23_driver <= io_bus_w_payload_data[24];
            targets_1_ie_24_driver <= io_bus_w_payload_data[25];
            targets_1_ie_25_driver <= io_bus_w_payload_data[26];
            targets_1_ie_26_driver <= io_bus_w_payload_data[27];
            targets_1_ie_27_driver <= io_bus_w_payload_data[28];
            targets_1_ie_28_driver <= io_bus_w_payload_data[29];
            targets_1_ie_29_driver <= io_bus_w_payload_data[30];
            targets_1_ie_30_driver <= io_bus_w_payload_data[31];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    targets_0_bestRequest_priority <= (_zz_targets_0_bestRequest_priority_6 ? _zz_targets_0_bestRequest_priority_4 : _zz_targets_0_bestRequest_priority_5);
    targets_0_bestRequest_id <= (_zz_targets_0_bestRequest_priority_6 ? (_zz_targets_0_bestRequest_id_80 ? (_zz_targets_0_bestRequest_id_72 ? (_zz_targets_0_bestRequest_id_48 ? _zz_targets_0_bestRequest_id_82 : _zz_targets_0_bestRequest_id_83) : (_zz_targets_0_bestRequest_id_51 ? _zz_targets_0_bestRequest_id_84 : _zz_targets_0_bestRequest_id_85)) : (_zz_targets_0_bestRequest_id_74 ? (_zz_targets_0_bestRequest_id_54 ? _zz_targets_0_bestRequest_id_86 : _zz_targets_0_bestRequest_id_87) : (_zz_targets_0_bestRequest_id_57 ? _zz_targets_0_bestRequest_id_88 : _zz_targets_0_bestRequest_id_89))) : (_zz_targets_0_bestRequest_id_81 ? (_zz_targets_0_bestRequest_id_76 ? (_zz_targets_0_bestRequest_id_60 ? _zz_targets_0_bestRequest_id_90 : _zz_targets_0_bestRequest_id_91) : (_zz_targets_0_bestRequest_id_63 ? _zz_targets_0_bestRequest_id_92 : _zz_targets_0_bestRequest_id_93)) : (_zz_targets_0_bestRequest_id_78 ? (_zz_targets_0_bestRequest_id_66 ? _zz_targets_0_bestRequest_id_94 : _zz_targets_0_bestRequest_id_95) : (_zz_targets_0_bestRequest_id_69 ? _zz_targets_0_bestRequest_id_96 : _zz_targets_0_bestRequest_id_97))));
    targets_0_bestRequest_valid <= (_zz_targets_0_bestRequest_priority_6 ? _zz_targets_0_bestRequest_valid : _zz_targets_0_bestRequest_valid_1);
    targets_1_bestRequest_priority <= (_zz_targets_1_bestRequest_priority_6 ? _zz_targets_1_bestRequest_priority_4 : _zz_targets_1_bestRequest_priority_5);
    targets_1_bestRequest_id <= (_zz_targets_1_bestRequest_priority_6 ? (_zz_targets_1_bestRequest_id_80 ? (_zz_targets_1_bestRequest_id_72 ? (_zz_targets_1_bestRequest_id_48 ? _zz_targets_1_bestRequest_id_82 : _zz_targets_1_bestRequest_id_83) : (_zz_targets_1_bestRequest_id_51 ? _zz_targets_1_bestRequest_id_84 : _zz_targets_1_bestRequest_id_85)) : (_zz_targets_1_bestRequest_id_74 ? (_zz_targets_1_bestRequest_id_54 ? _zz_targets_1_bestRequest_id_86 : _zz_targets_1_bestRequest_id_87) : (_zz_targets_1_bestRequest_id_57 ? _zz_targets_1_bestRequest_id_88 : _zz_targets_1_bestRequest_id_89))) : (_zz_targets_1_bestRequest_id_81 ? (_zz_targets_1_bestRequest_id_76 ? (_zz_targets_1_bestRequest_id_60 ? _zz_targets_1_bestRequest_id_90 : _zz_targets_1_bestRequest_id_91) : (_zz_targets_1_bestRequest_id_63 ? _zz_targets_1_bestRequest_id_92 : _zz_targets_1_bestRequest_id_93)) : (_zz_targets_1_bestRequest_id_78 ? (_zz_targets_1_bestRequest_id_66 ? _zz_targets_1_bestRequest_id_94 : _zz_targets_1_bestRequest_id_95) : (_zz_targets_1_bestRequest_id_69 ? _zz_targets_1_bestRequest_id_96 : _zz_targets_1_bestRequest_id_97))));
    targets_1_bestRequest_valid <= (_zz_targets_1_bestRequest_priority_6 ? _zz_targets_1_bestRequest_valid : _zz_targets_1_bestRequest_valid_1);
    if(bus_writeJoinEvent_translated_haltWhen_ready) begin
      bus_writeJoinEvent_translated_haltWhen_rData_resp <= bus_writeJoinEvent_translated_haltWhen_payload_resp;
    end
    if(io_bus_ar_ready) begin
      io_bus_ar_rData_addr <= io_bus_ar_payload_addr;
      io_bus_ar_rData_prot <= io_bus_ar_payload_prot;
    end
  end


endmodule

module AxiLite4Clint (
  input  wire          io_bus_aw_valid,
  output wire          io_bus_aw_ready,
  input  wire [15:0]   io_bus_aw_payload_addr,
  input  wire [2:0]    io_bus_aw_payload_prot,
  input  wire          io_bus_w_valid,
  output wire          io_bus_w_ready,
  input  wire [31:0]   io_bus_w_payload_data,
  input  wire [3:0]    io_bus_w_payload_strb,
  output wire          io_bus_b_valid,
  input  wire          io_bus_b_ready,
  output wire [1:0]    io_bus_b_payload_resp,
  input  wire          io_bus_ar_valid,
  output wire          io_bus_ar_ready,
  input  wire [15:0]   io_bus_ar_payload_addr,
  input  wire [2:0]    io_bus_ar_payload_prot,
  output wire          io_bus_r_valid,
  input  wire          io_bus_r_ready,
  output wire [31:0]   io_bus_r_payload_data,
  output wire [1:0]    io_bus_r_payload_resp,
  output wire [0:0]    io_timerInterrupt,
  output wire [0:0]    io_softwareInterrupt,
  output wire [63:0]   io_time,
  input  wire          clk,
  input  wire          reset
);

  wire                factory_readErrorFlag;
  wire                factory_writeErrorFlag;
  wire                factory_readHaltRequest;
  wire                factory_writeHaltRequest;
  wire                factory_writeJoinEvent_valid;
  wire                factory_writeJoinEvent_ready;
  wire                factory_writeOccur;
  reg        [1:0]    factory_writeRsp_resp;
  wire                factory_writeJoinEvent_translated_valid;
  wire                factory_writeJoinEvent_translated_ready;
  wire       [1:0]    factory_writeJoinEvent_translated_payload_resp;
  wire                _zz_factory_writeJoinEvent_translated_ready;
  wire                factory_writeJoinEvent_translated_haltWhen_valid;
  wire                factory_writeJoinEvent_translated_haltWhen_ready;
  wire       [1:0]    factory_writeJoinEvent_translated_haltWhen_payload_resp;
  wire                factory_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  wire                factory_writeJoinEvent_translated_haltWhen_halfPipe_ready;
  wire       [1:0]    factory_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  reg                 factory_writeJoinEvent_translated_haltWhen_rValid;
  wire                factory_writeJoinEvent_translated_haltWhen_halfPipe_fire;
  reg        [1:0]    factory_writeJoinEvent_translated_haltWhen_rData_resp;
  wire                factory_readDataStage_valid;
  wire                factory_readDataStage_ready;
  wire       [15:0]   factory_readDataStage_payload_addr;
  wire       [2:0]    factory_readDataStage_payload_prot;
  reg                 io_bus_ar_rValid;
  wire                factory_readDataStage_fire;
  reg        [15:0]   io_bus_ar_rData_addr;
  reg        [2:0]    io_bus_ar_rData_prot;
  reg        [31:0]   factory_readRsp_data;
  reg        [1:0]    factory_readRsp_resp;
  wire                _zz_factory_readDataStage_ready;
  wire                factory_readDataStage_haltWhen_valid;
  wire                factory_readDataStage_haltWhen_ready;
  wire       [15:0]   factory_readDataStage_haltWhen_payload_addr;
  wire       [2:0]    factory_readDataStage_haltWhen_payload_prot;
  wire                factory_readDataStage_haltWhen_translated_valid;
  wire                factory_readDataStage_haltWhen_translated_ready;
  wire       [31:0]   factory_readDataStage_haltWhen_translated_payload_data;
  wire       [1:0]    factory_readDataStage_haltWhen_translated_payload_resp;
  wire       [15:0]   factory_readAddressMasked;
  wire       [15:0]   factory_writeAddressMasked;
  wire                factory_readOccur;
  wire                logic_stop;
  reg        [63:0]   logic_time;
  wire                when_Clint_l39;
  reg        [63:0]   logic_harts_0_cmp;
  reg                 logic_harts_0_timerInterrupt;
  reg                 logic_harts_0_softwareInterrupt;
  wire       [63:0]   _zz_factory_readRsp_data;
  wire                when_AxiLite4SlaveFactory_l68;
  wire                when_AxiLite4SlaveFactory_l68_1;
  wire                when_AxiLite4SlaveFactory_l86;
  wire                when_AxiLite4SlaveFactory_l86_1;

  assign factory_readErrorFlag = 1'b0;
  assign factory_writeErrorFlag = 1'b0;
  assign factory_readHaltRequest = 1'b0;
  assign factory_writeHaltRequest = 1'b0;
  assign factory_writeOccur = (factory_writeJoinEvent_valid && factory_writeJoinEvent_ready);
  assign factory_writeJoinEvent_valid = (io_bus_aw_valid && io_bus_w_valid);
  assign io_bus_aw_ready = factory_writeOccur;
  assign io_bus_w_ready = factory_writeOccur;
  assign factory_writeJoinEvent_translated_valid = factory_writeJoinEvent_valid;
  assign factory_writeJoinEvent_ready = factory_writeJoinEvent_translated_ready;
  assign factory_writeJoinEvent_translated_payload_resp = factory_writeRsp_resp;
  assign _zz_factory_writeJoinEvent_translated_ready = (! factory_writeHaltRequest);
  assign factory_writeJoinEvent_translated_haltWhen_valid = (factory_writeJoinEvent_translated_valid && _zz_factory_writeJoinEvent_translated_ready);
  assign factory_writeJoinEvent_translated_ready = (factory_writeJoinEvent_translated_haltWhen_ready && _zz_factory_writeJoinEvent_translated_ready);
  assign factory_writeJoinEvent_translated_haltWhen_payload_resp = factory_writeJoinEvent_translated_payload_resp;
  assign factory_writeJoinEvent_translated_haltWhen_halfPipe_fire = (factory_writeJoinEvent_translated_haltWhen_halfPipe_valid && factory_writeJoinEvent_translated_haltWhen_halfPipe_ready);
  assign factory_writeJoinEvent_translated_haltWhen_ready = (! factory_writeJoinEvent_translated_haltWhen_rValid);
  assign factory_writeJoinEvent_translated_haltWhen_halfPipe_valid = factory_writeJoinEvent_translated_haltWhen_rValid;
  assign factory_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp = factory_writeJoinEvent_translated_haltWhen_rData_resp;
  assign io_bus_b_valid = factory_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  assign factory_writeJoinEvent_translated_haltWhen_halfPipe_ready = io_bus_b_ready;
  assign io_bus_b_payload_resp = factory_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  assign factory_readDataStage_fire = (factory_readDataStage_valid && factory_readDataStage_ready);
  assign io_bus_ar_ready = (! io_bus_ar_rValid);
  assign factory_readDataStage_valid = io_bus_ar_rValid;
  assign factory_readDataStage_payload_addr = io_bus_ar_rData_addr;
  assign factory_readDataStage_payload_prot = io_bus_ar_rData_prot;
  assign _zz_factory_readDataStage_ready = (! factory_readHaltRequest);
  assign factory_readDataStage_haltWhen_valid = (factory_readDataStage_valid && _zz_factory_readDataStage_ready);
  assign factory_readDataStage_ready = (factory_readDataStage_haltWhen_ready && _zz_factory_readDataStage_ready);
  assign factory_readDataStage_haltWhen_payload_addr = factory_readDataStage_payload_addr;
  assign factory_readDataStage_haltWhen_payload_prot = factory_readDataStage_payload_prot;
  assign factory_readDataStage_haltWhen_translated_valid = factory_readDataStage_haltWhen_valid;
  assign factory_readDataStage_haltWhen_ready = factory_readDataStage_haltWhen_translated_ready;
  assign factory_readDataStage_haltWhen_translated_payload_data = factory_readRsp_data;
  assign factory_readDataStage_haltWhen_translated_payload_resp = factory_readRsp_resp;
  assign io_bus_r_valid = factory_readDataStage_haltWhen_translated_valid;
  assign factory_readDataStage_haltWhen_translated_ready = io_bus_r_ready;
  assign io_bus_r_payload_data = factory_readDataStage_haltWhen_translated_payload_data;
  assign io_bus_r_payload_resp = factory_readDataStage_haltWhen_translated_payload_resp;
  always @(*) begin
    if(factory_writeErrorFlag) begin
      factory_writeRsp_resp = 2'b10;
    end else begin
      factory_writeRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    if(factory_readErrorFlag) begin
      factory_readRsp_resp = 2'b10;
    end else begin
      factory_readRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    factory_readRsp_data = 32'h0;
    case(factory_readAddressMasked)
      16'h0 : begin
        factory_readRsp_data[0 : 0] = logic_harts_0_softwareInterrupt;
      end
      default : begin
      end
    endcase
    if(when_AxiLite4SlaveFactory_l86) begin
      factory_readRsp_data[31 : 0] = _zz_factory_readRsp_data[31 : 0];
    end
    if(when_AxiLite4SlaveFactory_l86_1) begin
      factory_readRsp_data[31 : 0] = _zz_factory_readRsp_data[63 : 32];
    end
  end

  assign factory_readAddressMasked = (factory_readDataStage_payload_addr & (~ 16'h0003));
  assign factory_writeAddressMasked = (io_bus_aw_payload_addr & (~ 16'h0003));
  assign factory_readOccur = (io_bus_r_valid && io_bus_r_ready);
  assign logic_stop = 1'b0;
  assign when_Clint_l39 = (! logic_stop);
  assign _zz_factory_readRsp_data = logic_time;
  assign io_timerInterrupt[0] = logic_harts_0_timerInterrupt;
  assign io_softwareInterrupt[0] = logic_harts_0_softwareInterrupt;
  assign io_time = logic_time;
  assign when_AxiLite4SlaveFactory_l68 = ((factory_writeAddressMasked & (~ 16'h0003)) == 16'h4000);
  assign when_AxiLite4SlaveFactory_l68_1 = ((factory_writeAddressMasked & (~ 16'h0003)) == 16'h4004);
  assign when_AxiLite4SlaveFactory_l86 = ((factory_readAddressMasked & (~ 16'h0003)) == 16'hbff8);
  assign when_AxiLite4SlaveFactory_l86_1 = ((factory_readAddressMasked & (~ 16'h0003)) == 16'hbffc);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      factory_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      io_bus_ar_rValid <= 1'b0;
      logic_time <= 64'h0;
      logic_harts_0_softwareInterrupt <= 1'b0;
    end else begin
      if(factory_writeJoinEvent_translated_haltWhen_valid) begin
        factory_writeJoinEvent_translated_haltWhen_rValid <= 1'b1;
      end
      if(factory_writeJoinEvent_translated_haltWhen_halfPipe_fire) begin
        factory_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      end
      if(io_bus_ar_valid) begin
        io_bus_ar_rValid <= 1'b1;
      end
      if(factory_readDataStage_fire) begin
        io_bus_ar_rValid <= 1'b0;
      end
      if(when_Clint_l39) begin
        logic_time <= (logic_time + 64'h0000000000000001);
      end
      case(factory_writeAddressMasked)
        16'h0 : begin
          if(factory_writeOccur) begin
            logic_harts_0_softwareInterrupt <= io_bus_w_payload_data[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(factory_writeJoinEvent_translated_haltWhen_ready) begin
      factory_writeJoinEvent_translated_haltWhen_rData_resp <= factory_writeJoinEvent_translated_haltWhen_payload_resp;
    end
    if(io_bus_ar_ready) begin
      io_bus_ar_rData_addr <= io_bus_ar_payload_addr;
      io_bus_ar_rData_prot <= io_bus_ar_payload_prot;
    end
    logic_harts_0_timerInterrupt <= (logic_harts_0_cmp <= logic_time);
    if(when_AxiLite4SlaveFactory_l68) begin
      if(factory_writeOccur) begin
        logic_harts_0_cmp[31 : 0] <= io_bus_w_payload_data[31 : 0];
      end
    end
    if(when_AxiLite4SlaveFactory_l68_1) begin
      if(factory_writeOccur) begin
        logic_harts_0_cmp[63 : 32] <= io_bus_w_payload_data[31 : 0];
      end
    end
  end


endmodule

module FlowCCUnsafeByToggle (
  input  wire          io_input_valid,
  input  wire          io_input_payload_last,
  input  wire [0:0]    io_input_payload_fragment,
  output wire          io_output_valid,
  output wire          io_output_payload_last,
  output wire [0:0]    io_output_payload_fragment,
  input  wire          io_jtag_tck,
  input  wire          clk,
  input  wire          debugReset
);

  wire                inputArea_target_buffercc_io_dataOut;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg                 inputArea_target;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg                 inputArea_data_last;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [0:0]    inputArea_data_fragment;
  wire                outputArea_target;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire                outputArea_flow_payload_last;
  wire       [0:0]    outputArea_flow_payload_fragment;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg                 outputArea_flow_m2sPipe_valid;
  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg                 outputArea_flow_m2sPipe_payload_last;
  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [0:0]    outputArea_flow_m2sPipe_payload_fragment;

  (* keep_hierarchy = "TRUE" *) BufferCC_12 inputArea_target_buffercc (
    .io_dataIn  (inputArea_target                    ), //i
    .io_dataOut (inputArea_target_buffercc_io_dataOut), //o
    .clk        (clk                                 ), //i
    .debugReset (debugReset                          )  //i
  );
  initial begin
  `ifndef SYNTHESIS
    inputArea_target = $urandom;
    outputArea_hit = $urandom;
  `endif
  end

  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_m2sPipe_valid;
  assign io_output_payload_last = outputArea_flow_m2sPipe_payload_last;
  assign io_output_payload_fragment = outputArea_flow_m2sPipe_payload_fragment;
  always @(posedge io_jtag_tck) begin
    if(io_input_valid) begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @(posedge clk) begin
    outputArea_hit <= outputArea_target;
    if(outputArea_flow_valid) begin
      outputArea_flow_m2sPipe_payload_last <= outputArea_flow_payload_last;
      outputArea_flow_m2sPipe_payload_fragment <= outputArea_flow_payload_fragment;
    end
  end

  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      outputArea_flow_m2sPipe_valid <= 1'b0;
    end else begin
      outputArea_flow_m2sPipe_valid <= outputArea_flow_valid;
    end
  end


endmodule

module Apb3Router (
  input  wire [19:0]   io_input_PADDR,
  input  wire [7:0]    io_input_PSEL,
  input  wire          io_input_PENABLE,
  output wire          io_input_PREADY,
  input  wire          io_input_PWRITE,
  input  wire [31:0]   io_input_PWDATA,
  output wire [31:0]   io_input_PRDATA,
  output wire          io_input_PSLVERROR,
  output wire [19:0]   io_outputs_0_PADDR,
  output wire [0:0]    io_outputs_0_PSEL,
  output wire          io_outputs_0_PENABLE,
  input  wire          io_outputs_0_PREADY,
  output wire          io_outputs_0_PWRITE,
  output wire [31:0]   io_outputs_0_PWDATA,
  input  wire [31:0]   io_outputs_0_PRDATA,
  input  wire          io_outputs_0_PSLVERROR,
  output wire [19:0]   io_outputs_1_PADDR,
  output wire [0:0]    io_outputs_1_PSEL,
  output wire          io_outputs_1_PENABLE,
  input  wire          io_outputs_1_PREADY,
  output wire          io_outputs_1_PWRITE,
  output wire [31:0]   io_outputs_1_PWDATA,
  input  wire [31:0]   io_outputs_1_PRDATA,
  input  wire          io_outputs_1_PSLVERROR,
  output wire [19:0]   io_outputs_2_PADDR,
  output wire [0:0]    io_outputs_2_PSEL,
  output wire          io_outputs_2_PENABLE,
  input  wire          io_outputs_2_PREADY,
  output wire          io_outputs_2_PWRITE,
  output wire [31:0]   io_outputs_2_PWDATA,
  input  wire [31:0]   io_outputs_2_PRDATA,
  input  wire          io_outputs_2_PSLVERROR,
  output wire [19:0]   io_outputs_3_PADDR,
  output wire [0:0]    io_outputs_3_PSEL,
  output wire          io_outputs_3_PENABLE,
  input  wire          io_outputs_3_PREADY,
  output wire          io_outputs_3_PWRITE,
  output wire [31:0]   io_outputs_3_PWDATA,
  input  wire [31:0]   io_outputs_3_PRDATA,
  input  wire          io_outputs_3_PSLVERROR,
  output wire [19:0]   io_outputs_4_PADDR,
  output wire [0:0]    io_outputs_4_PSEL,
  output wire          io_outputs_4_PENABLE,
  input  wire          io_outputs_4_PREADY,
  output wire          io_outputs_4_PWRITE,
  output wire [31:0]   io_outputs_4_PWDATA,
  input  wire [31:0]   io_outputs_4_PRDATA,
  input  wire          io_outputs_4_PSLVERROR,
  output wire [19:0]   io_outputs_5_PADDR,
  output wire [0:0]    io_outputs_5_PSEL,
  output wire          io_outputs_5_PENABLE,
  input  wire          io_outputs_5_PREADY,
  output wire          io_outputs_5_PWRITE,
  output wire [31:0]   io_outputs_5_PWDATA,
  input  wire [31:0]   io_outputs_5_PRDATA,
  input  wire          io_outputs_5_PSLVERROR,
  output wire [19:0]   io_outputs_6_PADDR,
  output wire [0:0]    io_outputs_6_PSEL,
  output wire          io_outputs_6_PENABLE,
  input  wire          io_outputs_6_PREADY,
  output wire          io_outputs_6_PWRITE,
  output wire [31:0]   io_outputs_6_PWDATA,
  input  wire [31:0]   io_outputs_6_PRDATA,
  input  wire          io_outputs_6_PSLVERROR,
  output wire [19:0]   io_outputs_7_PADDR,
  output wire [0:0]    io_outputs_7_PSEL,
  output wire          io_outputs_7_PENABLE,
  input  wire          io_outputs_7_PREADY,
  output wire          io_outputs_7_PWRITE,
  output wire [31:0]   io_outputs_7_PWDATA,
  input  wire [31:0]   io_outputs_7_PRDATA,
  input  wire          io_outputs_7_PSLVERROR,
  input  wire          clk,
  input  wire          reset
);

  reg                 _zz_io_input_PREADY;
  reg        [31:0]   _zz_io_input_PRDATA;
  reg                 _zz_io_input_PSLVERROR;
  wire                _zz_selIndex;
  wire                _zz_selIndex_1;
  wire                _zz_selIndex_2;
  wire                _zz_selIndex_3;
  wire                _zz_selIndex_4;
  wire                _zz_selIndex_5;
  wire                _zz_selIndex_6;
  reg        [2:0]    selIndex;

  always @(*) begin
    case(selIndex)
      3'b000 : begin
        _zz_io_input_PREADY = io_outputs_0_PREADY;
        _zz_io_input_PRDATA = io_outputs_0_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_0_PSLVERROR;
      end
      3'b001 : begin
        _zz_io_input_PREADY = io_outputs_1_PREADY;
        _zz_io_input_PRDATA = io_outputs_1_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_1_PSLVERROR;
      end
      3'b010 : begin
        _zz_io_input_PREADY = io_outputs_2_PREADY;
        _zz_io_input_PRDATA = io_outputs_2_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_2_PSLVERROR;
      end
      3'b011 : begin
        _zz_io_input_PREADY = io_outputs_3_PREADY;
        _zz_io_input_PRDATA = io_outputs_3_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_3_PSLVERROR;
      end
      3'b100 : begin
        _zz_io_input_PREADY = io_outputs_4_PREADY;
        _zz_io_input_PRDATA = io_outputs_4_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_4_PSLVERROR;
      end
      3'b101 : begin
        _zz_io_input_PREADY = io_outputs_5_PREADY;
        _zz_io_input_PRDATA = io_outputs_5_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_5_PSLVERROR;
      end
      3'b110 : begin
        _zz_io_input_PREADY = io_outputs_6_PREADY;
        _zz_io_input_PRDATA = io_outputs_6_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_6_PSLVERROR;
      end
      default : begin
        _zz_io_input_PREADY = io_outputs_7_PREADY;
        _zz_io_input_PRDATA = io_outputs_7_PRDATA;
        _zz_io_input_PSLVERROR = io_outputs_7_PSLVERROR;
      end
    endcase
  end

  assign io_outputs_0_PADDR = io_input_PADDR;
  assign io_outputs_0_PENABLE = io_input_PENABLE;
  assign io_outputs_0_PSEL[0] = io_input_PSEL[0];
  assign io_outputs_0_PWRITE = io_input_PWRITE;
  assign io_outputs_0_PWDATA = io_input_PWDATA;
  assign io_outputs_1_PADDR = io_input_PADDR;
  assign io_outputs_1_PENABLE = io_input_PENABLE;
  assign io_outputs_1_PSEL[0] = io_input_PSEL[1];
  assign io_outputs_1_PWRITE = io_input_PWRITE;
  assign io_outputs_1_PWDATA = io_input_PWDATA;
  assign io_outputs_2_PADDR = io_input_PADDR;
  assign io_outputs_2_PENABLE = io_input_PENABLE;
  assign io_outputs_2_PSEL[0] = io_input_PSEL[2];
  assign io_outputs_2_PWRITE = io_input_PWRITE;
  assign io_outputs_2_PWDATA = io_input_PWDATA;
  assign io_outputs_3_PADDR = io_input_PADDR;
  assign io_outputs_3_PENABLE = io_input_PENABLE;
  assign io_outputs_3_PSEL[0] = io_input_PSEL[3];
  assign io_outputs_3_PWRITE = io_input_PWRITE;
  assign io_outputs_3_PWDATA = io_input_PWDATA;
  assign io_outputs_4_PADDR = io_input_PADDR;
  assign io_outputs_4_PENABLE = io_input_PENABLE;
  assign io_outputs_4_PSEL[0] = io_input_PSEL[4];
  assign io_outputs_4_PWRITE = io_input_PWRITE;
  assign io_outputs_4_PWDATA = io_input_PWDATA;
  assign io_outputs_5_PADDR = io_input_PADDR;
  assign io_outputs_5_PENABLE = io_input_PENABLE;
  assign io_outputs_5_PSEL[0] = io_input_PSEL[5];
  assign io_outputs_5_PWRITE = io_input_PWRITE;
  assign io_outputs_5_PWDATA = io_input_PWDATA;
  assign io_outputs_6_PADDR = io_input_PADDR;
  assign io_outputs_6_PENABLE = io_input_PENABLE;
  assign io_outputs_6_PSEL[0] = io_input_PSEL[6];
  assign io_outputs_6_PWRITE = io_input_PWRITE;
  assign io_outputs_6_PWDATA = io_input_PWDATA;
  assign io_outputs_7_PADDR = io_input_PADDR;
  assign io_outputs_7_PENABLE = io_input_PENABLE;
  assign io_outputs_7_PSEL[0] = io_input_PSEL[7];
  assign io_outputs_7_PWRITE = io_input_PWRITE;
  assign io_outputs_7_PWDATA = io_input_PWDATA;
  assign _zz_selIndex = io_input_PSEL[3];
  assign _zz_selIndex_1 = io_input_PSEL[5];
  assign _zz_selIndex_2 = io_input_PSEL[6];
  assign _zz_selIndex_3 = io_input_PSEL[7];
  assign _zz_selIndex_4 = (((io_input_PSEL[1] || _zz_selIndex) || _zz_selIndex_1) || _zz_selIndex_3);
  assign _zz_selIndex_5 = (((io_input_PSEL[2] || _zz_selIndex) || _zz_selIndex_2) || _zz_selIndex_3);
  assign _zz_selIndex_6 = (((io_input_PSEL[4] || _zz_selIndex_1) || _zz_selIndex_2) || _zz_selIndex_3);
  assign io_input_PREADY = _zz_io_input_PREADY;
  assign io_input_PRDATA = _zz_io_input_PRDATA;
  assign io_input_PSLVERROR = _zz_io_input_PSLVERROR;
  always @(posedge clk) begin
    selIndex <= {_zz_selIndex_6,{_zz_selIndex_5,_zz_selIndex_4}};
  end


endmodule

module Apb3Decoder (
  input  wire [19:0]   io_input_PADDR,
  input  wire [0:0]    io_input_PSEL,
  input  wire          io_input_PENABLE,
  output reg           io_input_PREADY,
  input  wire          io_input_PWRITE,
  input  wire [31:0]   io_input_PWDATA,
  output wire [31:0]   io_input_PRDATA,
  output reg           io_input_PSLVERROR,
  output wire [19:0]   io_output_PADDR,
  output reg  [7:0]    io_output_PSEL,
  output wire          io_output_PENABLE,
  input  wire          io_output_PREADY,
  output wire          io_output_PWRITE,
  output wire [31:0]   io_output_PWDATA,
  input  wire [31:0]   io_output_PRDATA,
  input  wire          io_output_PSLVERROR
);

  wire                when_Apb3Decoder_l88;

  assign io_output_PADDR = io_input_PADDR;
  assign io_output_PENABLE = io_input_PENABLE;
  assign io_output_PWRITE = io_input_PWRITE;
  assign io_output_PWDATA = io_input_PWDATA;
  always @(*) begin
    io_output_PSEL[0] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h0) && io_input_PSEL[0]);
    io_output_PSEL[1] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h01000) && io_input_PSEL[0]);
    io_output_PSEL[2] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h02000) && io_input_PSEL[0]);
    io_output_PSEL[3] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h03000) && io_input_PSEL[0]);
    io_output_PSEL[4] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h04000) && io_input_PSEL[0]);
    io_output_PSEL[5] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h05000) && io_input_PSEL[0]);
    io_output_PSEL[6] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h06000) && io_input_PSEL[0]);
    io_output_PSEL[7] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h07000) && io_input_PSEL[0]);
  end

  always @(*) begin
    io_input_PREADY = io_output_PREADY;
    if(when_Apb3Decoder_l88) begin
      io_input_PREADY = 1'b1;
    end
  end

  assign io_input_PRDATA = io_output_PRDATA;
  always @(*) begin
    io_input_PSLVERROR = io_output_PSLVERROR;
    if(when_Apb3Decoder_l88) begin
      io_input_PSLVERROR = 1'b1;
    end
  end

  assign when_Apb3Decoder_l88 = (io_input_PSEL[0] && (io_output_PSEL == 8'h0));

endmodule

//BufferCC_11 replaced by BufferCC_10

module BufferCC_10 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

//TmdsEncoder_2 replaced by TmdsEncoder

//TmdsEncoder_1 replaced by TmdsEncoder

module TmdsEncoder (
  input  wire [7:0]    io_VD,
  input  wire [1:0]    io_CD,
  input  wire          io_VDE,
  output reg  [9:0]    io_TMDS,
  input  wire          io_pix_clk,
  input  wire          io_pix_reset
);

  wire       [3:0]    _zz_ones;
  wire       [3:0]    _zz_ones_1;
  wire       [3:0]    _zz_ones_2;
  wire       [0:0]    _zz_ones_3;
  wire       [3:0]    _zz_ones_4;
  wire       [0:0]    _zz_ones_5;
  wire       [3:0]    _zz_ones_6;
  wire       [3:0]    _zz_ones_7;
  wire       [0:0]    _zz_ones_8;
  wire       [3:0]    _zz_ones_9;
  wire       [0:0]    _zz_ones_10;
  wire       [3:0]    _zz_ones_11;
  wire       [3:0]    _zz_ones_12;
  wire       [3:0]    _zz_ones_13;
  wire       [0:0]    _zz_ones_14;
  wire       [3:0]    _zz_ones_15;
  wire       [0:0]    _zz_ones_16;
  wire       [3:0]    _zz_ones_17;
  wire       [3:0]    _zz_ones_18;
  wire       [0:0]    _zz_ones_19;
  wire       [3:0]    _zz_ones_20;
  wire       [0:0]    _zz_ones_21;
  wire       [3:0]    _zz_dw_disp;
  wire       [3:0]    _zz_dw_disp_1;
  wire       [3:0]    _zz_dw_disp_2;
  wire       [3:0]    _zz_dw_disp_3;
  wire       [0:0]    _zz_dw_disp_4;
  wire       [3:0]    _zz_dw_disp_5;
  wire       [0:0]    _zz_dw_disp_6;
  wire       [3:0]    _zz_dw_disp_7;
  wire       [3:0]    _zz_dw_disp_8;
  wire       [0:0]    _zz_dw_disp_9;
  wire       [3:0]    _zz_dw_disp_10;
  wire       [0:0]    _zz_dw_disp_11;
  wire       [3:0]    _zz_dw_disp_12;
  wire       [3:0]    _zz_dw_disp_13;
  wire       [3:0]    _zz_dw_disp_14;
  wire       [0:0]    _zz_dw_disp_15;
  wire       [3:0]    _zz_dw_disp_16;
  wire       [0:0]    _zz_dw_disp_17;
  wire       [3:0]    _zz_dw_disp_18;
  wire       [3:0]    _zz_dw_disp_19;
  wire       [0:0]    _zz_dw_disp_20;
  wire       [3:0]    _zz_dw_disp_21;
  wire       [0:0]    _zz_dw_disp_22;
  wire       [3:0]    _zz_delta;
  wire       [0:0]    _zz_delta_1;
  wire       [3:0]    _zz_dc_bias_d;
  wire       [3:0]    _zz_dc_bias_d_1;
  wire       [0:0]    _zz_TMDS_data;
  wire       [0:0]    _zz_TMDS_data_1;
  reg        [3:0]    dc_bias;
  wire       [3:0]    ones;
  wire                XNOR_1;
  wire                dw_0;
  wire                dw_1;
  wire                dw_2;
  wire                dw_3;
  wire                dw_4;
  wire                dw_5;
  wire                dw_6;
  wire                dw_7;
  wire                dw_8;
  wire       [3:0]    dw_disp;
  wire                sign_eq;
  wire       [3:0]    delta;
  wire                inv_dw;
  wire       [3:0]    dc_bias_d;
  wire       [9:0]    TMDS_data;
  wire       [9:0]    TMDS_code;

  assign _zz_ones = (_zz_ones_1 + _zz_ones_6);
  assign _zz_ones_1 = (_zz_ones_2 + _zz_ones_4);
  assign _zz_ones_3 = io_VD[0];
  assign _zz_ones_2 = {3'd0, _zz_ones_3};
  assign _zz_ones_5 = io_VD[1];
  assign _zz_ones_4 = {3'd0, _zz_ones_5};
  assign _zz_ones_6 = (_zz_ones_7 + _zz_ones_9);
  assign _zz_ones_8 = io_VD[2];
  assign _zz_ones_7 = {3'd0, _zz_ones_8};
  assign _zz_ones_10 = io_VD[3];
  assign _zz_ones_9 = {3'd0, _zz_ones_10};
  assign _zz_ones_11 = (_zz_ones_12 + _zz_ones_17);
  assign _zz_ones_12 = (_zz_ones_13 + _zz_ones_15);
  assign _zz_ones_14 = io_VD[4];
  assign _zz_ones_13 = {3'd0, _zz_ones_14};
  assign _zz_ones_16 = io_VD[5];
  assign _zz_ones_15 = {3'd0, _zz_ones_16};
  assign _zz_ones_17 = (_zz_ones_18 + _zz_ones_20);
  assign _zz_ones_19 = io_VD[6];
  assign _zz_ones_18 = {3'd0, _zz_ones_19};
  assign _zz_ones_21 = io_VD[7];
  assign _zz_ones_20 = {3'd0, _zz_ones_21};
  assign _zz_dw_disp = (_zz_dw_disp_1 + _zz_dw_disp_12);
  assign _zz_dw_disp_1 = (_zz_dw_disp_2 + _zz_dw_disp_7);
  assign _zz_dw_disp_2 = (_zz_dw_disp_3 + _zz_dw_disp_5);
  assign _zz_dw_disp_4 = dw_0;
  assign _zz_dw_disp_3 = {3'd0, _zz_dw_disp_4};
  assign _zz_dw_disp_6 = dw_1;
  assign _zz_dw_disp_5 = {3'd0, _zz_dw_disp_6};
  assign _zz_dw_disp_7 = (_zz_dw_disp_8 + _zz_dw_disp_10);
  assign _zz_dw_disp_9 = dw_2;
  assign _zz_dw_disp_8 = {3'd0, _zz_dw_disp_9};
  assign _zz_dw_disp_11 = dw_3;
  assign _zz_dw_disp_10 = {3'd0, _zz_dw_disp_11};
  assign _zz_dw_disp_12 = (_zz_dw_disp_13 + _zz_dw_disp_18);
  assign _zz_dw_disp_13 = (_zz_dw_disp_14 + _zz_dw_disp_16);
  assign _zz_dw_disp_15 = dw_4;
  assign _zz_dw_disp_14 = {3'd0, _zz_dw_disp_15};
  assign _zz_dw_disp_17 = dw_5;
  assign _zz_dw_disp_16 = {3'd0, _zz_dw_disp_17};
  assign _zz_dw_disp_18 = (_zz_dw_disp_19 + _zz_dw_disp_21);
  assign _zz_dw_disp_20 = dw_6;
  assign _zz_dw_disp_19 = {3'd0, _zz_dw_disp_20};
  assign _zz_dw_disp_22 = dw_7;
  assign _zz_dw_disp_21 = {3'd0, _zz_dw_disp_22};
  assign _zz_delta_1 = ((dw_8 ^ (! sign_eq)) && (! ((dw_disp == 4'b0000) || (dc_bias == 4'b0000))));
  assign _zz_delta = {3'd0, _zz_delta_1};
  assign _zz_dc_bias_d = (dc_bias - delta);
  assign _zz_dc_bias_d_1 = (dc_bias + delta);
  assign _zz_TMDS_data = dw_1;
  assign _zz_TMDS_data_1 = dw_0;
  initial begin
  `ifndef SYNTHESIS
    dc_bias = {$urandom};
  `endif
  end

  assign ones = (_zz_ones + _zz_ones_11);
  assign XNOR_1 = ((4'b0100 < ones) || ((ones == 4'b0100) && (io_VD[0] == 1'b0)));
  assign dw_8 = (! XNOR_1);
  assign dw_7 = ((dw_6 ^ io_VD[7]) ^ XNOR_1);
  assign dw_6 = ((dw_5 ^ io_VD[6]) ^ XNOR_1);
  assign dw_5 = ((dw_4 ^ io_VD[5]) ^ XNOR_1);
  assign dw_4 = ((dw_3 ^ io_VD[4]) ^ XNOR_1);
  assign dw_3 = ((dw_2 ^ io_VD[3]) ^ XNOR_1);
  assign dw_2 = ((dw_1 ^ io_VD[2]) ^ XNOR_1);
  assign dw_1 = ((dw_0 ^ io_VD[1]) ^ XNOR_1);
  assign dw_0 = io_VD[0];
  assign dw_disp = (_zz_dw_disp + 4'b1100);
  assign sign_eq = (dw_disp[3] == dc_bias[3]);
  assign delta = (dw_disp - _zz_delta);
  assign inv_dw = (((dw_disp == 4'b0000) || (dc_bias == 4'b0000)) ? (! dw_8) : sign_eq);
  assign dc_bias_d = (inv_dw ? _zz_dc_bias_d : _zz_dc_bias_d_1);
  assign TMDS_data = {{inv_dw,dw_8},({dw_7,{dw_6,{dw_5,{dw_4,{dw_3,{dw_2,{_zz_TMDS_data,_zz_TMDS_data_1}}}}}}} ^ (inv_dw ? 8'hff : 8'h0))};
  assign TMDS_code = (io_CD[1] ? (io_CD[0] ? 10'h2ab : 10'h154) : (io_CD[0] ? 10'h0ab : 10'h354));
  always @(posedge io_pix_clk) begin
    io_TMDS <= (io_VDE ? TMDS_data : TMDS_code);
    dc_bias <= (io_VDE ? dc_bias_d : 4'b0000);
  end


endmodule

module VgaCtrl (
  input  wire          io_softReset,
  input  wire [11:0]   io_timings_h_syncStart,
  input  wire [11:0]   io_timings_h_syncEnd,
  input  wire [11:0]   io_timings_h_colorStart,
  input  wire [11:0]   io_timings_h_colorEnd,
  input  wire          io_timings_h_polarity,
  input  wire [11:0]   io_timings_v_syncStart,
  input  wire [11:0]   io_timings_v_syncEnd,
  input  wire [11:0]   io_timings_v_colorStart,
  input  wire [11:0]   io_timings_v_colorEnd,
  input  wire          io_timings_v_polarity,
  output wire          io_frameStart,
  input  wire          io_pixels_valid,
  output wire          io_pixels_ready,
  input  wire [7:0]    io_pixels_payload_r,
  input  wire [7:0]    io_pixels_payload_g,
  input  wire [7:0]    io_pixels_payload_b,
  output wire          io_vga_vSync,
  output wire          io_vga_hSync,
  output wire          io_vga_colorEn,
  output wire [7:0]    io_vga_color_r,
  output wire [7:0]    io_vga_color_g,
  output wire [7:0]    io_vga_color_b,
  output wire          io_error,
  input  wire          io_pix_clk,
  input  wire          io_pix_reset
);

  wire                when_VgaCtrl_l288;
  reg        [11:0]   h_counter;
  wire                h_syncStart;
  wire                h_syncEnd;
  wire                h_colorStart;
  wire                h_colorEnd;
  reg                 h_sync;
  reg                 h_colorEn;
  reg        [11:0]   v_counter;
  wire                v_syncStart;
  wire                v_syncEnd;
  wire                v_colorStart;
  wire                v_colorEnd;
  reg                 v_sync;
  reg                 v_colorEn;
  wire                colorEn;

  assign when_VgaCtrl_l288 = 1'b1;
  assign h_syncStart = (h_counter == io_timings_h_syncStart);
  assign h_syncEnd = (h_counter == io_timings_h_syncEnd);
  assign h_colorStart = (h_counter == io_timings_h_colorStart);
  assign h_colorEnd = (h_counter == io_timings_h_colorEnd);
  assign v_syncStart = (v_counter == io_timings_v_syncStart);
  assign v_syncEnd = (v_counter == io_timings_v_syncEnd);
  assign v_colorStart = (v_counter == io_timings_v_colorStart);
  assign v_colorEnd = (v_counter == io_timings_v_colorEnd);
  assign colorEn = (h_colorEn && v_colorEn);
  assign io_pixels_ready = (colorEn || io_softReset);
  assign io_error = (colorEn && (! io_pixels_valid));
  assign io_frameStart = (v_syncStart && h_syncStart);
  assign io_vga_hSync = (h_sync ^ io_timings_h_polarity);
  assign io_vga_vSync = (v_sync ^ io_timings_v_polarity);
  assign io_vga_colorEn = colorEn;
  assign io_vga_color_r = io_pixels_payload_r;
  assign io_vga_color_g = io_pixels_payload_g;
  assign io_vga_color_b = io_pixels_payload_b;
  always @(posedge io_pix_clk or posedge io_pix_reset) begin
    if(io_pix_reset) begin
      h_counter <= 12'h0;
      h_sync <= 1'b0;
      h_colorEn <= 1'b0;
      v_counter <= 12'h0;
      v_sync <= 1'b0;
      v_colorEn <= 1'b0;
    end else begin
      if(when_VgaCtrl_l288) begin
        h_counter <= (h_counter + 12'h001);
        if(h_syncEnd) begin
          h_counter <= 12'h0;
        end
      end
      if(h_syncStart) begin
        h_sync <= 1'b1;
      end
      if(h_syncEnd) begin
        h_sync <= 1'b0;
      end
      if(h_colorStart) begin
        h_colorEn <= 1'b1;
      end
      if(h_colorEnd) begin
        h_colorEn <= 1'b0;
      end
      if(io_softReset) begin
        h_counter <= 12'h0;
        h_sync <= 1'b0;
        h_colorEn <= 1'b0;
      end
      if(h_syncEnd) begin
        v_counter <= (v_counter + 12'h001);
        if(v_syncEnd) begin
          v_counter <= 12'h0;
        end
      end
      if(v_syncStart) begin
        v_sync <= 1'b1;
      end
      if(v_syncEnd) begin
        v_sync <= 1'b0;
      end
      if(v_colorStart) begin
        v_colorEn <= 1'b1;
      end
      if(v_colorEnd) begin
        v_colorEn <= 1'b0;
      end
      if(io_softReset) begin
        v_counter <= 12'h0;
        v_sync <= 1'b0;
        v_colorEn <= 1'b0;
      end
    end
  end


endmodule

module BufferCC_9 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          io_pix_clk,
  input  wire          io_pix_reset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_pix_clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module VideoDma (
  input  wire          io_start,
  output wire          io_busy,
  input  wire [24:0]   io_base,
  input  wire [17:0]   io_size,
  output reg           io_mem_cmd_valid,
  input  wire          io_mem_cmd_ready,
  output wire [24:0]   io_mem_cmd_payload,
  input  wire          io_mem_rsp_valid,
  input  wire          io_mem_rsp_payload_last,
  input  wire [31:0]   io_mem_rsp_payload_fragment,
  output wire          io_frame_valid,
  input  wire          io_frame_ready,
  output wire          io_frame_payload_last,
  output wire [31:0]   io_frame_payload_fragment,
  input  wire          clk,
  input  wire          reset,
  input  wire          io_pix_clk,
  input  wire          io_pix_reset
);

  wire                rspArea_fifo_io_push_ready;
  wire                rspArea_fifo_io_pop_valid;
  wire                rspArea_fifo_io_pop_payload_last;
  wire       [31:0]   rspArea_fifo_io_pop_payload_fragment;
  wire       [13:0]   rspArea_fifo_io_pushOccupancy;
  wire       [13:0]   rspArea_fifo_io_popOccupancy;
  wire       [10:0]   rspArea_frameClockArea_popCmdGray_buffercc_io_dataOut;
  wire       [24:0]   _zz_io_mem_cmd_payload;
  wire       [2:0]    _zz_rspArea_frameClockArea_popBeatCounter_valueNext;
  wire       [0:0]    _zz_rspArea_frameClockArea_popBeatCounter_valueNext_1;
  reg        [7:0]    _zz_pendingMemRsp;
  reg        [7:0]    _zz_pendingMemRsp_1;
  wire                io_mem_cmd_fire;
  wire                when_Utils_l735;
  reg                 pendingMemCmd_incrementIt;
  reg                 pendingMemCmd_decrementIt;
  wire       [4:0]    pendingMemCmd_valueNext;
  reg        [4:0]    pendingMemCmd_value;
  wire                pendingMemCmd_mayOverflow;
  wire                pendingMemCmd_mayUnderflow;
  wire                pendingMemCmd_willOverflowIfInc;
  wire                pendingMemCmd_willOverflow;
  wire                pendingMemCmd_willUnderflowIfDec;
  wire                pendingMemCmd_willUnderflow;
  reg        [4:0]    pendingMemCmd_finalIncrement;
  wire                when_Utils_l767;
  wire                when_Utils_l769;
  reg        [7:0]    pendingMemRsp;
  wire       [7:0]    _zz_pendingMemRsp_2;
  wire                toManyPendingCmd;
  wire                toManyPendingRsp;
  reg                 isActive;
  reg                 cmdActive;
  reg        [17:0]   memCmdCounter;
  wire                memCmdLast;
  wire                when_VideoDma_l94;
  wire                when_VideoDma_l102;
  wire                when_VideoDma_l104;
  wire                when_VideoDma_l108;
  wire                memRsp_valid;
  wire                memRsp_payload_last;
  wire       [31:0]   memRsp_payload_fragment;
  wire                fifoPop_valid;
  wire                fifoPop_ready;
  wire                fifoPop_payload_last;
  wire       [31:0]   fifoPop_payload_fragment;
  wire                memRsp_toStream_valid;
  wire                memRsp_toStream_ready;
  wire                memRsp_toStream_payload_last;
  wire       [31:0]   memRsp_toStream_payload_fragment;
  reg                 rspArea_frameClockArea_popBeatCounter_willIncrement;
  wire                rspArea_frameClockArea_popBeatCounter_willClear;
  reg        [2:0]    rspArea_frameClockArea_popBeatCounter_valueNext;
  reg        [2:0]    rspArea_frameClockArea_popBeatCounter_value;
  wire                rspArea_frameClockArea_popBeatCounter_willOverflowIfInc;
  wire                rspArea_frameClockArea_popBeatCounter_willOverflow;
  wire                rspArea_fifo_io_pop_fire;
  reg        [10:0]   rspArea_frameClockArea_popCmdGray;
  reg                 _zz_when_Utils_l452;
  wire       [10:0]   _zz_when_Utils_l452_1;
  reg                 _zz_when_Utils_l452_2;
  reg                 _zz_when_Utils_l452_3;
  reg                 _zz_when_Utils_l452_4;
  reg                 _zz_when_Utils_l452_5;
  reg                 _zz_when_Utils_l452_6;
  reg                 _zz_when_Utils_l452_7;
  reg                 _zz_when_Utils_l452_8;
  reg                 _zz_when_Utils_l452_9;
  reg                 _zz_when_Utils_l452_10;
  reg                 _zz_when_Utils_l452_11;
  wire                when_Utils_l452;
  wire                when_Utils_l452_1;
  wire                when_Utils_l452_2;
  wire                when_Utils_l452_3;
  wire                when_Utils_l452_4;
  wire                when_Utils_l452_5;
  wire                when_Utils_l452_6;
  wire                when_Utils_l452_7;
  wire                when_Utils_l452_8;
  wire                when_Utils_l452_9;
  wire                when_Utils_l452_10;
  wire       [10:0]   rspArea_popCmdGray;
  reg        [10:0]   rspArea_pushCmdGray;
  reg                 _zz_when_Utils_l452_12;
  wire       [10:0]   _zz_when_Utils_l452_13;
  reg                 _zz_when_Utils_l452_14;
  reg                 _zz_when_Utils_l452_15;
  reg                 _zz_when_Utils_l452_16;
  reg                 _zz_when_Utils_l452_17;
  reg                 _zz_when_Utils_l452_18;
  reg                 _zz_when_Utils_l452_19;
  reg                 _zz_when_Utils_l452_20;
  reg                 _zz_when_Utils_l452_21;
  reg                 _zz_when_Utils_l452_22;
  reg                 _zz_when_Utils_l452_23;
  wire                when_Utils_l452_11;
  wire                when_Utils_l452_12;
  wire                when_Utils_l452_13;
  wire                when_Utils_l452_14;
  wire                when_Utils_l452_15;
  wire                when_Utils_l452_16;
  wire                when_Utils_l452_17;
  wire                when_Utils_l452_18;
  wire                when_Utils_l452_19;
  wire                when_Utils_l452_20;
  wire                when_Utils_l452_21;
  wire       [32:0]   _zz_io_frame_payload_last;

  assign _zz_io_mem_cmd_payload = {7'd0, memCmdCounter};
  assign _zz_rspArea_frameClockArea_popBeatCounter_valueNext_1 = rspArea_frameClockArea_popBeatCounter_willIncrement;
  assign _zz_rspArea_frameClockArea_popBeatCounter_valueNext = {2'd0, _zz_rspArea_frameClockArea_popBeatCounter_valueNext_1};
  StreamFifoCC rspArea_fifo (
    .io_push_valid            (memRsp_toStream_valid                     ), //i
    .io_push_ready            (rspArea_fifo_io_push_ready                ), //o
    .io_push_payload_last     (memRsp_toStream_payload_last              ), //i
    .io_push_payload_fragment (memRsp_toStream_payload_fragment[31:0]    ), //i
    .io_pop_valid             (rspArea_fifo_io_pop_valid                 ), //o
    .io_pop_ready             (fifoPop_ready                             ), //i
    .io_pop_payload_last      (rspArea_fifo_io_pop_payload_last          ), //o
    .io_pop_payload_fragment  (rspArea_fifo_io_pop_payload_fragment[31:0]), //o
    .io_pushOccupancy         (rspArea_fifo_io_pushOccupancy[13:0]       ), //o
    .io_popOccupancy          (rspArea_fifo_io_popOccupancy[13:0]        ), //o
    .clk                      (clk                                       ), //i
    .reset                    (reset                                     ), //i
    .io_pix_clk               (io_pix_clk                                )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_8 rspArea_frameClockArea_popCmdGray_buffercc (
    .io_dataIn  (rspArea_frameClockArea_popCmdGray[10:0]                    ), //i
    .io_dataOut (rspArea_frameClockArea_popCmdGray_buffercc_io_dataOut[10:0]), //o
    .clk        (clk                                                        ), //i
    .reset      (reset                                                      )  //i
  );
  always @(*) begin
    _zz_pendingMemRsp = _zz_pendingMemRsp_1;
    if(io_mem_rsp_valid) begin
      _zz_pendingMemRsp = (_zz_pendingMemRsp_1 - 8'h01);
    end
  end

  always @(*) begin
    _zz_pendingMemRsp_1 = _zz_pendingMemRsp_2;
    if(io_mem_cmd_fire) begin
      _zz_pendingMemRsp_1 = (_zz_pendingMemRsp_2 + 8'h08);
    end
  end

  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready);
  assign when_Utils_l735 = (io_mem_rsp_valid && io_mem_rsp_payload_last);
  always @(*) begin
    pendingMemCmd_incrementIt = 1'b0;
    if(io_mem_cmd_fire) begin
      pendingMemCmd_incrementIt = 1'b1;
    end
  end

  always @(*) begin
    pendingMemCmd_decrementIt = 1'b0;
    if(when_Utils_l735) begin
      pendingMemCmd_decrementIt = 1'b1;
    end
  end

  assign pendingMemCmd_mayOverflow = (pendingMemCmd_value == 5'h1f);
  assign pendingMemCmd_mayUnderflow = (pendingMemCmd_value == 5'h0);
  assign pendingMemCmd_willOverflowIfInc = (pendingMemCmd_mayOverflow && (! pendingMemCmd_decrementIt));
  assign pendingMemCmd_willOverflow = (pendingMemCmd_willOverflowIfInc && pendingMemCmd_incrementIt);
  assign pendingMemCmd_willUnderflowIfDec = (pendingMemCmd_mayUnderflow && (! pendingMemCmd_incrementIt));
  assign pendingMemCmd_willUnderflow = (pendingMemCmd_willUnderflowIfDec && pendingMemCmd_decrementIt);
  assign when_Utils_l767 = (pendingMemCmd_incrementIt && (! pendingMemCmd_decrementIt));
  always @(*) begin
    if(when_Utils_l767) begin
      pendingMemCmd_finalIncrement = 5'h01;
    end else begin
      if(when_Utils_l769) begin
        pendingMemCmd_finalIncrement = 5'h1f;
      end else begin
        pendingMemCmd_finalIncrement = 5'h0;
      end
    end
  end

  assign when_Utils_l769 = ((! pendingMemCmd_incrementIt) && pendingMemCmd_decrementIt);
  assign pendingMemCmd_valueNext = (pendingMemCmd_value + pendingMemCmd_finalIncrement);
  assign _zz_pendingMemRsp_2 = pendingMemRsp;
  assign toManyPendingCmd = (5'h1e < pendingMemCmd_value);
  assign io_busy = isActive;
  assign memCmdLast = (memCmdCounter == io_size);
  always @(*) begin
    io_mem_cmd_valid = 1'b0;
    if(!when_VideoDma_l94) begin
      if(cmdActive) begin
        if(when_VideoDma_l102) begin
          io_mem_cmd_valid = 1'b1;
        end
      end
    end
  end

  assign io_mem_cmd_payload = (io_base + _zz_io_mem_cmd_payload);
  assign when_VideoDma_l94 = (! isActive);
  assign when_VideoDma_l102 = ((! toManyPendingCmd) && (! toManyPendingRsp));
  assign when_VideoDma_l104 = (memCmdLast && io_mem_cmd_ready);
  assign when_VideoDma_l108 = (pendingMemRsp == 8'h0);
  assign memRsp_valid = io_mem_rsp_valid;
  assign memRsp_payload_last = ((! cmdActive) && (pendingMemRsp == 8'h01));
  assign memRsp_payload_fragment = io_mem_rsp_payload_fragment;
  assign memRsp_toStream_valid = memRsp_valid;
  assign memRsp_toStream_payload_last = memRsp_payload_last;
  assign memRsp_toStream_payload_fragment = memRsp_payload_fragment;
  assign memRsp_toStream_ready = rspArea_fifo_io_push_ready;
  assign fifoPop_valid = rspArea_fifo_io_pop_valid;
  assign fifoPop_payload_last = rspArea_fifo_io_pop_payload_last;
  assign fifoPop_payload_fragment = rspArea_fifo_io_pop_payload_fragment;
  always @(*) begin
    rspArea_frameClockArea_popBeatCounter_willIncrement = 1'b0;
    if(rspArea_fifo_io_pop_fire) begin
      rspArea_frameClockArea_popBeatCounter_willIncrement = 1'b1;
    end
  end

  assign rspArea_frameClockArea_popBeatCounter_willClear = 1'b0;
  assign rspArea_frameClockArea_popBeatCounter_willOverflowIfInc = (rspArea_frameClockArea_popBeatCounter_value == 3'b111);
  assign rspArea_frameClockArea_popBeatCounter_willOverflow = (rspArea_frameClockArea_popBeatCounter_willOverflowIfInc && rspArea_frameClockArea_popBeatCounter_willIncrement);
  always @(*) begin
    rspArea_frameClockArea_popBeatCounter_valueNext = (rspArea_frameClockArea_popBeatCounter_value + _zz_rspArea_frameClockArea_popBeatCounter_valueNext);
    if(rspArea_frameClockArea_popBeatCounter_willClear) begin
      rspArea_frameClockArea_popBeatCounter_valueNext = 3'b000;
    end
  end

  assign rspArea_fifo_io_pop_fire = (rspArea_fifo_io_pop_valid && fifoPop_ready);
  assign _zz_when_Utils_l452_1 = {1'b1,{rspArea_frameClockArea_popCmdGray[8 : 0],_zz_when_Utils_l452}};
  always @(*) begin
    _zz_when_Utils_l452_2 = _zz_when_Utils_l452_3;
    if(when_Utils_l452_9) begin
      _zz_when_Utils_l452_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_3 = _zz_when_Utils_l452_4;
    if(when_Utils_l452_8) begin
      _zz_when_Utils_l452_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_4 = _zz_when_Utils_l452_5;
    if(when_Utils_l452_7) begin
      _zz_when_Utils_l452_4 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_5 = _zz_when_Utils_l452_6;
    if(when_Utils_l452_6) begin
      _zz_when_Utils_l452_5 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_6 = _zz_when_Utils_l452_7;
    if(when_Utils_l452_5) begin
      _zz_when_Utils_l452_6 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_7 = _zz_when_Utils_l452_8;
    if(when_Utils_l452_4) begin
      _zz_when_Utils_l452_7 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_8 = _zz_when_Utils_l452_9;
    if(when_Utils_l452_3) begin
      _zz_when_Utils_l452_8 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_9 = _zz_when_Utils_l452_10;
    if(when_Utils_l452_2) begin
      _zz_when_Utils_l452_9 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_10 = _zz_when_Utils_l452_11;
    if(when_Utils_l452_1) begin
      _zz_when_Utils_l452_10 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_11 = 1'b0;
    if(when_Utils_l452) begin
      _zz_when_Utils_l452_11 = 1'b1;
    end
  end

  assign when_Utils_l452 = (_zz_when_Utils_l452_1[0] && (! 1'b0));
  assign when_Utils_l452_1 = (_zz_when_Utils_l452_1[1] && (! _zz_when_Utils_l452_11));
  assign when_Utils_l452_2 = (_zz_when_Utils_l452_1[2] && (! _zz_when_Utils_l452_10));
  assign when_Utils_l452_3 = (_zz_when_Utils_l452_1[3] && (! _zz_when_Utils_l452_9));
  assign when_Utils_l452_4 = (_zz_when_Utils_l452_1[4] && (! _zz_when_Utils_l452_8));
  assign when_Utils_l452_5 = (_zz_when_Utils_l452_1[5] && (! _zz_when_Utils_l452_7));
  assign when_Utils_l452_6 = (_zz_when_Utils_l452_1[6] && (! _zz_when_Utils_l452_6));
  assign when_Utils_l452_7 = (_zz_when_Utils_l452_1[7] && (! _zz_when_Utils_l452_5));
  assign when_Utils_l452_8 = (_zz_when_Utils_l452_1[8] && (! _zz_when_Utils_l452_4));
  assign when_Utils_l452_9 = (_zz_when_Utils_l452_1[9] && (! _zz_when_Utils_l452_3));
  assign when_Utils_l452_10 = (_zz_when_Utils_l452_1[10] && (! _zz_when_Utils_l452_2));
  assign rspArea_popCmdGray = rspArea_frameClockArea_popCmdGray_buffercc_io_dataOut;
  assign _zz_when_Utils_l452_13 = {1'b1,{rspArea_pushCmdGray[8 : 0],_zz_when_Utils_l452_12}};
  always @(*) begin
    _zz_when_Utils_l452_14 = _zz_when_Utils_l452_15;
    if(when_Utils_l452_20) begin
      _zz_when_Utils_l452_14 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_15 = _zz_when_Utils_l452_16;
    if(when_Utils_l452_19) begin
      _zz_when_Utils_l452_15 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_16 = _zz_when_Utils_l452_17;
    if(when_Utils_l452_18) begin
      _zz_when_Utils_l452_16 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_17 = _zz_when_Utils_l452_18;
    if(when_Utils_l452_17) begin
      _zz_when_Utils_l452_17 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_18 = _zz_when_Utils_l452_19;
    if(when_Utils_l452_16) begin
      _zz_when_Utils_l452_18 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_19 = _zz_when_Utils_l452_20;
    if(when_Utils_l452_15) begin
      _zz_when_Utils_l452_19 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_20 = _zz_when_Utils_l452_21;
    if(when_Utils_l452_14) begin
      _zz_when_Utils_l452_20 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_21 = _zz_when_Utils_l452_22;
    if(when_Utils_l452_13) begin
      _zz_when_Utils_l452_21 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_22 = _zz_when_Utils_l452_23;
    if(when_Utils_l452_12) begin
      _zz_when_Utils_l452_22 = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_Utils_l452_23 = 1'b0;
    if(when_Utils_l452_11) begin
      _zz_when_Utils_l452_23 = 1'b1;
    end
  end

  assign when_Utils_l452_11 = (_zz_when_Utils_l452_13[0] && (! 1'b0));
  assign when_Utils_l452_12 = (_zz_when_Utils_l452_13[1] && (! _zz_when_Utils_l452_23));
  assign when_Utils_l452_13 = (_zz_when_Utils_l452_13[2] && (! _zz_when_Utils_l452_22));
  assign when_Utils_l452_14 = (_zz_when_Utils_l452_13[3] && (! _zz_when_Utils_l452_21));
  assign when_Utils_l452_15 = (_zz_when_Utils_l452_13[4] && (! _zz_when_Utils_l452_20));
  assign when_Utils_l452_16 = (_zz_when_Utils_l452_13[5] && (! _zz_when_Utils_l452_19));
  assign when_Utils_l452_17 = (_zz_when_Utils_l452_13[6] && (! _zz_when_Utils_l452_18));
  assign when_Utils_l452_18 = (_zz_when_Utils_l452_13[7] && (! _zz_when_Utils_l452_17));
  assign when_Utils_l452_19 = (_zz_when_Utils_l452_13[8] && (! _zz_when_Utils_l452_16));
  assign when_Utils_l452_20 = (_zz_when_Utils_l452_13[9] && (! _zz_when_Utils_l452_15));
  assign when_Utils_l452_21 = (_zz_when_Utils_l452_13[10] && (! _zz_when_Utils_l452_14));
  assign toManyPendingRsp = ((rspArea_pushCmdGray[10 : 9] == (~ rspArea_popCmdGray[10 : 9])) && (rspArea_pushCmdGray[8 : 0] == rspArea_popCmdGray[8 : 0]));
  assign io_frame_valid = fifoPop_valid;
  assign fifoPop_ready = io_frame_ready;
  assign _zz_io_frame_payload_last = {fifoPop_payload_fragment,fifoPop_payload_last};
  assign io_frame_payload_last = _zz_io_frame_payload_last[0];
  assign io_frame_payload_fragment = _zz_io_frame_payload_last[32 : 1];
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      pendingMemCmd_value <= 5'h0;
      pendingMemRsp <= 8'h0;
      isActive <= 1'b0;
      cmdActive <= 1'b0;
      rspArea_pushCmdGray <= 11'h0;
      _zz_when_Utils_l452_12 <= 1'b1;
    end else begin
      pendingMemCmd_value <= pendingMemCmd_valueNext;
      pendingMemRsp <= _zz_pendingMemRsp;
      if(when_VideoDma_l94) begin
        if(io_start) begin
          isActive <= 1'b1;
          cmdActive <= 1'b1;
        end
      end else begin
        if(cmdActive) begin
          if(when_VideoDma_l102) begin
            if(when_VideoDma_l104) begin
              cmdActive <= 1'b0;
            end
          end
        end else begin
          if(when_VideoDma_l108) begin
            isActive <= 1'b0;
          end
        end
      end
      if(io_mem_cmd_fire) begin
        if(when_Utils_l452_11) begin
          rspArea_pushCmdGray[0] <= (! rspArea_pushCmdGray[0]);
        end
        if(when_Utils_l452_12) begin
          rspArea_pushCmdGray[1] <= (! rspArea_pushCmdGray[1]);
        end
        if(when_Utils_l452_13) begin
          rspArea_pushCmdGray[2] <= (! rspArea_pushCmdGray[2]);
        end
        if(when_Utils_l452_14) begin
          rspArea_pushCmdGray[3] <= (! rspArea_pushCmdGray[3]);
        end
        if(when_Utils_l452_15) begin
          rspArea_pushCmdGray[4] <= (! rspArea_pushCmdGray[4]);
        end
        if(when_Utils_l452_16) begin
          rspArea_pushCmdGray[5] <= (! rspArea_pushCmdGray[5]);
        end
        if(when_Utils_l452_17) begin
          rspArea_pushCmdGray[6] <= (! rspArea_pushCmdGray[6]);
        end
        if(when_Utils_l452_18) begin
          rspArea_pushCmdGray[7] <= (! rspArea_pushCmdGray[7]);
        end
        if(when_Utils_l452_19) begin
          rspArea_pushCmdGray[8] <= (! rspArea_pushCmdGray[8]);
        end
        if(when_Utils_l452_20) begin
          rspArea_pushCmdGray[9] <= (! rspArea_pushCmdGray[9]);
        end
        if(when_Utils_l452_21) begin
          rspArea_pushCmdGray[10] <= (! rspArea_pushCmdGray[10]);
        end
        _zz_when_Utils_l452_12 <= (! _zz_when_Utils_l452_12);
      end
    end
  end

  always @(posedge clk) begin
    if(when_VideoDma_l94) begin
      if(io_start) begin
        memCmdCounter <= 18'h0;
      end
    end
    if(io_mem_cmd_fire) begin
      memCmdCounter <= (memCmdCounter + 18'h00001);
    end
  end

  always @(posedge io_pix_clk or posedge io_pix_reset) begin
    if(io_pix_reset) begin
      rspArea_frameClockArea_popBeatCounter_value <= 3'b000;
      rspArea_frameClockArea_popCmdGray <= 11'h0;
      _zz_when_Utils_l452 <= 1'b1;
    end else begin
      rspArea_frameClockArea_popBeatCounter_value <= rspArea_frameClockArea_popBeatCounter_valueNext;
      if(rspArea_frameClockArea_popBeatCounter_willOverflow) begin
        if(when_Utils_l452) begin
          rspArea_frameClockArea_popCmdGray[0] <= (! rspArea_frameClockArea_popCmdGray[0]);
        end
        if(when_Utils_l452_1) begin
          rspArea_frameClockArea_popCmdGray[1] <= (! rspArea_frameClockArea_popCmdGray[1]);
        end
        if(when_Utils_l452_2) begin
          rspArea_frameClockArea_popCmdGray[2] <= (! rspArea_frameClockArea_popCmdGray[2]);
        end
        if(when_Utils_l452_3) begin
          rspArea_frameClockArea_popCmdGray[3] <= (! rspArea_frameClockArea_popCmdGray[3]);
        end
        if(when_Utils_l452_4) begin
          rspArea_frameClockArea_popCmdGray[4] <= (! rspArea_frameClockArea_popCmdGray[4]);
        end
        if(when_Utils_l452_5) begin
          rspArea_frameClockArea_popCmdGray[5] <= (! rspArea_frameClockArea_popCmdGray[5]);
        end
        if(when_Utils_l452_6) begin
          rspArea_frameClockArea_popCmdGray[6] <= (! rspArea_frameClockArea_popCmdGray[6]);
        end
        if(when_Utils_l452_7) begin
          rspArea_frameClockArea_popCmdGray[7] <= (! rspArea_frameClockArea_popCmdGray[7]);
        end
        if(when_Utils_l452_8) begin
          rspArea_frameClockArea_popCmdGray[8] <= (! rspArea_frameClockArea_popCmdGray[8]);
        end
        if(when_Utils_l452_9) begin
          rspArea_frameClockArea_popCmdGray[9] <= (! rspArea_frameClockArea_popCmdGray[9]);
        end
        if(when_Utils_l452_10) begin
          rspArea_frameClockArea_popCmdGray[10] <= (! rspArea_frameClockArea_popCmdGray[10]);
        end
        _zz_when_Utils_l452 <= (! _zz_when_Utils_l452);
      end
    end
  end


endmodule

module Apb3SpiMasterCtrl (
  input  wire [7:0]    io_apb_PADDR,
  input  wire [0:0]    io_apb_PSEL,
  input  wire          io_apb_PENABLE,
  output wire          io_apb_PREADY,
  input  wire          io_apb_PWRITE,
  input  wire [31:0]   io_apb_PWDATA,
  output reg  [31:0]   io_apb_PRDATA,
  output wire [0:0]    io_spi_ss,
  output wire          io_spi_sclk,
  output wire          io_spi_mosi,
  input  wire          io_spi_miso,
  output wire          io_interrupt,
  input  wire          clk,
  input  wire          reset
);
  localparam SpiMasterCtrlCmdMode_DATA = 1'd0;
  localparam SpiMasterCtrlCmdMode_SS = 1'd1;

  reg                 spiCtrl_io_rsp_queueWithOccupancy_io_pop_ready;
  wire                spiCtrl_io_cmd_ready;
  wire                spiCtrl_io_rsp_valid;
  wire       [7:0]    spiCtrl_io_rsp_payload;
  wire                spiCtrl_io_spi_sclk;
  wire                spiCtrl_io_spi_mosi;
  wire       [0:0]    spiCtrl_io_spi_ss;
  wire                bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready;
  wire                bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid;
  wire       [0:0]    bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_mode;
  wire       [8:0]    bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_args;
  wire       [5:0]    bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_occupancy;
  wire       [5:0]    bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability;
  wire                spiCtrl_io_rsp_queueWithOccupancy_io_push_ready;
  wire                spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    spiCtrl_io_rsp_queueWithOccupancy_io_pop_payload;
  wire       [5:0]    spiCtrl_io_rsp_queueWithOccupancy_io_occupancy;
  wire       [5:0]    spiCtrl_io_rsp_queueWithOccupancy_io_availability;
  wire       [0:0]    _zz_bridge_cmdLogic_streamUnbuffered_payload_args;
  wire                busCtrl_readErrorFlag;
  wire                busCtrl_writeErrorFlag;
  wire                busCtrl_askWrite;
  wire                busCtrl_askRead;
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  wire                bridge_cmdLogic_streamUnbuffered_valid;
  wire                bridge_cmdLogic_streamUnbuffered_ready;
  wire       [0:0]    bridge_cmdLogic_streamUnbuffered_payload_mode;
  reg        [8:0]    bridge_cmdLogic_streamUnbuffered_payload_args;
  reg                 _zz_bridge_cmdLogic_streamUnbuffered_valid;
  wire       [7:0]    bridge_cmdLogic_dataCmd_data;
  wire                bridge_cmdLogic_dataCmd_read;
  wire                spiCtrl_io_rsp_toStream_valid;
  wire                spiCtrl_io_rsp_toStream_ready;
  wire       [7:0]    spiCtrl_io_rsp_toStream_payload;
  reg                 bridge_interruptCtrl_cmdIntEnable;
  reg                 bridge_interruptCtrl_rspIntEnable;
  wire                bridge_interruptCtrl_cmdInt;
  wire                bridge_interruptCtrl_rspInt;
  wire                bridge_interruptCtrl_interrupt;
  reg                 spiCtrl_io_config_kind_driver_cpol;
  reg                 spiCtrl_io_config_kind_driver_cpha;
  reg        [11:0]   spiCtrl_io_config_sclkToggle_driver;
  reg        [0:0]    spiCtrl_io_config_ss_activeHigh_driver;
  reg        [11:0]   spiCtrl_io_config_ss_setup_driver;
  reg        [11:0]   spiCtrl_io_config_ss_hold_driver;
  reg        [11:0]   spiCtrl_io_config_ss_disable_driver;
  wire       [0:0]    _zz_bridge_cmdLogic_streamUnbuffered_payload_mode;
  wire       [1:0]    _zz_spiCtrl_io_config_kind_driver_cpol;
  `ifndef SYNTHESIS
  reg [31:0] bridge_cmdLogic_streamUnbuffered_payload_mode_string;
  reg [31:0] _zz_bridge_cmdLogic_streamUnbuffered_payload_mode_string;
  `endif


  assign _zz_bridge_cmdLogic_streamUnbuffered_payload_args = io_apb_PWDATA[24];
  SpiMasterCtrl spiCtrl (
    .io_config_kind_cpol     (spiCtrl_io_config_kind_driver_cpol                                             ), //i
    .io_config_kind_cpha     (spiCtrl_io_config_kind_driver_cpha                                             ), //i
    .io_config_sclkToggle    (spiCtrl_io_config_sclkToggle_driver[11:0]                                      ), //i
    .io_config_ss_activeHigh (spiCtrl_io_config_ss_activeHigh_driver                                         ), //i
    .io_config_ss_setup      (spiCtrl_io_config_ss_setup_driver[11:0]                                        ), //i
    .io_config_ss_hold       (spiCtrl_io_config_ss_hold_driver[11:0]                                         ), //i
    .io_config_ss_disable    (spiCtrl_io_config_ss_disable_driver[11:0]                                      ), //i
    .io_cmd_valid            (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid            ), //i
    .io_cmd_ready            (spiCtrl_io_cmd_ready                                                           ), //o
    .io_cmd_payload_mode     (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_mode     ), //i
    .io_cmd_payload_args     (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_args[8:0]), //i
    .io_rsp_valid            (spiCtrl_io_rsp_valid                                                           ), //o
    .io_rsp_payload          (spiCtrl_io_rsp_payload[7:0]                                                    ), //o
    .io_spi_ss               (spiCtrl_io_spi_ss                                                              ), //o
    .io_spi_sclk             (spiCtrl_io_spi_sclk                                                            ), //o
    .io_spi_mosi             (spiCtrl_io_spi_mosi                                                            ), //o
    .io_spi_miso             (io_spi_miso                                                                    ), //i
    .clk                     (clk                                                                            ), //i
    .reset                   (reset                                                                          )  //i
  );
  StreamFifo_2 bridge_cmdLogic_streamUnbuffered_queueWithAvailability (
    .io_push_valid        (bridge_cmdLogic_streamUnbuffered_valid                                         ), //i
    .io_push_ready        (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready           ), //o
    .io_push_payload_mode (bridge_cmdLogic_streamUnbuffered_payload_mode                                  ), //i
    .io_push_payload_args (bridge_cmdLogic_streamUnbuffered_payload_args[8:0]                             ), //i
    .io_pop_valid         (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid            ), //o
    .io_pop_ready         (spiCtrl_io_cmd_ready                                                           ), //i
    .io_pop_payload_mode  (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_mode     ), //o
    .io_pop_payload_args  (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_args[8:0]), //o
    .io_flush             (1'b0                                                                           ), //i
    .io_occupancy         (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_occupancy[5:0]       ), //o
    .io_availability      (bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability[5:0]    ), //o
    .clk                  (clk                                                                            ), //i
    .reset                (reset                                                                          )  //i
  );
  StreamFifo_3 spiCtrl_io_rsp_queueWithOccupancy (
    .io_push_valid   (spiCtrl_io_rsp_toStream_valid                         ), //i
    .io_push_ready   (spiCtrl_io_rsp_queueWithOccupancy_io_push_ready       ), //o
    .io_push_payload (spiCtrl_io_rsp_toStream_payload[7:0]                  ), //i
    .io_pop_valid    (spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid        ), //o
    .io_pop_ready    (spiCtrl_io_rsp_queueWithOccupancy_io_pop_ready        ), //i
    .io_pop_payload  (spiCtrl_io_rsp_queueWithOccupancy_io_pop_payload[7:0] ), //o
    .io_flush        (1'b0                                                  ), //i
    .io_occupancy    (spiCtrl_io_rsp_queueWithOccupancy_io_occupancy[5:0]   ), //o
    .io_availability (spiCtrl_io_rsp_queueWithOccupancy_io_availability[5:0]), //o
    .clk             (clk                                                   ), //i
    .reset           (reset                                                 )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(bridge_cmdLogic_streamUnbuffered_payload_mode)
      SpiMasterCtrlCmdMode_DATA : bridge_cmdLogic_streamUnbuffered_payload_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : bridge_cmdLogic_streamUnbuffered_payload_mode_string = "SS  ";
      default : bridge_cmdLogic_streamUnbuffered_payload_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_bridge_cmdLogic_streamUnbuffered_payload_mode)
      SpiMasterCtrlCmdMode_DATA : _zz_bridge_cmdLogic_streamUnbuffered_payload_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : _zz_bridge_cmdLogic_streamUnbuffered_payload_mode_string = "SS  ";
      default : _zz_bridge_cmdLogic_streamUnbuffered_payload_mode_string = "????";
    endcase
  end
  `endif

  assign io_spi_ss = spiCtrl_io_spi_ss;
  assign io_spi_sclk = spiCtrl_io_spi_sclk;
  assign io_spi_mosi = spiCtrl_io_spi_mosi;
  assign busCtrl_readErrorFlag = 1'b0;
  assign busCtrl_writeErrorFlag = 1'b0;
  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      8'h0 : begin
        io_apb_PRDATA[31 : 31] = (spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid ^ 1'b0);
        io_apb_PRDATA[7 : 0] = spiCtrl_io_rsp_queueWithOccupancy_io_pop_payload;
        io_apb_PRDATA[21 : 16] = spiCtrl_io_rsp_queueWithOccupancy_io_occupancy;
      end
      8'h04 : begin
        io_apb_PRDATA[21 : 16] = bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability;
        io_apb_PRDATA[0 : 0] = bridge_interruptCtrl_cmdIntEnable;
        io_apb_PRDATA[1 : 1] = bridge_interruptCtrl_rspIntEnable;
        io_apb_PRDATA[8 : 8] = bridge_interruptCtrl_cmdInt;
        io_apb_PRDATA[9 : 9] = bridge_interruptCtrl_rspInt;
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign busCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign busCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign busCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  always @(*) begin
    _zz_bridge_cmdLogic_streamUnbuffered_valid = 1'b0;
    case(io_apb_PADDR)
      8'h0 : begin
        if(busCtrl_doWrite) begin
          _zz_bridge_cmdLogic_streamUnbuffered_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_cmdLogic_streamUnbuffered_valid = _zz_bridge_cmdLogic_streamUnbuffered_valid;
  always @(*) begin
    case(bridge_cmdLogic_streamUnbuffered_payload_mode)
      SpiMasterCtrlCmdMode_DATA : begin
        bridge_cmdLogic_streamUnbuffered_payload_args = {bridge_cmdLogic_dataCmd_read,bridge_cmdLogic_dataCmd_data};
      end
      default : begin
        bridge_cmdLogic_streamUnbuffered_payload_args = {8'd0, _zz_bridge_cmdLogic_streamUnbuffered_payload_args};
      end
    endcase
  end

  assign bridge_cmdLogic_streamUnbuffered_ready = bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready;
  assign spiCtrl_io_rsp_toStream_valid = spiCtrl_io_rsp_valid;
  assign spiCtrl_io_rsp_toStream_payload = spiCtrl_io_rsp_payload;
  assign spiCtrl_io_rsp_toStream_ready = spiCtrl_io_rsp_queueWithOccupancy_io_push_ready;
  always @(*) begin
    spiCtrl_io_rsp_queueWithOccupancy_io_pop_ready = 1'b0;
    case(io_apb_PADDR)
      8'h0 : begin
        if(busCtrl_doRead) begin
          spiCtrl_io_rsp_queueWithOccupancy_io_pop_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_interruptCtrl_cmdInt = (bridge_interruptCtrl_cmdIntEnable && (! bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid));
  assign bridge_interruptCtrl_rspInt = (bridge_interruptCtrl_rspIntEnable && spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid);
  assign bridge_interruptCtrl_interrupt = (bridge_interruptCtrl_rspInt || bridge_interruptCtrl_cmdInt);
  assign io_interrupt = bridge_interruptCtrl_interrupt;
  assign bridge_cmdLogic_dataCmd_data = io_apb_PWDATA[7 : 0];
  assign bridge_cmdLogic_dataCmd_read = io_apb_PWDATA[24];
  assign _zz_bridge_cmdLogic_streamUnbuffered_payload_mode = io_apb_PWDATA[28 : 28];
  assign bridge_cmdLogic_streamUnbuffered_payload_mode = _zz_bridge_cmdLogic_streamUnbuffered_payload_mode;
  assign _zz_spiCtrl_io_config_kind_driver_cpol = io_apb_PWDATA[1 : 0];
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      bridge_interruptCtrl_cmdIntEnable <= 1'b0;
      bridge_interruptCtrl_rspIntEnable <= 1'b0;
      spiCtrl_io_config_ss_activeHigh_driver <= 1'b0;
    end else begin
      case(io_apb_PADDR)
        8'h04 : begin
          if(busCtrl_doWrite) begin
            bridge_interruptCtrl_cmdIntEnable <= io_apb_PWDATA[0];
            bridge_interruptCtrl_rspIntEnable <= io_apb_PWDATA[1];
          end
        end
        8'h08 : begin
          if(busCtrl_doWrite) begin
            spiCtrl_io_config_ss_activeHigh_driver <= io_apb_PWDATA[4 : 4];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(io_apb_PADDR)
      8'h08 : begin
        if(busCtrl_doWrite) begin
          spiCtrl_io_config_kind_driver_cpol <= _zz_spiCtrl_io_config_kind_driver_cpol[0];
          spiCtrl_io_config_kind_driver_cpha <= _zz_spiCtrl_io_config_kind_driver_cpol[1];
        end
      end
      8'h0c : begin
        if(busCtrl_doWrite) begin
          spiCtrl_io_config_sclkToggle_driver <= io_apb_PWDATA[11 : 0];
        end
      end
      8'h10 : begin
        if(busCtrl_doWrite) begin
          spiCtrl_io_config_ss_setup_driver <= io_apb_PWDATA[11 : 0];
        end
      end
      8'h14 : begin
        if(busCtrl_doWrite) begin
          spiCtrl_io_config_ss_hold_driver <= io_apb_PWDATA[11 : 0];
        end
      end
      8'h18 : begin
        if(busCtrl_doWrite) begin
          spiCtrl_io_config_ss_disable_driver <= io_apb_PWDATA[11 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module Apb3UartCtrl (
  input  wire [4:0]    io_apb_PADDR,
  input  wire [0:0]    io_apb_PSEL,
  input  wire          io_apb_PENABLE,
  output wire          io_apb_PREADY,
  input  wire          io_apb_PWRITE,
  input  wire [31:0]   io_apb_PWDATA,
  output reg  [31:0]   io_apb_PRDATA,
  output wire          io_uart_txd,
  input  wire          io_uart_rxd,
  output wire          io_interrupt,
  input  wire          clk,
  input  wire          reset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;

  reg                 uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready;
  wire                uartCtrl_1_io_write_ready;
  wire                uartCtrl_1_io_read_valid;
  wire       [7:0]    uartCtrl_1_io_read_payload;
  wire                uartCtrl_1_io_uart_txd;
  wire                uartCtrl_1_io_readError;
  wire                uartCtrl_1_io_readBreak;
  wire                bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  wire                bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload;
  wire       [4:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy;
  wire       [4:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_availability;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_push_ready;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
  wire       [4:0]    uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
  wire       [4:0]    uartCtrl_1_io_read_queueWithOccupancy_io_availability;
  wire       [0:0]    _zz_bridge_misc_readError;
  wire       [0:0]    _zz_bridge_misc_readOverflowError;
  wire       [0:0]    _zz_bridge_misc_breakDetected;
  wire       [0:0]    _zz_bridge_misc_doBreak;
  wire       [0:0]    _zz_bridge_misc_doBreak_1;
  wire       [4:0]    _zz_io_apb_PRDATA;
  wire                busCtrl_readErrorFlag;
  wire                busCtrl_writeErrorFlag;
  wire                busCtrl_askWrite;
  wire                busCtrl_askRead;
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  wire                bridge_busCtrlWrapped_readErrorFlag;
  wire                bridge_busCtrlWrapped_writeErrorFlag;
  reg        [2:0]    bridge_uartConfigReg_frame_dataLength;
  reg        [0:0]    bridge_uartConfigReg_frame_stop;
  reg        [1:0]    bridge_uartConfigReg_frame_parity;
  reg        [19:0]   bridge_uartConfigReg_clockDivider;
  reg                 _zz_bridge_write_streamUnbuffered_valid;
  wire                bridge_write_streamUnbuffered_valid;
  wire                bridge_write_streamUnbuffered_ready;
  wire       [7:0]    bridge_write_streamUnbuffered_payload;
  reg                 bridge_read_streamBreaked_valid;
  reg                 bridge_read_streamBreaked_ready;
  wire       [7:0]    bridge_read_streamBreaked_payload;
  reg                 bridge_interruptCtrl_writeIntEnable;
  reg                 bridge_interruptCtrl_readIntEnable;
  wire                bridge_interruptCtrl_readInt;
  wire                bridge_interruptCtrl_writeInt;
  wire                bridge_interruptCtrl_interrupt;
  reg                 bridge_misc_readError;
  reg                 when_BusSlaveFactory_l341;
  wire                when_BusSlaveFactory_l347;
  reg                 bridge_misc_readOverflowError;
  reg                 when_BusSlaveFactory_l341_1;
  wire                when_BusSlaveFactory_l347_1;
  wire                uartCtrl_1_io_read_isStall;
  reg                 bridge_misc_breakDetected;
  reg                 uartCtrl_1_io_readBreak_regNext;
  wire                when_UartCtrl_l155;
  reg                 when_BusSlaveFactory_l341_2;
  wire                when_BusSlaveFactory_l347_2;
  reg                 bridge_misc_doBreak;
  reg                 when_BusSlaveFactory_l377;
  wire                when_BusSlaveFactory_l379;
  reg                 when_BusSlaveFactory_l341_3;
  wire                when_BusSlaveFactory_l347_3;
  wire       [1:0]    _zz_bridge_uartConfigReg_frame_parity;
  wire       [0:0]    _zz_bridge_uartConfigReg_frame_stop;
  wire                when_Apb3SlaveFactory_l81;
  `ifndef SYNTHESIS
  reg [23:0] bridge_uartConfigReg_frame_stop_string;
  reg [31:0] bridge_uartConfigReg_frame_parity_string;
  reg [31:0] _zz_bridge_uartConfigReg_frame_parity_string;
  reg [23:0] _zz_bridge_uartConfigReg_frame_stop_string;
  `endif


  assign _zz_bridge_misc_readError = 1'b0;
  assign _zz_bridge_misc_readOverflowError = 1'b0;
  assign _zz_bridge_misc_breakDetected = 1'b0;
  assign _zz_bridge_misc_doBreak = 1'b1;
  assign _zz_bridge_misc_doBreak_1 = 1'b0;
  assign _zz_io_apb_PRDATA = (5'h10 - bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy);
  UartCtrl uartCtrl_1 (
    .io_config_frame_dataLength (bridge_uartConfigReg_frame_dataLength[2:0]                          ), //i
    .io_config_frame_stop       (bridge_uartConfigReg_frame_stop                                     ), //i
    .io_config_frame_parity     (bridge_uartConfigReg_frame_parity[1:0]                              ), //i
    .io_config_clockDivider     (bridge_uartConfigReg_clockDivider[19:0]                             ), //i
    .io_write_valid             (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid       ), //i
    .io_write_ready             (uartCtrl_1_io_write_ready                                           ), //o
    .io_write_payload           (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload[7:0]), //i
    .io_read_valid              (uartCtrl_1_io_read_valid                                            ), //o
    .io_read_ready              (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready                 ), //i
    .io_read_payload            (uartCtrl_1_io_read_payload[7:0]                                     ), //o
    .io_uart_txd                (uartCtrl_1_io_uart_txd                                              ), //o
    .io_uart_rxd                (io_uart_rxd                                                         ), //i
    .io_readError               (uartCtrl_1_io_readError                                             ), //o
    .io_writeBreak              (bridge_misc_doBreak                                                 ), //i
    .io_readBreak               (uartCtrl_1_io_readBreak                                             ), //o
    .clk                        (clk                                                                 ), //i
    .reset                      (reset                                                               )  //i
  );
  StreamFifo bridge_write_streamUnbuffered_queueWithOccupancy (
    .io_push_valid   (bridge_write_streamUnbuffered_valid                                  ), //i
    .io_push_ready   (bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready       ), //o
    .io_push_payload (bridge_write_streamUnbuffered_payload[7:0]                           ), //i
    .io_pop_valid    (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid        ), //o
    .io_pop_ready    (uartCtrl_1_io_write_ready                                            ), //i
    .io_pop_payload  (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload[7:0] ), //o
    .io_flush        (1'b0                                                                 ), //i
    .io_occupancy    (bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy[4:0]   ), //o
    .io_availability (bridge_write_streamUnbuffered_queueWithOccupancy_io_availability[4:0]), //o
    .clk             (clk                                                                  ), //i
    .reset           (reset                                                                )  //i
  );
  StreamFifo uartCtrl_1_io_read_queueWithOccupancy (
    .io_push_valid   (uartCtrl_1_io_read_valid                                  ), //i
    .io_push_ready   (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready       ), //o
    .io_push_payload (uartCtrl_1_io_read_payload[7:0]                           ), //i
    .io_pop_valid    (uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid        ), //o
    .io_pop_ready    (uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready        ), //i
    .io_pop_payload  (uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload[7:0] ), //o
    .io_flush        (1'b0                                                      ), //i
    .io_occupancy    (uartCtrl_1_io_read_queueWithOccupancy_io_occupancy[4:0]   ), //o
    .io_availability (uartCtrl_1_io_read_queueWithOccupancy_io_availability[4:0]), //o
    .clk             (clk                                                       ), //i
    .reset           (reset                                                     )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(bridge_uartConfigReg_frame_stop)
      UartStopType_ONE : bridge_uartConfigReg_frame_stop_string = "ONE";
      UartStopType_TWO : bridge_uartConfigReg_frame_stop_string = "TWO";
      default : bridge_uartConfigReg_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(bridge_uartConfigReg_frame_parity)
      UartParityType_NONE : bridge_uartConfigReg_frame_parity_string = "NONE";
      UartParityType_EVEN : bridge_uartConfigReg_frame_parity_string = "EVEN";
      UartParityType_ODD : bridge_uartConfigReg_frame_parity_string = "ODD ";
      default : bridge_uartConfigReg_frame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_bridge_uartConfigReg_frame_parity)
      UartParityType_NONE : _zz_bridge_uartConfigReg_frame_parity_string = "NONE";
      UartParityType_EVEN : _zz_bridge_uartConfigReg_frame_parity_string = "EVEN";
      UartParityType_ODD : _zz_bridge_uartConfigReg_frame_parity_string = "ODD ";
      default : _zz_bridge_uartConfigReg_frame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_bridge_uartConfigReg_frame_stop)
      UartStopType_ONE : _zz_bridge_uartConfigReg_frame_stop_string = "ONE";
      UartStopType_TWO : _zz_bridge_uartConfigReg_frame_stop_string = "TWO";
      default : _zz_bridge_uartConfigReg_frame_stop_string = "???";
    endcase
  end
  `endif

  assign io_uart_txd = uartCtrl_1_io_uart_txd;
  assign busCtrl_readErrorFlag = 1'b0;
  assign busCtrl_writeErrorFlag = 1'b0;
  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      5'h0 : begin
        io_apb_PRDATA[16 : 16] = (bridge_read_streamBreaked_valid ^ 1'b0);
        io_apb_PRDATA[7 : 0] = bridge_read_streamBreaked_payload;
      end
      5'h04 : begin
        io_apb_PRDATA[20 : 16] = _zz_io_apb_PRDATA;
        io_apb_PRDATA[15 : 15] = bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
        io_apb_PRDATA[28 : 24] = uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
        io_apb_PRDATA[0 : 0] = bridge_interruptCtrl_writeIntEnable;
        io_apb_PRDATA[1 : 1] = bridge_interruptCtrl_readIntEnable;
        io_apb_PRDATA[8 : 8] = bridge_interruptCtrl_writeInt;
        io_apb_PRDATA[9 : 9] = bridge_interruptCtrl_readInt;
      end
      5'h10 : begin
        io_apb_PRDATA[0 : 0] = bridge_misc_readError;
        io_apb_PRDATA[1 : 1] = bridge_misc_readOverflowError;
        io_apb_PRDATA[8 : 8] = uartCtrl_1_io_readBreak;
        io_apb_PRDATA[9 : 9] = bridge_misc_breakDetected;
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign busCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign busCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign busCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign bridge_busCtrlWrapped_readErrorFlag = 1'b0;
  assign bridge_busCtrlWrapped_writeErrorFlag = 1'b0;
  always @(*) begin
    _zz_bridge_write_streamUnbuffered_valid = 1'b0;
    case(io_apb_PADDR)
      5'h0 : begin
        if(busCtrl_doWrite) begin
          _zz_bridge_write_streamUnbuffered_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_write_streamUnbuffered_valid = _zz_bridge_write_streamUnbuffered_valid;
  assign bridge_write_streamUnbuffered_payload = io_apb_PWDATA[7 : 0];
  assign bridge_write_streamUnbuffered_ready = bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  always @(*) begin
    bridge_read_streamBreaked_valid = uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid;
    if(uartCtrl_1_io_readBreak) begin
      bridge_read_streamBreaked_valid = 1'b0;
    end
  end

  always @(*) begin
    uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready = bridge_read_streamBreaked_ready;
    if(uartCtrl_1_io_readBreak) begin
      uartCtrl_1_io_read_queueWithOccupancy_io_pop_ready = 1'b1;
    end
  end

  assign bridge_read_streamBreaked_payload = uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
  always @(*) begin
    bridge_read_streamBreaked_ready = 1'b0;
    case(io_apb_PADDR)
      5'h0 : begin
        if(busCtrl_doRead) begin
          bridge_read_streamBreaked_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_interruptCtrl_readInt = (bridge_interruptCtrl_readIntEnable && bridge_read_streamBreaked_valid);
  assign bridge_interruptCtrl_writeInt = (bridge_interruptCtrl_writeIntEnable && (! bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid));
  assign bridge_interruptCtrl_interrupt = (bridge_interruptCtrl_readInt || bridge_interruptCtrl_writeInt);
  always @(*) begin
    when_BusSlaveFactory_l341 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l341 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l347 = io_apb_PWDATA[0];
  always @(*) begin
    when_BusSlaveFactory_l341_1 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l341_1 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l347_1 = io_apb_PWDATA[1];
  assign uartCtrl_1_io_read_isStall = (uartCtrl_1_io_read_valid && (! uartCtrl_1_io_read_queueWithOccupancy_io_push_ready));
  assign when_UartCtrl_l155 = (uartCtrl_1_io_readBreak && (! uartCtrl_1_io_readBreak_regNext));
  always @(*) begin
    when_BusSlaveFactory_l341_2 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l341_2 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l347_2 = io_apb_PWDATA[9];
  always @(*) begin
    when_BusSlaveFactory_l377 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l377 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l379 = io_apb_PWDATA[10];
  always @(*) begin
    when_BusSlaveFactory_l341_3 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite) begin
          when_BusSlaveFactory_l341_3 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_BusSlaveFactory_l347_3 = io_apb_PWDATA[11];
  assign io_interrupt = bridge_interruptCtrl_interrupt;
  assign _zz_bridge_uartConfigReg_frame_parity = io_apb_PWDATA[9 : 8];
  assign _zz_bridge_uartConfigReg_frame_stop = io_apb_PWDATA[16 : 16];
  assign when_Apb3SlaveFactory_l81 = ((io_apb_PADDR & (~ 5'h03)) == 5'h08);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      bridge_uartConfigReg_clockDivider <= 20'h0;
      bridge_interruptCtrl_writeIntEnable <= 1'b0;
      bridge_interruptCtrl_readIntEnable <= 1'b0;
      bridge_misc_readError <= 1'b0;
      bridge_misc_readOverflowError <= 1'b0;
      bridge_misc_breakDetected <= 1'b0;
      bridge_misc_doBreak <= 1'b0;
    end else begin
      if(when_BusSlaveFactory_l341) begin
        if(when_BusSlaveFactory_l347) begin
          bridge_misc_readError <= _zz_bridge_misc_readError[0];
        end
      end
      if(uartCtrl_1_io_readError) begin
        bridge_misc_readError <= 1'b1;
      end
      if(when_BusSlaveFactory_l341_1) begin
        if(when_BusSlaveFactory_l347_1) begin
          bridge_misc_readOverflowError <= _zz_bridge_misc_readOverflowError[0];
        end
      end
      if(uartCtrl_1_io_read_isStall) begin
        bridge_misc_readOverflowError <= 1'b1;
      end
      if(when_UartCtrl_l155) begin
        bridge_misc_breakDetected <= 1'b1;
      end
      if(when_BusSlaveFactory_l341_2) begin
        if(when_BusSlaveFactory_l347_2) begin
          bridge_misc_breakDetected <= _zz_bridge_misc_breakDetected[0];
        end
      end
      if(when_BusSlaveFactory_l377) begin
        if(when_BusSlaveFactory_l379) begin
          bridge_misc_doBreak <= _zz_bridge_misc_doBreak[0];
        end
      end
      if(when_BusSlaveFactory_l341_3) begin
        if(when_BusSlaveFactory_l347_3) begin
          bridge_misc_doBreak <= _zz_bridge_misc_doBreak_1[0];
        end
      end
      case(io_apb_PADDR)
        5'h04 : begin
          if(busCtrl_doWrite) begin
            bridge_interruptCtrl_writeIntEnable <= io_apb_PWDATA[0];
            bridge_interruptCtrl_readIntEnable <= io_apb_PWDATA[1];
          end
        end
        default : begin
        end
      endcase
      if(when_Apb3SlaveFactory_l81) begin
        if(busCtrl_doWrite) begin
          bridge_uartConfigReg_clockDivider[19 : 0] <= io_apb_PWDATA[19 : 0];
        end
      end
    end
  end

  always @(posedge clk) begin
    uartCtrl_1_io_readBreak_regNext <= uartCtrl_1_io_readBreak;
    case(io_apb_PADDR)
      5'h0c : begin
        if(busCtrl_doWrite) begin
          bridge_uartConfigReg_frame_dataLength <= io_apb_PWDATA[2 : 0];
          bridge_uartConfigReg_frame_parity <= _zz_bridge_uartConfigReg_frame_parity;
          bridge_uartConfigReg_frame_stop <= _zz_bridge_uartConfigReg_frame_stop;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

//Apb3Gpio_3 replaced by Apb3Gpio_2

module Apb3Gpio_2 (
  input  wire [3:0]    io_apb_PADDR,
  input  wire [0:0]    io_apb_PSEL,
  input  wire          io_apb_PENABLE,
  output wire          io_apb_PREADY,
  input  wire          io_apb_PWRITE,
  input  wire [31:0]   io_apb_PWDATA,
  output reg  [31:0]   io_apb_PRDATA,
  output wire          io_apb_PSLVERROR,
  input  wire [31:0]   io_gpio_read,
  output wire [31:0]   io_gpio_write,
  output wire [31:0]   io_gpio_writeEnable,
  output wire [31:0]   io_value,
  input  wire          clk,
  input  wire          reset
);

  wire       [31:0]   io_gpio_read_buffercc_io_dataOut;
  wire                ctrl_readErrorFlag;
  wire                ctrl_writeErrorFlag;
  wire                ctrl_askWrite;
  wire                ctrl_askRead;
  wire                ctrl_doWrite;
  wire                ctrl_doRead;
  reg        [31:0]   io_gpio_write_driver;
  reg        [31:0]   io_gpio_writeEnable_driver;

  (* keep_hierarchy = "TRUE" *) BufferCC_2 io_gpio_read_buffercc (
    .io_dataIn  (io_gpio_read[31:0]                    ), //i
    .io_dataOut (io_gpio_read_buffercc_io_dataOut[31:0]), //o
    .clk        (clk                                   ), //i
    .reset      (reset                                 )  //i
  );
  assign io_value = io_gpio_read_buffercc_io_dataOut;
  assign ctrl_readErrorFlag = 1'b0;
  assign ctrl_writeErrorFlag = 1'b0;
  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      4'b0000 : begin
        io_apb_PRDATA[31 : 0] = io_value;
      end
      4'b0100 : begin
        io_apb_PRDATA[31 : 0] = io_gpio_write_driver;
      end
      4'b1000 : begin
        io_apb_PRDATA[31 : 0] = io_gpio_writeEnable_driver;
      end
      default : begin
      end
    endcase
  end

  assign ctrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign ctrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign ctrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign ctrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign io_apb_PSLVERROR = ((ctrl_doWrite && ctrl_writeErrorFlag) || (ctrl_doRead && ctrl_readErrorFlag));
  assign io_gpio_write = io_gpio_write_driver;
  assign io_gpio_writeEnable = io_gpio_writeEnable_driver;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_gpio_writeEnable_driver <= 32'h0;
    end else begin
      case(io_apb_PADDR)
        4'b1000 : begin
          if(ctrl_doWrite) begin
            io_gpio_writeEnable_driver <= io_apb_PWDATA[31 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(io_apb_PADDR)
      4'b0100 : begin
        if(ctrl_doWrite) begin
          io_gpio_write_driver <= io_apb_PWDATA[31 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module Apb3Gpio_1 (
  input  wire [3:0]    io_apb_PADDR,
  input  wire [0:0]    io_apb_PSEL,
  input  wire          io_apb_PENABLE,
  output wire          io_apb_PREADY,
  input  wire          io_apb_PWRITE,
  input  wire [31:0]   io_apb_PWDATA,
  output reg  [31:0]   io_apb_PRDATA,
  output wire          io_apb_PSLVERROR,
  input  wire [3:0]    io_gpio_read,
  output wire [3:0]    io_gpio_write,
  output wire [3:0]    io_gpio_writeEnable,
  output wire [3:0]    io_value,
  input  wire          clk,
  input  wire          reset
);

  wire       [3:0]    io_gpio_read_buffercc_io_dataOut;
  wire                ctrl_readErrorFlag;
  wire                ctrl_writeErrorFlag;
  wire                ctrl_askWrite;
  wire                ctrl_askRead;
  wire                ctrl_doWrite;
  wire                ctrl_doRead;
  reg        [3:0]    io_gpio_write_driver;
  reg        [3:0]    io_gpio_writeEnable_driver;

  (* keep_hierarchy = "TRUE" *) BufferCC_1 io_gpio_read_buffercc (
    .io_dataIn  (io_gpio_read[3:0]                    ), //i
    .io_dataOut (io_gpio_read_buffercc_io_dataOut[3:0]), //o
    .clk        (clk                                  ), //i
    .reset      (reset                                )  //i
  );
  assign io_value = io_gpio_read_buffercc_io_dataOut;
  assign ctrl_readErrorFlag = 1'b0;
  assign ctrl_writeErrorFlag = 1'b0;
  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      4'b0000 : begin
        io_apb_PRDATA[3 : 0] = io_value;
      end
      4'b0100 : begin
        io_apb_PRDATA[3 : 0] = io_gpio_write_driver;
      end
      4'b1000 : begin
        io_apb_PRDATA[3 : 0] = io_gpio_writeEnable_driver;
      end
      default : begin
      end
    endcase
  end

  assign ctrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign ctrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign ctrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign ctrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign io_apb_PSLVERROR = ((ctrl_doWrite && ctrl_writeErrorFlag) || (ctrl_doRead && ctrl_readErrorFlag));
  assign io_gpio_write = io_gpio_write_driver;
  assign io_gpio_writeEnable = io_gpio_writeEnable_driver;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_gpio_writeEnable_driver <= 4'b0000;
    end else begin
      case(io_apb_PADDR)
        4'b1000 : begin
          if(ctrl_doWrite) begin
            io_gpio_writeEnable_driver <= io_apb_PWDATA[3 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(io_apb_PADDR)
      4'b0100 : begin
        if(ctrl_doWrite) begin
          io_gpio_write_driver <= io_apb_PWDATA[3 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module Apb3Gpio (
  input  wire [3:0]    io_apb_PADDR,
  input  wire [0:0]    io_apb_PSEL,
  input  wire          io_apb_PENABLE,
  output wire          io_apb_PREADY,
  input  wire          io_apb_PWRITE,
  input  wire [31:0]   io_apb_PWDATA,
  output reg  [31:0]   io_apb_PRDATA,
  output wire          io_apb_PSLVERROR,
  input  wire [5:0]    io_gpio_read,
  output wire [5:0]    io_gpio_write,
  output wire [5:0]    io_gpio_writeEnable,
  output wire [5:0]    io_value,
  input  wire          clk,
  input  wire          reset
);

  wire       [5:0]    io_gpio_read_buffercc_io_dataOut;
  wire                ctrl_readErrorFlag;
  wire                ctrl_writeErrorFlag;
  wire                ctrl_askWrite;
  wire                ctrl_askRead;
  wire                ctrl_doWrite;
  wire                ctrl_doRead;
  reg        [5:0]    io_gpio_write_driver;
  reg        [5:0]    io_gpio_writeEnable_driver;

  (* keep_hierarchy = "TRUE" *) BufferCC io_gpio_read_buffercc (
    .io_dataIn  (io_gpio_read[5:0]                    ), //i
    .io_dataOut (io_gpio_read_buffercc_io_dataOut[5:0]), //o
    .clk        (clk                                  ), //i
    .reset      (reset                                )  //i
  );
  assign io_value = io_gpio_read_buffercc_io_dataOut;
  assign ctrl_readErrorFlag = 1'b0;
  assign ctrl_writeErrorFlag = 1'b0;
  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      4'b0000 : begin
        io_apb_PRDATA[5 : 0] = io_value;
      end
      4'b0100 : begin
        io_apb_PRDATA[5 : 0] = io_gpio_write_driver;
      end
      4'b1000 : begin
        io_apb_PRDATA[5 : 0] = io_gpio_writeEnable_driver;
      end
      default : begin
      end
    endcase
  end

  assign ctrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign ctrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign ctrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign ctrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign io_apb_PSLVERROR = ((ctrl_doWrite && ctrl_writeErrorFlag) || (ctrl_doRead && ctrl_readErrorFlag));
  assign io_gpio_write = io_gpio_write_driver;
  assign io_gpio_writeEnable = io_gpio_writeEnable_driver;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_gpio_writeEnable_driver <= 6'h0;
    end else begin
      case(io_apb_PADDR)
        4'b1000 : begin
          if(ctrl_doWrite) begin
            io_gpio_writeEnable_driver <= io_apb_PWDATA[5 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(io_apb_PADDR)
      4'b0100 : begin
        if(ctrl_doWrite) begin
          io_gpio_write_driver <= io_apb_PWDATA[5 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BufferCC_12 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk,
  input  wire          debugReset
);

  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg                 buffers_0;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" , async_reg = "true" *) reg                 buffers_1;

  initial begin
  `ifndef SYNTHESIS
    buffers_0 = $urandom;
    buffers_1 = $urandom;
  `endif
  end

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module BufferCC_8 (
  input  wire [10:0]   io_dataIn,
  output wire [10:0]   io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" *) reg        [10:0]   buffers_0;
  (* async_reg = "true" *) reg        [10:0]   buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module StreamFifoCC (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire          io_push_payload_last,
  input  wire [31:0]   io_push_payload_fragment,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire          io_pop_payload_last,
  output wire [31:0]   io_pop_payload_fragment,
  output wire [13:0]   io_pushOccupancy,
  output wire [13:0]   io_popOccupancy,
  input  wire          clk,
  input  wire          reset,
  input  wire          io_pix_clk
);

  reg        [32:0]   ram_spinal_port1;
  wire       [13:0]   popToPushGray_buffercc_io_dataOut;
  wire                reset_asyncAssertSyncDeassert_buffercc_io_dataOut;
  wire       [13:0]   pushToPopGray_buffercc_io_dataOut;
  wire       [13:0]   _zz_pushCC_pushPtrGray;
  wire       [12:0]   _zz_ram_port;
  wire       [32:0]   _zz_ram_port_1;
  wire       [0:0]    _zz_io_pushOccupancy_13;
  wire       [3:0]    _zz_io_pushOccupancy_14;
  wire       [13:0]   _zz_popCC_popPtrGray;
  wire       [0:0]    _zz_io_popOccupancy_13;
  wire       [3:0]    _zz_io_popOccupancy_14;
  reg                 _zz_1;
  wire       [13:0]   popToPushGray;
  wire       [13:0]   pushToPopGray;
  reg        [13:0]   pushCC_pushPtr;
  wire       [13:0]   pushCC_pushPtrPlus;
  wire                io_push_fire;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [13:0]   pushCC_pushPtrGray;
  wire       [13:0]   pushCC_popPtrGray;
  wire                pushCC_full;
  wire                _zz_io_pushOccupancy;
  wire                _zz_io_pushOccupancy_1;
  wire                _zz_io_pushOccupancy_2;
  wire                _zz_io_pushOccupancy_3;
  wire                _zz_io_pushOccupancy_4;
  wire                _zz_io_pushOccupancy_5;
  wire                _zz_io_pushOccupancy_6;
  wire                _zz_io_pushOccupancy_7;
  wire                _zz_io_pushOccupancy_8;
  wire                _zz_io_pushOccupancy_9;
  wire                _zz_io_pushOccupancy_10;
  wire                _zz_io_pushOccupancy_11;
  wire                _zz_io_pushOccupancy_12;
  wire                reset_asyncAssertSyncDeassert;
  wire                reset_synchronized;
  reg        [13:0]   popCC_popPtr;
  (* keep , syn_keep *) wire       [13:0]   popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [13:0]   popCC_popPtrGray;
  wire       [13:0]   popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [12:0]   popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [12:0]   popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [12:0]   popCC_addressGen_rData;
  wire                when_Stream_l477;
  wire                popCC_readPort_cmd_valid;
  wire       [12:0]   popCC_readPort_cmd_payload;
  wire                popCC_readPort_rsp_last;
  wire       [31:0]   popCC_readPort_rsp_fragment;
  wire       [32:0]   _zz_popCC_readPort_rsp_last;
  wire                popCC_addressGen_toFlowFire_valid;
  wire       [12:0]   popCC_addressGen_toFlowFire_payload;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire                popCC_readArbitation_translated_payload_last;
  wire       [31:0]   popCC_readArbitation_translated_payload_fragment;
  wire                popCC_readArbitation_fire;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [13:0]   popCC_ptrToPush;
  reg        [13:0]   popCC_ptrToOccupancy;
  wire                _zz_io_popOccupancy;
  wire                _zz_io_popOccupancy_1;
  wire                _zz_io_popOccupancy_2;
  wire                _zz_io_popOccupancy_3;
  wire                _zz_io_popOccupancy_4;
  wire                _zz_io_popOccupancy_5;
  wire                _zz_io_popOccupancy_6;
  wire                _zz_io_popOccupancy_7;
  wire                _zz_io_popOccupancy_8;
  wire                _zz_io_popOccupancy_9;
  wire                _zz_io_popOccupancy_10;
  wire                _zz_io_popOccupancy_11;
  wire                _zz_io_popOccupancy_12;
  reg [32:0] ram [0:8191];

  assign _zz_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_ram_port = pushCC_pushPtr[12:0];
  assign _zz_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  assign _zz_ram_port_1 = {io_push_payload_fragment,io_push_payload_last};
  assign _zz_io_pushOccupancy_13 = _zz_io_pushOccupancy_3;
  assign _zz_io_pushOccupancy_14 = {_zz_io_pushOccupancy_2,{_zz_io_pushOccupancy_1,{_zz_io_pushOccupancy,(pushCC_popPtrGray[0] ^ _zz_io_pushOccupancy)}}};
  assign _zz_io_popOccupancy_13 = _zz_io_popOccupancy_3;
  assign _zz_io_popOccupancy_14 = {_zz_io_popOccupancy_2,{_zz_io_popOccupancy_1,{_zz_io_popOccupancy,(popCC_pushPtrGray[0] ^ _zz_io_popOccupancy)}}};
  always @(posedge clk) begin
    if(_zz_1) begin
      ram[_zz_ram_port] <= _zz_ram_port_1;
    end
  end

  always @(posedge io_pix_clk) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC_5 popToPushGray_buffercc (
    .io_dataIn  (popToPushGray[13:0]                    ), //i
    .io_dataOut (popToPushGray_buffercc_io_dataOut[13:0]), //o
    .clk        (clk                                    ), //i
    .reset      (reset                                  )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_6 reset_asyncAssertSyncDeassert_buffercc (
    .io_dataIn  (reset_asyncAssertSyncDeassert                    ), //i
    .io_dataOut (reset_asyncAssertSyncDeassert_buffercc_io_dataOut), //o
    .io_pix_clk (io_pix_clk                                       ), //i
    .reset      (reset                                            )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_7 pushToPopGray_buffercc (
    .io_dataIn          (pushToPopGray[13:0]                    ), //i
    .io_dataOut         (pushToPopGray_buffercc_io_dataOut[13:0]), //o
    .io_pix_clk         (io_pix_clk                             ), //i
    .reset_synchronized (reset_synchronized                     )  //i
  );
  always @(*) begin
    _zz_1 = 1'b0;
    if(io_push_fire) begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 14'h0001);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[13 : 12] == (~ pushCC_popPtrGray[13 : 12])) && (pushCC_pushPtrGray[11 : 0] == pushCC_popPtrGray[11 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign _zz_io_pushOccupancy = (pushCC_popPtrGray[1] ^ _zz_io_pushOccupancy_1);
  assign _zz_io_pushOccupancy_1 = (pushCC_popPtrGray[2] ^ _zz_io_pushOccupancy_2);
  assign _zz_io_pushOccupancy_2 = (pushCC_popPtrGray[3] ^ _zz_io_pushOccupancy_3);
  assign _zz_io_pushOccupancy_3 = (pushCC_popPtrGray[4] ^ _zz_io_pushOccupancy_4);
  assign _zz_io_pushOccupancy_4 = (pushCC_popPtrGray[5] ^ _zz_io_pushOccupancy_5);
  assign _zz_io_pushOccupancy_5 = (pushCC_popPtrGray[6] ^ _zz_io_pushOccupancy_6);
  assign _zz_io_pushOccupancy_6 = (pushCC_popPtrGray[7] ^ _zz_io_pushOccupancy_7);
  assign _zz_io_pushOccupancy_7 = (pushCC_popPtrGray[8] ^ _zz_io_pushOccupancy_8);
  assign _zz_io_pushOccupancy_8 = (pushCC_popPtrGray[9] ^ _zz_io_pushOccupancy_9);
  assign _zz_io_pushOccupancy_9 = (pushCC_popPtrGray[10] ^ _zz_io_pushOccupancy_10);
  assign _zz_io_pushOccupancy_10 = (pushCC_popPtrGray[11] ^ _zz_io_pushOccupancy_11);
  assign _zz_io_pushOccupancy_11 = (pushCC_popPtrGray[12] ^ _zz_io_pushOccupancy_12);
  assign _zz_io_pushOccupancy_12 = pushCC_popPtrGray[13];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_io_pushOccupancy_12,{_zz_io_pushOccupancy_11,{_zz_io_pushOccupancy_10,{_zz_io_pushOccupancy_9,{_zz_io_pushOccupancy_8,{_zz_io_pushOccupancy_7,{_zz_io_pushOccupancy_6,{_zz_io_pushOccupancy_5,{_zz_io_pushOccupancy_4,{_zz_io_pushOccupancy_13,_zz_io_pushOccupancy_14}}}}}}}}}});
  assign reset_asyncAssertSyncDeassert = (1'b0 ^ 1'b0);
  assign reset_synchronized = reset_asyncAssertSyncDeassert_buffercc_io_dataOut;
  assign popCC_popPtrPlus = (popCC_popPtr + 14'h0001);
  assign popCC_popPtrGray = (_zz_popCC_popPtrGray ^ popCC_popPtr);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign popCC_addressGen_valid = (! popCC_empty);
  assign popCC_addressGen_payload = popCC_popPtr[12:0];
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready);
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready;
    if(when_Stream_l477) begin
      popCC_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l477 = (! popCC_readArbitation_valid);
  assign popCC_readArbitation_valid = popCC_addressGen_rValid;
  assign popCC_readArbitation_payload = popCC_addressGen_rData;
  assign _zz_popCC_readPort_rsp_last = ram_spinal_port1;
  assign popCC_readPort_rsp_last = _zz_popCC_readPort_rsp_last[0];
  assign popCC_readPort_rsp_fragment = _zz_popCC_readPort_rsp_last[32 : 1];
  assign popCC_addressGen_toFlowFire_valid = popCC_addressGen_fire;
  assign popCC_addressGen_toFlowFire_payload = popCC_addressGen_payload;
  assign popCC_readPort_cmd_valid = popCC_addressGen_toFlowFire_valid;
  assign popCC_readPort_cmd_payload = popCC_addressGen_toFlowFire_payload;
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid;
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready;
  assign popCC_readArbitation_translated_payload_last = popCC_readPort_rsp_last;
  assign popCC_readArbitation_translated_payload_fragment = popCC_readPort_rsp_fragment;
  assign io_pop_valid = popCC_readArbitation_translated_valid;
  assign popCC_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_last = popCC_readArbitation_translated_payload_last;
  assign io_pop_payload_fragment = popCC_readArbitation_translated_payload_fragment;
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready);
  assign _zz_io_popOccupancy = (popCC_pushPtrGray[1] ^ _zz_io_popOccupancy_1);
  assign _zz_io_popOccupancy_1 = (popCC_pushPtrGray[2] ^ _zz_io_popOccupancy_2);
  assign _zz_io_popOccupancy_2 = (popCC_pushPtrGray[3] ^ _zz_io_popOccupancy_3);
  assign _zz_io_popOccupancy_3 = (popCC_pushPtrGray[4] ^ _zz_io_popOccupancy_4);
  assign _zz_io_popOccupancy_4 = (popCC_pushPtrGray[5] ^ _zz_io_popOccupancy_5);
  assign _zz_io_popOccupancy_5 = (popCC_pushPtrGray[6] ^ _zz_io_popOccupancy_6);
  assign _zz_io_popOccupancy_6 = (popCC_pushPtrGray[7] ^ _zz_io_popOccupancy_7);
  assign _zz_io_popOccupancy_7 = (popCC_pushPtrGray[8] ^ _zz_io_popOccupancy_8);
  assign _zz_io_popOccupancy_8 = (popCC_pushPtrGray[9] ^ _zz_io_popOccupancy_9);
  assign _zz_io_popOccupancy_9 = (popCC_pushPtrGray[10] ^ _zz_io_popOccupancy_10);
  assign _zz_io_popOccupancy_10 = (popCC_pushPtrGray[11] ^ _zz_io_popOccupancy_11);
  assign _zz_io_popOccupancy_11 = (popCC_pushPtrGray[12] ^ _zz_io_popOccupancy_12);
  assign _zz_io_popOccupancy_12 = popCC_pushPtrGray[13];
  assign io_popOccupancy = ({_zz_io_popOccupancy_12,{_zz_io_popOccupancy_11,{_zz_io_popOccupancy_10,{_zz_io_popOccupancy_9,{_zz_io_popOccupancy_8,{_zz_io_popOccupancy_7,{_zz_io_popOccupancy_6,{_zz_io_popOccupancy_5,{_zz_io_popOccupancy_4,{_zz_io_popOccupancy_13,_zz_io_popOccupancy_14}}}}}}}}}} - popCC_ptrToOccupancy);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_ptrToPush;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      pushCC_pushPtr <= 14'h0;
      pushCC_pushPtrGray <= 14'h0;
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (_zz_pushCC_pushPtrGray ^ pushCC_pushPtrPlus);
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @(posedge io_pix_clk or posedge reset_synchronized) begin
    if(reset_synchronized) begin
      popCC_popPtr <= 14'h0;
      popCC_addressGen_rValid <= 1'b0;
      popCC_ptrToPush <= 14'h0;
      popCC_ptrToOccupancy <= 14'h0;
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid;
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray;
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr;
      end
    end
  end

  always @(posedge io_pix_clk) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload;
    end
  end


endmodule

module StreamFifo_3 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clk,
  input  wire          reset
);

  reg        [7:0]    logic_ram_spinal_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1455;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l477;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp;
  wire                logic_pop_addressGen_toFlowFire_valid;
  wire       [4:0]    logic_pop_addressGen_toFlowFire_payload;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:31];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1455 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0];
  assign logic_push_onRam_write_payload_data = io_push_payload;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l477) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l477 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1;
  assign logic_pop_addressGen_toFlowFire_valid = logic_pop_addressGen_fire;
  assign logic_pop_addressGen_toFlowFire_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_toFlowFire_valid;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_toFlowFire_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (6'h20 - logic_ptr_occupancy);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      logic_ptr_push <= 6'h0;
      logic_ptr_pop <= 6'h0;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 6'h0;
    end else begin
      if(when_Stream_l1455) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01);
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0;
        logic_ptr_pop <= 6'h0;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

module StreamFifo_2 (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [0:0]    io_push_payload_mode,
  input  wire [8:0]    io_push_payload_args,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [0:0]    io_pop_payload_mode,
  output wire [8:0]    io_pop_payload_args,
  input  wire          io_flush,
  output wire [5:0]    io_occupancy,
  output wire [5:0]    io_availability,
  input  wire          clk,
  input  wire          reset
);
  localparam SpiMasterCtrlCmdMode_DATA = 1'd0;
  localparam SpiMasterCtrlCmdMode_SS = 1'd1;

  reg        [9:0]    logic_ram_spinal_port1;
  wire       [9:0]    _zz_logic_ram_port;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [5:0]    logic_ptr_push;
  reg        [5:0]    logic_ptr_pop;
  wire       [5:0]    logic_ptr_occupancy;
  wire       [5:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1455;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [4:0]    logic_push_onRam_write_payload_address;
  wire       [0:0]    logic_push_onRam_write_payload_data_mode;
  wire       [8:0]    logic_push_onRam_write_payload_data_args;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [4:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [4:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [4:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l477;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [4:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [0:0]    logic_pop_sync_readPort_rsp_mode;
  wire       [8:0]    logic_pop_sync_readPort_rsp_args;
  wire       [0:0]    _zz_logic_pop_sync_readPort_rsp_mode;
  wire       [9:0]    _zz_logic_pop_sync_readPort_rsp_args;
  wire       [0:0]    _zz_logic_pop_sync_readPort_rsp_mode_1;
  wire                logic_pop_addressGen_toFlowFire_valid;
  wire       [4:0]    logic_pop_addressGen_toFlowFire_payload;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [0:0]    logic_pop_sync_readArbitation_translated_payload_mode;
  wire       [8:0]    logic_pop_sync_readArbitation_translated_payload_args;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [5:0]    logic_pop_sync_popReg;
  `ifndef SYNTHESIS
  reg [31:0] io_push_payload_mode_string;
  reg [31:0] io_pop_payload_mode_string;
  reg [31:0] logic_push_onRam_write_payload_data_mode_string;
  reg [31:0] logic_pop_sync_readPort_rsp_mode_string;
  reg [31:0] _zz_logic_pop_sync_readPort_rsp_mode_string;
  reg [31:0] _zz_logic_pop_sync_readPort_rsp_mode_1_string;
  reg [31:0] logic_pop_sync_readArbitation_translated_payload_mode_string;
  `endif

  reg [9:0] logic_ram [0:31];

  assign _zz_logic_ram_port = {logic_push_onRam_write_payload_data_args,logic_push_onRam_write_payload_data_mode};
  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= _zz_logic_ram_port;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(io_push_payload_mode)
      SpiMasterCtrlCmdMode_DATA : io_push_payload_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : io_push_payload_mode_string = "SS  ";
      default : io_push_payload_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(io_pop_payload_mode)
      SpiMasterCtrlCmdMode_DATA : io_pop_payload_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : io_pop_payload_mode_string = "SS  ";
      default : io_pop_payload_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(logic_push_onRam_write_payload_data_mode)
      SpiMasterCtrlCmdMode_DATA : logic_push_onRam_write_payload_data_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : logic_push_onRam_write_payload_data_mode_string = "SS  ";
      default : logic_push_onRam_write_payload_data_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(logic_pop_sync_readPort_rsp_mode)
      SpiMasterCtrlCmdMode_DATA : logic_pop_sync_readPort_rsp_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : logic_pop_sync_readPort_rsp_mode_string = "SS  ";
      default : logic_pop_sync_readPort_rsp_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_logic_pop_sync_readPort_rsp_mode)
      SpiMasterCtrlCmdMode_DATA : _zz_logic_pop_sync_readPort_rsp_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : _zz_logic_pop_sync_readPort_rsp_mode_string = "SS  ";
      default : _zz_logic_pop_sync_readPort_rsp_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_logic_pop_sync_readPort_rsp_mode_1)
      SpiMasterCtrlCmdMode_DATA : _zz_logic_pop_sync_readPort_rsp_mode_1_string = "DATA";
      SpiMasterCtrlCmdMode_SS : _zz_logic_pop_sync_readPort_rsp_mode_1_string = "SS  ";
      default : _zz_logic_pop_sync_readPort_rsp_mode_1_string = "????";
    endcase
  end
  always @(*) begin
    case(logic_pop_sync_readArbitation_translated_payload_mode)
      SpiMasterCtrlCmdMode_DATA : logic_pop_sync_readArbitation_translated_payload_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : logic_pop_sync_readArbitation_translated_payload_mode_string = "SS  ";
      default : logic_pop_sync_readArbitation_translated_payload_mode_string = "????";
    endcase
  end
  `endif

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1455 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 6'h20) == 6'h0);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[4:0];
  assign logic_push_onRam_write_payload_data_mode = io_push_payload_mode;
  assign logic_push_onRam_write_payload_data_args = io_push_payload_args;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[4:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l477) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l477 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign _zz_logic_pop_sync_readPort_rsp_args = logic_ram_spinal_port1;
  assign _zz_logic_pop_sync_readPort_rsp_mode_1 = _zz_logic_pop_sync_readPort_rsp_args[0 : 0];
  assign _zz_logic_pop_sync_readPort_rsp_mode = _zz_logic_pop_sync_readPort_rsp_mode_1;
  assign logic_pop_sync_readPort_rsp_mode = _zz_logic_pop_sync_readPort_rsp_mode;
  assign logic_pop_sync_readPort_rsp_args = _zz_logic_pop_sync_readPort_rsp_args[9 : 1];
  assign logic_pop_addressGen_toFlowFire_valid = logic_pop_addressGen_fire;
  assign logic_pop_addressGen_toFlowFire_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_toFlowFire_valid;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_toFlowFire_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload_mode = logic_pop_sync_readPort_rsp_mode;
  assign logic_pop_sync_readArbitation_translated_payload_args = logic_pop_sync_readPort_rsp_args;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload_mode = logic_pop_sync_readArbitation_translated_payload_mode;
  assign io_pop_payload_args = logic_pop_sync_readArbitation_translated_payload_args;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (6'h20 - logic_ptr_occupancy);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      logic_ptr_push <= 6'h0;
      logic_ptr_pop <= 6'h0;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 6'h0;
    end else begin
      if(when_Stream_l1455) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 6'h01);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 6'h01);
      end
      if(io_flush) begin
        logic_ptr_push <= 6'h0;
        logic_ptr_pop <= 6'h0;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 6'h0;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

module SpiMasterCtrl (
  input  wire          io_config_kind_cpol,
  input  wire          io_config_kind_cpha,
  input  wire [11:0]   io_config_sclkToggle,
  input  wire [0:0]    io_config_ss_activeHigh,
  input  wire [11:0]   io_config_ss_setup,
  input  wire [11:0]   io_config_ss_hold,
  input  wire [11:0]   io_config_ss_disable,
  input  wire          io_cmd_valid,
  output reg           io_cmd_ready,
  input  wire [0:0]    io_cmd_payload_mode,
  input  wire [8:0]    io_cmd_payload_args,
  output wire          io_rsp_valid,
  output wire [7:0]    io_rsp_payload,
  output wire [0:0]    io_spi_ss,
  output wire          io_spi_sclk,
  output wire          io_spi_mosi,
  input  wire          io_spi_miso,
  input  wire          clk,
  input  wire          reset
);
  localparam SpiMasterCtrlCmdMode_DATA = 1'd0;
  localparam SpiMasterCtrlCmdMode_SS = 1'd1;

  wire       [3:0]    _zz_fsm_counter_valueNext;
  wire       [0:0]    _zz_fsm_counter_valueNext_1;
  wire       [8:0]    _zz_fsm_buffer;
  wire                _zz_when;
  wire       [7:0]    _zz__zz_io_spi_mosi;
  wire       [2:0]    _zz__zz_io_spi_mosi_1;
  wire       [2:0]    _zz__zz_io_spi_mosi_2;
  reg        [11:0]   timer_counter;
  reg                 timer_reset;
  wire                timer_ss_setupHit;
  wire                timer_ss_holdHit;
  wire                timer_ss_disableHit;
  wire                timer_sclkToggleHit;
  reg                 fsm_counter_willIncrement;
  wire                fsm_counter_willClear;
  reg        [3:0]    fsm_counter_valueNext;
  reg        [3:0]    fsm_counter_value;
  wire                fsm_counter_willOverflowIfInc;
  wire                fsm_counter_willOverflow;
  reg        [7:0]    fsm_buffer;
  reg        [0:0]    fsm_ss;
  wire                when_SpiMasterCtrl_l201;
  wire                when_SpiMasterCtrl_l218;
  wire                when_SpiMasterCtrl_l231;
  wire                io_cmd_fire;
  reg                 _zz_io_rsp_valid;
  wire                when_SpiMasterCtrl_l252;
  reg                 _zz_io_spi_sclk;
  reg                 _zz_io_spi_mosi;
  `ifndef SYNTHESIS
  reg [31:0] io_cmd_payload_mode_string;
  `endif


  assign _zz_when = io_cmd_payload_args[0];
  assign _zz_fsm_counter_valueNext_1 = fsm_counter_willIncrement;
  assign _zz_fsm_counter_valueNext = {3'd0, _zz_fsm_counter_valueNext_1};
  assign _zz_fsm_buffer = {fsm_buffer,io_spi_miso};
  assign _zz__zz_io_spi_mosi = io_cmd_payload_args[7 : 0];
  assign _zz__zz_io_spi_mosi_1 = (3'b111 - _zz__zz_io_spi_mosi_2);
  assign _zz__zz_io_spi_mosi_2 = (fsm_counter_value >>> 1'd1);
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_cmd_payload_mode)
      SpiMasterCtrlCmdMode_DATA : io_cmd_payload_mode_string = "DATA";
      SpiMasterCtrlCmdMode_SS : io_cmd_payload_mode_string = "SS  ";
      default : io_cmd_payload_mode_string = "????";
    endcase
  end
  `endif

  always @(*) begin
    timer_reset = 1'b0;
    if(io_cmd_valid) begin
      if(when_SpiMasterCtrl_l201) begin
        if(timer_sclkToggleHit) begin
          timer_reset = 1'b1;
        end
      end else begin
        if(!_zz_when) begin
          if(when_SpiMasterCtrl_l231) begin
            if(timer_ss_holdHit) begin
              timer_reset = 1'b1;
            end
          end
        end
      end
    end
    if(when_SpiMasterCtrl_l252) begin
      timer_reset = 1'b1;
    end
  end

  assign timer_ss_setupHit = (timer_counter == io_config_ss_setup);
  assign timer_ss_holdHit = (timer_counter == io_config_ss_hold);
  assign timer_ss_disableHit = (timer_counter == io_config_ss_disable);
  assign timer_sclkToggleHit = (timer_counter == io_config_sclkToggle);
  always @(*) begin
    fsm_counter_willIncrement = 1'b0;
    if(io_cmd_valid) begin
      if(when_SpiMasterCtrl_l201) begin
        if(timer_sclkToggleHit) begin
          fsm_counter_willIncrement = 1'b1;
        end
      end else begin
        if(!_zz_when) begin
          if(when_SpiMasterCtrl_l231) begin
            if(timer_ss_holdHit) begin
              fsm_counter_willIncrement = 1'b1;
            end
          end
        end
      end
    end
  end

  assign fsm_counter_willClear = 1'b0;
  assign fsm_counter_willOverflowIfInc = (fsm_counter_value == 4'b1111);
  assign fsm_counter_willOverflow = (fsm_counter_willOverflowIfInc && fsm_counter_willIncrement);
  always @(*) begin
    fsm_counter_valueNext = (fsm_counter_value + _zz_fsm_counter_valueNext);
    if(fsm_counter_willClear) begin
      fsm_counter_valueNext = 4'b0000;
    end
  end

  always @(*) begin
    io_cmd_ready = 1'b0;
    if(io_cmd_valid) begin
      if(when_SpiMasterCtrl_l201) begin
        if(timer_sclkToggleHit) begin
          io_cmd_ready = fsm_counter_willOverflowIfInc;
        end
      end else begin
        if(_zz_when) begin
          if(timer_ss_setupHit) begin
            io_cmd_ready = 1'b1;
          end
        end else begin
          if(!when_SpiMasterCtrl_l231) begin
            if(timer_ss_disableHit) begin
              io_cmd_ready = 1'b1;
            end
          end
        end
      end
    end
  end

  assign when_SpiMasterCtrl_l201 = (io_cmd_payload_mode == SpiMasterCtrlCmdMode_DATA);
  assign when_SpiMasterCtrl_l218 = fsm_counter_value[0];
  assign when_SpiMasterCtrl_l231 = (! fsm_counter_value[0]);
  assign io_cmd_fire = (io_cmd_valid && io_cmd_ready);
  assign io_rsp_valid = _zz_io_rsp_valid;
  assign io_rsp_payload = fsm_buffer;
  assign when_SpiMasterCtrl_l252 = ((! io_cmd_valid) || io_cmd_ready);
  assign io_spi_ss = (fsm_ss ^ io_config_ss_activeHigh);
  assign io_spi_sclk = _zz_io_spi_sclk;
  assign io_spi_mosi = _zz_io_spi_mosi;
  always @(posedge clk) begin
    timer_counter <= (timer_counter + 12'h001);
    if(timer_reset) begin
      timer_counter <= 12'h0;
    end
    if(io_cmd_valid) begin
      if(when_SpiMasterCtrl_l201) begin
        if(timer_sclkToggleHit) begin
          if(when_SpiMasterCtrl_l218) begin
            fsm_buffer <= _zz_fsm_buffer[7:0];
          end
        end
      end
    end
    _zz_io_spi_sclk <= (((io_cmd_valid && (io_cmd_payload_mode == SpiMasterCtrlCmdMode_DATA)) && (fsm_counter_value[0] ^ io_config_kind_cpha)) ^ io_config_kind_cpol);
    _zz_io_spi_mosi <= _zz__zz_io_spi_mosi[_zz__zz_io_spi_mosi_1];
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      fsm_counter_value <= 4'b0000;
      fsm_ss <= 1'b1;
      _zz_io_rsp_valid <= 1'b0;
    end else begin
      fsm_counter_value <= fsm_counter_valueNext;
      if(io_cmd_valid) begin
        if(!when_SpiMasterCtrl_l201) begin
          if(_zz_when) begin
            fsm_ss[0] <= 1'b0;
          end else begin
            if(!when_SpiMasterCtrl_l231) begin
              fsm_ss[0] <= 1'b1;
            end
          end
        end
      end
      _zz_io_rsp_valid <= ((io_cmd_fire && (io_cmd_payload_mode == SpiMasterCtrlCmdMode_DATA)) && io_cmd_payload_args[8]);
      if(when_SpiMasterCtrl_l252) begin
        fsm_counter_value <= 4'b0000;
      end
    end
  end


endmodule

//StreamFifo_1 replaced by StreamFifo

module StreamFifo (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [7:0]    io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [7:0]    io_pop_payload,
  input  wire          io_flush,
  output wire [4:0]    io_occupancy,
  output wire [4:0]    io_availability,
  input  wire          clk,
  input  wire          reset
);

  reg        [7:0]    logic_ram_spinal_port1;
  reg                 _zz_1;
  wire                logic_ptr_doPush;
  wire                logic_ptr_doPop;
  wire                logic_ptr_full;
  wire                logic_ptr_empty;
  reg        [4:0]    logic_ptr_push;
  reg        [4:0]    logic_ptr_pop;
  wire       [4:0]    logic_ptr_occupancy;
  wire       [4:0]    logic_ptr_popOnIo;
  wire                when_Stream_l1455;
  reg                 logic_ptr_wentUp;
  wire                io_push_fire;
  wire                logic_push_onRam_write_valid;
  wire       [3:0]    logic_push_onRam_write_payload_address;
  wire       [7:0]    logic_push_onRam_write_payload_data;
  wire                logic_pop_addressGen_valid;
  reg                 logic_pop_addressGen_ready;
  wire       [3:0]    logic_pop_addressGen_payload;
  wire                logic_pop_addressGen_fire;
  wire                logic_pop_sync_readArbitation_valid;
  wire                logic_pop_sync_readArbitation_ready;
  wire       [3:0]    logic_pop_sync_readArbitation_payload;
  reg                 logic_pop_addressGen_rValid;
  reg        [3:0]    logic_pop_addressGen_rData;
  wire                when_Stream_l477;
  wire                logic_pop_sync_readPort_cmd_valid;
  wire       [3:0]    logic_pop_sync_readPort_cmd_payload;
  wire       [7:0]    logic_pop_sync_readPort_rsp;
  wire                logic_pop_addressGen_toFlowFire_valid;
  wire       [3:0]    logic_pop_addressGen_toFlowFire_payload;
  wire                logic_pop_sync_readArbitation_translated_valid;
  wire                logic_pop_sync_readArbitation_translated_ready;
  wire       [7:0]    logic_pop_sync_readArbitation_translated_payload;
  wire                logic_pop_sync_readArbitation_fire;
  reg        [4:0]    logic_pop_sync_popReg;
  reg [7:0] logic_ram [0:15];

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_push_onRam_write_payload_address] <= logic_push_onRam_write_payload_data;
    end
  end

  always @(posedge clk) begin
    if(logic_pop_sync_readPort_cmd_valid) begin
      logic_ram_spinal_port1 <= logic_ram[logic_pop_sync_readPort_cmd_payload];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_push_onRam_write_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign when_Stream_l1455 = (logic_ptr_doPush != logic_ptr_doPop);
  assign logic_ptr_full = (((logic_ptr_push ^ logic_ptr_popOnIo) ^ 5'h10) == 5'h0);
  assign logic_ptr_empty = (logic_ptr_push == logic_ptr_pop);
  assign logic_ptr_occupancy = (logic_ptr_push - logic_ptr_popOnIo);
  assign io_push_ready = (! logic_ptr_full);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign logic_ptr_doPush = io_push_fire;
  assign logic_push_onRam_write_valid = io_push_fire;
  assign logic_push_onRam_write_payload_address = logic_ptr_push[3:0];
  assign logic_push_onRam_write_payload_data = io_push_payload;
  assign logic_pop_addressGen_valid = (! logic_ptr_empty);
  assign logic_pop_addressGen_payload = logic_ptr_pop[3:0];
  assign logic_pop_addressGen_fire = (logic_pop_addressGen_valid && logic_pop_addressGen_ready);
  assign logic_ptr_doPop = logic_pop_addressGen_fire;
  always @(*) begin
    logic_pop_addressGen_ready = logic_pop_sync_readArbitation_ready;
    if(when_Stream_l477) begin
      logic_pop_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l477 = (! logic_pop_sync_readArbitation_valid);
  assign logic_pop_sync_readArbitation_valid = logic_pop_addressGen_rValid;
  assign logic_pop_sync_readArbitation_payload = logic_pop_addressGen_rData;
  assign logic_pop_sync_readPort_rsp = logic_ram_spinal_port1;
  assign logic_pop_addressGen_toFlowFire_valid = logic_pop_addressGen_fire;
  assign logic_pop_addressGen_toFlowFire_payload = logic_pop_addressGen_payload;
  assign logic_pop_sync_readPort_cmd_valid = logic_pop_addressGen_toFlowFire_valid;
  assign logic_pop_sync_readPort_cmd_payload = logic_pop_addressGen_toFlowFire_payload;
  assign logic_pop_sync_readArbitation_translated_valid = logic_pop_sync_readArbitation_valid;
  assign logic_pop_sync_readArbitation_ready = logic_pop_sync_readArbitation_translated_ready;
  assign logic_pop_sync_readArbitation_translated_payload = logic_pop_sync_readPort_rsp;
  assign io_pop_valid = logic_pop_sync_readArbitation_translated_valid;
  assign logic_pop_sync_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload = logic_pop_sync_readArbitation_translated_payload;
  assign logic_pop_sync_readArbitation_fire = (logic_pop_sync_readArbitation_valid && logic_pop_sync_readArbitation_ready);
  assign logic_ptr_popOnIo = logic_pop_sync_popReg;
  assign io_occupancy = logic_ptr_occupancy;
  assign io_availability = (5'h10 - logic_ptr_occupancy);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      logic_ptr_push <= 5'h0;
      logic_ptr_pop <= 5'h0;
      logic_ptr_wentUp <= 1'b0;
      logic_pop_addressGen_rValid <= 1'b0;
      logic_pop_sync_popReg <= 5'h0;
    end else begin
      if(when_Stream_l1455) begin
        logic_ptr_wentUp <= logic_ptr_doPush;
      end
      if(io_flush) begin
        logic_ptr_wentUp <= 1'b0;
      end
      if(logic_ptr_doPush) begin
        logic_ptr_push <= (logic_ptr_push + 5'h01);
      end
      if(logic_ptr_doPop) begin
        logic_ptr_pop <= (logic_ptr_pop + 5'h01);
      end
      if(io_flush) begin
        logic_ptr_push <= 5'h0;
        logic_ptr_pop <= 5'h0;
      end
      if(logic_pop_addressGen_ready) begin
        logic_pop_addressGen_rValid <= logic_pop_addressGen_valid;
      end
      if(io_flush) begin
        logic_pop_addressGen_rValid <= 1'b0;
      end
      if(logic_pop_sync_readArbitation_fire) begin
        logic_pop_sync_popReg <= logic_ptr_pop;
      end
      if(io_flush) begin
        logic_pop_sync_popReg <= 5'h0;
      end
    end
  end

  always @(posedge clk) begin
    if(logic_pop_addressGen_ready) begin
      logic_pop_addressGen_rData <= logic_pop_addressGen_payload;
    end
  end


endmodule

module UartCtrl (
  input  wire [2:0]    io_config_frame_dataLength,
  input  wire [0:0]    io_config_frame_stop,
  input  wire [1:0]    io_config_frame_parity,
  input  wire [19:0]   io_config_clockDivider,
  input  wire          io_write_valid,
  output reg           io_write_ready,
  input  wire [7:0]    io_write_payload,
  output wire          io_read_valid,
  input  wire          io_read_ready,
  output wire [7:0]    io_read_payload,
  output wire          io_uart_txd,
  input  wire          io_uart_rxd,
  output wire          io_readError,
  input  wire          io_writeBreak,
  output wire          io_readBreak,
  input  wire          clk,
  input  wire          reset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;

  wire                tx_io_write_ready;
  wire                tx_io_txd;
  wire                rx_io_read_valid;
  wire       [7:0]    rx_io_read_payload;
  wire                rx_io_rts;
  wire                rx_io_error;
  wire                rx_io_break;
  reg        [19:0]   clockDivider_counter;
  wire                clockDivider_tick;
  reg                 clockDivider_tickReg;
  reg                 io_write_throwWhen_valid;
  wire                io_write_throwWhen_ready;
  wire       [7:0]    io_write_throwWhen_payload;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif


  UartCtrlTx tx (
    .io_configFrame_dataLength (io_config_frame_dataLength[2:0]), //i
    .io_configFrame_stop       (io_config_frame_stop           ), //i
    .io_configFrame_parity     (io_config_frame_parity[1:0]    ), //i
    .io_samplingTick           (clockDivider_tickReg           ), //i
    .io_write_valid            (io_write_throwWhen_valid       ), //i
    .io_write_ready            (tx_io_write_ready              ), //o
    .io_write_payload          (io_write_throwWhen_payload[7:0]), //i
    .io_cts                    (1'b0                           ), //i
    .io_txd                    (tx_io_txd                      ), //o
    .io_break                  (io_writeBreak                  ), //i
    .clk                       (clk                            ), //i
    .reset                     (reset                          )  //i
  );
  UartCtrlRx rx (
    .io_configFrame_dataLength (io_config_frame_dataLength[2:0]), //i
    .io_configFrame_stop       (io_config_frame_stop           ), //i
    .io_configFrame_parity     (io_config_frame_parity[1:0]    ), //i
    .io_samplingTick           (clockDivider_tickReg           ), //i
    .io_read_valid             (rx_io_read_valid               ), //o
    .io_read_ready             (io_read_ready                  ), //i
    .io_read_payload           (rx_io_read_payload[7:0]        ), //o
    .io_rxd                    (io_uart_rxd                    ), //i
    .io_rts                    (rx_io_rts                      ), //o
    .io_error                  (rx_io_error                    ), //o
    .io_break                  (rx_io_break                    ), //o
    .clk                       (clk                            ), //i
    .reset                     (reset                          )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_config_frame_stop)
      UartStopType_ONE : io_config_frame_stop_string = "ONE";
      UartStopType_TWO : io_config_frame_stop_string = "TWO";
      default : io_config_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_config_frame_parity)
      UartParityType_NONE : io_config_frame_parity_string = "NONE";
      UartParityType_EVEN : io_config_frame_parity_string = "EVEN";
      UartParityType_ODD : io_config_frame_parity_string = "ODD ";
      default : io_config_frame_parity_string = "????";
    endcase
  end
  `endif

  assign clockDivider_tick = (clockDivider_counter == 20'h0);
  always @(*) begin
    io_write_throwWhen_valid = io_write_valid;
    if(rx_io_break) begin
      io_write_throwWhen_valid = 1'b0;
    end
  end

  always @(*) begin
    io_write_ready = io_write_throwWhen_ready;
    if(rx_io_break) begin
      io_write_ready = 1'b1;
    end
  end

  assign io_write_throwWhen_payload = io_write_payload;
  assign io_write_throwWhen_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  assign io_readError = rx_io_error;
  assign io_readBreak = rx_io_break;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      clockDivider_counter <= 20'h0;
      clockDivider_tickReg <= 1'b0;
    end else begin
      clockDivider_tickReg <= clockDivider_tick;
      clockDivider_counter <= (clockDivider_counter - 20'h00001);
      if(clockDivider_tick) begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end


endmodule

//BufferCC_3 replaced by BufferCC_2

module BufferCC_2 (
  input  wire [31:0]   io_dataIn,
  output wire [31:0]   io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" *) reg        [31:0]   buffers_0;
  (* async_reg = "true" *) reg        [31:0]   buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module BufferCC_1 (
  input  wire [3:0]    io_dataIn,
  output wire [3:0]    io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" *) reg        [3:0]    buffers_0;
  (* async_reg = "true" *) reg        [3:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module BufferCC (
  input  wire [5:0]    io_dataIn,
  output wire [5:0]    io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" *) reg        [5:0]    buffers_0;
  (* async_reg = "true" *) reg        [5:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module BufferCC_7 (
  input  wire [13:0]   io_dataIn,
  output wire [13:0]   io_dataOut,
  input  wire          io_pix_clk,
  input  wire          reset_synchronized
);

  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [13:0]   buffers_0;
  (* async_reg = "true" *) reg        [13:0]   buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_pix_clk or posedge reset_synchronized) begin
    if(reset_synchronized) begin
      buffers_0 <= 14'h0;
      buffers_1 <= 14'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC_6 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          io_pix_clk,
  input  wire          reset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_pix_clk or posedge reset) begin
    if(reset) begin
      buffers_0 <= 1'b1;
      buffers_1 <= 1'b1;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC_5 (
  input  wire [13:0]   io_dataIn,
  output wire [13:0]   io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [13:0]   buffers_0;
  (* async_reg = "true" *) reg        [13:0]   buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      buffers_0 <= 14'h0;
      buffers_1 <= 14'h0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module UartCtrlRx (
  input  wire [2:0]    io_configFrame_dataLength,
  input  wire [0:0]    io_configFrame_stop,
  input  wire [1:0]    io_configFrame_parity,
  input  wire          io_samplingTick,
  output wire          io_read_valid,
  input  wire          io_read_ready,
  output wire [7:0]    io_read_payload,
  input  wire          io_rxd,
  output wire          io_rts,
  output reg           io_error,
  output wire          io_break,
  input  wire          clk,
  input  wire          reset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlRxState_IDLE = 3'd0;
  localparam UartCtrlRxState_START = 3'd1;
  localparam UartCtrlRxState_DATA = 3'd2;
  localparam UartCtrlRxState_PARITY = 3'd3;
  localparam UartCtrlRxState_STOP = 3'd4;

  wire                io_rxd_buffercc_io_dataOut;
  wire                _zz_sampler_value;
  wire                _zz_sampler_value_1;
  wire                _zz_sampler_value_2;
  wire                _zz_sampler_value_3;
  wire                _zz_sampler_value_4;
  wire                _zz_sampler_value_5;
  wire                _zz_sampler_value_6;
  wire       [2:0]    _zz_when_UartCtrlRx_l139;
  wire       [0:0]    _zz_when_UartCtrlRx_l139_1;
  reg                 _zz_io_rts;
  wire                sampler_synchroniser;
  wire                sampler_samples_0;
  reg                 sampler_samples_1;
  reg                 sampler_samples_2;
  reg                 sampler_samples_3;
  reg                 sampler_samples_4;
  reg                 sampler_value;
  reg                 sampler_tick;
  reg        [2:0]    bitTimer_counter;
  reg                 bitTimer_tick;
  wire                when_UartCtrlRx_l43;
  reg        [2:0]    bitCounter_value;
  reg        [6:0]    break_counter;
  wire                break_valid;
  wire                when_UartCtrlRx_l69;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg        [7:0]    stateMachine_shifter;
  reg                 stateMachine_validReg;
  wire                when_UartCtrlRx_l93;
  wire                when_UartCtrlRx_l103;
  wire                when_UartCtrlRx_l111;
  wire                when_UartCtrlRx_l113;
  wire                when_UartCtrlRx_l125;
  wire                when_UartCtrlRx_l136;
  wire                when_UartCtrlRx_l139;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_when_UartCtrlRx_l139_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlRx_l139 = {2'd0, _zz_when_UartCtrlRx_l139_1};
  assign _zz_sampler_value = ((((1'b0 || ((_zz_sampler_value_1 && sampler_samples_1) && sampler_samples_2)) || (((_zz_sampler_value_2 && sampler_samples_0) && sampler_samples_1) && sampler_samples_3)) || (((1'b1 && sampler_samples_0) && sampler_samples_2) && sampler_samples_3)) || (((1'b1 && sampler_samples_1) && sampler_samples_2) && sampler_samples_3));
  assign _zz_sampler_value_3 = (((1'b1 && sampler_samples_0) && sampler_samples_1) && sampler_samples_4);
  assign _zz_sampler_value_4 = ((1'b1 && sampler_samples_0) && sampler_samples_2);
  assign _zz_sampler_value_5 = (1'b1 && sampler_samples_1);
  assign _zz_sampler_value_6 = 1'b1;
  assign _zz_sampler_value_1 = (1'b1 && sampler_samples_0);
  assign _zz_sampler_value_2 = 1'b1;
  (* keep_hierarchy = "TRUE" *) BufferCC_4 io_rxd_buffercc (
    .io_dataIn  (io_rxd                    ), //i
    .io_dataOut (io_rxd_buffercc_io_dataOut), //o
    .clk        (clk                       ), //i
    .reset      (reset                     )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlRxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlRxState_START : stateMachine_state_string = "START ";
      UartCtrlRxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlRxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlRxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    io_error = 1'b0;
    case(stateMachine_state)
      UartCtrlRxState_IDLE : begin
      end
      UartCtrlRxState_START : begin
      end
      UartCtrlRxState_DATA : begin
      end
      UartCtrlRxState_PARITY : begin
        if(bitTimer_tick) begin
          if(!when_UartCtrlRx_l125) begin
            io_error = 1'b1;
          end
        end
      end
      default : begin
        if(bitTimer_tick) begin
          if(when_UartCtrlRx_l136) begin
            io_error = 1'b1;
          end
        end
      end
    endcase
  end

  assign io_rts = _zz_io_rts;
  assign sampler_synchroniser = io_rxd_buffercc_io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @(*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick) begin
      if(when_UartCtrlRx_l43) begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign when_UartCtrlRx_l43 = (bitTimer_counter == 3'b000);
  assign break_valid = (break_counter == 7'h68);
  assign when_UartCtrlRx_l69 = (io_samplingTick && (! break_valid));
  assign io_break = break_valid;
  assign io_read_valid = stateMachine_validReg;
  assign when_UartCtrlRx_l93 = ((sampler_tick && (! sampler_value)) && (! break_valid));
  assign when_UartCtrlRx_l103 = (sampler_value == 1'b1);
  assign when_UartCtrlRx_l111 = (bitCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlRx_l113 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlRx_l125 = (stateMachine_parity == sampler_value);
  assign when_UartCtrlRx_l136 = (! sampler_value);
  assign when_UartCtrlRx_l139 = (bitCounter_value == _zz_when_UartCtrlRx_l139);
  assign io_read_payload = stateMachine_shifter;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_io_rts <= 1'b0;
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_samples_3 <= 1'b1;
      sampler_samples_4 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      break_counter <= 7'h0;
      stateMachine_state <= UartCtrlRxState_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      _zz_io_rts <= (! io_read_ready);
      if(io_samplingTick) begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick) begin
        sampler_samples_2 <= sampler_samples_1;
      end
      if(io_samplingTick) begin
        sampler_samples_3 <= sampler_samples_2;
      end
      if(io_samplingTick) begin
        sampler_samples_4 <= sampler_samples_3;
      end
      sampler_value <= ((((((_zz_sampler_value || _zz_sampler_value_3) || (_zz_sampler_value_4 && sampler_samples_4)) || ((_zz_sampler_value_5 && sampler_samples_2) && sampler_samples_4)) || (((_zz_sampler_value_6 && sampler_samples_0) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_1) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_2) && sampler_samples_3) && sampler_samples_4));
      sampler_tick <= io_samplingTick;
      if(sampler_value) begin
        break_counter <= 7'h0;
      end else begin
        if(when_UartCtrlRx_l69) begin
          break_counter <= (break_counter + 7'h01);
        end
      end
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        UartCtrlRxState_IDLE : begin
          if(when_UartCtrlRx_l93) begin
            stateMachine_state <= UartCtrlRxState_START;
          end
        end
        UartCtrlRxState_START : begin
          if(bitTimer_tick) begin
            stateMachine_state <= UartCtrlRxState_DATA;
            if(when_UartCtrlRx_l103) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        UartCtrlRxState_DATA : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l111) begin
              if(when_UartCtrlRx_l113) begin
                stateMachine_state <= UartCtrlRxState_STOP;
                stateMachine_validReg <= 1'b1;
              end else begin
                stateMachine_state <= UartCtrlRxState_PARITY;
              end
            end
          end
        end
        UartCtrlRxState_PARITY : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l125) begin
              stateMachine_state <= UartCtrlRxState_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l136) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end else begin
              if(when_UartCtrlRx_l139) begin
                stateMachine_state <= UartCtrlRxState_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(sampler_tick) begin
      bitTimer_counter <= (bitTimer_counter - 3'b001);
    end
    if(bitTimer_tick) begin
      bitCounter_value <= (bitCounter_value + 3'b001);
    end
    if(bitTimer_tick) begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      UartCtrlRxState_IDLE : begin
        if(when_UartCtrlRx_l93) begin
          bitTimer_counter <= 3'b010;
        end
      end
      UartCtrlRxState_START : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
        end
      end
      UartCtrlRxState_DATA : begin
        if(bitTimer_tick) begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(when_UartCtrlRx_l111) begin
            bitCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlRxState_PARITY : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module UartCtrlTx (
  input  wire [2:0]    io_configFrame_dataLength,
  input  wire [0:0]    io_configFrame_stop,
  input  wire [1:0]    io_configFrame_parity,
  input  wire          io_samplingTick,
  input  wire          io_write_valid,
  output reg           io_write_ready,
  input  wire [7:0]    io_write_payload,
  input  wire          io_cts,
  output wire          io_txd,
  input  wire          io_break,
  input  wire          clk,
  input  wire          reset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlTxState_IDLE = 3'd0;
  localparam UartCtrlTxState_START = 3'd1;
  localparam UartCtrlTxState_DATA = 3'd2;
  localparam UartCtrlTxState_PARITY = 3'd3;
  localparam UartCtrlTxState_STOP = 3'd4;

  wire       [2:0]    _zz_clockDivider_counter_valueNext;
  wire       [0:0]    _zz_clockDivider_counter_valueNext_1;
  wire       [2:0]    _zz_when_UartCtrlTx_l93;
  wire       [0:0]    _zz_when_UartCtrlTx_l93_1;
  reg                 clockDivider_counter_willIncrement;
  wire                clockDivider_counter_willClear;
  reg        [2:0]    clockDivider_counter_valueNext;
  reg        [2:0]    clockDivider_counter_value;
  wire                clockDivider_counter_willOverflowIfInc;
  wire                clockDivider_counter_willOverflow;
  reg        [2:0]    tickCounter_value;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg                 stateMachine_txd;
  wire                when_UartCtrlTx_l58;
  wire                when_UartCtrlTx_l73;
  wire                when_UartCtrlTx_l76;
  wire                when_UartCtrlTx_l93;
  wire       [2:0]    _zz_stateMachine_state;
  reg                 _zz_io_txd;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  reg [47:0] _zz_stateMachine_state_string;
  `endif


  assign _zz_clockDivider_counter_valueNext_1 = clockDivider_counter_willIncrement;
  assign _zz_clockDivider_counter_valueNext = {2'd0, _zz_clockDivider_counter_valueNext_1};
  assign _zz_when_UartCtrlTx_l93_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlTx_l93 = {2'd0, _zz_when_UartCtrlTx_l93_1};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlTxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlTxState_START : stateMachine_state_string = "START ";
      UartCtrlTxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlTxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlTxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_stateMachine_state)
      UartCtrlTxState_IDLE : _zz_stateMachine_state_string = "IDLE  ";
      UartCtrlTxState_START : _zz_stateMachine_state_string = "START ";
      UartCtrlTxState_DATA : _zz_stateMachine_state_string = "DATA  ";
      UartCtrlTxState_PARITY : _zz_stateMachine_state_string = "PARITY";
      UartCtrlTxState_STOP : _zz_stateMachine_state_string = "STOP  ";
      default : _zz_stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick) begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == 3'b111);
  assign clockDivider_counter_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @(*) begin
    clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_clockDivider_counter_valueNext);
    if(clockDivider_counter_willClear) begin
      clockDivider_counter_valueNext = 3'b000;
    end
  end

  always @(*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        stateMachine_txd = 1'b0;
      end
      UartCtrlTxState_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      UartCtrlTxState_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_write_ready = io_break;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            io_write_ready = 1'b1;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign when_UartCtrlTx_l58 = ((io_write_valid && (! io_cts)) && clockDivider_counter_willOverflow);
  assign when_UartCtrlTx_l73 = (tickCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlTx_l76 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlTx_l93 = (tickCounter_value == _zz_when_UartCtrlTx_l93);
  assign _zz_stateMachine_state = (io_write_valid ? UartCtrlTxState_START : UartCtrlTxState_IDLE);
  assign io_txd = _zz_io_txd;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      clockDivider_counter_value <= 3'b000;
      stateMachine_state <= UartCtrlTxState_IDLE;
      _zz_io_txd <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        UartCtrlTxState_IDLE : begin
          if(when_UartCtrlTx_l58) begin
            stateMachine_state <= UartCtrlTxState_START;
          end
        end
        UartCtrlTxState_START : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_DATA;
          end
        end
        UartCtrlTxState_DATA : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l73) begin
              if(when_UartCtrlTx_l76) begin
                stateMachine_state <= UartCtrlTxState_STOP;
              end else begin
                stateMachine_state <= UartCtrlTxState_PARITY;
              end
            end
          end
        end
        UartCtrlTxState_PARITY : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_STOP;
          end
        end
        default : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l93) begin
              stateMachine_state <= _zz_stateMachine_state;
            end
          end
        end
      endcase
      _zz_io_txd <= (stateMachine_txd && (! io_break));
    end
  end

  always @(posedge clk) begin
    if(clockDivider_counter_willOverflow) begin
      tickCounter_value <= (tickCounter_value + 3'b001);
    end
    if(clockDivider_counter_willOverflow) begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        if(clockDivider_counter_willOverflow) begin
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
          tickCounter_value <= 3'b000;
        end
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            tickCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
        if(clockDivider_counter_willOverflow) begin
          tickCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BufferCC_4 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk,
  input  wire          reset
);

  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
