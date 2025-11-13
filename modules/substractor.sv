module substractor #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  output logic [DATA_WIDTH-1:0] out
);


logic [DATA_WIDTH-1:0] bout;
logic [DATA_WIDTH-1:0] inv_b;

assign inv_b = ~b;

adder #(DATA_WIDTH) l(
  .a(a),
  .b(inv_b),
  .out(bout)
);

assign out = bout + 1;


endmodule;

