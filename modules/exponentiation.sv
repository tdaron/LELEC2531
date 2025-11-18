/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module exponentiation #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  input logic [DATA_WIDTH-1:0] modulant,
  input logic                  clock,
  input logic                  set,
  output logic [DATA_WIDTH-1:0] out,
  output logic                  finished
);

reg [DATA_WIDTH-1:0] exponant;
reg [DATA_WIDTH-1:0] squares, new_squares;
reg [DATA_WIDTH-1:0] result, new_result;

reg end_flag;

always_ff@(posedge clock) begin
    if(set) begin   
        squares <= a;
        result <= b[0] ? a : 1; 
        exponent <= b >> 1; 
        end_flag <= 0;
    end
    else if(~end_flag) begin
        squares <= new_squares;
        result <= (exponent[0]) ? new_result : result;
        exponent <= exponent >> 1;
        end_flag = (exponent == 0) ? 1 : 0;
    end
end

mutiplicator #(parameter DATA_WIDTH = 8) sqr_mult(
  .a(squares),
  .b(squares),
  .modulant(modulant),
  .out(new_squares)
);

mutiplicator #(parameter DATA_WIDTH = 8) res_mult(
  .a(result),
  .b(new_squares),
  .modulant(modulant),
  .out(new_result)
);

assign out = result;
assign finished = end_flag;

endmodule;
