----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: top_uart_tx - Behavioral
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

entity top_module is
    Port (
        clk         : in  std_logic;
        btn_start   : in  std_logic;
        data_in     : in  std_logic_vector(7 downto 0);
        tx_done     : out std_logic;
        tx          : out std_logic
    );
end top_module;

architecture Behavioral of top_module is

    -- UART TX component
    component uart_tx
        Port (
            clk         : in  std_logic;
            tx_start    : in  std_logic;
            data_in     : in  std_logic_vector(7 downto 0);
            tx_data_out : out std_logic;
            tx_done     : out std_logic;
            tx_busy     : out std_logic
        );
    end component;

    -- Debounce component
    component debounce
        Port (
            clk       : in  std_logic;
            btn_in    : in  std_logic;
            btn_out   : out std_logic
        );
    end component;

    signal tx_done_sig   : std_logic;
    signal tx_busy_sig   : std_logic;
    signal debounced_btn : std_logic;
    
    constant led_blink      : natural := 100_000_000;
    signal counter          : integer range 0 to led_blink - 1;
    signal led_on           : std_logic := '0';

begin

process(clk)
begin
    if rising_edge(clk) then
        if tx_done_sig = '1' then
            led_on <= '1';  
            counter <= 0;   
        elsif led_on = '1' then
            if counter = led_blink - 1 then
                led_on <= '0';   
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end if;
end process;

    -- debounce instance
    debounce_inst : debounce
        port map (
            clk     => clk,
            btn_in  => btn_start,
            btn_out => debounced_btn
        );

    -- uart instance
    uart_tx_inst : uart_tx
        port map (
            clk         => clk,
            tx_start    => debounced_btn,
            data_in     => data_in,
            tx_data_out => tx,
            tx_done     => tx_done_sig,
            tx_busy     => tx_busy_sig
        );
        
       
tx_done <= led_on;
        

end Behavioral;