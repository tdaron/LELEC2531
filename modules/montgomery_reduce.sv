/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module mongomery_reduce #(parameter DATA_WIDTH = 8)(
  input logic [2*DATA_WIDTH-1:0] t, //parce que input*rmm
  input logic [DATA_WIDTH-1:0] R_minus_one, //le nb de bits utilisés du modulant rempli de 1.
  input logic [DATA_WIDTH-1:0] modulant,
  input logic [DATA_WIDTH-1:0] modulant_inv, // compris entre 1 et R-1 ,les deux compris
  input logic [DATA_WIDTH-1:0] bit_length, //max val = DATA_WIDTH, so necessary is log2(DATA_WIDTH)
  output logic [DATA_WIDTH-1:0] out //because Montgomery(nb) <= R - 1, in the worst case the number of bits of n
);

logic [DATA_WIDTH-1:0] a;
assign a = t[bit_length-1:0];

logic [2*DATA_WIDTH-1:0] b;
assign b = a * n_inv;

logic [DATA_WIDTH-1:0] m;
assign m = b[bit_length-1:0];

logic [DATA_WIDTH-1:0] x;
assign x = (t + m*modulant) >> bit_length;

assign out = (x < modulant) ? x : x - modulant;

endmodule;

