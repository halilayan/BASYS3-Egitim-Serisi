----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: TOP_DIGITAL_CLOCK - Behavioral
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

entity top_digital_clock is
    Port (
        clk     : in  std_logic;
        btnL    : in std_logic;
        btnR    : in std_logic;
        seg     : out std_logic_vector (6 downto 0);
        an      : out std_logic_vector (3 downto 0);
        led     : out std_logic_vector (5 downto 0)
    );
end top_digital_clock;

architecture Behavioral of top_digital_clock is

    
    component one_sec_clock is
        Port (
            clk     : in  std_logic;
            one_sec : out std_logic
        );
    end component;

    component sec_min_ho is
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
    end component;

    component multiplexing_decoder is
        Port (
            clk   : in  std_logic;
            dec_0 : in  std_logic_vector(3 downto 0);
            dec_1 : in  std_logic_vector(3 downto 0);
            dec_2 : in  std_logic_vector(3 downto 0);
            dec_3 : in  std_logic_vector(3 downto 0);
            seg   : out std_logic_vector(6 downto 0);
            an    : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component debounce is
        Port (
            clk      : in  std_logic;
            btn_in   : in  std_logic;
            btn_out  : out std_logic  
        );
    end component;

    
    signal one_sec      : std_logic;
    signal dec_0        : std_logic_vector(3 downto 0);
    signal dec_1        : std_logic_vector(3 downto 0);
    signal dec_2        : std_logic_vector(3 downto 0);
    signal dec_3        : std_logic_vector(3 downto 0);
    signal snc_mns_u    : std_logic;
    signal snc_hrs_u    : std_logic;

begin

    
    sec_clk_inst : one_sec_clock
        port map (
            clk     => clk,
            one_sec => one_sec
        );

    
    sec_min_inst : sec_min_ho
        port map (
            clk         => clk,
            tick_1hz    => one_sec,
            minutes_up  => snc_mns_u,
            hours_up    => snc_hrs_u, 
            led         => led,     
            min_ones    => dec_0,
            min_tens    => dec_1,
            hour_ones   => dec_2,
            hour_tens   => dec_3
        );

    
    mux_inst : multiplexing_decoder
        port map (
            clk   => clk,
            dec_0 => dec_0,
            dec_1 => dec_1,
            dec_2 => dec_2,
            dec_3 => dec_3,
            seg   => seg,
            an    => an
        );
        
      
     btn_debounce_minutes : debounce
        port map(
            clk     => clk, 
            btn_in  => btnR,
            btn_out => snc_mns_u
        );
        
      btn_debounce_hours : debounce
        port map(
            clk     => clk, 
            btn_in  => btnL,
            btn_out => snc_hrs_u
        );
     

end Behavioral;
