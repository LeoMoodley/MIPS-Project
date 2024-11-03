library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory_tb is
-- No ports for the testbench
end DataMemory_tb;

architecture Behavioral of DataMemory_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component DataMemory
        port (
            CLK         : in STD_LOGIC;
            Address     : in STD_LOGIC_VECTOR (31 downto 0);
            Write_Data  : in STD_LOGIC_VECTOR (31 downto 0);
            MemRead     : in STD_LOGIC;
            MemWrite    : in STD_LOGIC;
            Read_Data   : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal CLK         : STD_LOGIC := '0';
    signal Address     : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal Write_Data  : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal MemRead     : STD_LOGIC := '0';
    signal MemWrite    : STD_LOGIC := '0';
    signal Read_Data   : STD_LOGIC_VECTOR (31 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: DataMemory
        port map (
            CLK         => CLK,
            Address     => Address,
            Write_Data  => Write_Data,
            MemRead     => MemRead,
            MemWrite    => MemWrite,
            Read_Data   => Read_Data
        );

    -- Clock generation process
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test Case 1: Write data to address 0x00000001
        Address <= X"00000001";
        Write_Data <= X"DEADBEEF";
        MemWrite <= '1';
        MemRead <= '0';
        wait for CLK_PERIOD;

        -- Test Case 2: Write data to address 0x00000002
        Address <= X"00000002";
        Write_Data <= X"CAFEBABE";
        MemWrite <= '1';
        wait for CLK_PERIOD;

        -- Test Case 3: Read from address 0x00000001
        Address <= X"00000001";
        MemWrite <= '0';
        MemRead <= '1';
        wait for CLK_PERIOD;

        -- Test Case 4: Read from address 0x00000002
        Address <= X"00000002";
        wait for CLK_PERIOD;

        -- Test Case 5: Read from an address with initial data (e.g., 0x00000000)
        Address <= X"00000000";
        wait for CLK_PERIOD;

        -- Test Case 6: Write and then read back from address 0x00000003
        Address <= X"00000003";
        Write_Data <= X"12345678";
        MemWrite <= '1';
        MemRead <= '0';
        wait for CLK_PERIOD;

        -- Change to read mode and read back the data
        MemWrite <= '0';
        MemRead <= '1';
        wait for CLK_PERIOD;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
