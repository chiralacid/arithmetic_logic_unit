LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity ALU_mod is -- ALU unit includes Reg. 3
port ( 
	clk, res : in std_logic ;
	Reg1, Reg2 : in unsigned(7 downto 0); -- 8-bit inputs A & B from Reg. 1 & Reg. 2
	opcode : in unsigned(15 downto 0); -- 8-bit opcode from Decoder
	R1, R2 : out unsigned(3 downto 0);
	neg : out std_logic 
	);
end ALU_mod;

architecture calculation of ALU_mod is
	signal result : unsigned(7 downto 0); -- 8-bit Result
	begin
	process ( clk, res, opcode )
		begin
			if res = '1' then
				result <= (others => '0');
				neg<='0';
			end if;
			--elsif (clk'EVENT AND clk = '1') then
				case opcode is
					when "0000000000000001" =>
						--decrement B by 9
						if (Reg2>9) then
							result<=Reg2 - 9; 
							neg<='0';
						else 
							result<=9-Reg2;
							neg<='1';
						end if;
					when "0000000000000010" =>
						--swap upper and lower 4 bits of B
						result <= Reg2(3 downto 0) & Reg2(7 downto 4);
						neg<='0';
					when "0000000000000100" =>
						--shift A to the left by 2 bits, input bit=0 (SHL)
						result <= Reg1 sll 2;
						neg<='0';
					when "0000000000001000" =>
						--do NAND of A and B
						result<= Reg1 nand Reg2; 
						neg<='0';
					when "0000000000010000" =>
						--Compare A and B, output greater value
						if(Reg1>Reg2) then
							result<=Reg1;
						else 
							result<=Reg2;
						end if;
						neg<='0';
					when "0000000000100000" =>
						--invert even bits of B
						result <= (Reg2(7) & not Reg2(6) & Reg2(5) & not Reg2(4) & 
							Reg2(3) & not Reg2(2) & Reg2(1) & not Reg2(0));
						neg<='0';
					when "0000000001000000" =>
						--produce null on output
						result<= (others => '0');
						neg<='0';
					when "0000000010000000" =>
						--replace upper 4 bits of Reg2 with upper 4 bits of Reg1
						result<= Reg1(7 downto 4)&Reg2(3 downto 0);
						neg<='0';
					when others =>
						result<= "--------"; -- Don’t care, do nothing (8 don’t cares)
						neg<='0';
				end case ;
			--end if ;
	end process ;
	R1<=result(3 downto 0);
	R2<=result(7 downto 4);
end calculation ;