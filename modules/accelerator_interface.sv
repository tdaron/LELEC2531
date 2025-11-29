/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

//control scheme : 
//000 : addition
//001 : soustraction
//010 : modulo
//011 : R setup
//100 : multiplication
//101 : exponentiation

//WARNING : le modulant doit être impair pour que les fonctions mult et exp marchent correctement. Si le modulant est pair, il faudra tout faire en software.

module accelerator_interface #(parameter DATA_WIDTH = 8)(
  input logic  [DATA_WIDTH-1:0] a,
  input logic  [DATA_WIDTH-1:0] b,
  input logic  [DATA_WIDTH-1:0] modulant,
  input logic 					start,
  input logic  [2:0]			control,
  input logic					clk,
  output logic [DATA_WIDTH-1:0] result,
  output logic [DATA_WIDTH-1:0] R_2,
  output logic [DATA_WIDTH-1:0] R_sqr,
  output logic					finished,
  output logic 					r_fin
);

logic [DATA_WIDTH-1:0] R_div_two;
logic [DATA_WIDTH-1:0] R_squared;
logic [DATA_WIDTH-1:0] R_div_two_intermidiate;
logic [DATA_WIDTH-1:0] R_squared_intermidiate;

logic [DATA_WIDTH-1:0] intermidiate_result;
logic				   intermidiate_finished;

wire [DATA_WIDTH-1:0] Res_add;
wire [DATA_WIDTH-1:0] Res_sub;
wire [DATA_WIDTH-1:0] Res_mod;
wire [DATA_WIDTH-1:0] Res_mult;
wire [DATA_WIDTH-1:0] Res_exp;

wire r_setup_done;
wire mod_done;
wire exp_done;

always_latch begin
	case(control)
		3'b000 : begin
			intermidiate_result = Res_add;
			intermidiate_finished = 1;
		end
		3'b001 : begin
			intermidiate_result = Res_sub;
			intermidiate_finished = 1;
		end
		3'b010 : begin
			intermidiate_result = Res_mod;
			intermidiate_finished = mod_done;
		end
		3'b011 : begin
			intermidiate_result = r_setup_done;
			intermidiate_finished = r_setup_done;
			if(r_setup_done == 1) begin
				R_div_two = R_div_two_intermidiate;
				R_squared = R_squared_intermidiate;
			end
		end
		3'b100 : begin
			intermidiate_result = Res_mult;
			intermidiate_finished = 1;
		end
		3'b101 : begin
			intermidiate_result = Res_exp;
			intermidiate_finished = exp_done;
		end
		default : begin
			intermidiate_result = 0;
			intermidiate_finished = 1;
		end
	endcase
end

adder #(.DATA_WIDTH(8)) add(
  .a(a),
  .b(b),
  .modulant(modulant),
  .out(Res_add)
);

substractor #(.DATA_WIDTH(8)) sub(
  .a(a),
  .b(b),
  .modulant(modulant),
  .out(Res_sub)
);

R_computation #(.DATA_WIDTH(8)) R_setup(
  .modulant(modulant),
  .start(start),
  .clk(clk),
  .R_div_2(R_div_two_intermidiate),
  .R_square(R_squared_intermidiate),
  .done(r_setup_done)
);

modulo #(.DATA_WIDTH(8)) mod(
  .a({1'b0, a, b}),
  .modulant(modulant),
  .clk(clk),
  .start(start),
  .out(Res_mod),
  .done(mod_done)
);

multiplicator #(.DATA_WIDTH(8)) mult(
  .a(a),
  .b(b),
  .modulant(modulant),
  .R_div_two(R_div_two),
  .R_squared(R_squared),
  .out(Res_mult)
);

exponentiation #(.DATA_WIDTH(8)) exp(
  .a(a),
  .b(b),
  .modulant(modulant),
  .R_div_two(R_div_two),
  .R_squared(R_squared),
  .clock(clk),
  .set(start),
  .out(Res_exp),
  .finished(exp_done)
);


assign result = intermidiate_result;
assign finished = intermidiate_finished;

assign R_2 = R_div_two;
assign R_sqr = R_squared;
assign r_fin = r_setup_done;

endmodule;
