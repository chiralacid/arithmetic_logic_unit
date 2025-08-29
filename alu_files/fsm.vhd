LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fsm IS
port (
	data_in, clk, reset : in std_logic ;
	current_state : out std_logic_vector(3 downto 0);
	student_id : out std_logic_vector(3 downto 0)
);
end fsm ;

architecture fsm of fsm is
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
	signal yfsm : state_type ;
	begin
		process (clk, reset)
		begin
		if reset = '1' then--CHANGE reset = '0' IF BOARD DOESNT WORK
		yfsm <= s0 ;

		elsif (clk'EVENT AND clk = '1') then
			case yfsm is
				when s0 =>
				if data_in = '1' then
					yfsm <= s6 ;
				end if ;
				when s1 =>
				if data_in = '1' then
					yfsm <= s0 ;
				end if;
				when s2 =>
				if data_in = '1' then
					yfsm <= s7 ;
				end if;
				when s3 =>
				if data_in = '1' then
					yfsm <= s1 ;
				end if;
				when s4 =>
				if data_in = '1' then
					yfsm <= s2 ;
				end if;
				when s5 =>
				if data_in = '1' then
					yfsm <= s3 ;
				end if;
				when s6 =>
				if data_in = '1' then
					yfsm <= s4 ;
				end if;
				when s7 =>
				if data_in = '1' then
					yfsm <= s5 ;
				end if;
				end case ;
			end if ;
		end process ;

		process (yfsm)
			begin
			case yfsm is
			when s0 => current_state <= "0000" ;
				student_id <= "0000" ; -- d2
			when s1 => current_state <= "0001" ;
				student_id <= "0001" ; -- d3
			when s2 => current_state <= "0010" ;
				student_id <= "0010" ; -- d4
			when s3 => current_state <= "0011" ;
				student_id <= "0101" ; -- d5
			when s4 => current_state <= "0100" ;
				student_id <= "0111" ; -- d6
			when s5 => current_state <= "0101" ;
				student_id <= "0010" ; -- d7
			when s6 => current_state <= "0110" ;
				student_id <= "0110" ; -- d8
			when s7 => current_state <= "0111" ;
				student_id <= "0110" ; -- d9 St. ID
			end case ; -- d1 d2 d3 d4 d5 d6 d7 d8 d9
		end process ; -- 5  0  1  2  5  7  2  6  6

end fsm ; -- states: s0 s1 s2 s3 s4 s5 s6 s7