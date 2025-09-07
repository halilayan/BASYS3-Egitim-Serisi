----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: sec_min_ho - Behavioral
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

entity sec_min_ho is
    Port (
        clk         : in  std_logic;                      
        tick_1hz    : in  std_logic;                      
        minutes_up  : in std_logic;
        hours_up    : in std_logic;
        led         : out std_logic_vector(5 downto 0);   
        min_ones    : out std_logic_vector(3 downto 0);
        min_tens    : out std_logic_vector(3 downto 0);
        hour_ones   : out std_logic_vector(3 downto 0);
        hour_tens   : out std_logic_vector(3 downto 0)
    );
end sec_min_ho;

architecture Behavioral of sec_min_ho is

    signal sec_cnt  : unsigned(5 downto 0) := (others => '0'); 
    signal m_ones   : unsigned(3 downto 0) := (others => '0');
    signal m_tens   : unsigned(3 downto 0) := (others => '0');
    signal h_ones   : unsigned(3 downto 0) := (others => '0');
    signal h_tens   : unsigned(3 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if tick_1hz = '1' then
                
                if sec_cnt = 59 then
                    sec_cnt <= (others => '0');                  
                    if m_ones = 9 then
                        m_ones <= (others => '0');          
                        
                        if m_tens = 5 then
                            m_tens <= (others => '0');
                            
                            if (h_tens = 2 and h_ones = 3) then
                                h_tens <= (others => '0');
                                h_ones <= (others => '0');
                            elsif h_ones = 9 then
                                h_ones <= (others => '0');
                                h_tens <= h_tens + 1;
                            else
                                h_ones <= h_ones + 1;
                            end if;
                        else
                            m_tens <= m_tens + 1;
                        end if;
                    else
                        m_ones <= m_ones + 1;
                    end if;
                else
                    sec_cnt <= sec_cnt + 1;
                end if;
            end if;
            
           
               if minutes_up = '1' then
                  sec_cnt <= (others => '0');  
                    if m_ones = 9 then
                        m_ones <= (others => '0');
                        if m_tens = 5 then
                            m_tens <= (others => '0');
                        else
                            m_tens <= m_tens + 1;
                        end if;
                    else
                        m_ones <= m_ones + 1;
                    end if;
            end if;
    
            if hours_up = '1' then
                sec_cnt <= (others => '0');
                if (h_tens = 2 and h_ones = 3) then
                    h_tens <= (others => '0');
                    h_ones <= (others => '0');
                elsif h_ones = 9 then
                    h_ones <= (others => '0');
                    h_tens <= h_tens + 1;
                else
                    h_ones <= h_ones + 1;
                end if;
            end if;            
        end if;                
    end process;

    
    led         <= std_logic_vector(sec_cnt);
    min_ones    <= std_logic_vector(m_ones);
    min_tens    <= std_logic_vector(m_tens);
    hour_ones   <= std_logic_vector(h_ones);
    hour_tens   <= std_logic_vector(h_tens);

end Behavioral;
