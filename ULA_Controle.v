module ULA_Controle(
	input wire [1:0] ULAOp,
	input wire Funct,
	
	output reg [1:0] ULA_Control
);

	always@* begin
		
		ULA_Control = 2'b00; //Começa como ADD (Para ULAop = 10,11)
		
		case (ULAOp)
			2'b00: begin
				if (Funct)
					ULA_Control = 2'b01; // SUB
				else
					ULA_Control = 2'b00; // ADD
			end
			
			2'b01: begin
				if (Funct)
					ULA_Control = 2'b11; // NOT
				else
					ULA_Control = 2'b10; //SLT
			end
		endcase
	end

endmodule

