library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use STD.TEXTIO.all;

entity ThirdProcessor is
    Port ( CLK : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           aluresult : out  STD_LOGIC_VECTOR (31 downto 0) := (others =>'0'));
end ThirdProcessor;

architecture Behavioral of ThirdProcessor is	

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
			  op2 : in STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  icc : in STD_LOGIC_VECTOR (3 downto 0);
			  cond : in STD_LOGIC_VECTOR (3 downto 0);
			  rfs : out STD_LOGIC_VECTOR (1 downto 0);
			  rfd : out STD_LOGIC;
			  PCs : out STD_LOGIC_VECTOR (1 downto 0);
			  DMwen : out STD_LOGIC;
			  DMren : out STD_LOGIC;
			  RFwen : out STD_LOGIC;
			  --CLK : in STD_LOGIC;
           aluop : out  STD_LOGIC_VECTOR (5 downto 0));
	end component;
	
	component RegisterFile
	 Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
			  wen : in STD_LOGIC;
			  --CLK : in STD_LOGIC;
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  crd : out STD_LOGIC_VECTOR (31 downto 0));
			  
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
	
	component DataMemory 
    Port ( cRD : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           WEn : in  STD_LOGIC;
           REn : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           Data : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	
	component MuxDM_ALUtoRF
    Port ( DM : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFs : in  STD_LOGIC_VECTOR (1 downto 0);
           Data : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ProcessorStateRegister 
    Port ( nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
			  nCWP : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           rst : in  STD_LOGIC;
			  CWP : out STD_LOGIC;
           Carry : out  STD_LOGIC;
			  icc : out STD_LOGIC_VECTOR (3 downto 0));
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
	
	component SEU22 
    Port ( Data22 : in  STD_LOGIC_VECTOR (21 downto 0);
           Data32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component SEU30 
    Port ( Data30 : in  STD_LOGIC_VECTOR (29 downto 0);
           Data32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component MuxWM_15toRF 
    Port ( rd : in  STD_LOGIC_VECTOR (5 downto 0);
           reg : in  STD_LOGIC_VECTOR (5 downto 0);
			  rfd : in STD_LOGIC;
           nrd : out  STD_LOGIC_VECTOR (5 downto 0));
	end component;
	
	component MuxCUtoPC 
    Port ( PC30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           AluPC : in  STD_LOGIC_VECTOR (31 downto 0);
           PCs : in  STD_LOGIC_VECTOR (1 downto 0);
           nPC : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal PC22_aux, PC30_aux, nPC_aux, SEU22_aux, SEU30_aux, PC30, PC22, Adder_nPC, nPC_PC, PC_IM, Instruction, Crs1_aux, Crs2_aux, Result_aux, SEU_Imm32, Mux_ALU, Mux_RF, cRD_aux, DDM_aux : std_logic_vector(31 downto 0) := (others => '0');
	signal CU_ALU, Nrs1_aux, Nrs2_aux, Nrd_aux, rd_aux : std_logic_vector(5 downto 0) := (others => '0');
	signal NZVC_out, icc_aux : std_logic_vector(3 downto 0) := (others => '0');
	signal PCs_aux, rfs_aux : std_logic_vector(1 downto 0) := "00";
	signal rfd_aux, Carry_ALU, CWP_aux, nCWP_aux, WEn_aux, REn_aux, RFWen_aux : std_logic := '0';

begin

	nPC : ProgramCounter
		port map(address_in => nPC_aux,
					CLK => CLK,
					rst => rst,
					address_out => nPC_PC
		);
		
	ADD : Adder
		port map(op_a => x"00000001",
					op_b => nPC_PC,
					result => Adder_nPC
		);
		
	ADD22 : Adder
		port map(op_a => SEU22_aux,
					op_b => PC_IM,
					result => PC22
		);
		
	ADD30 : Adder
		port map(op_a => SEU30_aux,
					op_b => PC_IM,
					result => PC30
		);
		
	SEU_22 : SEU22
		port map(Data22 => Instruction(21 downto 0),
					Data32 => SEU22_aux
		);
		
	SEU_30 : SEU30
		port map(Data30 => Instruction(29 downto 0),
					Data32 => SEU30_aux
		);
		
	MuxPC : MuxCUtoPC
		port map(PC30 => PC30,
					PC22 => PC22,
					PC => Adder_nPC,
					AluPC => Result_aux,
					PCs => PCs_aux,
					nPC => nPC_aux
		);
		
	MuxRF : MuxWM_15toRF
		port map(rd => Nrd_aux,
					reg => "001111",
					rfd => rfd_aux,
					nrd => rd_aux
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
					op2 => Instruction(24 downto 22),
					op3 => Instruction(24 downto 19),
					icc => icc_aux,
				   cond => Instruction(28 downto 25),
					rfs => rfs_aux,
					rfd => rfd_aux,
					PCs => PCs_aux,
					DMwen => WEn_aux,
					DMren => REn_aux,
					RFwen => RFWen_aux,
					--CLK => CLK,
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
					rd => rd_aux,
					rst => rst,
					wen => RFWEn_aux,
					dwr => Mux_RF,
					crs1 => Crs1_aux,
					crs2 => Crs2_aux,
					--CLK => CLK,
					crd => cRD_aux
					
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
		
	MuxDM_ALU : MuxDM_ALUtoRF
		port map(DM => DDM_aux,
					AluResult => Result_aux,
					PC => PC_IM,
					RFs => rfs_aux,
					Data => Mux_RF
		);
		
	DM : DataMemory
		port map(cRD => cRD_aux,
					AluResult => Result_aux,
					WEn => WEn_aux,
					REn => REn_aux,
					rst => rst,
					CLK => CLK,
					Data => DDM_aux
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
					carry => Carry_ALU,
					icc => icc_aux					
		);
	
	aluresult <= Result_aux;
end Behavioral;


