--Figure 6.47
library ieee;
use ieee.std_logic_1164.all;

entity sseg_dual is
port (
	bcd : in std_logic_vector(3 downto 0);
	bcd2 : in std_logic_vector(3 downto 0);
	neg : in std_logic; --given sign
	--first & second 7 segment display
	leds : out std_logic_vector(0 to 6);
	leds2 : out std_logic_vector(0 to 6)
);
end sseg_dual;

architecture Behavior of sseg_dual is
	begin
	--BCD to 7 seg decoder start
	--turns on lettered leds (abcdefg) based on binary representation
	--of given number
	process(bcd, bcd2)
		begin
			if(neg='1') then
				leds2<= NOT "0000000";--no sign
			else
				leds2<= NOT "0000001";--negative sign, middle 7 seg light on (g)
			end if;
		
        case bcd2 is               	--	abcdefg
            when "0000" => leds2 <= NOT "1111110"; -- 0
            when "0001" => leds2 <= NOT "0110000"; -- 1
            when "0010" => leds2 <= NOT "1101101"; -- 2
            when "0011" => leds2 <= NOT "1111001"; -- 3
            when "0100" => leds2 <= NOT "0110011"; -- 4
            when "0101" => leds2 <= NOT "1011011"; -- 5
            when "0110" => leds2 <= NOT "1011111"; -- 6
            when "0111" => leds2 <= NOT "1110000"; -- 7
            when "1000" => leds2 <= NOT "1111111"; -- 8
            when "1001" => leds2 <= NOT "1110011"; -- 9
				--for addtion/subtraction above 9
				when "1010" => leds2 <= NOT "1110111"; -- A
				when "1011" => leds2 <= NOT "0011111"; -- B
				when "1100" => leds2 <= NOT "1001110"; -- C
				when "1101" => leds2 <= NOT "0111101"; -- D
				when "1110" => leds2 <= NOT "1001111"; -- E
				when "1111" => leds2 <= NOT "1000111"; -- F
            when others => leds2 <= NOT "-------"; -- error case
        end case;
		
        case bcd is               	--	abcdefg
            when "0000" => leds <= NOT "1111110"; -- 0
            when "0001" => leds <= NOT "0110000"; -- 1
            when "0010" => leds <= NOT "1101101"; -- 2
            when "0011" => leds <= NOT "1111001"; -- 3
            when "0100" => leds <= NOT "0110011"; -- 4
            when "0101" => leds <= NOT "1011011"; -- 5
            when "0110" => leds <= NOT "1011111"; -- 6
            when "0111" => leds <= NOT "1110000"; -- 7
            when "1000" => leds <= NOT "1111111"; -- 8
            when "1001" => leds <= NOT "1110011"; -- 9
				--for addtion/subtraction above 9
				when "1010" => leds <= NOT "1110111"; -- A
				when "1011" => leds <= NOT "0011111"; -- B
				when "1100" => leds <= NOT "1001110"; -- C
				when "1101" => leds <= NOT "0111101"; -- D
				when "1110" => leds <= NOT "1001111"; -- E
				when "1111" => leds <= NOT "1000111"; -- F
				--note: board defaults to active HIGH			
            when others => leds <= NOT "-------"; -- error case
        end case;
	end process;
end Behavior; 
