library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vmul32x32p is
	port (
		X: in UNSIGNED (31 downto 0);
		Y: in UNSIGNED (31 downto 0);
		P: out UNSIGNED (63 downto 0)
		);
end vmul32x32p;


architecture vmul32x32truly_arch of vmul32x32p is
begin
	P <= X * Y;
end vmul32x32truly_arch;
