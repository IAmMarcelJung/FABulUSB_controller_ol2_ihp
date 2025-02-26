set usb_clock_period 40
set system_clock_period 20.8333

# Create a 25 MHz clock (period 40 ns)
create_clock -period $usb_clock_period -waveform {0 20} [get_ports clk_system_i]

# Create a 48 MHz clock (period 20.83 ns)
create_clock -period $system_clock_period -waveform {0 10.41665} [get_ports clk_usb_i]

# Set clk_25MHz and clk_48MHz as asynchronous clock domains
set_clock_groups -asynchronous -group [get_clocks clk_system_i] -group [get_clocks clk_usb_i]

# create_clock [get_ports $::env(CLOCK_PORT)]  -name $::env(CLOCK_PORT)  -period $::env(CLOCK_PERIOD)
set usb_input_delay_value [expr $usb_clock_period * $::env(IO_PCT)]
set usb_output_delay_value [expr $usb_clock_period * $::env(IO_PCT)]
puts "\[INFO\]: Setting output delay for usb clock to: $usb_output_delay_value"
puts "\[INFO\]: Setting input delay for usb clock to: $usb_input_delay_value"

set system_input_delay_value [expr $system_clock_period * $::env(IO_PCT)]
set system_output_delay_value [expr $system_clock_period * $::env(IO_PCT)]
puts "\[INFO\]: Setting output delay for system clock to: $system_output_delay_value"
puts "\[INFO\]: Setting input delay for system clock to: $system_input_delay_value"


set usb_clk_indx [lsearch [all_inputs] [get_port clk_usb_i]]
#set rst_indx [lsearch [all_inputs] [get_port resetn]]
set usb_all_inputs_wo_clk [lreplace [all_inputs] $usb_clk_indx $usb_clk_indx]
#set all_inputs_wo_clk_rst [lreplace $all_inputs_wo_clk $rst_indx $rst_indx]
set usb_all_inputs_wo_clk_rst $usb_all_inputs_wo_clk


# correct resetn
set_input_delay $usb_input_delay_value  -clock [get_clocks clk_usb_i] $usb_all_inputs_wo_clk_rst
#set_input_delay 0.0 -clock [get_clocks $::env(CLOCK_PORT)] {resetn}
set_output_delay $usb_output_delay_value  -clock [get_clocks clk_usb_i] [all_outputs]

set system_clk_indx [lsearch [all_inputs] [get_port clk_system_i]]
#set rst_indx [lsearch [all_inputs] [get_port resetn]]
set system_all_inputs_wo_clk [lreplace [all_inputs] $system_clk_indx $system_clk_indx]
#set all_inputs_wo_clk_rst [lreplace $all_inputs_wo_clk $rst_indx $rst_indx]
set system_all_inputs_wo_clk_rst $system_all_inputs_wo_clk


# correct resetn
set_input_delay $system_input_delay_value  -clock [get_clocks clk_system_i] $system_all_inputs_wo_clk_rst
#set_input_delay 0.0 -clock [get_clocks $::env(CLOCK_PORT)] {resetn}
set_output_delay $system_output_delay_value  -clock [get_clocks clk_system_i] [all_outputs]

# TODO set this as parameter
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]
