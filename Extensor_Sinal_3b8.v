module Extensor_Sinal_3b8(
	input wire [2:0] entrada,
	output reg [7:0] saida
);
	
	always @* begin
	
		saida = {5'b00000, entrada}; //adiciona 5 zeros no início da saída e concatena com a entrada
	end

endmodule
