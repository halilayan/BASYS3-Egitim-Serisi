----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: pwm_led - Behavioral
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

entity pwm_led is 
    port (
        clk     : in std_logic;
        sw      : in std_logic_vector(4 downto 0);  
        led0    : out std_logic;  
        led1    : out std_logic   
    );
end pwm_led;

architecture Behavioral of pwm_led is
    
    constant PWM_MAX        : natural := 255;  
    signal pwm_counter      : unsigned(7 downto 0) := (others => '0');
    signal breathing_duty   : unsigned(7 downto 0) := (others => '0');
    signal manual_duty      : unsigned(7 downto 0) := (others => '0');
    signal pwm_out0         : std_logic := '0';  
    signal pwm_out1         : std_logic := '0';  
    
    
    constant BREATH_MAX     : natural := 255;
    signal breath_counter   : unsigned(7 downto 0) := (others => '0');
    signal breath_up        : std_logic := '1';
    
    
    constant BRIGHTNESS_12  : unsigned(7 downto 0) := to_unsigned(31, 8);
    constant BRIGHTNESS_25  : unsigned(7 downto 0) := to_unsigned(63, 8);   
    constant BRIGHTNESS_50  : unsigned(7 downto 0) := to_unsigned(127, 8);  
    constant BRIGHTNESS_75  : unsigned(7 downto 0) := to_unsigned(191, 8); 
    constant BRIGHTNESS_100 : unsigned(7 downto 0) := to_unsigned(255, 8);  
    
    
    constant PWM_DIV        : natural := 5000;     
    signal pwm_clk_counter  : integer range 0 to PWM_DIV-1 := 0;
    signal pwm_clk_enable   : std_logic := '0';
    
    constant BREATH_DIV     : natural := 500000;  
    signal breath_clk_counter : integer range 0 to BREATH_DIV-1 := 0;
    signal breath_clk_enable  : std_logic := '0';
    
begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if pwm_clk_counter = PWM_DIV - 1 then
                pwm_clk_counter <= 0;
                pwm_clk_enable <= '1';
            else
                pwm_clk_counter <= pwm_clk_counter + 1;
                pwm_clk_enable <= '0';
            end if;
        end if;
    end process;
    
    
    process(clk)
    begin
        if rising_edge(clk) then
            if breath_clk_counter = BREATH_DIV - 1 then
                breath_clk_counter <= 0;
                breath_clk_enable <= '1';
            else
                breath_clk_counter <= breath_clk_counter + 1;
                breath_clk_enable <= '0';
            end if;
        end if;
    end process;
    
   
    process(clk)
    begin
        if rising_edge(clk) then
            if pwm_clk_enable = '1' then
                if pwm_counter = PWM_MAX then
                    pwm_counter <= (others => '0');
                else
                    pwm_counter <= pwm_counter + 1;
                end if;
                
                
                if pwm_counter < breathing_duty then
                    pwm_out0 <= '1';
                else
                    pwm_out0 <= '0';
                end if;
                
                
                if pwm_counter < manual_duty then
                    pwm_out1 <= '1';
                else
                    pwm_out1 <= '0';
                end if;
            end if;
        end if;
    end process;
    
    
    process(clk)
    begin
        if rising_edge(clk) then
            if breath_clk_enable = '1' then
                if breath_up = '1' then
                    if breathing_duty = BREATH_MAX then
                        breath_up <= '0';
                    else
                        breathing_duty <= breathing_duty + 1;
                    end if;
                else
                    if breathing_duty = 0 then
                        breath_up <= '1';
                    else
                        breathing_duty <= breathing_duty - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    
    process(clk)
    begin
        if rising_edge(clk) then
            
            if sw(4) = '1' then
                manual_duty <= BRIGHTNESS_100;  
            elsif sw(3) = '1' then
                manual_duty <= BRIGHTNESS_75;   
            elsif sw(2) = '1' then
                manual_duty <= BRIGHTNESS_50;   
            elsif sw(1) = '1' then
                manual_duty <= BRIGHTNESS_25;   
            elsif sw(0) = '1' then
                manual_duty <= BRIGHTNESS_12;   
            else
                manual_duty <= (others => '0'); 
            end if;
        end if;
    end process;
    
    
    led0 <= pwm_out0; 
    led1 <= pwm_out1; 
    
end Behavioral;
