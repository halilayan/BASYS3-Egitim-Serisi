----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil İbrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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



entity clock_divider is
    Port (
            clk     : in std_logic;
            rst     : in std_logic;
            sw      : in std_logic_vector (8 downto 0);
            div_clk : out std_logic
         );
end clock_divider;

architecture Behavioral of clock_divider is

    constant clk_2       : natural := 200_000_000; --2 sn
    constant clk_1       : natural := 100_000_000; --1 sn 
    constant clk_05      : natural := 50_000_000;  --0.5 sn
    constant clk_025     : natural := 25_000_000;  --0.25 sn
    constant clk_0125    : natural := 12_500_000;  --0.125 sn
    constant clk_00625   : natural := 6_250_000;   --0.0625 sn
    constant clk_00310   : natural := 3_125_000;   --0.0312 sn
    constant clk_00156   : natural := 1_562_500;   --0.0156 sn
    constant clk_00078   : natural := 781_250;     --0.0078 sn
    
    signal target_200       : unsigned(27 downto 0) := (others => '0');
    signal target_100       : unsigned(26 downto 0) := (others => '0');
    signal target_50        : unsigned(25 downto 0) := (others => '0');
    signal target_25        : unsigned(24 downto 0) := (others => '0');
    signal target_125       : unsigned(23 downto 0) := (others => '0');
    signal target_062       : unsigned(22 downto 0) := (others => '0');
    signal target_031       : unsigned(21 downto 0) := (others => '0');
    signal target_015       : unsigned(20 downto 0) := (others => '0');
    signal target_007       : unsigned(19 downto 0) := (others => '0');
    signal div_clk_reg      : std_logic := '0';

begin
         process(clk)
        begin              
                if rising_edge(clk) then
                    if rst = '1' then
                        target_200 <= (others => '0');
                        target_100 <= (others => '0');
                        target_50  <= (others => '0');
                        target_25  <= (others => '0');
                        target_125 <= (others => '0');
                        target_062 <= (others => '0');
                        target_031 <= (others => '0');
                        div_clk_reg <= '0';
                    else                
                            if sw(0) = '1' then
                                if target_200 = to_unsigned(clk_2, 28) then
                                    target_200  <= (others => '0');
                                    div_clk_reg <= '1';
                                else
                                    target_200  <= target_200 + 1;
                                    div_clk_reg <= '0';
                                end if;
                
                            elsif sw(1) = '1' then
                                if target_100 = to_unsigned(clk_1, 27) then
                                    target_100  <= (others => '0');
                                    div_clk_reg <= '1';
                                else
                                    target_100  <= target_100 + 1;
                                    div_clk_reg <= '0';
                                end if;
                
                            elsif sw(2) = '1' then
                                if target_50 = to_unsigned(clk_05, 26) then
                                    target_50   <= (others => '0');
                                    div_clk_reg <= '1';
                                else
                                    target_50   <= target_50 + 1;
                                    div_clk_reg <= '0';
                                end if;
                
                            elsif sw(3) = '1' then
                                if target_25 = to_unsigned(clk_025, 25) then
                                    target_25   <= (others => '0');
                                    div_clk_reg <= '1';  
                                else
                                    target_25   <= target_25 + 1;
                                    div_clk_reg <= '0';
                                end if;
                                
                                
                            elsif sw(4) = '1' then
                                if target_125 = to_unsigned(clk_0125, 24) then
                                    target_125   <= (others => '0');
                                    div_clk_reg <= '1';  
                                else
                                    target_125   <= target_125 + 1;
                                    div_clk_reg <= '0';
                                end if;
                                
                            elsif sw(5) = '1' then
                                if target_062 = to_unsigned(clk_00625, 23) then
                                    target_062   <= (others => '0');
                                    div_clk_reg <= '1';  
                                else
                                    target_062   <= target_062 + 1;
                                    div_clk_reg <= '0';
                                end if;
                                
                            elsif sw(6) = '1' then
                                if target_031 = to_unsigned(clk_00310, 22) then
                                    target_031   <= (others => '0');
                                    div_clk_reg <= '1';  
                                else
                                    target_031   <= target_031 + 1;
                                    div_clk_reg <= '0';
                                end if;
                            
                            elsif sw(7) = '1' then
                                if target_015 = to_unsigned(clk_00156, 21) then
                                    target_015   <= (others => '0');
                                    div_clk_reg <= '1';  
                                else
                                    target_015   <= target_015 + 1;
                                    div_clk_reg <= '0';
                                end if;         
                            
                            elsif sw(8) = '1' then
                                if target_007 = to_unsigned(clk_00078, 20) then
                                    target_007   <= (others => '0');
                                    div_clk_reg <= '1';  
                                else
                                    target_007   <= target_007 + 1;
                                    div_clk_reg <= '0';
                                end if;
                            
                            else
                                div_clk_reg <= '0';
                            end if;
                    end if;
                end if;           
          
        end process;
        
        div_clk <= div_clk_reg;

end Behavioral;
