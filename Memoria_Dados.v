module Memoria_Dados (
    input  wire clk,					 			// clock
	 input  wire reset,				 			// reset
    input  wire habilita_escrita, 			// MemWrite
    input  wire habilita_leitura, 			// MemRead
    input  wire [7:0] endereco,				// endereco do banco de memoria
    input  wire [7:0] dado_entrada,			// dados de entrada
    output reg  [7:0] dado_saida				// dados de saida
);

    reg [7:0] memoria [255:0]; 				// 256 bytes de memória

    //Escrita na borda de subida
    always @(posedge clk) begin
        if (habilita_escrita) begin
            memoria[endereco] = dado_entrada;
        end
    end
	 
    // leitura na borda de descida
    always @* begin
		  if (reset)
            dado_saida = 8'b0; 				//O reset ira funcionar apenas para a saida
        else if (habilita_leitura)
            dado_saida = memoria[endereco];
		  
    end
endmodule
