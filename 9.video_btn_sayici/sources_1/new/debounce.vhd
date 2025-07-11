----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.07.2025 11:01:13
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Port (
        clk     : in std_logic;
        btn_in  : in std_logic;
        btn_out : out std_logic
    );
end debounce;

architecture Behavioral of debounce is
    constant max_count : natural := 500_000 - 1; 
    signal counter     : unsigned(19 downto 0) := (others => '0');
    signal stable_btn  : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if btn_in = stable_btn then
                counter <= (others => '0');
            else
                counter <= counter + 1;
                if counter = max_count then
                    stable_btn <= btn_in;
                    counter <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    btn_out <= stable_btn;
end Behavioral;