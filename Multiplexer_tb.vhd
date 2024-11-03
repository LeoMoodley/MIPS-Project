library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer_tb is
-- No ports for the testbench
end Multiplexer_tb;

architecture Behavioral of Multiplexer_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component Multiplexer
        generic (
            N : integer := 32
        );
        port (
            MUX_in_0   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
            MUX_in_1   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
            MUX_select : in  STD_LOGIC;
            MUX_out    : out STD_LOGIC_VECTOR(N - 1 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal MUX_in_0   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal MUX_in_1   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal MUX_select : STD_LOGIC := '0';
    signal MUX_out    : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Multiplexer
        generic map (
            N => 32
        )
        port map (
            MUX_in_0   => MUX_in_0,
            MUX_in_1   => MUX_in_1,
            MUX_select => MUX_select,
            MUX_out    => MUX_out
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: MUX_select = '0', expecting MUX_out = MUX_in_0
        MUX_in_0 <= X"AAAAAAAA";
        MUX_in_1 <= X"55555555";
        MUX_select <= '0';
        wait for 10 ns;
        assert (MUX_out = MUX_in_0) report "Failed: MUX_out should be equal to MUX_in_0 when MUX_select = '0'" severity error;

        -- Test Case 2: MUX_select = '1', expecting MUX_out = MUX_in_1
        MUX_select <= '1';
        wait for 10 ns;
        assert (MUX_out = MUX_in_1) report "Failed: MUX_out should be equal to MUX_in_1 when MUX_select = '1'" severity error;

        -- Test Case 3: Change MUX_in_0 while MUX_select = '0'
        MUX_select <= '0';
        MUX_in_0 <= X"12345678";
        wait for 10 ns;
        assert (MUX_out = MUX_in_0) report "Failed: MUX_out should be equal to updated MUX_in_0 when MUX_select = '0'" severity error;

        -- Test Case 4: Change MUX_in_1 while MUX_select = '1'
        MUX_select <= '1';
        MUX_in_1 <= X"87654321";
        wait for 10 ns;
        assert (MUX_out = MUX_in_1) report "Failed: MUX_out should be equal to updated MUX_in_1 when MUX_select = '1'" severity error;

        -- Test Case 5: MUX_select switching from '0' to '1'
        MUX_in_0 <= X"DEADBEEF";
        MUX_in_1 <= X"CAFEBABE";
        MUX_select <= '0';
        wait for 10 ns;
        assert (MUX_out = MUX_in_0) report "Failed: MUX_out should be MUX_in_0 just before select changes to '1'" severity error;
        
        MUX_select <= '1';
        wait for 10 ns;
        assert (MUX_out = MUX_in_1) report "Failed: MUX_out should switch to MUX_in_1 after select changes to '1'" severity error;

        -- End of test cases
        wait;
    end process;

end Behavioral;
