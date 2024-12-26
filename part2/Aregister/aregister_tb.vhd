library ieee;
use ieee.std_logic_1164.ALL;
entity A_register_tb IS
end entity;
 
architecture tb of A_register_tb is
 component A_register
	port(clk : in std_logic;
           op  : in std_logic_vector(6 downto 0);
	     F   : in std_logic_vector(7 downto 0); 
           A   : out std_logic_vector(7 downto 0)
           );
end component;
 
signal clk_tb : std_logic := '0';
signal op_tb  : std_logic_vector(6 downto 0) := "0000000";
signal F_tb   : std_logic_vector(7 downto 0) := "00000000"; 
signal A_tb   : std_logic_vector(7 downto 0);
constant period : time := 6 ns;
begin
 
--(UUT)
uut: A_register     
	port map (clk => clk_tb, op => op_tb,  F => F_tb, A => A_tb );
	clk_tb <= not clk_tb after period/2;
	  	
	op_tb  <= "0000000", "1111111" after 50 ns, "1010101" after 100 ns, "0101010" after 150 ns, "0010011" after 200 ns, "1011100" after 250 ns;
	 F_tb   <= "00000000", "11111111" after 50 ns, "01010101" after 100 ns, "10011001" after 150 ns, "00110011" after 200 ns, "10001000" after 250 ns;

		

 stop: process
 begin
	wait for 300 ns; 
		assert false
			report "Simulation ended by SK at" & time'image(now)
		severity failure;
	end process;
end tb;

