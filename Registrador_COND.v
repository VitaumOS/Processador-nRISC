module Registrador_COND (
    input  wire clk,
	 input  wire reset,
    input  wire cond_ULA,     	// Valor de COND da ULA (Zero ou Slt)
    input  wire reset_cond,   	// Sinal de controle para limpar COND (Ex: após um BEQ)
    output reg  cond_atual    	// Valor atual de COND
);

    // Lista de Sensibilidade: reage à borda de subida do CLK ou do RESET
    always @(posedge clk or posedge reset) begin 
        
        // 1. Reset Assíncrono (do sistema) - Prioridade máxima
        if (reset)
            cond_atual <= 1'b0; 
        
        // 2. Lógica Síncrona (na borda de CLK)
        else begin
            // 2a. Reset Síncrono (limpa a flag se reset_cond for 1)
            if (reset_cond)
                cond_atual <= 1'b0;
            
            // 2b. Senão, carrega o novo valor da ULA
            else
                cond_atual <= cond_ULA; 
        end
    end
endmodule