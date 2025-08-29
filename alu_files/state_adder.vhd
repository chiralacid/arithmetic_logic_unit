--makes state on board the same as the function table given
library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity state_adder is
port (
	state_in : in unsigned(3 downto 0);
	state_out : out unsigned(3 downto 0)
);
end state_adder;

architecture Behavior of state_adder is
	signal state_add : unsigned(3 downto 0); -- 8-bit Result
	begin
	process(state_in)
		begin
			state_add<=state_in+1;
	end process;
	state_out<=state_add;
end Behavior; 