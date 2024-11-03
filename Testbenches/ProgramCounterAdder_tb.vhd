library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounterAdder_tb is
-- No ports for testbench
end ProgramCounterAdder_tb;

architecture Behavioral of ProgramCounterAdder_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ProgramCounterAdder
        port (
            PCA_in  : in STD_LOGIC_VECTOR(31 downto 0);
            PCA_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal PCA_in  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal PCA_out : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ProgramCounterAdder
        port map (
            PCA_in  => PCA_in,
            PCA_out => PCA_out
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: PCA_in = 0, expecting PCA_out = 4
        PCA_in <= X"00000000";
        wait for 10 ns;
        assert (PCA_out = X"00000004") report "Test Case 1 Failed: PCA_out should be 0x00000004" severity error;

        -- Test Case 2: PCA_in = 4, expecting PCA_out = 8
        PCA_in <= X"00000004";
        wait for 10 ns;
        assert (PCA_out = X"00000008") report "Test Case 2 Failed: PCA_out should be 0x00000008" severity error;

        -- Test Case 3: PCA_in = 10, expecting PCA_out = 14
        PCA_in <= X"0000000A";
        wait for 10 ns;
        assert (PCA_out = X"0000000E") report "Test Case 3 Failed: PCA_out should be 0x0000000E" severity error;

        -- Test Case 4: PCA_in = 100, expecting PCA_out = 104
        PCA_in <= X"00000064";
        wait for 10 ns;
        assert (PCA_out = X"00000068") report "Test Case 4 Failed: PCA_out should be 0x00000068" severity error;

        -- Test Case 5: PCA_in = maximum 32-bit value - 4 (0xFFFFFFFC), expecting PCA_out = 0x00000000 (wrap-around behavior)
        PCA_in <= X"FFFFFFFC";
        wait for 10 ns;
        assert (PCA_out = X"00000000") report "Test Case 5 Failed: PCA_out should wrap around to 0x00000000" severity error;

        -- End of test cases
        wait;
    end process;

end Behavioral;
