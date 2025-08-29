LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity ALU_P3 is -- ALU_P3 unit includes Reg. 3
port ( 
	clk, res : in std_logic ;
	Reg1, Reg2 : in unsigned(7 downto 0); -- 8-bit inputs A & B from Reg. 1 & Reg. 2
	opcode : in unsigned(15 downto 0); -- 8-bit opcode from Decoder
	result : out unsigned (3 downto 0);
	student_id : in unsigned(3 downto 0)
);
end ALU_P3 ;

architecture calculation of ALU_P3 is
	-- display 'y' if one of 2 digits for A (Reg1) is less than studnet_id, 
	-- otherwise display 'n'
	signal Reg1_high : unsigned(3 downto 0);
	signal Reg2_low : unsigned(3 downto 0);
	
	begin
		-- extract digits of Reg1 
		Reg1_high <= Reg1(7 downto 4); 
		Reg2_low  <= Reg1(3 downto 0);
	process ( clk, res, opcode)
		begin
			if res = '1' then
				result <= (others => '0');
			end if;
			--elsif (clk'EVENT AND clk = '1') then
				if (Reg1_high > student_id) or 
					(Reg2_low > student_id) then
					-- set result to 'y'
					result <= "1111";
				else
				-- set result to 'n'
					result <= "0000";
				end if ;
			--end if;
	end process ;
end calculation ;