/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module multiplicator #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0]  a,
  input logic [DATA_WIDTH-1:0]  b,
  input logic [DATA_WIDTH-1:0]  modulant,
  input logic 				    reset,
  output logic [DATA_WIDTH-1:0] out
);

input logic [DATA_WIDTH-1:0]   self_modulant;
input logic [DATA_WIDTH-1:0]   self_rrm; 
input logic [DATA_WIDTH-1:0]   self_bit_length; 
    
always_comb begin

	if(reset) begin
		//on set
	end

end

input logic [2*DATA_WIDTH-1:0] t1 = a * self_rrm;
input logic [2*DATA_WIDTH-1:0] t2 = b * self_rrm;

input logic [2*DATA_WIDTH-1:0] r1, r2;

mongomery_reduce #(DATA_WIDTH = 8) reduce1(
	.t(a),
	.modulant(modulant)
	.bit_length(self_bit_length),
	.out(r1)
);

mongomery_reduce #(DATA_WIDTH = 8) reduce2(
	.t(b),
	.modulant(modulant)
	.bit_length(self_bit_length),
	.out(r2)
);

input logic [2*DATA_WIDTH-1:0] c;
assign c = r1 * r2;

input logic [2*DATA_WIDTH-1:0] z;
mongomery_reduce #(DATA_WIDTH = 8) reduce3(
	.t(c),
	.modulant(modulant)
	.bit_length(self_bit_length),
	.out(z)
);

mongomery_reduce #(DATA_WIDTH = 8) reduce3(
	.t(z),
	.modulant(modulant)
	.bit_length(self_bit_length),
	.out(out)
);

endmodule;

