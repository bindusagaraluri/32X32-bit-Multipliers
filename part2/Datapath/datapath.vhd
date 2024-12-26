library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity datapath_unit is
    generic (
        n : integer := 8  -- Data width
    );
    port (
        clk    : in  std_logic;                       -- Clock signal
        rst    : in  std_logic;                       -- Reset signal
        op     : in  std_logic_vector(6 downto 0);    -- Control signals
        D_in : in  std_logic_vector(n-1 downto 0);  -- Input to D-register
        Q_in  : in std_logic_vector(n-1 downto 0);  -- Output of Q-register
       -- A_out  : out std_logic_vector(n-1 downto 0);  -- Output of A-register
        result : out std_logic_vector(15 downto 0) ;    -- ALU result
           zi : out std_logic
    );
end datapath_unit;

architecture behavioral of datapath_unit is
    -- Signals to connect internal components
    signal D_reg_out : std_logic_vector(n-1 downto 0);
    signal A_reg_out : std_logic_vector(n-1 downto 0);
    signal Q_reg_out : std_logic_vector(n downto 0);
    signal alu_out   : std_logic_vector(n-1 downto 0);


    -- Control signals
    signal D_op  : std_logic;
    signal A_op  : std_logic_vector(1 downto 0);
    signal Q_op  : std_logic_vector(1 downto 0);

    -- Intermediate connections
   signal shift_in : std_logic_vector(1 downto 0);
begin
    -- Extract control signals from op
    D_op  <= op(6);
    A_op  <= op(5 downto 4);
    Q_op  <= op(3 downto 2);

    -- Instantiate D-register
    D_register: entity work.D_register
        --generic map (n => n)
        port map (
            clk => clk,
            --rst => rst,
            op  => op,
            DD => D_in,
            D => D_reg_out
        );

    -- Instantiate A-register
    A_register: entity work.A_register
        --generic map (n => n)
        port map (
            clk => clk,
            op  => op,
            F   => alu_out(n-1 downto 0),
            A   => A_reg_out
        );

    -- Instantiate Q-register
    Q_register: entity work.Q_register
        --generic map (n => n)
        port map (
            clk   => clk,
            op    => op,
            f0    => alu_out(0),
            Q0    => Q_in,
            Qn_l  => Q_reg_out,
            q0_l  => shift_in
        );

    -- Instantiate ALU
    alu: entity work.alu
        --generic map (n => n)
        port map (
            A => A_reg_out,
            B => D_reg_out,
            q0_1 => shift_in,
            F    => alu_out
        );

 cnt : entity work.cnt
   -- generic(n : INTEGER := 8);
      port map(clk => clk,
           op => op,
	     zI => zi
	      );

    -- Outputs
   -- Q_out  <= Q_reg_out;
   -- A_out  <= A_reg_out;
    result <= A_reg_out & Q_reg_out(n downto 1);
end behavioral;

