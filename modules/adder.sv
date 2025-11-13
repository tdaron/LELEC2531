/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module adder #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  input logic [DATA_WIDTH-1:0] modulant,
  output logic [DATA_WIDTH-1:0] out
);


logic [DATA_WIDTH:0] t_out;
logic [DATA_WIDTH:0] t_sub;


assign t_out = a + b;
assign t_sub = t_out - modulant;

always_comb
  begin
    if (t_out >= modulant) out = t_sub;
    else out = t_out; 

  end
    

endmodule;


