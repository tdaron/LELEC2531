module adder #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  output logic [DATA_WIDTH-1:0] out
);

assign out = a + b;


endmodule;


