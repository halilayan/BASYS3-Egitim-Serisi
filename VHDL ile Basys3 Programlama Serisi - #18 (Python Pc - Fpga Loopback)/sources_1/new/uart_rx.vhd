----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: uart_rx - Behavioral
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

entity uart_rx is
  Port ( 
        clk         : in std_logic;
        rx_data_in  : in std_logic;
        rx_data_out : out std_logic_vector (7 downto 0);
        rx_done     : out std_logic  
  );
end uart_rx;

architecture Behavioral of uart_rx is

    type States is (IDLE, START, RECEIVE, STOP, DONE);
    signal state : States := IDLE;
    
    constant baudrate       : natural := 868;
    signal s_rx_data_out    : std_logic_vector (7 downto 0);
    signal baud_cnt         : integer range 0 to 868 := 0;
    signal bit_index        : integer range 0 to 8 := 0;
    signal stop_index       : integer range 0 to 2 := 0;
    signal s_rx_done        : std_logic := '0';
    
begin

    uart_rx     :process(clk)
                begin
                
                if rising_edge(clk) then
                    case state is
                    
                        when IDLE =>
                            s_rx_done   <= '0';
                            baud_cnt    <= 0;
                            bit_index   <= 0;
                            
                            if rx_data_in ='0' then
                                state <= START;
                            else
                                state <= IDLE;
                            end if;
                            
                        when START =>
                            if baud_cnt = baudrate/2 then
                                if rx_data_in ='0' then
                                    baud_cnt <= 0;
                                    state <= RECEIVE;
                                else
                                    state <= IDLE;
                                end if;
                            else
                                baud_cnt <= baud_cnt + 1;
                            end if;
                            
                        when RECEIVE =>
                            if baud_cnt = baudrate then
                                s_rx_data_out(bit_index) <= rx_data_in;
                                baud_cnt <= 0;
                                    if bit_index = 7 then
                                        bit_index <= 0;
                                        state <= STOP;
                                    else
                                        bit_index <= bit_index + 1;
                                        state <= RECEIVE;
                                    end if;
                            else
                                baud_cnt <= baud_cnt +1;    
                            end if;
                            
                        when STOP =>
                            if baud_cnt = baudrate then
                                baud_cnt    <= 0;
                                if rx_data_in = '1' then
                                    if stop_index = 1 then
                                        
                                        stop_index  <= 0;  
                                        state       <= DONE;
                                    else
                                        stop_index <= stop_index + 1;    
                                    end if;
                                else
                                    state <= IDLE;    
                                end if;
                            else
                                baud_cnt <= baud_cnt + 1;
                            end if;
                            
                        when DONE =>                        
                            s_rx_done   <= '1';
                            state <= IDLE;
                        
                    end case;
                end if;
                end process;
    
    rx_data_out <= s_rx_data_out;
    rx_done  <= s_rx_done;        

end Behavioral;
