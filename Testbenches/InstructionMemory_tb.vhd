library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory_tb is
-- No ports for the testbench
end InstructionMemory_tb;

architecture Behavioral of InstructionMemory_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component InstructionMemory
        port (
            Address     : in STD_LOGIC_VECTOR(31 downto 0);
            Instruction : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal Address     : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Instruction : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: InstructionMemory
        port map (
            Address     => Address,
            Instruction => Instruction
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Read instruction from address 0x00000000
        Address <= X"00000000";
        wait for 10 ns;
        assert (Instruction /= X"00000000") report "Failed: Instruction at 0x00000000 expected to be loaded from file." severity failure;

        -- Test Case 2: Read instruction from address 0x00000004
        Address <= X"00000004";
        wait for 10 ns;
        assert (Instruction /= X"00000000") report "Failed: Instruction at 0x00000004 expected to be loaded from file." severity failure;

        -- Test Case 3: Read instruction from address 0x00000008
        Address <= X"00000008";
        wait for 10 ns;
        assert (Instruction /= X"00000000") report "Failed: Instruction at 0x00000008 expected to be loaded from file." severity failure;

        -- Test Case 4: Read instruction from address 0x0000000C
        Address <= X"0000000C";
        wait for 10 ns;
        assert (Instruction /= X"00000000") report "Failed: Instruction at 0x0000000C expected to be loaded from file." severity failure;

        -- Test Case 5: Read instruction from address 0x00000010
        Address <= X"00000010";
        wait for 10 ns;
        assert (Instruction /= X"00000000") report "Failed: Instruction at 0x00000010 expected to be loaded from file." severity failure;

        -- Test Case 6: Read instruction from an address beyond initialized values, expect default behavior (e.g., 0x00000000 or an uninitialized state)
        Address <= X"00000040";
        wait for 10 ns;
        assert (Instruction = X"00000000") report "Failed: Instruction at 0x00000040 should default to zero." severity failure;

        -- Stop the simulation after tests are complete
        wait;
    end process;

end Behavioral;
