library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath_unit_tb is
end entity;

architecture tb of datapath_unit_tb is
    constant n : integer := 8;  -- Data width

    -- DUT signals
    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '0';
    signal op_tb     : std_logic_vector(6 downto 0) := (others => '0');
    signal D_in_tb   : std_logic_vector(n-1 downto 0) := (others => '0');
    signal Q_in_tb   : std_logic_vector(n-1 downto 0) := (others => '0');
    signal result_tb : std_logic_vector(15 downto 0);
    signal zi_tb     : std_logic;

    constant clk_period : time := 20 ns;
begin
    -- Instantiate DUT
    uut: entity work.datapath_unit
        generic map (n => n)
        port map (
            clk    => clk_tb,
            rst    => rst_tb,
            op     => op_tb,
            D_in   => D_in_tb,
            Q_in   => Q_in_tb,
            result => result_tb,
            zi     => zi_tb
        );

    -- Clock generation
    clk_process: process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Test stimulus
    stimulus_process: process
    begin
        -- Reset
        rst_tb <= '1';
        wait for clk_period;
        rst_tb <= '0';

        -- Test 1: Load data into D-register and Q-register
        D_in_tb <= x"55";
        op_tb <= "1100000"; -- Load D-register
        wait for clk_period;

        op_tb <= "0010100"; -- Load Q-register
        wait for clk_period;

        -- Test 2: Perform ALU operation
        op_tb <= "0001001"; -- Example ALU operation
        wait for clk_period;

        -- Test 3: Shift Q-register
        op_tb <= "0000110"; -- Shift Q-register
        wait for clk_period;

        -- End simulation
        wait for clk_period * 5;
        assert false
        report "Simulation ended successfully"
        severity failure;
    end process;

end tb;
