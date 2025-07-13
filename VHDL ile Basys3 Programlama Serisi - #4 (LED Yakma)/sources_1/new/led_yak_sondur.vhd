
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity led_yak_sondur is
Port (
        led : out std_logic
 );
end led_yak_sondur;

architecture Behavioral of led_yak_sondur is

begin
        led <= '1';

end Behavioral;
