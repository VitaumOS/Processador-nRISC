module nRisc(
    input wire CLK,
    input wire RESET 
		
);


	wire [7:0] PC_Atual;             
	wire [7:0] PC_Somado;          
	wire [7:0] Instrucao_Lida;       
	wire [7:0] BancoReg_A;       
	wire [7:0] BancoReg_B;       
	wire [7:0] Extensor_Out3;
	wire [7:0] Extensor_Out5;
	wire [7:0] ULA_Data1_MuxOut;     
	wire [7:0] ULA_Data2_MuxOut;     
	wire [7:0] ULA_Saida;              
	wire [7:0] Memoria_Saida;          
	wire [7:0] Dado_Escrito_Banco;   
	wire [7:0] PC_Branch_Target;     
	wire [7:0] PC_MUX_Branch_Out;    
	wire [7:0] novo_PC;     

	// Sinais de Controle (Unidade de Controle)
	wire RegDst, RegWrite, MemRead, MemWrite, Branch, Jump, ULASrc, Halt;
	wire [1:0] ULAOp; 
	
	wire [1:0] ULA_Control;          
	
	wire Cond_ULA;                 
	wire Cond_Atual;                 
	
	wire Branch_Cond;            

	// Extração dos campos da instrução 
	wire [2:0] Opcode = 	Instrucao_Lida[7:5];  
	wire 		  Funct = 	  Instrucao_Lida[0];    
	wire [1:0] Reg1 = 	Instrucao_Lida[4:3];  // Endereço de Leitura A (2 bits)
	wire [1:0] Reg2 = 	Instrucao_Lida[2:1];  // Endereço de Leitura B / Destino (2 bits)
	wire [4:0] Target = 	Instrucao_Lida[4:0];  //Target (5 bits)
	wire [2:0] Imm3 = 	Instrucao_Lida[2:0];  // Imediato (2 bits)


	PC PC(.clk(CLK), .reset(RESET), .novo_PC(novo_PC), .pc_atual(PC_Atual));


	Somador Somador(.d1(PC_Atual), .d2(8'd1), .saida(PC_Somado));


	Memoria_Instrucao InstrMem(.clk(CLK), .reset(RESET), .endereco(PC_Atual), .instrucao_saida(Instrucao_Lida));

	Unidade_Controle UC(
		.Opcode(Opcode), .Funct(Funct),
		.RegDst(RegDst), .RegWrite(RegWrite), .MemRead(MemRead), 
		.MemWrite(MemWrite), .Branch(Branch), .Jump(Jump), 
		.ULASrc(ULASrc), .Halt(Halt), .ULAOp(ULAOp)
	);

	Banco_Registradores BancoReg(
		.clk(CLK), .reset(RESET), 
		.habilita_escrita(RegWrite), 
		.endereco_leitura_A(Reg1), 
		.endereco_leitura_B(Reg2),
		.endereco_escrita(Reg1), 
		.dado_escrita(Dado_Escrito_Banco), 
		.dado_leitura_A(BancoReg_A), 
		.dado_leitura_B(BancoReg_B)
	);
	
	
	Extensor_Sinal_5b8 Ext5(.entrada(Target), .saida(Extensor_Out5));
	Extensor_Sinal_3b8 Ext3(.entrada(Imm3), .saida(Extensor_Out3));


	MUX Mux_ALUSrc1(.d1(8'b00), .d2(BancoReg_A), .seletor(ULASrc), .saida(ULA_Data1_MuxOut));
	MUX Mux_ALUSrc2(.d1(Extensor_Out3), .d2(BancoReg_B), .seletor(ULASrc), .saida(ULA_Data2_MuxOut));
	MUX Mux_RegDst(.d1(ULA_Saida), .d2(Memoria_Saida), .seletor(RegDst), .saida(Dado_Escrito_Banco));
	MUX Mux_Branch(.d1(Extensor_Out5), .d2(PC_Somado), .seletor(Branch_Cond), .saida(PC_MUX_Branch_Out));
	MUX Mux_Jump(.d1(Extensor_Out5), .d2(PC_MUX_Branch_Out), .seletor(Jump), .saida(novo_PC));


	ULA_Controle ULA_CTRL(.ULAOp(ULAOp), .Funct(Funct), .ULA_Control(ULA_Control));

	ULA ULA1(
		.d1(ULA_Data1_MuxOut), 
		.d2(ULA_Data2_MuxOut), 
		.ULA_Control(ULA_Control),
		.Resultado(ULA_Saida), 
		.COND(Cond_ULA) 
	);
	
	Porta_AND AND_Reset_Cond (.d1(Branch), .d2(Cond_Atual), .saida(Branch_Cond));
	
	Registrador_COND Reg_COND(
		.clk(CLK), 
		.reset(RESET), 
		.cond_ULA(Cond_ULA), 
		.reset_cond(Branch_Cond), 
		.cond_atual(Cond_Atual)
	);
	
	Memoria_Dados DataMem(
		.clk(CLK), .reset(RESET), 
		.habilita_escrita(MemWrite), 
		.habilita_leitura(MemRead), 
		.endereco(BancoReg_B), 
		.dado_entrada(BancoReg_A), 
		.dado_saida(Memoria_Saida)
	);


	

endmodule