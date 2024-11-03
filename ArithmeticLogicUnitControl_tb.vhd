library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ArithmeticLogicUnitControl_tb is
-- No ports in the testbench
end ArithmeticLogicUnitControl_tb;

architecture Behavioral of ArithmeticLogicUnitControl_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ArithmeticLogicUnitControl
        port (
            ALUC_funct    : in  STD_LOGIC_VECTOR(5 downto 0);
            ALUOp         : in  STD_LOGIC_VECTOR(1 downto 0);
            ALUC_operation: out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal ALUC_funct    : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal ALUOp         : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal ALUC_operation: STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ArithmeticLogicUnitControl
        port map (
            ALUC_funct     => ALUC_funct,
            ALUOp          => ALUOp,
            ALUC_operation => ALUC_operation
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: ALUOp = "00", ALUC_funct = "000000"
        ALUOp <= "00";
        ALUC_funct <= "000000";
        wait for 10 ns;

        -- Test Case 2: ALUOp = "01", ALUC_funct = "100100"
        ALUOp <= "01";
        ALUC_funct <= "100100";
        wait for 10 ns;

        -- Test Case 3: ALUOp = "10", ALUC_funct = "100000" (e.g., ADD operation in R-type)
        ALUOp <= "10";
        ALUC_funct <= "100000";
        wait for 10 ns;

        -- Test Case 4: ALUOp = "10", ALUC_funct = "100010" (e.g., SUBTRACT operation in R-type)
        ALUOp <= "10";
        ALUC_funct <= "100010";
        wait for 10 ns;

        -- Test Case 5: ALUOp = "10", ALUC_funct = "101010" (e.g., SLT operation in R-type)
        ALUOp <= "10";
        ALUC_funct <= "101010";
        wait for 10 ns;

        -- Test Case 6: ALUOp = "10", ALUC_funct = "100101" (e.g., OR operation in R-type)
        ALUOp <= "10";
        ALUC_funct <= "100101";
        wait for 10 ns;

        -- Test Case 7: ALUOp = "11", ALUC_funct = "110000" (testing different ALUOp with funct)
        ALUOp <= "11";
        ALUC_funct <= "110000";
        wait for 10 ns;

        -- Add more cases as needed for thorough testing

        -- Stop simulation
        wait;
    end process;

end Behavioral;
