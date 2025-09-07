----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 1_sec_clock - Behavioral
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

entity one_sec_clock is
  Port (
        clk         : in std_logic;       
        one_sec     : out std_logic      
   );
end one_sec_clock;

architecture Behavioral of one_sec_clock is

    constant CLOCK_FREQ : integer := 100_000_000;  
    signal counter      : integer range 0 to CLOCK_FREQ-1 := 0;
    signal tick_int     : std_logic := '0';

begin

    process(clk)
    begin 
        if rising_edge(clk) then
            if counter = CLOCK_FREQ-1 then
                counter <= 0;
                tick_int <= '1';  
            else
                counter <= counter + 1;
                tick_int <= '0';
            end if;
        end if;
    end process;

    one_sec  <= tick_int;

end Behavioral;
