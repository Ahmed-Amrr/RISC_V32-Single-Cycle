

module Register_File(
    input [4:0]A1,A2,A3,
    input [31:0]WD3,
    input WE3,clk,areset,
    output reg [31:0]RD1,RD2
);
reg [31:0] Register [31:0];
integer i;
always @(posedge clk or negedge areset) begin
    if (~areset) begin
        for (i=0 ;i<32 ;i=i+1 ) begin
            Register[i]<=0;
        end
    end
       else if (WE3) begin
            Register[A3]<=WD3; 
        end
end
always @(*) begin
    RD1<=Register[A1];
    RD2<=Register[A2];
    
end
endmodule