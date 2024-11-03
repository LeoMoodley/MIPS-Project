library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftLefter_tb is
end ShiftLefter_tb;

architecture Behavioral of ShiftLefter_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ShiftLefter
        generic (
            N : integer := 2;
            W : integer := 32
        );
        port (
            SL_in  : in  STD_LOGIC_VECTOR(W - 1 downto 0);
            SL_out : out STD_LOGIC_VECTOR(W - 1 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal SL_in  : STD_LOGIC_VECTOR(31 downto 0);
    signal SL_out : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ShiftLefter
        generic map (
            N => 2,
            W => 32
        )
        port map (
            SL_in => SL_in,
            SL_out => SL_out
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Shift a simple pattern
        SL_in <= "00000000000000000000000000001111";  -- Input pattern
        wait for 10 ns;  -- Wait for the output to settle
        assert (SL_out = "00000000000000000000000000111100")  -- Expect shifting left by 2
            report "Test Case 1 Failed: Incorrect output for input 00000000000000000000000000001111" severity error;

        -- Test Case 2: Shift with leading zeros
        SL_in <= "00000000000000000000000000000001";  -- Input pattern
        wait for 10 ns;
        assert (SL_out = "00000000000000000000000000000100")  -- Expect shifting left by 2
            report "Test Case 2 Failed: Incorrect output for input 00000000000000000000000000000001" severity error;

        -- Test Case 3: Shift all ones
        SL_in <= "11111111111111111111111111111111";  -- Input pattern
        wait for 10 ns;
        assert (SL_out = "11111111111111111111111111111100")  -- Expect shifting left by 2
            report "Test Case 3 Failed: Incorrect output for input 11111111111111111111111111111111" severity error;

     
        -- Test Case 5: Shift with maximum W
        SL_in <= "00000000000000000000000000000001";  -- Input pattern
        wait for 10 ns;
        assert (SL_out = "00000000000000000000000000000100")  -- Expect shifting left by 2
            report "Test Case 5 Failed: Incorrect output for input with maximum W" severity error;

        -- End of test cases
        wait;
    end process;

end Behavioral;
