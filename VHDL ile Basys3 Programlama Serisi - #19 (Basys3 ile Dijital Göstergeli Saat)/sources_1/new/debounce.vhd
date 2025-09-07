----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
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
        clk      : in  std_logic;
        btn_in   : in  std_logic;
        btn_out  : out std_logic  
    );
end debounce;

architecture Behavioral of debounce is

    constant max_counter : natural := 1_000_000 - 1;  
    signal counter      : unsigned(19 downto 0) := (others => '0');

    signal debounce_reg : std_logic := '0';          
    signal btn_prev     : std_logic := '0';          

begin

    process(clk)
    begin
        if rising_edge(clk) then
            
            if counter = max_counter then
                counter <= (others => '0');
                debounce_reg <= btn_in;
            else
                counter <= counter + 1;
            end if;

            
            btn_out <= '0'; 

            if debounce_reg = '1' and btn_prev = '0' then
                btn_out <= '1';  
            end if;

            btn_prev <= debounce_reg; 
        end if;
    end process;

end Behavioral;


