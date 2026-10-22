package require qsys
create_system vidpll
set_project_property DEVICE_FAMILY {Arria V}
set_project_property DEVICE 5AGXMA3D4F31I3
set_validation_property AUTOMATIC_VALIDATION false

add_instance pll altera_pll
set_instance_parameter_value pll gui_reference_clock_frequency 40.0
set_instance_parameter_value pll gui_pll_mode {Integer-N PLL}
set_instance_parameter_value pll gui_operation_mode direct
set_instance_parameter_value pll gui_number_of_clocks 3
set_instance_parameter_value pll gui_multiply_factor 75
set_instance_parameter_value pll gui_divide_factor_n 4
set_instance_parameter_value pll gui_output_clock_frequency0 25.0
set_instance_parameter_value pll gui_divide_factor_c0 30
set_instance_parameter_value pll gui_output_clock_frequency1 125.0
set_instance_parameter_value pll gui_divide_factor_c1 6
set_instance_parameter_value pll gui_output_clock_frequency2 125.0
set_instance_parameter_value pll gui_divide_factor_c2 6
set_instance_parameter_value pll gui_use_locked 1

validate_system
set_validation_property AUTOMATIC_VALIDATION true

set_interface_property refclk   EXPORT_OF pll.refclk
set_interface_property reset    EXPORT_OF pll.reset
set_interface_property px_clk   EXPORT_OF pll.outclk0
set_interface_property x5_clk   EXPORT_OF pll.outclk1
set_interface_property fab_clk  EXPORT_OF pll.outclk2
set_interface_property locked   EXPORT_OF pll.locked

set script_dir [file dirname [info script]]
save_system [file join $script_dir ip vidpll.qsys]
puts "== SAVED =="
