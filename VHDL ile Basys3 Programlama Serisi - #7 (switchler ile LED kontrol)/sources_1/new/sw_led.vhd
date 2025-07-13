----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2025 23:50:44
-- Design Name: 
-- Module Name: sw_led - Behavioral
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


entity sw_led is
Port (
        switch       : in std_logic;
        switch_2     : in std_logic;
        switch_3     : in std_logic;
        switch_4     : in std_logic;
        led          : out std_logic;
        led_2        : out std_logic;
        led_3        : out std_logic;
        led_4        : out std_logic

 );
end sw_led;

architecture Behavioral of sw_led is

begin
    led <= switch;
    led_2 <= switch_2;
    led_3 <= switch_3;
    led_4 <= switch_4;

end Behavioral;
