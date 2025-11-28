module Banco_Registradores (
    input  wire clk,                  		// Clock
	 input  wire reset,							// Reset
    input  wire habilita_escrita,     		// controle de escrita (RegWrite)
    input  wire [1:0] endereco_leitura_A, // endereço do registrador fonte A
    input  wire [1:0] endereco_leitura_B, // endereço do registrador fonte B
    input  wire [1:0] endereco_escrita,   // endereço do registrador destino
    input  wire [7:0] dado_escrita,       // dado a ser escrito no registrador
    output reg  [7:0] dado_leitura_A,     // saída da porta de leitura A
    output reg  [7:0] dado_leitura_B      // saída da porta de leitura B
);

    
    // banco de 4 registradores    
    reg [7:0] registradores [3:0];


    // escrita na borda de subida do clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            registradores[0] <= 8'b0;
            registradores[1] <= 8'b0;
            registradores[2] <= 8'b0;
            registradores[3] <= 8'b0;
        end
        else if (habilita_escrita) begin
            registradores[endereco_escrita] <= dado_escrita;
        end
    end

    // leitura na borda de descida do clock
    always @(negedge clk) begin
        dado_leitura_A <= registradores[endereco_leitura_A];
        dado_leitura_B <= registradores[endereco_leitura_B];
    end

endmodule