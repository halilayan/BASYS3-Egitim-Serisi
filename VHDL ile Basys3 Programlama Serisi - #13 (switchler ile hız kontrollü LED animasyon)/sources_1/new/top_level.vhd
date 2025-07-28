----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil İbrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: top_level - Behavioral
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


entity top_level is
    Port ( 
           clk  : in std_logic;
           rst  : in std_logic;
           sw   : in std_logic_vector (8 downto 0);
           led  : out std_logic_vector (15 downto 0)
            );
end top_level;

architecture Behavioral of top_level is

signal div_clk_s : std_logic;


component clock_divider is
 Port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        sw      : in  std_logic_vector (8 downto 0);
        div_clk : out std_logic
 
  );
end component;


component led_animasyon is
  Port ( 
        clk      : in  std_logic;
        rst      : in  std_logic;  
        div_clk  : in  std_logic;  
        led      : out std_logic_vector(15 downto 0)  
        );
end component;

begin

    clk_ins: clock_divider
    port map (
                clk     => clk,
                rst     => rst,
                sw      => sw,
                div_clk => div_clk_s
                );
                
     led_an_ins : led_animasyon
     port map (
                clk     => clk,
                rst     => rst,
                div_clk => div_clk_s,
                led     => led
                );
     

end Behavioral;
