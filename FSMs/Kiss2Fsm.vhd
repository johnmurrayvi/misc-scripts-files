----------------------------------------------------------------------------------
-- Company: 
-- Engineer:       Jeppe M.
-- 
-- Create Date:    09:25:23 03/14/2008 
-- Design Name:  
-- Module Name:    Kiss2Fsm - Behavioral 

----------------------------------------------start of
--example of input file---------------------------
--..i 2
--..o 2
--..p 8
--..s 4
--01 s0 s1 11
--11 so s3 00
--01 s1 s0 11
--11 s1 s2 00
--1- s2 s3 01
--0- s2 s1 10
--11 s3 s0 10
--10 s3 s2 11
----------------------------------------------end of
--file---------------------------------
--i= # of inputs
--o= # of outputs
--p= # of transitions
--s= # of states
--01 so s1 11 = this is read as for input 01 and current state s0 the
--output is 11 and next state is s1.
--'-' means don't care
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Kiss2Fsm is
    Port ( Clk : in  STD_LOGIC;
           i : in   STD_LOGIC_VECTOR (1 downto 0);
           O : out  STD_LOGIC_VECTOR (1 downto 0));
end Kiss2Fsm;

architecture Behavioral of Kiss2Fsm is
   type states is (S0,S1,S2,S3);
	signal state: states := s0;
begin

   -------------------- State transitions process -----------------------
   process( Clk)
	begin
	   if rising_edge(clk) then
		   case State is
			   when s0 => --============================================ 
				   if i="01" then 
					   State <= S1; 
					end if;
				   if i="11" then 
					   State <= S3; 
					end if;					
			   when s1 => --============================================ 
				   if i="01" then 
					   State <= S0; 
					end if;
				   if i="11" then 
					   State <= S2; 
					end if;
			   when s2 => --============================================ 
				   if i(1)='1' then   -- note single bit
					   State <= S3; 
					end if;
				   if i="0-" then      -- note dont care signal
					   State <= S1; 
					end if;
			   when s3 => --============================================== 
				   case i is                      -- alternative assignment
					   when   "11" => State <= S0;
						when   "10" => State <= S2;
						when others => State <= S3; -- Default needed here
					end case;
			end case;
		end if;
	end process;
	
	-------------------------- Output process -----------------------
	process( State, i)
	begin
	   case state is
		   when s0 => --==========================================
			   case i is
				   when "01"   => O <= "11";
					when "11"   => O <= "00";
					when others => O <= "01";
				end case;
		   when s1 => --==========================================
			   case i is
				   when "01"   => O <= "11";
					when "11"   => O <= "00";
					when others => O <= "01";
				end case;
		   when s2 => --==========================================
			   case i is
				   when "1-"   => O <= "01";
					when "0-"   => O <= "10";
					when others => O <= "11";
				end case;
		   when s3 => --==========================================
			   case i is
				   when "11"   => O <= "10";
					when "10"   => O <= "11";
					when others => O <= "--";
				end case;
		end case;
	end process;
end Behavioral;

