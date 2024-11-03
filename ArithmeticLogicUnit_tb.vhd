library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ArithmeticLogicUnit_tb is
-- Testbench has no ports
end ArithmeticLogicUnit_tb;

architecture Behavioral of ArithmeticLogicUnit_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ArithmeticLogicUnit
        port (
            Input_1      : in  STD_LOGIC_VECTOR(31 downto 0);
            Input_2      : in  STD_LOGIC_VECTOR(31 downto 0);
            ALU_control  : in  STD_LOGIC_VECTOR(3 downto 0);
            ALU_result   : out STD_LOGIC_VECTOR(31 downto 0);
            Zero         : out STD_LOGIC
        );
    end component;

    -- Signals to connect to UUT
    signal Input_1     : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Input_2     : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal ALU_control : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal ALU_result  : STD_LOGIC_VECTOR(31 downto 0);
    signal Zero        : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ArithmeticLogicUnit
        port map (
            Input_1     => Input_1,
            Input_2     => Input_2,
            ALU_control => ALU_control,
            ALU_result  => ALU_result,
            Zero        => Zero
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Addition (ALU_control = "0010")
        Input_1 <= X"00000005";    -- 5 in decimal
        Input_2 <= X"00000003";    -- 3 in decimal
        ALU_control <= "0010";     -- Addition
        wait for 10 ns;
        
        -- Test Case 2: Subtraction (ALU_control = "0110")
        Input_1 <= X"00000008";    -- 8 in decimal
        Input_2 <= X"00000005";    -- 5 in decimal
        ALU_control <= "0110";     -- Subtraction
        wait for 10 ns;

        -- Test Case 3: Bitwise And (ALU_control = "0000")
        Input_1 <= X"0000000F";    -- 15 in decimal
        Input_2 <= X"00000003";    -- 3 in decimal
        ALU_control <= "0000";     -- And
        wait for 10 ns;

        -- Test Case 4: Bitwise Or (ALU_control = "0001")
        Input_1 <= X"0000000F";    -- 15 in decimal
        Input_2 <= X"00000003";    -- 3 in decimal
        ALU_control <= "0001";     -- Or
        wait for 10 ns;

        -- Test Case 5: Set Less Than (ALU_control = "0111", Input_1 < Input_2)
        Input_1 <= X"00000001";    -- 1 in decimal
        Input_2 <= X"00000002";    -- 2 in decimal
        ALU_control <= "0111";     -- Set Less Than
        wait for 10 ns;

        -- Test Case 6: Set Less Than (ALU_control = "0111", Input_1 > Input_2)
        Input_1 <= X"00000002";    -- 2 in decimal
        Input_2 <= X"00000001";    -- 1 in decimal
        ALU_control <= "0111";     -- Set Less Than
        wait for 10 ns;

        -- Test Case 7: Zero Result Test (ALU_control = "0110", Input_1 = Input_2)
        Input_1 <= X"00000003";    -- 3 in decimal
        Input_2 <= X"00000003";    -- 3 in decimal
        ALU_control <= "0110";     -- Subtraction (Result should be zero)
        wait for 10 ns;

        -- Stop the simulation
        wait;
    end process;

end Behavioral;
