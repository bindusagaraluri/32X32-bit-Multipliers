library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mul32x32_t is
end entity;

architecture stru of mul32x32_t is
    component vmul32x32p is
        port (
            X: in UNSIGNED(31 downto 0);
            Y: in UNSIGNED(31 downto 0);
            P: out UNSIGNED(63 downto 0)
        );
    end component;

    signal x_t : UNSIGNED(31 downto 0);
    signal y_t : UNSIGNED(31 downto 0);
    signal p_t : UNSIGNED(63 downto 0);

begin
    uut : vmul32x32p
        port map (
            X => x_t,
            Y => y_t,
            P => p_t
        );

    x_t <= to_unsigned(16#00100100#, 32) after 0 ns,
           to_unsigned(16#00000100#, 32) after 150 ns,
           to_unsigned(16#000030f0#, 32) after 250 ns,
           to_unsigned(16#00010100#, 32) after 350 ns;

    y_t <= to_unsigned(16#10000110#, 32) after 0 ns,
           to_unsigned(16#00000110#, 32) after 150 ns,
           to_unsigned(16#000000e0#, 32) after 250 ns,
           to_unsigned(16#00000110#, 32) after 350 ns;

    timeBomb : process
    begin
        wait for 1000 ns;
        assert false
            report "Simulation ended by SV at " & time'image(now)
            severity failure;
    end process;

end stru;