
module UartplusBuffer(
  input clk1,areset,WD,
  input [7:0] data,
  output tx_serial
);

wire [7:0] q;

uart_tx uart (.areset(areset),.clk1(clk1),.data(q),.tx_serial(tx_serial));
Buffer buff (.areset(areset),.clk(clk1),.load(WD),.d(data),.q(q));

endmodule
