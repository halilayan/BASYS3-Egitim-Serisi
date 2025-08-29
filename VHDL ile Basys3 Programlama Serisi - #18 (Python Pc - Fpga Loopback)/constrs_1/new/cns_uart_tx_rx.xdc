# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


#USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rx_data_in]						
set_property IOSTANDARD LVCMOS33 [get_ports rx_data_in]
set_property PACKAGE_PIN A18 [get_ports tx_data_out]						
set_property IOSTANDARD LVCMOS33 [get_ports tx_data_out]