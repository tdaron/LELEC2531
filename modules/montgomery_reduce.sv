/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module montgomery_reduce #(parameter DATA_WIDTH = 8)(
  input logic [2*DATA_WIDTH-1:0] t,
  input logic [DATA_WIDTH-1:0] modulant,
  input logic [DATA_WIDTH-1:0] R_div_two,
  output logic [DATA_WIDTH-1:0] out
);

logic [DATA_WIDTH:0][2*DATA_WIDTH-1:0] a;
logic [DATA_WIDTH-1:0][2*DATA_WIDTH-1:0] b;
assign a[0] = t;
logic [DATA_WIDTH:0][DATA_WIDTH-1:0] counter;
assign counter[0] = R_div_two;
logic [DATA_WIDTH-1:0] cond;

genvar i;
generate
	for(i = 0; i < DATA_WIDTH; i++) begin: gen_loop
		assign cond[i] = (counter[i] != 0);
		assign b[i] = (a[i][0] & cond[i]) ? a[i] + modulant : a[i];
		assign a[i+1] = cond[i] ? b[i] >> 1 : b[i];
		assign counter[i+1] = counter[i] >> 1;
	end
endgenerate

assign out = (a[DATA_WIDTH] >= modulant) ? a[DATA_WIDTH][DATA_WIDTH-1:0] - modulant : a[DATA_WIDTH][DATA_WIDTH-1:0];

endmodule
