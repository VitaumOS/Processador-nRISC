module nRisc_Simula;

reg CLK;
reg RESET;
integer i;

nRisc nRisc( 
	.CLK(CLK),
	.RESET(RESET)
);

initial begin
				
		nRisc.Mem_Data.memoria[0]=8'b00000101; 		//5
		nRisc.Mem_Data.memoria[1]=8'b00001000; 		//8
		nRisc.Mem_Data.memoria[2]=8'b11111111; 		//-1
		nRisc.Mem_Data.memoria[3]=8'b00000001; 		//1
		nRisc.Mem_Data.memoria[4]=8'b00001010; 		//10

		nRisc.Mem_Inst.memoria[0]=8'b10001000; 		//LI R1, 0
		nRisc.Mem_Inst.memoria[1]=8'b10010001; 		//LI R2, 1
		nRisc.Mem_Inst.memoria[2]=8'b10011101; 		//LI R3, 5
		nRisc.Mem_Inst.memoria[3]=8'b01000010; 		//LW R0, R1
		nRisc.Mem_Inst.memoria[4]=8'b10100001; 		//NOT R0, R0
		nRisc.Mem_Inst.memoria[5]=8'b00100100; 		//ADD R0, R2
		nRisc.Mem_Inst.memoria[6]=8'b01000011; 		//SW R0, R1
		nRisc.Mem_Inst.memoria[7]=8'b00101100; 		//ADD R1, R2
		nRisc.Mem_Inst.memoria[8]=8'b10101110; 		//SLT R1, R3
		nRisc.Mem_Inst.memoria[9]=8'b11100011; 		//BEQ 4
		nRisc.Mem_Inst.memoria[10]=8'b00000000; 		//HALT
		
		$display("Memoria:%d, %d, %d, %d, %d", 
			$signed(nRisc.Mem_Data.memoria[0]), 
			$signed(nRisc.Mem_Data.memoria[1]), 
			$signed(nRisc.Mem_Data.memoria[2]), 
			$signed(nRisc.Mem_Data.memoria[3]), 
			$signed(nRisc.Mem_Data.memoria[4])
			);
		
		CLK = 0;
		RESET = 1;
		#5;
		RESET = 0;
end


initial begin
	forever begin
		#5;	
		CLK = ~CLK;
	end
end

		 
always @(posedge CLK) begin

	$display("\nTempo = %0t | Clock = %b  Reset = %b", $time, CLK, RESET);

	$display("PC = %d | Instrucao = %b", nRisc.PC_Atual, nRisc.Instrucao);
	$display("Decodificacao da instrucao: Opcode = %b Funct = %b R1 = %d R2 = %d Imm3 = %d Target = %d", 
		nRisc.Opcode, nRisc.Funct, nRisc.Reg1, nRisc.Reg2, nRisc.Imm3, nRisc.Target);

	$display("Unidade de Controle: RegDst = %b RegWrite = %b MemRead = %b MemWrite = %b Branch = %b Jump = %b ULASrc = %b Halt = %b ULAOP = %b ", 
		nRisc.RegDst,nRisc.RegWrite, nRisc.MemRead, nRisc.MemWrite, nRisc.Branch, nRisc.Jump, nRisc.ULASrc, nRisc.Halt, nRisc.ULAOp);
	$display("Unidade de Controle ULA: ULAControl = %b", nRisc.ULA_Control);
                
	$display("ULA: d1 =%b d2 =%b | Resultado = %b | COND = %b",
		nRisc.ULA_d1, nRisc.ULA_d2, nRisc.ULA_Saida, nRisc.Cond_ULA);

	$display("Memoria de Dados (Interna): Endereco = %d | DadoEscrito = %b | DadoLido = %b",
		nRisc.Dado2, nRisc.Dado1, nRisc.Memoria_Saida); 
	$display("Saida do MUX RegDst: %b", nRisc.Dado_Escreve_Banco);
								 
	$display("Valores da Memoria de Dados: Mem0 = %b(%3d)| Mem1 = %b(%3d) | Mem2 = %b(%3d) | Mem3 = %b(%3d) | Mem4 = %b(%3d)", 
		nRisc.Mem_Data.memoria[0],$signed(nRisc.Mem_Data.memoria[0]),
		nRisc.Mem_Data.memoria[1],$signed(nRisc.Mem_Data.memoria[1]),
		nRisc.Mem_Data.memoria[2],$signed(nRisc.Mem_Data.memoria[2]),
		nRisc.Mem_Data.memoria[3],$signed(nRisc.Mem_Data.memoria[3]),
		nRisc.Mem_Data.memoria[4],$signed(nRisc.Mem_Data.memoria[4]));
				
	$display("Banco Registradores: R0 = %b | R1 = %b | R2 = %b | R3 = %b",
		nRisc.BancoReg.registradores[0], 
		nRisc.BancoReg.registradores[1], 
		nRisc.BancoReg.registradores[2], 
		nRisc.BancoReg.registradores[3]);
	$display("Novo PC: %d", nRisc.novo_PC);
end
		

always @(posedge CLK) begin
    if (nRisc.Instrucao == 8'b0) begin 
		$display("Memoria:%d, %d, %d, %d, %d", 
			$signed(nRisc.Mem_Data.memoria[0]), 
			$signed(nRisc.Mem_Data.memoria[1]), 
			$signed(nRisc.Mem_Data.memoria[2]), 
			$signed(nRisc.Mem_Data.memoria[3]), 
			$signed(nRisc.Mem_Data.memoria[4])
			);
      $finish;
    end
end

endmodule
