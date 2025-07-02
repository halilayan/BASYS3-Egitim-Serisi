----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2025 22:20:12
-- Design Name: 
-- Module Name: led_blink - Behavioral
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

entity led_blink is
  Port (
            clk     : in std_logic;
            led     : out std_logic;
            led2    : out std_logic
  
   );
end led_blink;

architecture Behavioral of led_blink is

    constant max_count      : natural := 100_000_000-1;
    signal counter          : unsigned (26 downto 0) := (others => '0');
    signal led_state        : std_logic := '0';
    signal led_state_2      : std_logic := '0';

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if counter = max_count then
                counter <= (others => '0');
                led_state <= not led_state;
                led_state_2 <= not led_state_2;
            else
                counter <= counter +1;
            end if;        
        end if;
     end process;
     
    led <= led_state;
    led2 <= led_state_2;
        
            

end Behavioral;
