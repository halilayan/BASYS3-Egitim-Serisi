----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: tb_uart_tx - Behavioral
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

entity tb_uart_tx is
end tb_uart_tx;

architecture Behavioral of tb_uart_tx is

    
    component uart_tx
        Port ( 
            clk         : in std_logic;
            tx_start    : in std_logic;
            data_in     : in std_logic_vector (7 downto 0);
            tx_data_out : out std_logic;
            tx_done     : out std_logic;
            tx_busy     : out std_logic  
        );
    end component;

   
    signal clk         : std_logic := '0';
    signal tx_start    : std_logic := '0';
    signal data_in     : std_logic_vector (7 downto 0) := (others => '0');
    signal tx_data_out : std_logic;
    signal tx_done     : std_logic;
    signal tx_busy     : std_logic;

    constant clk_period : time := 10 ns;

begin

    
    uut: uart_tx
        port map (
            clk         => clk,
            tx_start    => tx_start,
            data_in     => data_in,
            tx_data_out => tx_data_out,
            tx_done     => tx_done,
            tx_busy     => tx_busy
        );

    
    clk_process : process
    begin        
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;        
    end process;

    
    stim_proc: process
    begin
        wait for 100 ns;

        
        data_in <= "01010101";
        tx_start <= '1';
        wait for clk_period;
        tx_start <= '0';

        
        wait until tx_done = '1';
        
        
 
        wait for 100 ns;

        assert false report "Simulation Finished" severity failure;
        wait;
    end process;

end Behavioral;
