/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module mutiplicator #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  input logic [DATA_WIDTH-1:0] modulant,
  output logic [DATA_WIDTH-1:0] out
);

logic [2*DATA_WIDTH-1:0] intermidiate;
    
assign intermidiate = a * b;

assign out = intermidiate % modulant;

endmodule;

