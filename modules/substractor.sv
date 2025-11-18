/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module substractor #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  input logic [DATA_WIDTH-1:0] modulant,
  output logic [DATA_WIDTH-1:0] out
);

logic [DATA_WIDTH:0] t_out;
logic [DATA_WIDTH:0] t_sub;


assign t_out = a - b;
assign t_sub = t_out + modulant;

assign out = t_out[DATA_WIDTH] ? t_sub[DATA_WIDTH-1:0] : t_out[DATA_WIDTH-1:0];
    

endmodule;

