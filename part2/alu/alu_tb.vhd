library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ALU_tb is
end entity;
 
architecture tb OF ALU_tb is
 component ALU
	port (A  : in  signed(7 downto 0);
	      B  : in  signed(7 downto 0); 
            q0_1 : in std_logic_vector(1 downto 0);
	      F  : out signed(7 downto 0)
            );
end component;
signal A_tb   : signed(7 downto 0) := "00000000";
signal B_tb   : signed(7 downto 0) := "00000000";
signal q0_1_tb  : std_logic_vector(1 downto 0) := "00";
signal F_tb   : signed(7 downto 0);
begin
uut: ALU       
	port map ( A  => A_tb, B  => B_tb, q0_1 => q0_1_tb, F => F_tb );
	 A_tb   <= "00000000", "11111111" after 8 ns, "01000101" after 12 ns, "11100101" after 25 ns, "01100111" after 34 ns, "10001101" after 45 ns;
       B_tb   <= "00000000", "11110111" after 8 ns, "11100001" after 12 ns, "01000001" after 25 ns, "01100011" after 34 ns, "10000101" after 45 ns;
       q0_1_tb  <= "00", "11" after 8 ns, "01" after 12 ns, "10" after 25 ns, "11" after 34 ns, "01" after 45 ns; 
		
stop: process
 begin
	wait FOR 60 ns; 
		assert false
			report "Simulation ended by SK at" & time'image(now)
		severity failure;
	end process;
end tb;