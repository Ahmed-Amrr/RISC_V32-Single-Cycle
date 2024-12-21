
module Instr_mem(
    input [31:0]A,
    output reg [31:0]RD
);
reg [31:0] instr [63:0];

always @(*) begin
            RD=instr[A[31:2]]; 
end
initial begin
    $readmemh("program.txt",instr);
end
endmodule