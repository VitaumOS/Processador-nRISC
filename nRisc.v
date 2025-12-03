module nRisc(
    input wire CLK,
    input wire RESET 
		
);
	
	//Interconexões entre os módulos
	wire [7:0] PC_Atual;             
	wire [7:0] PC_Somado;          
	wire [7:0] Instrucao;       
	wire [7:0] Dado1;       
	wire [7:0] Dado2;       
	wire [7:0] Extensor_Out3;
	wire [7:0] Extensor_Out5;
	wire [7:0] ULA_d1;     
	wire [7:0] ULA_d2;     
	wire [7:0] ULA_Saida;              
	wire [7:0] Memoria_Saida;          
	wire [7:0] Dado_Escreve_Banco;   
	wire [7:0] PC_Branch_Target;     
	wire [7:0] PC_MUX_Branch_Out;    
	wire [7:0] novo_PC;     

	// Sinais de Controle
	wire RegDst, RegWrite, MemRead, MemWrite, Branch, Jump, ULASrc, Halt;
	wire [1:0] ULAOp; 
	
	wire [1:0] ULA_Control;          
	
	//Interconexao do COND
	wire Cond_ULA;                 
	wire Cond_Atual;                 
	wire Branch_Cond;            

	//Separando cada parte da Instrucao
	wire [2:0] Opcode = 	Instrucao[7:5];  // Opcode da Instrucao
	wire 		  Funct = 	  Instrucao[0];  // Funct  
	wire [1:0] Reg1 = 	Instrucao[4:3];  // Endereço de Leitura A 
	wire [1:0] Reg2 = 	Instrucao[2:1];  // Endereço de Leitura B 
	wire [4:0] Target = 	Instrucao[4:0];  // Target 
	wire [2:0] Imm3 = 	Instrucao[2:0];  // Imediato 
	
	
	// Módulo do PC: Recebe o novo_PC e atualiza o atual
	PC PC(.clk(CLK), .reset(RESET), .novo_PC(novo_PC), .pc_atual(PC_Atual));

	//Somador: Soma mais um ao PC
	Somador Somador(.d1(PC_Atual), .d2(8'd1), .saida(PC_Somado));

	//Memória de Instrucao: recebe o PC e, a partir dele, envia a nova instrucao para o processador
	Memoria_Instrucao Mem_Inst(.clk(CLK), .reset(RESET), .endereco(PC_Atual), .instrucao_saida(Instrucao));
	
	//Unidade de Controle: Baseado no valor do Opcode e Funct, define quais sinais serão ativados
	Unidade_Controle UC(
		.Opcode(Opcode), 
		.Funct(Funct),
		.RegDst(RegDst), 
		.RegWrite(RegWrite), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.Branch(Branch), 
		.Jump(Jump), 
		.ULASrc(ULASrc), 
		.Halt(Halt), 
		.ULAOp(ULAOp)
	);
	
	//Banco de Registradores: Envia os registradores a partir dos endereços de entrada 
	//e escreve no registrador destino (Reg1) caso o habilita_escrita esteja ativado
	Banco_Registradores BancoReg(
		.clk(CLK), .reset(RESET), 
		.habilita_escrita(RegWrite), 
		.endereco_leitura_A(Reg1), 
		.endereco_leitura_B(Reg2),
		.endereco_escrita(Reg1), 
		.dado_escrita(Dado_Escreve_Banco), 
		.dado_leitura_A(Dado1), 
		.dado_leitura_B(Dado2)
	);
	
	//Extensores de sinal de 3 e 5 bits para 8 bits: extende ambos os sinais para 8 bits
	Extensor_Sinal_5b8 Ext5(.entrada(Target), .saida(Extensor_Out5));
	Extensor_Sinal_3b8 Ext3(.entrada(Imm3), .saida(Extensor_Out3));
	
	//MUX ALUSrc: baseado no valor de ULASrc, define se o valor que será enviado para a 
	//ULA sera o valor extendido ou os valores dos registradores do Banco de Registradores
	MUX Mux_ULASrc1(.d1(8'b00), .d2(Dado1), .seletor(ULASrc), .saida(ULA_d1));
	MUX Mux_ULASrc2(.d1(Extensor_Out3), .d2(Dado2), .seletor(ULASrc), .saida(ULA_d2));

	//Unidade de Controle da ULA: A partir do Funct e do ULAOp, decide qual operação será feito na ULA
	ULA_Controle ULA_Controle(.ULAOp(ULAOp), .Funct(Funct), .ULA_Control(ULA_Control));
	
	//ULA: baseado no valor de ULA_Control, decide qual operacao sera feita dentro da ULA:
	//Soma, subtracao, comparacao ou negacao
	ULA ULA(
		.d1(ULA_d1), 
		.d2(ULA_d2), 
		.ULA_Control(ULA_Control),
		.Resultado(ULA_Saida), 
		.COND(Cond_ULA) 
	);
	
	//Registrador COND: Caso d1<d2, a ULA ativa o valor dentro do Registrador COND para 1.
	//Ele será usado para o Branch caso ele seja ativado
	Registrador_COND Reg_COND(
		.clk(CLK), 
		.reset(RESET), 
		.cond_ULA(Cond_ULA), 
		.reset_cond(Branch_Cond), 
		.cond_atual(Cond_Atual)
	);
	
	//Porta AND Branch & COND: se o COND e o Branch for verdadeiro, a saída é ativada
	Porta_AND AND_Cond (.d1(Branch), .d2(Cond_Atual), .saida(Branch_Cond));
	
	
	//Memoria de Dados: Baseado no valor de dado 1 e 2 e nos valores de MemWrite e MemRead, 
	//Le os valores dentro da memoria ou escreve neles
	Memoria_Dados Mem_Data(
		.clk(CLK), .reset(RESET), 
		.habilita_escrita(MemWrite), 
		.habilita_leitura(MemRead), 
		.endereco(Dado2), 
		.dado_entrada(Dado1), 
		.dado_saida(Memoria_Saida)
	);
	
	//MUX Branch e Jump: Decide se o novo PC será o valor somado do PC, o valor de PC via Branch ou
	//o valor de PC via Jump
	MUX Mux_Branch(.d1(Extensor_Out5), .d2(PC_Somado), .seletor(Branch_Cond), .saida(PC_MUX_Branch_Out));
	MUX Mux_Jump(.d1(Extensor_Out5), .d2(PC_MUX_Branch_Out), .seletor(Jump), .saida(novo_PC));

	//MUX RegDst: decide se o valor enviado para o banco de registradores sera o da ULA ou do 
	//Banco de Memoria de Dados
	MUX Mux_RegDst(.d1(ULA_Saida), .d2(Memoria_Saida), .seletor(RegDst), .saida(Dado_Escreve_Banco));

endmodule