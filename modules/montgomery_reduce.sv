/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module mongomery_reduce #(parameter DATA_WIDTH = 8)(
  input logic [2*DATA_WIDTH-1:0] t, //parce que input*rmm
  input logic [DATA_WIDTH-1:0] modulant,
  input logic [DATA_WIDTH-1:0] bit_length, //max val = DATA_WIDTH, so necessary is log2(DATA_WIDTH)
  output logic [2*DATA_WIDTH-1:0] out
);
    
input logic [2*DATA_WIDTH-1:0] a;

always_comb begin
	a = t;

	for (int i = 0; i < bit_length; i++) begin
		if(a[0])
			a = a + modulant;
		a = a >> 1;
	end
	
	if(a > modulant)
		a = a - modulant;
end

assign out = a;

endmodule;

