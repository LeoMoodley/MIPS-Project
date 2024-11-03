library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_tb is
-- No ports for testbench
end RegisterFile_tb;

architecture Behavioral of RegisterFile_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component RegisterFile
        port (
            CLK              : in STD_LOGIC;
            RegWrite         : in STD_LOGIC;
            Read_Register_1  : in STD_LOGIC_VECTOR(4 downto 0);
            Read_Register_2  : in STD_LOGIC_VECTOR(4 downto 0);
            Write_Register   : in STD_LOGIC_VECTOR(4 downto 0);
            Write_Data       : in STD_LOGIC_VECTOR(31 downto 0);
            Read_Data_1      : out STD_LOGIC_VECTOR(31 downto 0);
            Read_Data_2      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal CLK            : STD_LOGIC := '0';
    signal RegWrite       : STD_LOGIC := '0';
    signal Read_Register_1: STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal Read_Register_2: STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal Write_Register : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal Write_Data     : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Read_Data_1    : STD_LOGIC_VECTOR(31 downto 0);
    signal Read_Data_2    : STD_LOGIC_VECTOR(31 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: RegisterFile
        port map (
            CLK            => CLK,
            RegWrite       => RegWrite,
            Read_Register_1 => Read_Register_1,
            Read_Register_2 => Read_Register_2,
            Write_Register => Write_Register,
            Write_Data     => Write_Data,
            Read_Data_1    => Read_Data_1,
            Read_Data_2    => Read_Data_2
        );

    -- Clock generation
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Read initial values in registers $a0 and $a1 (expected to be 0x00000004 and 0x00000005)
        Read_Register_1 <= "00100";  -- Address for $a0
        Read_Register_2 <= "00101";  -- Address for $a1
        wait for CLK_PERIOD;
        assert (Read_Data_1 = X"00000004" and Read_Data_2 = X"00000005")
            report "Test Case 1 Failed: Initial values in $a0 and $a1 incorrect" severity error;

        -- Test Case 2: Write 0x12345678 to register $t0, then read it back
        Write_Register <= "01000";  -- Address for $t0
        Write_Data <= X"12345678";
        RegWrite <= '1';
        wait for CLK_PERIOD;
        RegWrite <= '0';  -- Disable write

        -- Read back value from $t0
        Read_Register_1 <= "01000";  -- Address for $t0
        wait for CLK_PERIOD;
        assert (Read_Data_1 = X"12345678")
            report "Test Case 2 Failed: Write or read back from $t0 incorrect" severity error;

        -- Test Case 3: Write 0xDEADBEEF to register $s0 and read back
        Write_Register <= "10000";  -- Address for $s0
        Write_Data <= X"DEADBEEF";
        RegWrite <= '1';
        wait for CLK_PERIOD;
        RegWrite <= '0';

        -- Read back value from $s0
        Read_Register_1 <= "10000";  -- Address for $s0
        wait for CLK_PERIOD;
        assert (Read_Data_1 = X"DEADBEEF")
            report "Test Case 3 Failed: Write or read back from $s0 incorrect" severity error;

        -- Test Case 4: Verify that register $zero cannot be modified (attempt to write to $zero)
        Write_Register <= "00000";  -- Address for $zero
        Write_Data <= X"FFFFFFFF";
        RegWrite <= '1';
        wait for CLK_PERIOD;
        RegWrite <= '0';

        -- Check if $zero is still 0
        Read_Register_1 <= "00000";  -- Address for $zero
        wait for CLK_PERIOD;
        assert (Read_Data_1 = X"00000000")
            report "Test Case 4 Failed: Register $zero should remain 0" severity error;

        -- End of test cases
        wait;
    end process;

end Behavioral;
