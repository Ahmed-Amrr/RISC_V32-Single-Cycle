

module Data_mem(
    input [31:0]A,
    input [31:0]WD,
    input WE,clk,
    output reg [31:0]RD
);
reg [31:0] memory [63:0];
always @(posedge clk) begin
        if (WE) begin
            memory[A[31:2]]<=WD; 
        end
end
always @(*) begin
    RD=memory[A[31:2]];
end
endmodule