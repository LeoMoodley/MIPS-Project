library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity InstructionMemory is
    port (
        Address     : in  STD_LOGIC_VECTOR(31 downto 0);
        Instruction : out STD_LOGIC_VECTOR(31 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    type Memory is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
    signal IMem : Memory := (others => X"00000000");  -- Initialize with zeros

    -- File declaration for reading the instructions
    file imem_file : text open read_mode is "test.dat";

begin
    -- Process to read instructions from the file and initialize IMem
    load_instructions: process
        variable line_content : line;
        variable hex_instr : STD_LOGIC_VECTOR(31 downto 0);
        variable i : integer := 0;
        variable result, j: integer;
        variable ch: character;
    begin
        -- Read each line and load it into IMem
        while not endfile(imem_file) and i < 16 loop
            -- Read one line from the file
            readline(imem_file, line_content);
            
            -- Report the line read from the file
            report "Read line from file: " & line_content.all;

            -- Initialize hex_instr to all zeros
            hex_instr := (others => '0');

            result := 0;    
            for j in 0 to 7 loop  -- Use 0 to 7 for the loop index
                read(line_content, ch);
                if '0' <= ch and ch <= '9' then 
                    result := character'pos(ch) - character'pos('0');
                elsif 'a' <= ch and ch <= 'f' then
                    result := character'pos(ch) - character'pos('a') + 10;
                elsif 'A' <= ch and ch <= 'F' then  -- Handle uppercase hex
                    result := character'pos(ch) - character'pos('A') + 10;
                else
                    report "Format error on line " & integer'image(i)
                        severity error;
                end if;
                hex_instr(31 - j * 4 downto 28 - j * 4) := std_logic_vector(to_unsigned(result, 4));  -- Convert result to 4-bit
            end loop;

            -- Assign the instruction to the IMem array
            IMem(i) <= hex_instr;  -- Assign the whole hex instruction
            i := i + 1;
        end loop;
        
        wait;  -- End the process after initialization
    end process load_instructions;

    -- Process to output the instruction based on the address
    process (Address)
    begin
        Instruction <= IMem(to_integer(unsigned(Address(5 downto 2))));
    end process;

end Behavioral;


-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity InstructionMemory is
-- 	port (
-- 		Address     : in STD_LOGIC_VECTOR(31 downto 0);
-- 		Instruction : out STD_LOGIC_VECTOR(31 downto 0)
-- 	);
-- end InstructionMemory;

-- architecture Behavioral of InstructionMemory is
-- 	type Memory is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
-- 	signal IMem : Memory := (
-- 		 X"8C410001", -- LW $1, 1(2) --> $1 = MEM (0X02 + 0X01)
-- 										 -- = MEM (03) = 0X33
-- 		 X"00A41822", -- SUB $3, $5, $4 --> $3 = 0X05 - 0X04 = 0X01
-- 		 X"00E61024", -- AND $2, $7, $6 --> $2 = 0X07 AND 0X06 = 0X06
-- 		 X"00852025", -- OR $4, $4, $5 --> $4 = 0X04 OR 0X05 = 0X05
-- 		 X"00C72820", -- ADD $5, $6, $7 --> $5 = 0X06 + 0X07 = 0X0D
-- 		 X"1421FFFA", -- BNE $1, $1, -24 --> BRANCH NOT IF $1=$1
-- 		 X"1022FFFF", -- BEQ $1, $2, -4 --> BRANCH IF $1=$2
-- 		 X"0062302A", -- SLT $6, $3, $2 --> $6 = $3 < $2 = 0X01
-- 											-- = 0X01 < 0X06
-- 		 X"10210002", -- BEQ $1, $1, 2 --> BRANCH IF $1=$1
-- 		 X"00000000", -- NOP --> NOP
-- 		 X"00000000", -- NOP --> NOP
-- 		 X"AC010002", -- SW $1, 2 --> $1 = 0X33 = MEMORY(02)
-- 		 X"00232020", -- ADD $4, $1, $3 --> $4= 0X33 + 0X01 = 0X34
-- 		 X"08000000", -- JUMP 0 --> JUMP TO PC = 00 
-- 		 X"00000000",
-- 		 X"00000000"
-- 	);

-- begin
	
-- 	process (Address)
-- 	begin
-- 		Instruction <= IMem(TO_INTEGER(UNSIGNED(Address)) / 4);
-- 	end process;
	
-- end Behavioral;
