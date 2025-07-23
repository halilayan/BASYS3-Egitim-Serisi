----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil İbrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: bin_to_dec - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity binary2dec is
    generic(N: positive := 16);
    port(
        clk			: in std_logic; 
        binary_in	: in std_logic_vector	(N-1 downto 0);
        dec_0		: out std_logic_vector 	(3 downto 0); 
		dec_1		: out std_logic_vector 	(3 downto 0); 
		dec_2		: out std_logic_vector 	(3 downto 0); 
		dec_3		: out std_logic_vector 	(3 downto 0) 
    );
end binary2dec ;
 
architecture behavioral of binary2dec is
    type states is (start, shift, done);
    signal current_state, next_state: states;
 
    signal binary		: std_logic_vector(N-1 downto 0);
	signal binary_next	: std_logic_vector(N-1 downto 0);
    signal sdec			: std_logic_vector(15 downto 0); 
	signal dec_reg		: std_logic_vector(15 downto 0); 
	signal dec_next		: std_logic_vector(15 downto 0);
	
    signal dec_out_reg			: std_logic_vector(15 downto 0); 
	signal dec_out_next			: std_logic_vector(15 downto 0);
	
    signal 	shift_counter		: natural range 0 to N; 
	signal	shift_counter_next	: natural range 0 to N;
begin
 
    process(clk)
    begin
        if rising_edge(clk) then
            binary			<= binary_next;
            sdec 			<= dec_next;
            current_state 	<= next_state;
            dec_out_reg 	<= dec_out_next;
            shift_counter 	<= shift_counter_next;
        end if;
    end process;
 
    convert:
    process(current_state, binary, binary_in, sdec, dec_reg, shift_counter)
    begin
        next_state			<= current_state;
        dec_next 			<= sdec;
        binary_next 		<= binary;
        shift_counter_next 	<= shift_counter;
 
        case current_state is
            when start =>
                next_state 			<= shift;
                binary_next 		<= binary_in;
                dec_next 			<= (others => '0');
                shift_counter_next 	<= 0;
				
            when shift =>
                if shift_counter = N then
                    next_state <= done;
                else
                    binary_next 		<= binary(N-2 downto 0) & '0';
                    dec_next 			<= dec_reg(14 downto 0) & binary(N-1);
                    shift_counter_next 	<= shift_counter + 1;
                end if;
				
            when done =>
                next_state <= start;
        end case;
    end process;
								
    dec_reg(15 downto 12) 	<= sdec(15 downto 12) + 3 when sdec(15 downto 12) > 4 else
								sdec(15 downto 12);
								
    dec_reg(11 downto 8) 	<= sdec(11 downto 8) + 3 when sdec(11 downto 8) > 4 else
								sdec(11 downto 8);
								
    dec_reg(7 downto 4) 	<= sdec(7 downto 4) + 3 when sdec(7 downto 4) > 4 else
								sdec(7 downto 4);
								
    dec_reg(3 downto 0) 	<= sdec(3 downto 0) + 3 when sdec(3 downto 0) > 4 else
								sdec(3 downto 0);
 
    dec_out_next <= sdec when current_state = done else
                         dec_out_reg;
 
    dec_3 <= dec_out_reg(15 downto 12);
    dec_2 <= dec_out_reg(11 downto 8);
    dec_1 <= dec_out_reg(7 downto 4);
    dec_0 <= dec_out_reg(3 downto 0);
 
end behavioral;

