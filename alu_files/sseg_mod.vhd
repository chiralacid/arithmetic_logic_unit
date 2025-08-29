--Figure 6.47
library ieee;
use ieee.std_logic_1164.all;

entity sseg_mod is
port (
	bcd : in std_logic_vector(3 downto 0);
	--7 segment display
	leds : out std_logic_vector(0 to 6)
);
end sseg_mod;

architecture Behavior of sseg_mod is
	begin
	--BCD to 7 seg decoder start
	--turns on lettered leds (abcdefg) based on binary representation
	--of given number
	process(bcd)
		begin
        case bcd is               	--	abcdefg
            when "0000" => leds <= NOT "0111011";--displays y
				when "1111" => leds <= NOT "1110110";--displays n
            when others => leds <= NOT "-------"; -- error case
        end case;
end process;
end Behavior; 