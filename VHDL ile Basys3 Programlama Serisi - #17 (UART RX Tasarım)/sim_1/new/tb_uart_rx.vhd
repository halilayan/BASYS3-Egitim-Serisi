----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Halil Ibrahim Ayan
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: tb_uart_rx - Behavioral
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

entity tb_uart_rx is
end tb_uart_rx;

architecture sim of tb_uart_rx is

    signal clk         : std_logic := '0';
    signal rx_data_in  : std_logic := '1';
    signal rx_data_out : std_logic_vector(7 downto 0);
    signal rx_done     : std_logic;

    constant clk_period : time := 10 ns;  -- 100 MHz clock
    constant baudrate   : integer := 868;
    constant bit_time   : time := clk_period * baudrate;

    component uart_rx
        Port ( 
            clk         : in std_logic;
            rx_data_in  : in std_logic;
            rx_data_out : out std_logic_vector (7 downto 0);
            rx_done     : out std_logic  
        );
    end component;

begin

    -- Instantiate the UART RX
    uut: uart_rx
        port map (
            clk         => clk,
            rx_data_in  => rx_data_in,
            rx_data_out => rx_data_out,
            rx_done     => rx_done
        );

    -- Clock process
    clk_process : process
    begin
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
    end process;

    
    stim_proc: process
    begin
        
        wait for 1000 ns;

       
        rx_data_in <= '0';
        wait for bit_time;

        -- Send 8-bit data: "10101010"
        rx_data_in <= '0'; wait for bit_time;  -- LSB
        rx_data_in <= '1'; wait for bit_time;
        rx_data_in <= '0'; wait for bit_time;
        rx_data_in <= '1'; wait for bit_time;
        rx_data_in <= '0'; wait for bit_time;
        rx_data_in <= '1'; wait for bit_time;
        rx_data_in <= '0'; wait for bit_time;
        rx_data_in <= '1'; wait for bit_time;  -- MSB

        -- 2 stop bits
        rx_data_in <= '1'; wait for bit_time;
        rx_data_in <= '1'; wait for bit_time;

        -- Wait for DONE
        wait for 5 * bit_time;

        -- Test finished
        assert false report "Simulation Finished" severity failure;
        wait;
    end process;

    
end sim;
