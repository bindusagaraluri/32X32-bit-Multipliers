library ieee;
use ieee.std_logic_1164.all;

entity MAJ is
    port( I0, I1, I2: in STD_LOGIC;
O: out STD_LOGIC );
end entity;
 
architecture bh of MAJ is
 
begin
 
O <= ((I0 and I1) or (I0 and I2) or (I1 and I2));
 
end architecture;
