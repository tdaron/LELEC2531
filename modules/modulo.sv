/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module modulo #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] modulant,
  output logic [DATA_WIDTH-1:0] out
);

    assign out = a % modulant;    

endmodule;


