
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity btn_sayici is
  Port (
        clk     : in std_logic;
        btnU    : in std_logic;
        btnD    : in std_logic;
        btnC    : in std_logic;
        counter : out std_logic_vector (7 downto 0) := (others => '0')
  
   );
end btn_sayici;

architecture Behavioral of btn_sayici is

signal btnU_db      : std_logic := '0';
signal btnD_db      : std_logic := '0';
signal btnC_db      : std_logic := '0';

signal counter_db   : std_logic_vector (7 downto 0) := (others => '0');
signal prevU        : std_logic := '0';
signal prevD        : std_logic := '0';
signal prevC        : std_logic := '0';


component debounce is
    Port (
        clk     : in std_logic;
        btn_in  : in std_logic;
        btn_out : out std_logic
    );
end component;

begin

debU: debounce port map (
                            clk     => clk,
                            btn_in  => btnU,
                            btn_out => btnU_db                            
                         );
                         
 debD: debounce port map (
                            clk     => clk,
                            btn_in  => btnD,
                            btn_out => btnD_db                            
                         );
                         
 debC: debounce port map (
                            clk     => clk,
                            btn_in  => btnC,
                            btn_out => btnC_db                            
                         );                        


    process(clk)
        begin
            if(rising_edge(clk)) then
                if (btnU_db = '1' and prevU = '0') then
                    counter_db <= counter_db +1;
                end if;
                
                if (btnD_db = '1' and prevD = '0') then
                    counter_db <= counter_db -1;
                end if;
                
                if (btnC_db = '1' and prevC = '0') then
                    counter_db <= (others => '0');
                end if;
                
                prevU <=btnU_db;
                prevD <=btnD_db;
                prevC <=btnC_db;
                
            end if;
    end process;
    
    counter <= counter_db;

end Behavioral;
