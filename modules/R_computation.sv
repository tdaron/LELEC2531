/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off LATCH */

module R_computation #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0]  modulant,
  input logic					start,
  input logic					clk,
  output logic [DATA_WIDTH-1:0] R_div_2,
  output logic [DATA_WIDTH-1:0] R_square,
  output logic 					done
);

typedef enum logic [1:0] {IDLE=2'b00, COMPUTING_R=2'b01, COMPUTING_R_2=2'b10} statetype;

statetype state;
statetype nextstate;

logic finish;
logic next_finish;
logic [DATA_WIDTH:0] R;
logic [DATA_WIDTH:0] next_R;
logic mod_start;
logic next_mod_start;
logic mod_done;

always_ff @(posedge clk) begin
	if(start) begin
		state <= IDLE;
		R <= 1;
		finish <= 0;
		mod_start <= 0;
	end
	else begin
		state <= nextstate;
		R <= next_R;
		finish <= next_finish;
		mod_start <= next_mod_start;
	end
end

always_comb begin
	case(state)
		IDLE : begin
			next_R = R;
			next_finish = finish;
			next_mod_start = mod_start;
			if(finish == 0)
				nextstate = COMPUTING_R;
			else
				nextstate = IDLE;
		end
		COMPUTING_R : begin
			if(R <= modulant) begin
				next_R = R << 1;
				nextstate = COMPUTING_R;
			end
			else begin
				next_mod_start = 1;
				nextstate = COMPUTING_R_2;
			end
		end
		COMPUTING_R_2 : begin
			if(mod_start == 1)
				next_mod_start = 0;
			else if (mod_done) begin
				next_finish = 1;
				nextstate = IDLE;
			end
		end
		default : nextstate = IDLE;
	endcase
end

modulo #(.DATA_WIDTH(8)) mod(
  .a(R*R),
  .modulant(modulant),
  .clk(clk),
  .start(mod_start),
  .out(R_square),
  .done(mod_done)
);

assign R_div_2 = R >> 1;
assign done = finish; 

endmodule;
