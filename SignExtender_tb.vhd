library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtender_tb is
end SignExtender_tb;

architecture Behavioral of SignExtender_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component SignExtender
        port (
            SE_in  : in  STD_LOGIC_VECTOR(15 downto 0);
            SE_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal SE_in  : STD_LOGIC_VECTOR(15 downto 0);
    signal SE_out : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: SignExtender
        port map (
            SE_in => SE_in,
            SE_out => SE_out
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Positive value
        SE_in <= "0000000000001001";  -- +9
        wait for 10 ns;  -- Wait for output to stabilize
        assert (SE_out = "00000000000000000000000000001001")
            report "Test Case 1 Failed: Incorrect output for +9" severity error;

        -- Test Case 2: Negative value
        SE_in <= "1111111111111001";  -- -7
        wait for 10 ns;
        assert (SE_out = "11111111111111111111111111111001")
            report "Test Case 2 Failed: Incorrect output for -7" severity error;

        -- Test Case 3: Zero value
        SE_in <= "0000000000000000";  -- 0
        wait for 10 ns;
        assert (SE_out = "00000000000000000000000000000000")
            report "Test Case 3 Failed: Incorrect output for 0" severity error;

        -- Test Case 4: All ones (negative value)
        SE_in <= "1111111111111111";  -- -1
        wait for 10 ns;
        assert (SE_out = "11111111111111111111111111111111")
            report "Test Case 4 Failed: Incorrect output for -1" severity error;

        -- End of test cases
        wait;
    end process;

end Behavioral;
