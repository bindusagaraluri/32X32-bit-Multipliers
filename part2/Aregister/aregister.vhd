library ieee;
use ieee.std_logic_1164.all;

entity A_register is
    generic (
        m : integer := 8
    );
    port (
        clk : in std_logic;
        op  : in std_logic_vector(6 downto 0);
        F   : in std_logic_vector(m downto 1);
        A   : out std_logic_vector(m-1 downto 0)
    );
end entity;

architecture behavioral of A_register is
    signal Aop : std_logic_vector(1 downto 0);
    signal A_internal : std_logic_vector(m-1 downto 0); -- Internal signal
begin
    Aop <= op(5 downto 4);

    process(clk)
    begin
        if rising_edge(clk) then -- Use rising_edge for better clarity
            if (Aop = "00") then
                A_internal <= A_internal; -- Hold current value
            elsif (Aop = "01") then
                A_internal <= F(8) & F(8 downto 2); -- Shift operation
            elsif (Aop = "10" or Aop = "11") then
                A_internal <= (others => '0'); -- Reset
            end if;
        end if;
    end process;

    -- Assign the internal signal to the output port
    A <= A_internal;
end architecture;
