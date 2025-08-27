----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: tb_top_uart_tx_rx_2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_top_uart_tx_rx_2 is
end tb_top_uart_tx_rx_2;

architecture Behavioral of tb_top_uart_tx_rx_2 is

component top_uart_tx_rx_2 is
  Port ( 
        clk         : in std_logic;
        rx_data_in  : in std_logic;
        tx_data_out : out std_logic
  );
end component;

signal clk         : std_logic;
signal rx_data_in  : std_logic;
signal tx_data_out : std_logic;

constant clk_period : time := 10ns;
constant baudrate   : integer := 868;
constant bit_time   : time := clk_period * baudrate;


begin

uut: top_uart_tx_rx_2
port map(
        clk         => clk,         
        rx_data_in  => rx_data_in, 
        tx_data_out => tx_data_out 
);

        clk_process : process
        begin
                clk <= '0';
                wait for clk_period / 2;
                clk <= '1';
                wait for clk_period / 2;
        end process;

        stim_proc:  process
                    begin
                        wait for 1000ns;
                        
                        rx_data_in <= '0';
                        wait for bit_time;
                        
                        --"10101010"
                        rx_data_in <= '0';
                        wait for bit_time;
                        rx_data_in <= '1';
                        wait for bit_time;
                        rx_data_in <= '0';
                        wait for bit_time;
                        rx_data_in <= '1';
                        wait for bit_time;
                        rx_data_in <= '0';
                        wait for bit_time;
                        rx_data_in <= '1';
                        wait for bit_time;
                        rx_data_in <= '0';
                        wait for bit_time;
                        rx_data_in <= '1';
                        wait for bit_time; 
                        
                        --stop bit
                        rx_data_in <= '1';
                        wait for bit_time;
                        rx_data_in <= '1';
                        wait for bit_time; 
                        
                        wait for 20*bit_time;
                        assert false report "Simulation Finished" severity failure;
                        wait;                                            
                    end process;
        

end Behavioral;
