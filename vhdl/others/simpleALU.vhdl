--
-- VERY simplistic ALU implementation
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is
    Port (	enableF, Go, clk : in  std_logic;
        	F : in  std_logic_vector (3 downto 0);
        	BUSin : in  std_logic_vector (15 downto 0);
        	R0,R1 : out  std_logic_vector (15 downto 0);
			ex : out  std_logic	-- exit is a keyword, so use ex instead
			  );
end ALU;

architecture behav of ALU is
	type state_type is (S0,S1,S2,S3);
	signal s_cur : state_type := S0;
	signal F1 : std_logic_vector (3 downto 0);
	signal REG0,REG1,A,C : std_logic_vector (15 downto 0);
	signal T0,T1,T2,T3,I0,I1,I2,I3,ExtData,AddSub : std_logic;
	signal R0in,R0out,R1in,R1out,Ain,Cin,Cout : std_logic;
begin
	process (enableF,Go,clk)
	begin
		if (clk'event and clk = '1') then
			if (enableF = '1') then
			-- load instruction vector
				F1 <= F;
			-- reset instruction register
				I0 <= '0';
				I1 <= '0';
				I2 <= '0';
				I3 <= '0';
			elsif (Go = '1') then
			-- start fsm cycle
				s_cur <= S1;
				
				-- op code decode
				-- note: I* must be reset to '0' at end of cycle
				case F1(3)F1(2) is
					when "00" =>	-- load
						I0 <= '1';
					when "01" =>	-- copy
						I1 <= '1';
					when "10" =>	-- add
						I2 <= '1';
					when "11" =>	-- subtract
						I3 <= '1';
				end case;

			elsif
				case s_cur is
					when S2 =>
						s_cur <= S3;
					when S3 =>
						s_cur <= S0;
				end case;				
			end if;			
		end if;

		-- internal signals

		-- timing decode
		T0 <= '1' when s_curr = S0 else '0';
		T1 <= '1' when s_curr = S1 else '0';
		T2 <= '1' when s_curr = S2 else '0';
		T3 <= '1' when s_curr = S3 else '0';

		-- Reg decode
		Ain <= '1' when (T1 and (I2 or I3)) else '0';
		Cin <= '1' when (T2 and (I2 or I3)) else '0';
		Cout <= '1' when (T3 and (I2 or I3)) else '0';

		R0in <= '1' when (
					(T1 and ((I0 and not F1(1))	or (I1 and F1(0))) or 
					(T3 and ((I2 and not F1(1)) or (I3 and not F1(1)))
					) else '0';

		R0out <= '1' when (
					(T1 and not F1(1) and (I1 or I2 or I3)) or
					(T2 and not F1(0) and (I2 or I3))
					) else '0';

		R1in <= '1' when (
					(T1 and ((I0 and F1(1)) or (I1 and F1(0))) or 
					(T3 and ((I2 and F1(1)) or (I3 and F1(1)))
					) else '0';

		R1out <= '1' when (
					(T1 and F1(1) and (I1 or I2 or I3)) or
					(T2 and F1(0) and (I2 or I3))
					) else '0';
		
		-- other signals
		AddSub <= '1' when (T2 and I3) else '0';

		-- external signals
		ExtData <= '1' when (T1 and I0) else '0';
		ex <= '1' when T3 else '0';

	end process;
end behav;

