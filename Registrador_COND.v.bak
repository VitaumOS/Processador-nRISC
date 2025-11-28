module Registrador_COND (
    input  wire clk,
	 input  wire reset,
    input  wire cond_ULA,     				// Valor de COND da ULA
    input  wire reset_cond,   				// Valor de reset após o COND ser utilizado
    output reg  cond_atual    				// Valor atual de COND
);

    always @(posedge clk or posedge reset) begin
        if (reset_cond)
            cond_atual <= 1'b0; 
		  else if (reset)
            cond_atual <= 1'b0; 
        else
            cond_atual <= cond_ULA; 
    end
endmodule