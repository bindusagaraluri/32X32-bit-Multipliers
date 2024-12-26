library ieee;
use ieee.std_logic_1164.all;
entity D_register_tb is
end entity;
 
architecture tb OF D_register_tb is
component D_register
	PORT(clk : in std_logic;
           op  : in std_logic_vector(6 DOWNTO 0);
	     DD  : in std_logic_vector(7 DOWNTO 0); 
           D   : out std_logic_vector(7 DOWNTO 0)
           );
end component;
SIGNAL clk_tb : std_logic := '0';
SIGNAL op_tb  : std_logic_vector(6 DOWNTO 0) := "0000000";
SIGNAL DD_tb  : std_logic_vector(7 DOWNTO 0) := "00000000"; 
SIGNAL D_tb   : std_logic_vector(7 DOWNTO 0);
CONSTANT period : time := 2 ns;
 
begin
--  (UUT)
uut: D_register      
	port map (clk => clk_tb, op => op_tb, DD => DD_tb, D => D_tb);
	clk_tb <= NOT clk_tb after period/2;
	op_tb <= "0000000", "1111111" after 10 ns, "1010101" after 20 ns, "0101010" after 30 ns,"1100011" after 40 ns,"1011101" after 50 ns;
      DD_tb <= "00000000", "11111111" after 10 ns, "01010101" after 20 ns, "10011001" after 30 ns,"00101100" after 40 ns,"10000011" after 50 ns;

		

stop: process
 begin
	wait FOR 60 ns; 
		assert false
			report "Simulation ended by SK at" & time'image(now)
		severity failure;
	end process;
end tb;
