

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
    signal debounce_btnR    : std_logic := '0';
    
    
    signal debounce_btnL    : std_logic := '0';
    signal prev_btnL        : std_logic := '0';
    signal led_state        : std_logic := '0';


begin

--zamanlama yöntemi
    process(clk)
        begin
            if rising_edge(clk) then
                if counter = max_counter then
                    counter <= (others => '0');
                    debounce_btnR <= btnR;
                    debounce_btnL <= btnL;
                else 
                    counter <= counter + 1;    
                end if;
                if debounce_btnL = '1' and prev_btnL = '0' then
                    led_state <= not led_state;
                end if;
                prev_btnL <= debounce_btnL;
            end if;
    end process;
   
    
    led0    <= debounce_btnR;
    led15   <=  led_state;

end Behavioral;
