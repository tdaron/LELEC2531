module substractor(
  input logic [7:0] a,
  input logic [7:0] b,
  output logic [7:0] out
);


logic [7:0] bout;
logic [7:0] inv_b;

assign inv_b = ~b;

adder l(
  .a(a),
  .b(inv_b),
  .out(bout)
);

assign out = bout + 1;


endmodule;

