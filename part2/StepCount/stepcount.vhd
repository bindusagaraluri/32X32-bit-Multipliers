library ieee;
use ieee.std_logic_1164.all;
entity cnt is
    generic(n : INTEGER := 8);
      port(clk : in std_logic;
           op  : in std_logic_vector(6 downto 0);
	     zI  : out std_logic
	      );
end entity;
architecture behavioral of cnt is
signal Sop : std_logic_vector(1 downto 0);
begin
	Sop <= op(1 downto 0);
process(clk)
	VARIABLE Sc : INTEGER := 0;
begin
	  if (clk 'event AND clk = '1') then
	        if (Sop = "00" ) then 
			Sc := Sc;  
			zI <= '0';

	  elsif (Sop = "01" ) then
			Sc := Sc + 1;
		if (Sc = (n-1)) then
			zI <= '1';
	  else
		zI <= '0';
	 end if ;

	elsif(Sop = "10" OR Sop = "11" ) then
		Sc := 0;
		zI <= '0';
	end if;
	end if;


	end process;

end architecture;

