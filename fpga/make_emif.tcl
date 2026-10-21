package require qsys
create_system emifsys
set_project_property DEVICE_FAMILY {Arria V}
set_project_property DEVICE 5AGXMA3D4F31I3
set_validation_property AUTOMATIC_VALIDATION false

# ===========================================================================
# EMIF -- identical DDR3L configuration to nios2_soc/ddr3_test (proven)
# ===========================================================================
add_instance emif_0 altera_mem_if_ddr3_emif

set_instance_parameter_value emif_0 SPEED_GRADE 3
set_instance_parameter_value emif_0 REF_CLK_FREQ 40.0
# 300 MHz: afi_clk 150 MHz gives the fabric/bridge logic extra slack vs the
# 200 MHz/400 MHz configuration (timing closure, not bandwidth)
set_instance_parameter_value emif_0 MEM_CLK_FREQ 300.0
set_instance_parameter_value emif_0 RATE Half
set_instance_parameter_value emif_0 MEM_VOLTAGE {1.35V DDR3L}
set_instance_parameter_value emif_0 MEM_FORMAT DISCRETE
set_instance_parameter_value emif_0 MEM_NUMBER_OF_DIMMS 1
set_instance_parameter_value emif_0 MEM_IF_NUMBER_OF_RANKS 1
set_instance_parameter_value emif_0 MEM_NUMBER_OF_RANKS_PER_DIMM 1
set_instance_parameter_value emif_0 MEM_IF_CS_WIDTH 1
set_instance_parameter_value emif_0 MEM_IF_CS_PER_RANK 1
set_instance_parameter_value emif_0 MEM_CS_WIDTH 1
set_instance_parameter_value emif_0 CTL_CS_WIDTH 1
set_instance_parameter_value emif_0 MEM_IF_CK_WIDTH 1
set_instance_parameter_value emif_0 MEM_CK_WIDTH 1
set_instance_parameter_value emif_0 MEM_IF_CLK_EN_WIDTH 1
set_instance_parameter_value emif_0 MEM_IF_ODT_WIDTH 1
set_instance_parameter_value emif_0 MEM_DQ_WIDTH 48
set_instance_parameter_value emif_0 CTL_ECC_ENABLED 0
set_instance_parameter_value emif_0 BYTE_ENABLE 1
set_instance_parameter_value emif_0 MEM_DQ_PER_DQS 8
set_instance_parameter_value emif_0 MEM_IF_DQSN_EN 1
set_instance_parameter_value emif_0 MEM_IF_DM_PINS_EN 1
set_instance_parameter_value emif_0 MEM_ROW_ADDR_WIDTH 14
set_instance_parameter_value emif_0 MEM_COL_ADDR_WIDTH 10
set_instance_parameter_value emif_0 MEM_BANKADDR_WIDTH 3
set_instance_parameter_value emif_0 ADDR_ORDER 0
set_instance_parameter_value emif_0 MEM_TCL 6
set_instance_parameter_value emif_0 MEM_WTCL 5
set_instance_parameter_value emif_0 MEM_ATCL Disabled
set_instance_parameter_value emif_0 MEM_BL OTF
set_instance_parameter_value emif_0 MEM_BT Sequential
set_instance_parameter_value emif_0 MEM_TINIT_US 500
set_instance_parameter_value emif_0 MEM_TMRD_CK 4
set_instance_parameter_value emif_0 MEM_TRAS_NS 37.5
set_instance_parameter_value emif_0 MEM_TRCD_NS 11.25
set_instance_parameter_value emif_0 MEM_TRP_NS 11.25
set_instance_parameter_value emif_0 MEM_TREFI_US 7.8
set_instance_parameter_value emif_0 MEM_TRFC_NS 160.0
set_instance_parameter_value emif_0 MEM_TWR_NS 15.0
set_instance_parameter_value emif_0 MEM_TWTR 4
set_instance_parameter_value emif_0 MEM_TFAW_NS 37.5
set_instance_parameter_value emif_0 MEM_TRRD_NS 7.5
set_instance_parameter_value emif_0 MEM_TRTP_NS 7.5
set_instance_parameter_value emif_0 MEM_DRV_STR RZQ/6
set_instance_parameter_value emif_0 MEM_RTT_NOM RZQ/6
set_instance_parameter_value emif_0 MEM_RTT_WR {Dynamic ODT off}
set_instance_parameter_value emif_0 OCT_SHARING_MODE None
set_instance_parameter_value emif_0 MEM_USER_LEVELING_MODE Leveling
set_instance_parameter_value emif_0 MEM_GUARANTEED_WRITE_INIT 1

# board skews measured via EMIF toolkit (same values as ddr3_test)
set_instance_parameter_value emif_0 TIMING_BOARD_SKEW_CKDQS_DIMM_MIN -0.05
set_instance_parameter_value emif_0 TIMING_BOARD_SKEW_CKDQS_DIMM_MAX 0.05
set_instance_parameter_value emif_0 TIMING_BOARD_SKEW_BETWEEN_DQS 0.08
set_instance_parameter_value emif_0 TIMING_BOARD_SKEW_WITHIN_DQS 0.05
set_instance_parameter_value emif_0 TIMING_BOARD_DQ_TO_DQS_SKEW 0.0
set_instance_parameter_value emif_0 TIMING_BOARD_AC_SKEW 0.02
set_instance_parameter_value emif_0 TIMING_BOARD_AC_TO_CK_SKEW 0.0
set_instance_parameter_value emif_0 TIMING_BOARD_MAX_CK_DELAY 0.6
set_instance_parameter_value emif_0 TIMING_BOARD_MAX_DQS_DELAY 0.6
set_instance_parameter_value emif_0 TIMING_BOARD_SKEW_BETWEEN_DIMMS 0.0
set_instance_parameter_value emif_0 TIMING_BOARD_DELTA_DQS_ARRIVAL_TIME 0.0
set_instance_parameter_value emif_0 TIMING_BOARD_DELTA_READ_DQS_ARRIVAL_TIME 0.0

# soft reset bridge: input exported, output feeds emif_0.soft_reset
add_instance rst_soft altera_reset_bridge
set_instance_parameter_value rst_soft ACTIVE_LOW_RESET 1

# ===========================================================================
# JTAG debug: two avalon masters + status mailbox (same idea as nios2_soc)
#   jtagm  = "tester"  -> exported master; top.v muxes it onto avlbr.s0
#   jtagm2 = "reader"  -> dbg_ram.s1 only (stays alive even if DDR bus wedges)
# ===========================================================================
add_instance jtagm altera_jtag_avalon_master
add_instance jtagm2 altera_jtag_avalon_master
add_instance dbg_ram altera_avalon_onchip_memory2
set_instance_parameter_value dbg_ram dataWidth 32
set_instance_parameter_value dbg_ram memorySize 1024
set_instance_parameter_value dbg_ram dualPort true
set_instance_parameter_value dbg_ram singleClockOperation false
set_instance_parameter_value dbg_ram writable true
set_instance_parameter_value dbg_ram initMemContent false

# ===========================================================================
# clocks / resets -- everything here lives in the afi_clk domain; the
# 125 MHz fabric and the whole CPU complex are plain RTL in top.v/soc.v
# ===========================================================================
add_connection emif_0.afi_clk jtagm.clk clock
add_connection emif_0.afi_clk jtagm2.clk clock
add_connection emif_0.afi_clk dbg_ram.clk1 clock
add_connection emif_0.afi_clk dbg_ram.clk2 clock
add_connection emif_0.afi_clk rst_soft.clk clock

add_connection emif_0.afi_reset jtagm.clk_reset reset
add_connection emif_0.afi_reset jtagm2.clk_reset reset
add_connection emif_0.afi_reset dbg_ram.reset1 reset
add_connection emif_0.afi_reset dbg_ram.reset2 reset
add_connection rst_soft.out_reset emif_0.soft_reset reset

# ===========================================================================
# masters / slaves
# ===========================================================================
add_connection jtagm2.master dbg_ram.s1 avalon
set_connection_parameter_value jtagm2.master/dbg_ram.s1 baseAddress 0x0000

validate_system
set_validation_property AUTOMATIC_VALIDATION true

# ===========================================================================
# exports
# ===========================================================================
set_interface_property pll_ref_clk EXPORT_OF emif_0.pll_ref_clk
set_interface_property global_reset EXPORT_OF emif_0.global_reset
set_interface_property soft_reset EXPORT_OF rst_soft.in_reset
set_interface_property avl EXPORT_OF emif_0.avl
set_interface_property memory EXPORT_OF emif_0.memory
set_interface_property status EXPORT_OF emif_0.status
set_interface_property oct EXPORT_OF emif_0.oct
set_interface_property afi_clk EXPORT_OF emif_0.afi_clk
set_interface_property afi_reset EXPORT_OF emif_0.afi_reset
set_interface_property jtag_avl EXPORT_OF jtagm.master
set_interface_property dbg EXPORT_OF dbg_ram.s2

set script_dir [file dirname [info script]]
save_system [file join $script_dir ip emifsys.qsys]
puts "== SAVED =="
