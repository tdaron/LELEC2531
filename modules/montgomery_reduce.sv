/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module montgomery_reduce #(parameter DATA_WIDTH = 8)(
  input logic [2*DATA_WIDTH-1:0] t,
  input logic [DATA_WIDTH-1:0] modulant,
  input logic [DATA_WIDTH-1:0] R_minus_one,
  output logic [DATA_WIDTH-1:0] out
);

logic [DATA_WIDTH:0][2*DATA_WIDTH-1:0] a, b;
assign a[0] = t;
logic [2*DATA_WIDTH-1:0] n;
assign n = modulant;
const [DATA_WIDTH:0][DATA_WIDTH-1:0] counter;
assign counter[0] = R_minus_one;

genvar i;
generate
	for(i = 0; i < DATA_WIDTH; i++) begin
		if (counter[i] != 0) begin
			assign b[i] = a[i][0] ? a[i] + n : a[i];
			assign a[i+1] = b[i] >> 1;
			assign counter[i+1] = counter[i] >> 1;
		end
	end
	
endgenerate

assign out = (a[DATA_WIDTH] >= n) ? a[DATA_WIDTH-1:0] - modulant : a[DATA_WIDTH-1:0];

endmodule
