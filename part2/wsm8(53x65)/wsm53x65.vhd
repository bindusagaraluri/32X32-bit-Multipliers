library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity topmodule is
generic (
        m : positive := 8;  -- default value for m
        n : positive := 8   -- default value for n
    );
  port(  DD_in : in std_logic_vector( m-1 downto 0);
          QQ_in : in std_logic_vector( n-1 downto 0);
         st : in std_logic;
           clk : in std_logic;
          rst : in std_logic;
          rdy : out std_logic;
         aq :  out std_logic_vector(15 downto 0));
end entity;


architecture stru of topmodule is 
    
signal tempop : std_logic_vector( 6 downto 0);

signal tempzi : std_logic;

begin

datapath_unit: entity work. datapath_unit 
     port map( clk  => clk, 
                rst => rst,
                op => tempop(6 downto 0),
                D_in => DD_in,
                Q_in => QQ_in,
                result => aq,
                   zi => tempzi);

cntu : entity work.cntu
  port map(   clk => clk,
              rst => rst,
              st => st,
              zi => tempzi,
               op => tempop,
              rdy => rdy);


end architecture;  



 




