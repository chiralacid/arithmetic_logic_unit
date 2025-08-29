LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity ALU is -- ALU unit includes Reg. 3
port ( 
	clk, res : in std_logic ;
	Reg1, Reg2 : in unsigned(7 downto 0); -- 8-bit inputs A & B from Reg. 1 & Reg. 2
	opcode : in unsigned(15 downto 0); -- 8-bit opcode from Decoder
	R1 : out unsigned(3 downto 0);
	R2 : out unsigned(3 downto 0);
	neg : out std_logic 
);
end ALU ;

architecture calculation of ALU is
	signal result : unsigned ( 7 downto 0 );	
	begin
	process ( clk, res, opcode)
		begin
			if res = '1' then
				result <= (others => '0');
				neg<='0';
			end if;
			--elsif (clk'EVENT AND clk = '1') then
				case opcode is
					when "0000000000000001" =>
						result<=Reg1 + Reg2; --Do addition for Reg1 and Reg2
						neg<='0';
						--result<="10000001"; --error code test 1
					when "0000000000000010" =>
						if (Reg1>Reg2) then
							result<=Reg1 - Reg2; -- Do subtraction for Reg1 and Reg2
							neg<='0';
						--result<="01111110"; --error code test 2
						else 
							result<=Reg2-Reg1;
							neg<='1';
						--result<="00001111"; --error code test 3
						end if;
					when "0000000000000100" =>
						result <= not(Reg1); -- Do inverse of Reg1
						neg<='0';
						--result<="11110000"; --error code test 4
					when "0000000000001000" =>
						result <= Reg1 nand Reg2; -- Do Boolean NAND
						neg<='0';
						--result<="11001100";  --error code test 5
					when "0000000000010000" =>
						result <= Reg1 nor Reg2; -- Do Boolean NOR
						neg<='0';
						--result<="00110011";  --error code test 6
					when "0000000000100000" =>
						result <= Reg1 and Reg2; -- Do Boolean AND
						neg<='0';
						--result<="00011000"; --error code test 7
					when "0000000001000000" =>
						result <= Reg1 xor Reg2; -- Do Boolean XOR
						neg<='0';
						--result<="11100111"; --error code test 8
					when "0000000010000000" =>
						result <= Reg1 or Reg2; -- Do Boolean OR
						neg<='0';
						--result<="00111100"; --error code test 9
					when others =>
						result<= (others => '0'); -- Don’t care, do nothing 
				end case ;
			--end if ;
	end process ;
	R1<=result(3 downto 0);
	R2<=result(7 downto 4);
end calculation ;