library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit_tb is
-- No ports for the testbench
end ControlUnit_tb;

architecture Behavioral of ControlUnit_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ControlUnit
        port (
            Opcode    : in  STD_LOGIC_VECTOR (5 downto 0);
            RegDst    : out STD_LOGIC;
            Jump      : out STD_LOGIC;
            Branch_E  : out STD_LOGIC;
            Branch_NE : out STD_LOGIC;
            MemRead   : out STD_LOGIC;
            MemtoReg  : out STD_LOGIC;
            ALUOp     : out STD_LOGIC_VECTOR (1 downto 0);
            MemWrite  : out STD_LOGIC;
            ALUSrc    : out STD_LOGIC;
            RegWrite  : out STD_LOGIC
        );
    end component;

    -- Signals to connect to UUT
    signal Opcode    : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
    signal RegDst    : STD_LOGIC;
    signal Jump      : STD_LOGIC;
    signal Branch_E  : STD_LOGIC;
    signal Branch_NE : STD_LOGIC;
    signal MemRead   : STD_LOGIC;
    signal MemtoReg  : STD_LOGIC;
    signal ALUOp     : STD_LOGIC_VECTOR (1 downto 0);
    signal MemWrite  : STD_LOGIC;
    signal ALUSrc    : STD_LOGIC;
    signal RegWrite  : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ControlUnit
        port map (
            Opcode    => Opcode,
            RegDst    => RegDst,
            Jump      => Jump,
            Branch_E  => Branch_E,
            Branch_NE => Branch_NE,
            MemRead   => MemRead,
            MemtoReg  => MemtoReg,
            ALUOp     => ALUOp,
            MemWrite  => MemWrite,
            ALUSrc    => ALUSrc,
            RegWrite  => RegWrite
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: R-type instruction (Opcode = "000000")
        Opcode <= "000000";
        wait for 10 ns;

        -- Test Case 2: lw instruction (Opcode = "100011")
        Opcode <= "100011";
        wait for 10 ns;

        -- Test Case 3: sw instruction (Opcode = "101011")
        Opcode <= "101011";
        wait for 10 ns;

        -- Test Case 4: beq instruction (Opcode = "000100")
        Opcode <= "000100";
        wait for 10 ns;

        -- Test Case 5: bne instruction (Opcode = "000101")
        Opcode <= "000101";
        wait for 10 ns;

        -- Test Case 6: j instruction (Opcode = "000010")
        Opcode <= "000010";
        wait for 10 ns;

        -- Test Case 7: Undefined instruction (Opcode = "111111")
        Opcode <= "111111";
        wait for 10 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
