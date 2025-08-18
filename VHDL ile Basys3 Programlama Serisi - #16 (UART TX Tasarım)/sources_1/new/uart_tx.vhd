----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ýbrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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


entity uart_tx is
  Port ( 
            clk         : in std_logic;
            tx_start    : in std_logic;
            data_in     : in std_logic_vector (7 downto 0);
            tx_data_out : out std_logic;
            tx_done     : out std_logic;
            tx_busy     : out std_logic  
  );
end uart_tx;

architecture Behavioral of uart_tx is

    type States is (IDLE, START, DATA, STOP, DONE);
    signal state    : States := IDLE;
    
    constant baudrate       : natural := 868;
    
    signal s_data           : std_logic_vector (7 downto 0);
    signal baud_cnt         : integer range 0 to 868 := 0;
    signal bit_index        : integer range 0 to 8 := 0;
    signal stop_index       : integer range 0 to 2 := 0;    
	signal s_tx_done		: std_logic := '0';
	signal s_tx_busy		: std_logic := '0';
    


begin
    
    uart_tx :   process (clk)
                begin
                
                if rising_edge(clk) then
                    case state is 
                        when IDLE =>
                            s_tx_busy     	<= '0';
                            tx_data_out 	<= '1';
                            s_tx_done    	<= '0';
                            baud_cnt    	<= 0;
                            bit_index   	<= 0;
                            stop_index      <= 0;                            
                            
                            if tx_start = '1' then
                                s_data      <= data_in;
                                state <= START;
                            else
                                state <= IDLE;
                            end if;
                            
                        when START =>
                            s_tx_busy <= '1';
                            tx_data_out <= '0';
                            
                            if baud_cnt = baudrate then
                                baud_cnt <= 0;
                                state <= DATA;                               
                            else 
                                baud_cnt <= baud_cnt + 1;
                                state <= START;
                            end if;
                            
                        when DATA =>
                            tx_data_out <= s_data(bit_index);
                            
                            if baud_cnt = baudrate then
                                baud_cnt <= 0;
                                if bit_index = 7 then
                                    bit_index <= 0;
                                    state <= STOP;
                                else
                                    bit_index <= bit_index + 1;
                                    state <= DATA;
                                end if;
                            else
                                baud_cnt <= baud_cnt + 1;
                            end if;
                            
                        when STOP =>
                            tx_data_out <= '1';
                            if baud_cnt = baudrate then
                                baud_cnt <= 0;
                                if stop_index = 1 then
                                    stop_index <= 0;  
                                    state <= DONE;
                                else
                                    stop_index <= stop_index + 1;
                                    state <= STOP;
                                end if;
                            else
                                baud_cnt <= baud_cnt + 1;
                                state <= STOP;
                            end if;
                            
                        when DONE =>
                            s_tx_busy <= '0';
                            s_tx_done <= '1';
                            state <= IDLE; 
                            
                        when others =>
                            state <= IDLE;    
                        end case;
                    end if;
                end process;

	tx_done <= s_tx_done;
	tx_busy <= s_tx_busy;
	
end Behavioral;
