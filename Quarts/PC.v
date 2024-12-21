module PC(
input [31:0] ImmExt,
input clk,areset,load,PCSrc,
output reg[31:0] PC
);
reg [31:0]PCNext;
always @(*) begin
    if(PCSrc)
        PCNext=PC+ImmExt;
    else
        PCNext=PC+3'b100;        
end
always @(posedge clk or negedge areset) begin
    if(~areset)
   	PC<=0;
    else if(load)
        PC<=PCNext;
end

endmodule