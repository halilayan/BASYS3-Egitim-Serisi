## Clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Switches 
set_property PACKAGE_PIN V17 [get_ports data_in[0]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[0]]

set_property PACKAGE_PIN V16 [get_ports data_in[1]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[1]]

set_property PACKAGE_PIN W16 [get_ports data_in[2]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[2]]

set_property PACKAGE_PIN W17 [get_ports data_in[3]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[3]]

set_property PACKAGE_PIN W15 [get_ports data_in[4]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[4]]

set_property PACKAGE_PIN V15 [get_ports data_in[5]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[5]]

set_property PACKAGE_PIN W14 [get_ports data_in[6]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[6]]

set_property PACKAGE_PIN W13 [get_ports data_in[7]]
set_property IOSTANDARD LVCMOS33 [get_ports data_in[7]]

## UART TX 
set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]

## buton
set_property PACKAGE_PIN U18 [get_ports btn_start]
set_property IOSTANDARD LVCMOS33 [get_ports btn_start]

## LED
set_property PACKAGE_PIN L1 [get_ports tx_done]					
set_property IOSTANDARD LVCMOS33 [get_ports tx_done]


set_property PACKAGE_PIN U16 [get_ports tx_busy]					
set_property IOSTANDARD LVCMOS33 [get_ports tx_busy]
