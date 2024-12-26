library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
 
entity  topmul_t is
generic (
        m : positive := 8;  -- default value for m
        n : positive := 8   -- default value for n
    ); 
end entity;
architecture stru of topmul_t is
 
component topmodule is
  port(  DD_in : in std_logic_vector( m-1 downto 0);
          QQ_in : in std_logic_vector( n-1 downto 0);
         st : in std_logic;
           clk : in std_logic;
          rst : in std_logic;
          rdy : out std_logic;
         aq :  out std_logic_vector(15 downto 0));
end component;
 

  signal  ddin_t :  std_logic_vector(m-1 downto 0):= x"08";
  signal  qqin_t :  std_logic_vector(n-1 downto 0) := x"02";
  signal  clk_t :  std_logic := '0';
  signal  rst_t :  std_logic := '0';
    signal  st_t :  std_logic := '0';
    signal rdy_t :  std_logic ;
     signal  aq_t:  std_logic_vector(15 downto 0);
begin
uut : topmodule port map ( dd_in => ddin_t, qq_in => qqin_t, clk => clk_t, rst => rst_t, st=> st_t, rdy => rdy_t, aq => aq_t);
clk_process : process
begin
clk_t <= '1';
wait for 50 ns;
clk_t <= '0';
wait for 50 ns;
end process;
outputprocess: process
begin
rst_t <= '0';
wait for 50 ns;
rst_t <= '1';
 
st_t <=  '1' ;
ddin_t <= x"f8" ;
 
qqin_t <= x"02";
wait until rdy_t <= '1';
wait for 50 ns;
 
rst_t <= '0';
wait for 50 ns;
rst_t <= '1';
 
st_t <= '0';
wait for 50 ns;
 
st_t <= '1';
ddin_t <= x"09" ;
 
qqin_t <= x"f8" ;
wait until rdy_t <= '1';
 
wait for 50 ns;
 
rst_t <= '0';
wait for 50 ns;
rst_t <= '1';
 
 
st_t <= '0';
wait for 100 ns;
 
st_t <= '1';
ddin_t <= x"01" ;
 
qqin_t <= x"f1" ;
wait until rdy_t <= '1';
wait for 50 ns;
rst_t <= '0';
wait for 50 ns;
rst_t <= '1';
 
st_t <= '0';
wait for 100 ns;
 
st_t <= '1';
      ddin_t <= x"f1" ;
 
qqin_t <= x"f1" ;
wait until rdy_t <= '1';
 
wait for 50 ns;
rst_t <= '0';
wait for 50 ns;
rst_t <= '1';
st_t <= '0';
wait for 50 ns;
st_t <= '1';
      ddin_t <= x"01" ;
 
qqin_t <= x"11" ;
wait until rdy_t <= '1';
end process;
  timeBomb : process 
        begin
	 wait for 5000 ns;
	 assert false
  	report " simulation ended by SV at "&time'image(now)
  	severity failure;
     end process;
end architecture;
