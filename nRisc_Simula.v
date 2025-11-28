module nRisc_Simula;

reg CLK;
reg RESET;

integer i;



// 1. Instância do Processador
nRisc nRisc( // MÓDULO CORRIGIDO: nRisc
	.CLK(CLK),
	.RESET(RESET)

);



// ----------------------------------------------------------------------
// Geração de Clock e Inicialização
// ----------------------------------------------------------------------

initial
	begin
		$display("Inicializando simulacao do nRisc Uniciclo de 8 bits...");
		
		
		
		nRisc.DataMem.memoria[0]=8'b00000101;
		nRisc.DataMem.memoria[1]=8'b00001000;
		nRisc.DataMem.memoria[2]=8'b11111111;
		nRisc.DataMem.memoria[3]=8'b00000001;
		nRisc.DataMem.memoria[4]=8'b00001010;

		nRisc.InstrMem.memoria[0]=8'b10001000;
		nRisc.InstrMem.memoria[1]=8'b10010001;
		nRisc.InstrMem.memoria[2]=8'b10011101;
		nRisc.InstrMem.memoria[3]=8'b01000010;
		nRisc.InstrMem.memoria[4]=8'b10100001;
		nRisc.InstrMem.memoria[5]=8'b00100100;
		nRisc.InstrMem.memoria[6]=8'b01000011;
		nRisc.InstrMem.memoria[7]=8'b00101100;
		nRisc.InstrMem.memoria[8]=8'b10101110;
		nRisc.InstrMem.memoria[9]=8'b11000011;
		nRisc.InstrMem.memoria[10]=8'b00000000;
		
		for(i=0; i<=4; i=i+1)
			$display("Memoria:%d", $signed(nRisc.DataMem.memoria[i]));
		
		CLK = 0;
		RESET = 1;
		#5;
		RESET = 0;
	end

// Geração de Clock (Ciclo de 10ns)
initial
	begin
		forever begin
			#5;
			CLK = ~CLK;
		end
	end

// ----------------------------------------------------------------------
// Monitoramento e Debug (Executa na borda de subida - posedge CLK)
// ----------------------------------------------------------------------


		 
always @(posedge CLK) begin

	$display("\nTempo: %0tns | Clock = %b | Reset = %b", $time, CLK, RESET);

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
