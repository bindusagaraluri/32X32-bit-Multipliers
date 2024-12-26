library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity D_register is
    generic(m : positive := 8);
    port(clk : in std_logic;
         op  : in std_logic_vector(6 DOWNTO 0);
	   DD  : in std_logic_vector(m-1 DOWNTO 0); 
         D : out std_logic_vector(m-1 DOWNTO 0)
         );
end entity;

architecture behavioral of D_register is
signal D_s : std_logic_vector(m-1 DOWNTO 0);
SIGNAL Dop : std_logic;

begin
    Dop <= op(6);
   process(clk)
     begin	
	if (clk 'event AND clk = '1') then
		if (Dop = '0' ) then			
		    D_s <= D_s;
	 elsif (Dop = '1' ) then 
		    D_s <= DD;
		end if;
	 end if;
end process;
 D <= D_s;

end architecture;