module Porta_AND(

	input wire d1,d2,
	
	output reg saida

);

	always @* begin
		
		saida = d1&d2;
	end

endmodule