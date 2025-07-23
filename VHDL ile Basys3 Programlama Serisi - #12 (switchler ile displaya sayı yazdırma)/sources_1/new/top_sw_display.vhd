----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.07.2025 11:15:21
-- Design Name: 
-- Module Name: top_sw_display - Behavioral
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

entity top_display is
    Port (
        clk      : in  std_logic;
        sw       : in  std_logic_vector(15 downto 0);  -- 16 switch
        seg      : out std_logic_vector(6 downto 0);   -- segment (a-g)
        an       : out std_logic_vector(3 downto 0)    -- anode (AN0-AN3)
    );
end top_display;

architecture Structural of top_display is

    -- Ara sinyaller
    signal dec_0_s, dec_1_s, dec_2_s, dec_3_s, dec_4_s : std_logic_vector(3 downto 0);
    
    
    component binary2dec is
    generic(N: positive := 16);
    port(
        clk			: in std_logic; 
        binary_in	: in std_logic_vector	(N-1 downto 0);
        dec_0		: out std_logic_vector 	(3 downto 0); 
		dec_1		: out std_logic_vector 	(3 downto 0); 
		dec_2		: out std_logic_vector 	(3 downto 0); 
		dec_3		: out std_logic_vector 	(3 downto 0) 

    );
end component ;

    component display_multiplexer is
  Port (
    clk    : in  std_logic;
    dec_0  : in  std_logic_vector(3 downto 0);
    dec_1  : in  std_logic_vector(3 downto 0);
    dec_2  : in  std_logic_vector(3 downto 0);
    dec_3  : in  std_logic_vector(3 downto 0);
    seg    : out std_logic_vector(6 downto 0);
    an     : out std_logic_vector(3 downto 0)
  );
end component;

begin
        bin_to_dec : binary2dec
        generic map (N => 16)
        port map (
            clk      => clk,
            binary_in => sw,
            dec_0    => dec_0_s,
            dec_1    => dec_1_s,
            dec_2    => dec_2_s,
            dec_3    => dec_3_s

        );

    
    disp_mux_inst: display_multiplexer
        port map (
            clk    => clk,
            dec_0  => dec_0_s,
            dec_1  => dec_1_s,
            dec_2  => dec_2_s,
            dec_3  => dec_3_s,
            seg    => seg,
            an     => an
        );

end Structural;

