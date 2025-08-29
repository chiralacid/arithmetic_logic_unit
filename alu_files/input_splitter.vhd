library ieee;
use ieee.std_logic_1164.all;

entity input_splitter is port 
(
	result : in std_logic_vector(7 downto 0);
	digitsA : out std_logic_vector(3 downto 0);
	digitsB : out std_logic_vector(3 downto 0)
);
end input_splitter;

architecture behavior of input_splitter is
	begin 
	process(result)
		begin 
			digitsA<=result(3 downto 0);
			digitsB<=result(7 downto 4);
	end process;
end behavior;