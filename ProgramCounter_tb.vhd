library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter_tb is
-- No ports for testbench
end ProgramCounter_tb;

architecture Behavioral of ProgramCounter_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ProgramCounter
        port (
            CLK    : in STD_LOGIC;
            Reset  : in STD_LOGIC;
            PC_in  : in STD_LOGIC_VECTOR(31 downto 0);
            PC_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal CLK    : STD_LOGIC := '0';
    signal Reset  : STD_LOGIC := '0';
    signal PC_in  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal PC_out : STD_LOGIC_VECTOR(31 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ProgramCounter
        port map (
            CLK    => CLK,
            Reset  => Reset,
            PC_in  => PC_in,
            PC_out => PC_out
        );

    -- Clock process to generate clock signal
    CLK_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Reset is active, expecting PC_out to reset to zero
        Reset <= '1';
        wait for CLK_PERIOD;
        assert (PC_out = X"00000000") report "Failed: PC_out should be 0x00000000 after reset" severity error;

        -- Test Case 2: Release Reset, load a value into PC_in
        Reset <= '0';
        PC_in <= X"00000004";
        wait for CLK_PERIOD;
        assert (PC_out = PC_in) report "Failed: PC_out should be equal to PC_in (0x00000004) on clock edge" severity error;

        -- Test Case 3: Change PC_in, verify PC_out updates on clock edge
        PC_in <= X"00000008";
        wait for CLK_PERIOD;
        assert (PC_out = PC_in) report "Failed: PC_out should be equal to PC_in (0x00000008) on clock edge" severity error;

        -- Test Case 4: Assert Reset while clock is high, expecting PC_out to reset to zero
        Reset <= '1';
        wait for CLK_PERIOD;
        assert (PC_out = X"00000000") report "Failed: PC_out should reset to 0x00000000 when Reset is asserted" severity error;

        -- Test Case 5: Release Reset and set new PC_in
        Reset <= '0';
        PC_in <= X"0000000C";
        wait for CLK_PERIOD;
        assert (PC_out = PC_in) report "Failed: PC_out should be equal to PC_in (0x0000000C) on clock edge" severity error;

        -- End of test cases
        wait;
    end process;

end Behavioral;
