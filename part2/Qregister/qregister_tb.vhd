library ieee;
use ieee.std_logic_1164.all;

entity Q_register_tb is
end entity;

architecture tb of Q_register_tb is
    -- Component Declaration
    component Q_register
        generic (
            n : integer := 7  -- Match the default value of `n`
        );
        port (
            clk : in std_logic;
            op  : in std_logic_vector(3 downto 0); -- Match the 4-bit `op` signal
            f0  : in std_logic;
            Q0  : in std_logic_vector(7 downto 0); -- Match the 8-bit `Q0`
            Qn_l : out std_logic_vector(7 downto 0); -- Match the 8-bit `Qn_l`
            q0_l : out std_logic_vector(1 downto 0) -- Match the 2-bit `q0_l`
        );
    end component;

    -- Signal Declarations
    signal clk_tb : std_logic := '0';
    signal op_tb  : std_logic_vector(3 downto 0) := "0000"; -- Correct width
    signal Q0_tb  : std_logic_vector(7 downto 0) := "00000000";
    signal f0_tb  : std_logic := '0';
    signal Qn_l_tb : std_logic_vector(7 downto 0); -- 8-bit output
    signal q0_l_tb : std_logic_vector(1 downto 0); -- 2-bit output

    constant period : time := 100 ns;

begin
    -- Unit Under Test (UUT)
    uut: Q_register
        port map (
            clk => clk_tb,
            op  => op_tb,
            f0  => f0_tb,
            Q0  => Q0_tb,
            Qn_l => Qn_l_tb,
            q0_l => q0_l_tb
        );

    -- Clock Generation
    clk_tb <= not clk_tb after period / 2;

    -- Stimuli Process
    stim_process: process
    begin
        -- Initialize Signals
        op_tb <= "0000"; -- Hold operation
        Q0_tb <= (others => '0');
        f0_tb <= '0';
        wait for 200 ns;

        -- Load Operation
        op_tb <= "1010"; -- Load operation
        Q0_tb <= "10101010"; -- Load value into the register
        wait for 200 ns;

        -- Shift Operation
        op_tb <= "0101"; -- Shift operation
        f0_tb <= '1'; -- Shift in a '1'
        wait for 200 ns;

        -- Hold Operation
        op_tb <= "0000";
        wait for 200 ns;

        -- End Simulation
        wait;
    end process;

end architecture;

