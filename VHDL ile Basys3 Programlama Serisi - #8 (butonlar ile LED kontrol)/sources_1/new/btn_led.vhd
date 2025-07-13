
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity btn_led is
 Port ( 
        clk     : in std_logic;
        btnR    : in std_logic;
        btnL    : in std_logic;
        led0    : out std_logic;
        led15   : out std_logic
 
 );
end btn_led;

architecture Behavioral of btn_led is

    constant max_counter    : natural := 1_000_000-1;
    signal counter          : unsigned (19 downto 0) := (others => '0');
    signal debounce         : std_logic := '0';
    

    signal prev_btnL        : std_logic := '0';
    signal led_state        : std_logic := '0';


begin

--zamanlama y�ntemi
    process(clk)
        begin
            if rising_edge(clk) then
                if counter = max_counter then
                    counter <= (others => '0');
                    debounce <= btnR;
                else 
                    counter <= counter + 1;    
                end if;
            end if;
    end process;
    
--edge detection
    process(clk)
        begin
            if rising_edge(clk) then
                if btnL = '1' and prev_btnL = '0' then
                    led_state <= not led_state;
                end if;
              prev_btnL <= btnL;  
            end if;
    end process;    
    
    led0    <= '1' when debounce    = '1' else '0';
    led15   <=  led_state;

end Behavioral;
