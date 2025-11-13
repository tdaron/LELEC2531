module adder(
  input logic [7:0] a,
  input logic [7:0] b,
  output logic [7:0] out
);

assign out = a + b;


endmodule;


module adder_tb();

  logic [7:0] a;
  logic [7:0] b;
  logic [7:0] out;

  adder dut(
    .a(a),
    .b(b),
    .out(out)
  );

  initial
    begin
      a = 5;
      b = 7;
      #1
      assert(out == 12);
    end

endmodule;
