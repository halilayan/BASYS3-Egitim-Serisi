set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
	
set_property PACKAGE_PIN E19 [get_ports led]					
set_property IOSTANDARD LVCMOS33 [get_ports led]

set_property PACKAGE_PIN L1 [get_ports led2]					
set_property IOSTANDARD LVCMOS33 [get_ports led2]