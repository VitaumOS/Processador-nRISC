module Memoria_Instrucao(
    input  wire clk,
	 input  wire reset,
    input  wire [7:0] endereco,				// Enredeco do PC de entrada
    output reg  [7:0] instrucao_saida		// Instrucao de saida
);
	reg [7:0] memoria [255:0]; 				// 256 bytes de memória
	always @(negedge clk or posedge reset) begin
		if (reset)
         instrucao_saida <= memoria[0];
      else
			instrucao_saida <= memoria[endereco];
   end
endmodule