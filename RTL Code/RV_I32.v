module RV_32I(input clk,areset);

wire [31:0]SrcA,ALUResult,PC,instr,WriteData,ReadData,SrcB,ImmExt,Result;
wire [2:0]ALUControl;
wire [1:0]ImmSrc;
wire zero,ALUSrc,sign,load,PCSrc,RegWrite,MemWrite,ResultSrc;

ALU top_ALU(
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .zero(zero),
    .sign(sign));


PC top_PC(
    .clk(clk),
    .areset(areset),
    .ImmExt(ImmExt),
    .load(1'b1),
    .PCSrc(PCSrc),
    .PC(PC)
);


Instr_mem top_Instr_mem(
    .A(PC),
    .RD(instr)
);


Register_File top_Register_File(
    .A1(instr[19:15]),
    .A2(instr[24:20]),
    .A3(instr[11:7]),
    .WD3(Result),
    .WE3(RegWrite),
    .clk(clk),
    .areset(areset),
    .RD1(SrcA),
    .RD2(WriteData)
);


Data_mem top_Data_mem(
    .A(ALUResult),
    .WD(WriteData),
    .WE(MemWrite),
    .clk(clk),
    .RD(ReadData)
);


CU top_CU(
    .zero(zero),
    .funct7(instr[30]),
    .OP(instr[6:0]),
    .funct3(instr[14:12]),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .PCSrc(PCSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .sign(sign)
);


sign_Extender top_sign_Extender(
    .instr(instr),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);

assign Result = ResultSrc? ReadData : ALUResult;
assign SrcB = ALUSrc? ImmExt : WriteData;

endmodule