library ieee;
use ieee.std_logic_1164.ALL;
entity cnt_tb is
end entity;
architecture tb of cnt_tb is
 
component cnt
	PORT(clk : in std_logic;
           op  : in std_logic_vector(6 downto 0);
	     zI  : out std_logic
           );
end component;
signal clk_tb : std_logic := '0';
signal op_tb  : std_logic_vector(6 downto 0) := "0000000";
signal zI_tb   : std_logic;
CONSTANT period : time := 2 ns;
 begin
 
--  (UUT)
uut: cnt      
	PORT MAP (clk => clk_tb, op => op_tb, zI => zI_tb );
	clk_tb <= NOT clk_tb after period/2;
	op_tb  <= "0000000", "1111111" after 3 ns, "1110001" after 6 ns, "0100001" after 9 ns, "0110001" after 12 ns, "1000101" after 15 ns, "0011001" after 18 ns, "0111011" after 20 ns, "0101101" after 29 ns, "0010001" after 31 ns, "1110111" after 35 ns, "1010101" after 39 ns, "1011001" after 40 ns, "1010111" after 45 ns, "1111101" after 50 ns;
		

stop: process
 begin
	wait FOR 60 ns; 
		assert false
			report "Simulation ended by SK at" & time'image(now)
		severity failure;
	end process;
end tb;
