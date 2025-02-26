set_max_fanout 5 [current_design]
# Create a 25 MHz clock (period 40 ns)
create_clock -period 40 -waveform {0 20} [get_ports clk_system_i]

# Create a 48 MHz clock (period 20.83 ns)
create_clock -period 20.8333 -waveform {0 10.41665} [get_ports clk_usb_i]

# Set clk_25MHz and clk_48MHz as asynchronous clock domains
set_clock_groups -asynchronous -group [get_clocks clk_system_i] -group [get_clocks clk_usb_i]

# False path between clk_system_i and clk_usb_i
set_false_path -from [get_clocks clk_system_i] -to [get_clocks clk_usb_i]
set_false_path -from [get_clocks clk_usb_i] -to [get_clocks clk_system_i]
#set_clock_uncertainty -setup 0.5 [get_clocks clk_system_i]
#set_clock_uncertainty -setup 0.3 [get_clocks clk_usb_i]
#set_input_delay -max 5 [get_ports <input_signal>] -clock clk_system_i
#set_output_delay -max 3 [get_ports <output_signal>] -clock clk_system_i
#set_clock_latency -max 2 [get_clocks clk_system_i]
#set_clock_latency -max 1 [get_clocks clk_usb_i]
