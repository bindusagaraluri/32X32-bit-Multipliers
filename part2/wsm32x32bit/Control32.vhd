library ieee ;
use ieee.std_logic_1164.all ;

entity cntu is
	PORT ( clk: IN STD_LOGIC;
	       rst: IN STD_LOGIC;
	       st : IN STD_LOGIC;
	       zi : IN STD_LOGIC;
	       op : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	      rdy : OUT STD_LOGIC
	     );
END cntu ;

architecture behv OF cntu is
	
	SIGNAL stt   : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
	SIGNAL nxtSt : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
	CONSTANT SI : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00" ;
	CONSTANT SM : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01" ;
	CONSTANT SF : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10" ;	
	SIGNAL Aop : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL Qop : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL Sop : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL Dop : STD_LOGIC;
	CONSTANT loadD : STD_LOGIC := '1' ;
	CONSTANT nopD  : STD_LOGIC := '0' ;
	CONSTANT nop   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00" ;
	CONSTANT ldAshr: STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
	CONSTANT shrQ  : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
	CONSTANT cnt   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
	CONSTANT reset : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";
	CONSTANT load  : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";

begin
clkd: PROCESS ( clk, rst)
	begin
		if (rst = '0') then
			stt <= SI; 
		elsif ( clk'EVENT AND clk = '1' AND clk'LAST_VALUE = '0' ) then
			stt <= nxtSt; 
		end if ;
end process clkd ;
stm: PROCESS ( stt, st, zi )
	begin
		nxtSt <= stt ;
		Dop <= nopD ;
		Aop <= nop ;
		Qop <= nop ;
		Sop <= nop ;
		rdy <= '0' ;
	CASE stt is
		when SI => 
			rdy <= '0';
			Dop <= loadD; 
			Aop <= reset; 
			Qop <= load;  
			Sop <= reset; 

				if (st = '1') then 
					nxtSt <= SM; 
				elsif(st = '0') then
					nxtSt <= SI; 
				end if;
		when SM =>  
			Aop <= ldAshr; 
			Qop <= shrQ;   
			Sop <= cnt;    
				if (zi = '1') then 
					nxtSt <= SF; 
				elsif (zi = '0') then
					nxtSt <= SM;
				end if;

		WHEN OTHERS => 
			rdy <= '1'; 
				if (st = '0') then 
					nxtSt <= SI; 
				elsif (st = '1') then
					nxtSt <= SF;
				end if;
	end case;
end process stm;
op(6) <= Dop ;     	
op(5 DOWNTO 4) <= Aop ; 
op(3 DOWNTO 2) <= Qop ;	
op(1 DOWNTO 0) <= Sop ;	

END behv;
