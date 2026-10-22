# board clocks
create_clock -name i_sys_clk -period 25.000 [get_ports i_sys_clk]

# POR counter is a slow async-style path
set_false_path -from [get_registers {por_cnt[*]}]

# async FIFO / gray-pointer synchronizers
#   fb_reader pixel fifo (rgray/wgray, vsync_px) and avl_cdc afifos
#   (wptr_g/rptr_g + rq2_wptr/wq2_rptr sync stages)
set_false_path -from [get_registers {*rgray*}]
set_false_path -from [get_registers {*wgray*}]
set_false_path -from [get_registers {*vsync_px*}]
set_false_path -from [get_registers {*pll_meta*}]
# only the first-stage sync flops need relaxing; the gray regs themselves
# are clocked in their own domain and must stay timed
set_false_path -to   [get_registers {*rq2_wptr*}]
set_false_path -to   [get_registers {*wq2_rptr*}]
set_false_path -to   [get_registers {*fab_rst_meta*}]

# async FIFO storage arrays (avl_afifo mem~*): written in the wclk domain,
# read combinationally by the rclk-domain rbin pointer. Quartus models the
# array read output as launched by wclk and reports bogus wclk->rclk paths
# (~1 ns relationship). The gray-pointer protocol guarantees the data was
# written many cycles before being read; do not time these paths.
set_false_path -from [get_registers {*avl_afifo*|mem~*}]

# generated SpinalHDL BufferCC two-flop synchronizers (VideoDma gray
# pointers pushCC_pushPtrGray/popCC_popPtrGray, frameTgl/errTgl/enPix
# toggles, debug/reset syncs): cut the path INTO the first sync stage.
set_false_path -to [get_registers {*buffers_0*}]

# video status nibble: fab_clk -> afi_clk mailbox 2-flop sync, quasi-static.
set_false_path -to [get_registers {*vid_st_sync0*}]

# mailbox debug bundle: soc_dbg/fab_hb/fab reset+lock flags -> afi_clk
# 2-flop sync (top.v). Cut paths into the first stage only; the s1
# stage is afi_clk->afi_clk and stays timed.
set_false_path -to [get_registers {*soc_dbg_s0*}]
set_false_path -to [get_registers {*fab_hb_s0*}]
set_false_path -to [get_registers {*misc_s0*}]

derive_pll_clocks
derive_clock_uncertainty
