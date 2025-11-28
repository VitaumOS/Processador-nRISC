module ULA(
	input wire [7:0] d1,
	input wire [7:0] d2,
	input wire [1:0] ULA_Control,
	
	output reg [7:0] Resultado,
	output reg COND
	
);
	always @* begin
        // Inicialização
        Resultado = 8'b0;
        COND = 1'b0;
        
        case (ULA_Control)
            // 00: ADD
            2'b00: 
                Resultado = $signed(d1) + $signed(d2); //é aplicado o $signed diretamente na conta
					 
            // 01: SUB
            2'b01: 
                Resultado = $signed(d1) - $signed(d2); 
					 
            // 10: SLT
            2'b10: begin
                if ($signed(d1) < $signed(d2))
                    COND = 1'b1;
            end
				
            // 11: NOT
            2'b11: 
                Resultado = ~d1; //ele não precisa de signed
        endcase
    end

endmodule
