library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use STD.TEXTIO.all;

entity SecondProcessor is
    Port ( CLK : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           aluresult : out  STD_LOGIC_VECTOR (31 downto 0) := (others =>'0'));
end SecondProcessor;

architecture Behavioral of SecondProcessor is	

	component Adder
	 Port ( op_a : in  STD_LOGIC_VECTOR (31 downto 0);
           op_b : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ProgramCounter
	 Port ( address_in : in  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           address_out : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component InstructionMemory
	 Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));	
	end component;
	
	component ControlUnit
	 Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           aluop : out  STD_LOGIC_VECTOR (5 downto 0));
	end component;
	
	component RegisterFile
	 Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component SignExtensionUnit
	 Port ( data13 : in  STD_LOGIC_VECTOR (12 downto 0);
           data32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component MuxRF_SEUtoALU
	 Port ( crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           imm32 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i : in STD_LOGIC;
           data32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ArithmeticLogicUnit
	 Port ( aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           op_a : in  STD_LOGIC_VECTOR (31 downto 0);
           op_b : in  STD_LOGIC_VECTOR (31 downto 0);
			  carry : in STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ProcessorStateRegister 
    Port ( nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
			  nCWP : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           rst : in  STD_LOGIC;
			  CWP : out STD_LOGIC;
           Carry : out  STD_LOGIC );
	end component;
	
	component PSRModifier
	 Port ( alu_op : in  STD_LOGIC_VECTOR (5 downto 0);
           alu_result : in  STD_LOGIC_VECTOR (31 downto 0);
           op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc_out : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component WindowsManager
	 Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           CWP : in  STD_LOGIC;
           Nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           Nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           Nrd : out  STD_LOGIC_VECTOR (5 downto 0);
           nCWP : out  STD_LOGIC);
	end component;
	
	signal Adder_nPC, nPC_PC, PC_IM, Instruction, Crs1_aux, Crs2_aux, Result_aux, SEU_Imm32, Mux_ALU : std_logic_vector(31 downto 0) := (others => '0');
	signal CU_ALU, Nrs1_aux, Nrs2_aux, Nrd_aux : std_logic_vector(5 downto 0) := (others => '0');
	signal NZVC_out : std_logic_vector(3 downto 0) := (others => '0');
	signal Carry_ALU, CWP_aux, nCWP_aux : std_logic := '0';

begin

	nPC : ProgramCounter
		port map(address_in => Adder_nPC,
					CLK => CLK,
					rst => rst,
					address_out => nPC_PC
		);
		
	ADD : Adder
		port map(op_a => x"00000001",
					op_b => nPC_PC,
					result => Adder_nPC
		);
		
	PC : ProgramCounter
		port map(address_in => nPC_PC,
					CLK => CLK,
					rst => rst,
					address_out => PC_IM
		);
		
	IM : InstructionMemory
		port map(address => PC_IM, 
					rst => rst,
					instruction => Instruction
		);
		
	CU : ControlUnit
		port map(op => Instruction(31 downto 30),
					op3 => Instruction(24 downto 19),
					aluop => CU_ALU
		);
		
	WM : WindowsManager
		port map(op => Instruction(31 downto 30),
					op3 => Instruction(24 downto 19),
					rs1 => Instruction(18 downto 14),
					rs2 => Instruction(4 downto 0),
					rd => Instruction(29 downto 25),
					CWP => CWP_aux,
					Nrs1 => Nrs1_aux,
					Nrs2 => Nrs2_aux,
					Nrd => Nrd_aux,
					nCWP => nCWP_aux
		);
		
	RF : RegisterFile
		port map(rs1 => Nrs1_aux,
					rs2 => Nrs2_aux,
					rd => Nrd_aux,
					rst => rst,
					dwr => Result_aux,
					crs1 => Crs1_aux,
					crs2 => Crs2_aux
		);
		
	SEU : SignExtensionUnit
		port map(data13 => Instruction(12 downto 0),
					data32 => SEU_Imm32
		);
		
	MuxRF_ALU : MuxRF_SEUtoALU
		port map(crs2 => Crs2_aux,
					imm32 => SEU_Imm32,
					i => Instruction(13),
					data32 => Mux_ALU
		);
		
	ALU : ArithmeticLogicUnit
		port map(aluop => CU_ALU,
					op_a => Crs1_aux,
					op_b => Mux_ALU,
					carry => Carry_ALU,
					result => Result_aux
		);
	PSRM : PSRModifier
		port map(alu_op => CU_ALU,
					alu_result => Result_aux,
					op1 => Crs1_aux,
					op2 => Mux_ALU,
					nzvc_out => NZVC_out
		);
		
	PSR : ProcessorStateRegister
		port map(nzvc => NZVC_out,
					nCWP => nCWP_aux,
					CLK => CLK,
					rst => rst,
					CWP => CWP_aux,
					carry => Carry_ALU
		);
	
	aluresult <= Result_aux;
end Behavioral;

