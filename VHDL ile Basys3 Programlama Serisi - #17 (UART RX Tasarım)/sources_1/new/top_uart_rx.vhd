----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: top_uart_rx - Behavioral
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

entity top_uart_led is
    Port (
        clk         : in  std_logic;
        rx_data_in  : in  std_logic;
        leds        : out std_logic_vector(7 downto 0)
    );
end top_uart_led;

architecture Behavioral of top_uart_led is

    
    component uart_rx
        Port ( 
            clk         : in std_logic;
            rx_data_in  : in std_logic;
            rx_data_out : out std_logic_vector (7 downto 0);
            rx_done     : out std_logic  
        );
    end component;

    signal rx_data      : std_logic_vector(7 downto 0);
    signal rx_done_sig  : std_logic;
    signal led_reg      : std_logic_vector(7 downto 0) := (others => '0');

begin

    -- UART RX Instance
    uart_rx_inst : uart_rx
        port map (
            clk         => clk,
            rx_data_in  => rx_data_in,
            rx_data_out => rx_data,
            rx_done     => rx_done_sig
        );

    
    process(clk)
    begin
        if rising_edge(clk) then
            if rx_done_sig = '1' then
                led_reg <= rx_data;
            end if;
        end if;
    end process;

    -- Output assignment
    leds <= led_reg;

end Behavioral;
