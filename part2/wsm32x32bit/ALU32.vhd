library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    generic(m : INTEGER := 32);
     port(A  : in  std_logic_vector(m-1 downto 0);
	    B  : in  std_logic_vector(m-1 downto 0); 
          q0_1: in std_logic_vector(1 downto 0);
	    F  : out std_logic_vector(m-1 downto 0)
           );
end entity;

architecture behavioral of ALU is
signal Fop : std_logic_vector(1 downto 0):="00";

begin
      Fop <= q0_1(1 downto 0);
      with Fop select
		F <=  std_logic_vector( unsigned(A)+ unsigned(B))   when "01", 
		       std_logic_vector(unsigned(A)-unsigned(B))   when "10",
		       A    when others;

end architecture;
