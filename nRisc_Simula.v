module nRisc_Simula;

reg CLK;
reg RESET;
integer i;

nRisc nRisc( 
	.CLK(CLK),
	.RESET(RESET)
);

initial begin
				
		nRisc.DataMem.memoria[0]=8'b00000101; 		//5
		nRisc.DataMem.memoria[1]=8'b00001000; 		//8
		nRisc.DataMem.memoria[2]=8'b11111111; 		//-1
		nRisc.DataMem.memoria[3]=8'b00000001; 		//1
		nRisc.DataMem.memoria[4]=8'b00001010; 		//10

		nRisc.InstrMem.memoria[0]=8'b10001000; 	//LI R1, 0
		nRisc.InstrMem.memoria[1]=8'b10010001; 	//LI R2, 1
		nRisc.InstrMem.memoria[2]=8'b10011101; 	//LI R3, 5
		nRisc.InstrMem.memoria[3]=8'b01000010; 	//LW R0, R1
		nRisc.InstrMem.memoria[4]=8'b10100001; 	//NOT R0, R0
		nRisc.InstrMem.memoria[5]=8'b00100100; 	//ADD R0, R2
		nRisc.InstrMem.memoria[6]=8'b01000011; 	//SW R0, R1
		nRisc.InstrMem.memoria[7]=8'b00101100; 	//ADD R1, R2
		nRisc.InstrMem.memoria[8]=8'b10101110; 	//SLT R1, R3
		nRisc.InstrMem.memoria[9]=8'b11100011; 	//BEQ 4
		nRisc.InstrMem.memoria[10]=8'b00000000; 	//HALT
		
		for(i=0; i<=4; i=i+1)
			$display("Memoria:%d", $signed(nRisc.DataMem.memoria[i]));
		
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

	$display("\nTempo = %0t| Clock = %b  Reset = %b", $time, CLK, RESET);

	$display("PC=%d | Instrucao=%b", nRisc.PC_Atual, nRisc.Instrucao_Lida);
	$display("Decodificacao: Opcode=%b | Funct=%b | R1 = %d | R2 = %d | Imm3=%d | Target=%d", 
		nRisc.Opcode, nRisc.Funct, nRisc.Reg1, nRisc.Reg2, nRisc.Imm3, nRisc.Target);

	$display("Controle: RegWrite=%b MemRead=%b MemWrite=%b Branch=%b Jump=%b ULASrc=%b",
		nRisc.RegWrite, nRisc.MemRead, nRisc.MemWrite, nRisc.Branch, nRisc.Jump, nRisc.ULASrc);
                
	$display("ULA: In1=%d In2=%d | Out=%d | COND=%b",
		nRisc.ULA_Data1_MuxOut, nRisc.ULA_Data2_MuxOut, nRisc.ULA_Saida, nRisc.Cond_ULA);

	$display("Mem Dados (Interna): Endereco=%b DadoEscrito=%b",
		nRisc.Reg1, nRisc.Dado_Escrito_Banco); 
								 
	$display("Banco Memoria: Mem1 = %b(%3d)| Mem2 = %b(%3d) | Mem3 = %b(%3d) | Mem4 = %b(%3d) | Mem5 = %b(%3d)", 
		nRisc.DataMem.memoria[0],$signed(nRisc.DataMem.memoria[0]),
		nRisc.DataMem.memoria[1],$signed(nRisc.DataMem.memoria[1]),
		nRisc.DataMem.memoria[2],$signed(nRisc.DataMem.memoria[2]),
		nRisc.DataMem.memoria[3],$signed(nRisc.DataMem.memoria[3]),
		nRisc.DataMem.memoria[4],$signed(nRisc.DataMem.memoria[4]));
				
	$display("Banco Registradores: R0 = %b | R1 = %b | R2 = %b | R3 = %b",
		nRisc.BancoReg.registradores[0], 
		nRisc.BancoReg.registradores[1], 
		nRisc.BancoReg.registradores[2], 
		nRisc.BancoReg.registradores[3]);
end
		

always @(posedge CLK) begin
    if (nRisc.Instrucao_Lida == 8'b0) begin 
		for(i=0; i<=4; i=i+1)
			$display("Memoria:%d", $signed(nRisc.DataMem.memoria[i]));
      $finish;
    end
end

endmodule
