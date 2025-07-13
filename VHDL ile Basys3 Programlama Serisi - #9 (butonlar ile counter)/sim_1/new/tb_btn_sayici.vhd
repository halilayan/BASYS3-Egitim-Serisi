
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity tb_btn_sayici is
end tb_btn_sayici;

architecture Behavioral of tb_btn_sayici is

component btn_sayici is
  Port (
        clk     : in std_logic;
        btnU    : in std_logic;
        btnD    : in std_logic;
        btnC    : in std_logic;
        counter : out std_logic_vector (7 downto 0) := (others => '0')
   );
end component;

        signal clk     : std_logic := '0';
        signal btnU    : std_logic := '0';
        signal btnD    : std_logic := '0';
        signal btnC    : std_logic := '0';
        signal counter : std_logic_vector (7 downto 0) := (others => '0');
        
        constant clk_period : time := 10ns;

begin

    uut: btn_sayici
        port map (
                    clk     => clk    ,
                    btnU    => btnU   ,
                    btnD    => btnD   ,
                    btnC    => btnC   ,
                    counter => counter                              
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
        wait for 10 ms;


        btnU <= '1';
        wait for 7 ms;      
        btnU <= '0';
        wait for 10 ms;


        btnU <= '1';
        wait for 7 ms;
        btnU <= '0';
        wait for 10 ms;
        
        btnU <= '1';
        wait for 7 ms;
        btnU <= '0';
        wait for 10 ms;


        btnD <= '1';
        wait for 7 ms;
        btnD <= '0';
        wait for 10 ms;


        btnC <= '1';
        wait for 7 ms;
        btnC <= '0';
        wait for 10 ms;

        wait; 
    end process;

end Behavioral;
