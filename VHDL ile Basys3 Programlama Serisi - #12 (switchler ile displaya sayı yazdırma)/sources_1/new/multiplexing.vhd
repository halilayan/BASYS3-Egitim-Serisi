----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.07.2025 11:14:00
-- Design Name: 
-- Module Name: multiplexing - Behavioral
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

entity display_multiplexer is
  Port (
    clk    : in  std_logic;
    dec_0  : in  std_logic_vector(3 downto 0);
    dec_1  : in  std_logic_vector(3 downto 0);
    dec_2  : in  std_logic_vector(3 downto 0);
    dec_3  : in  std_logic_vector(3 downto 0);
    seg    : out std_logic_vector(6 downto 0);
    an     : out std_logic_vector(3 downto 0)
  );
end display_multiplexer;

architecture Behavioral of display_multiplexer is


  signal clk_div      : unsigned(16 downto 0) := (others => '0');
  signal refresh_tick : std_logic := '0';


  signal digit_sel       : unsigned(1 downto 0) := (others => '0');
  signal selected_digit  : std_logic_vector(3 downto 0);
  signal seg_internal    : std_logic_vector(6 downto 0);
  signal an_internal     : std_logic_vector(3 downto 0);

begin


  process(clk)
  begin
    if rising_edge(clk) then
      if clk_div = 99999 then  
        clk_div <= (others => '0');
        refresh_tick <= '1';
      else
        clk_div <= clk_div + 1;
        refresh_tick <= '0';
      end if;
    end if;
  end process;

 
  process(clk)
  begin
    if rising_edge(clk) then
      if refresh_tick = '1' then
        digit_sel <= digit_sel + 1;
      end if;
    end if;
  end process;

	process (digit_sel)
		begin
			case digit_sel is
				when "00" 	=> selected_digit <= dec_0;
				when "01" 	=> selected_digit <= dec_1;
				when "10" 	=> selected_digit <= dec_2;
				when "11" 	=> selected_digit <= dec_3;
				when others => selected_digit <= "0000";
			end case;
	end process;


	process(digit_sel)
		begin
			case digit_sel is
				when "00" 	=> an_internal <= "1110";
				when "01" 	=> an_internal <= "1101";
				when "10" 	=> an_internal <= "1011";
				when "11" 	=> an_internal <= "0111";
				when others => an_internal <= "1111";
			end case;
	end process;	



  process(selected_digit)
  begin
    case selected_digit is
      when "0000" => seg_internal <= "1000000"; 
      when "0001" => seg_internal <= "1111001"; 
      when "0010" => seg_internal <= "0100100"; 
      when "0011" => seg_internal <= "0110000"; 
      when "0100" => seg_internal <= "0011001"; 
      when "0101" => seg_internal <= "0010010"; 
      when "0110" => seg_internal <= "0000010"; 
      when "0111" => seg_internal <= "1111000"; 
      when "1000" => seg_internal <= "0000000"; 
      when "1001" => seg_internal <= "0010000"; 
      when others => seg_internal <= "1111111"; 
    end case;
  end process;


  seg <= seg_internal;
  an  <= an_internal;

end Behavioral;
