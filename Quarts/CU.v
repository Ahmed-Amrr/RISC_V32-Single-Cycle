
module CU(
    input zero,funct7,sign,
    input [6:0]OP,
    input [2:0]funct3,
    output reg ResultSrc,MemWrite,ALUSrc,RegWrite,
    output reg PCSrc,load,
    output reg [1:0]ImmSrc,
    output reg [2:0]ALUControl
);
reg [1:0]ALUOp;
reg Branch;
always @(*) begin
    case (ALUOp)
        2'b00:ALUControl=0;
        2'b01:begin 
            case (funct3)
                3'b000: ALUControl=3'b010;
                3'b001: ALUControl=3'b010;
                3'b100: ALUControl=3'b010;
            default: ALUControl = 3'b000;
                 
            endcase
        end
        2'b10:begin 
            case (funct3)
                3'b000:begin if(OP[5]==0 || funct7==0)
                            ALUControl=3'b000;
                        else if(OP[5]==1 && funct7==1)
                            ALUControl=3'b010;
                end 
                3'b001:ALUControl=3'b001;
                3'b100:ALUControl=3'b100;    
                3'b101:ALUControl=3'b101;    
                3'b110:ALUControl=3'b110;    
                3'b111:ALUControl=3'b111;
            default:ALUControl=3'b000;    
            endcase
        end 
        default: ALUControl=0;
    endcase
end
always @(*) begin
    case (OP)
        7'b000_0011:begin
            RegWrite=1;ImmSrc=2'b00;ALUSrc=1;load=1;
            MemWrite=0;ResultSrc=1;Branch=0;ALUOp=2'b00;
        end
        7'b010_0011:begin
            RegWrite=0;ImmSrc=2'b01;ALUSrc=1;load=1;
            MemWrite=1;ResultSrc=0;Branch=0;ALUOp=2'b00;
        end
        7'b011_0011:begin
            RegWrite=1;ImmSrc=2'b00;ALUSrc=0;load=1;
            MemWrite=0;ResultSrc=0;Branch=0;ALUOp=2'b10;
        end
        7'b001_0011:begin
            RegWrite=1;ImmSrc=2'b00;ALUSrc=1;load=1;
            MemWrite=0;ResultSrc=0;Branch=0;ALUOp=2'b10;
        end
        7'b110_0011:begin
            RegWrite=0;ImmSrc=2'b10;ALUSrc=0;load=1;
            MemWrite=0;ResultSrc=0;Branch=1;ALUOp=2'b01;
        end
        default:begin
            RegWrite=0;ImmSrc=2'b00;ALUSrc=0;load=1;
            MemWrite=0;ResultSrc=0;Branch=0;ALUOp=2'b00;
        end
    endcase
end
always @(*) begin
    if(Branch)begin
            case (funct3)
                3'b000:
                PCSrc = zero & Branch;
                 
                3'b001:
                PCSrc = (~zero) & Branch;
                 
                3'b100:
                PCSrc = sign & Branch;
                 
            endcase
    end
    else 
    PCSrc=0;
    
end
endmodule