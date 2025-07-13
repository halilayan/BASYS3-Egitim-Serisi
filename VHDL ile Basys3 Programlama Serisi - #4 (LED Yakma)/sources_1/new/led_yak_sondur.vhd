----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2025 11:58:37
-- Design Name: 
-- Module Name: led_yak_sondur - Behavioral
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



entity led_yak_sondur is
Port (
        led : out std_logic
 );
end led_yak_sondur;

architecture Behavioral of led_yak_sondur is

begin
        led <= '1';

end Behavioral;
