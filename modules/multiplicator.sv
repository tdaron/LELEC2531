/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module multiplicator #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  input logic [DATA_WIDTH-1:0] modulant,
  input logic [DATA_WIDTH-1:0] R_div_two,
  input logic [DATA_WIDTH-1:0] R_squared,
  output logic [DATA_WIDTH-1:0] out
);

logic [DATA_WIDTH-1:0] ma;
logic [DATA_WIDTH-1:0] mb;
logic [DATA_WIDTH-1:0] mc;

montgomery_reduce #(.DATA_WIDTH(DATA_WIDTH)) r1(
  .t(a * R_squared),
  .modulant(modulant),
  .R_div_two(R_div_two),
  .out(ma)
);

montgomery_reduce #(.DATA_WIDTH(DATA_WIDTH)) r2(
  .t(b * R_squared),
  .modulant(modulant),
  .R_div_two(R_div_two),
  .out(mb)
);

montgomery_reduce #(.DATA_WIDTH(DATA_WIDTH)) rc(
  .t(ma * mb),
  .modulant(modulant),
  .R_div_two(R_div_two),
  .out(mc)
);

montgomery_reduce #(.DATA_WIDTH(DATA_WIDTH)) r_final(
  .t(mc),
  .modulant(modulant),
  .R_div_two(R_div_two),
  .out(out)
);

endmodule;

