module Extensor_Sinal_5b8( 
	input wire [4:0] entrada,
	output reg [7:0] saida

);
	always @* begin
	
		saida = {3'b000, entrada}; //adiciona 3 zeros no início da saída e concatena com a entrada
	end

endmodule
