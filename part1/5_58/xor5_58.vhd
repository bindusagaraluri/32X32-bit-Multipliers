library ieee;
use ieee.std_logic_1164.all;
 
entity XOR3 is
    port( I0, I1, I2: in STD_LOGIC;
O: out STD_LOGIC );
end entity;
 
architecture bh of XOR3 is
 
begin
 
O <= I0 xor I1 xor I2;
 
end architecture;
