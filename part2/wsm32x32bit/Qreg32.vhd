library ieee;
use ieee.std_logic_1164.all;

entity Q_register is
    generic (
        n : integer := 32
    );
    port (
        clk : in std_logic;                      
        op  : in std_logic_vector(6 downto 0);
        f0  : in std_logic;                      
        Q0  : in std_logic_vector(n-1 downto 0);   
        Qn_l : out std_logic_vector(n downto 0); 
        q0_l : out std_logic_vector(1 downto 0)  
    );
end Q_register;

architecture behavioral of Q_register is
    signal Qop : std_logic_vector(1 downto 0);
    signal Qn_l_int : std_logic_vector(n downto 0);
begin
    Qop <= op(3 downto 2);

    process(clk)
    begin
        if (clk'event and clk = '1') then
            if (Qop = "00") then
                Qn_l_int <= Qn_l_int; 
            elsif (Qop = "01") then
                Qn_l_int <= f0 & Qn_l_int(n downto 1);
            elsif (Qop = "10" or Qop = "11") then
                Qn_l_int <= Q0 & '0';
            end if;
        end if;
    end process;
    Qn_l <= Qn_l_int;
    q0_l <= Qn_l_int(1 downto 0);

end behavioral;

