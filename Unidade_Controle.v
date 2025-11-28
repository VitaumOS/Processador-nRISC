module Unidade_Controle (
    input  wire [2:0] Opcode, 
    input  wire Funct,  		
    
    // Sinais
    output reg RegDst,        
    output reg RegWrite,      
    output reg MemRead,       
    output reg MemWrite,      
    output reg Branch,        
    output reg Jump,          
    output reg ULASrc,        
    output reg Halt,          
    output reg [1:0] ULAOp    
);

    always @* begin
        RegDst = 1'b0;
        RegWrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        Branch = 1'b0;
        Jump = 1'b0;
        ULASrc = 1'b0;
        Halt = 1'b0;
        ULAOp = 2'b00;

        case (Opcode)
            3'b001: begin
					case (Funct) 
						1'b0: begin // 001-0: ADD 
							RegDst = 1'b1;
							RegWrite = 1'b1;
						end
						1'b1: begin // 001-1: SUB 
							 RegDst = 1'b1;
							 RegWrite = 1'b1;
						end
				
					endcase
				end
				
				3'b101: begin
					case (Funct) 
						1'b0: begin // 101-0: SLT
							 ULAOp = 2'b01;
						end
						1'b1: begin // 101-1: NOT 
							 RegDst = 1'b1;
							 RegWrite = 1'b1;
							 ULAOp = 2'b01; 
						end
					endcase
				end
            
				3'b010: begin
					case (Funct) 
						1'b0: begin // 010-0: LW 
							 RegWrite = 1'b1;
							 MemRead = 1'b1;
							 ULAOp = 2'b11; 
						end
						 
						1'b1: begin // 010-1: SW
							 MemWrite = 1'b1;
							 ULAOp = 2'b11; 
						end
					endcase
				end
            
            
            3'b100: begin // 100: LI 
                RegDst = 1'b1;
                RegWrite = 1'b1;
                ULASrc = 1'b1;
                ULAOp = 2'b10; 
            end
				
				
            3'b110: begin // 110: BEQ 
                Branch = 1'b1;
                ULAOp = 2'b11; 
            end
				
				
            3'b011: begin // 011: J 
                Jump = 1'b1;
                ULAOp = 2'b11; 
            end
				
             
            3'b000: begin // 000: HALT
                Halt = 1'b1;
                ULAOp = 2'b11;
            end
        endcase
    end

endmodule