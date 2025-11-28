module PC (
    input  wire clk,
    input  wire reset,
    input  wire [7:0] novo_PC,				// Valor do PC que será inserido
    output reg  [7:0] pc_atual				// Valor atual do PC
);
    // escrita na borda de subida
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_atual <= 8'b0;
        else
            pc_atual <= novo_PC;
    end
endmodule