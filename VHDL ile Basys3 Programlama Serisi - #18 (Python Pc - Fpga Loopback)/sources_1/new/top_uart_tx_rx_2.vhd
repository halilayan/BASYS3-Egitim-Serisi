----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: top_uart_tx_rx_2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity top_uart_tx_rx_2 is
  Port ( 
        clk         : in std_logic;
        rx_data_in  : in std_logic;
        tx_data_out : out std_logic
  );
end top_uart_tx_rx_2;

architecture Behavioral of top_uart_tx_rx_2 is

    signal rx_data_out_s : std_logic_vector(7 downto 0);
    signal rx_done_s     : std_logic;

    signal tx_start_s    : std_logic := '0';
    signal tx_data_in_s  : std_logic_vector(7 downto 0);
    signal tx_done_s     : std_logic;
    signal tx_busy_s     : std_logic;

component uart_tx is
  Port ( 
        clk         : in std_logic;
        tx_start    : in std_logic;
        data_in     : in std_logic_vector (7 downto 0);
        tx_data_out : out std_logic;
        tx_done     : out std_logic;
        tx_busy     : out std_logic  
  );
end component;

component uart_rx is
  Port ( 
        clk         : in std_logic;
        rx_data_in  : in std_logic;
        rx_data_out : out std_logic_vector (7 downto 0);
        rx_done     : out std_logic  
  );
end component;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rx_done_s = '1' and tx_busy_s = '0' then
                tx_data_in_s <= rx_data_out_s;
                tx_start_s   <= '1';
            else
                tx_start_s <= '0';
            end if;
        end if;
    end process;

    uart_tx_ins : uart_tx
    port map(
             clk          => clk, 
             tx_start     => tx_start_s, 
             data_in      => tx_data_in_s, 
             tx_data_out  => tx_data_out, 
             tx_done      => tx_done_s, 
             tx_busy      => tx_busy_s                 
    );

    uart_rx_ins : uart_rx
    port map(
             clk          => clk,
             rx_data_in   => rx_data_in,
             rx_data_out  => rx_data_out_s,
             rx_done      => rx_done_s
    );

end Behavioral;
