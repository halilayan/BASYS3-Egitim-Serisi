# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {leds[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property PACKAGE_PIN E19 [get_ports {leds[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN U19 [get_ports {leds[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN V19 [get_ports {leds[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property PACKAGE_PIN W18 [get_ports {leds[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property PACKAGE_PIN U15 [get_ports {leds[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property PACKAGE_PIN U14 [get_ports {leds[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property PACKAGE_PIN V14 [get_ports {leds[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

#USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rx_data_in]						
set_property IOSTANDARD LVCMOS33 [get_ports rx_data_in]