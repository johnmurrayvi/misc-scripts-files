-- Button debounce circuit;
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_UNSIGNED.all;

ENTITY DEBOUNCE IS
PORT (
  Clk       : IN STD_LOGIC; ---make it low frequency
  Key       : IN STD_LOGIC;  -- active low input
  pulse     : OUT STD_LOGIC);
END DEBOUNCE;

ARCHITECTURE clean_pulse OF DEBOUNCE IS
  SIGNAL cnt       : STD_LOGIC_VECTOR (1 DOWNTO 0);
BEGIN
  PROCESS (Clk,Key)
  BEGIN
    IF Key = '1' THEN
      cnt <= "00";
    ELSIF (clk'EVENT AND Clk = '1') THEN
      IF (cnt /= "11") THEN cnt <= cnt + 1; END IF;
    END IF;
    IF (cnt = "10") AND (Key = '0') THEN pulse <= '1'; ELSE pulse <= '0'; END IF;
  END PROCESS;
END clean_pulse;

