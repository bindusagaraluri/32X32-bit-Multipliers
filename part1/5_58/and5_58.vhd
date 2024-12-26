library ieee;
use ieee.std_logic_1164.all;
 
entity AND2 is
    port( I0, I1: in STD_LOGIC;
O: out STD_LOGIC );
end entity;
 
architecture bh of and2 is
 
begin
 
O <= I0 and I1;
 
end architecture;
