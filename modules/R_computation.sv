/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off LATCH */

module R_computation #(parameter DATA_WIDTH = 8)(
  input logic [DATA_WIDTH-1:0]  modulant,
  input logic					start,
  input logic					clk,
  output logic [DATA_WIDTH-1:0] R_out,
  output logic 					done
);

typedef enum logic [1:0] {IDLE=1'b0, COMPUTING_R=1'b1} statetype;

statetype state;
statetype nextstate;

logic finish;
logic next_finish;
logic [DATA_WIDTH:0] R;
logic [DATA_WIDTH:0] next_R;

always_ff @(posedge clk) begin
	if(start) begin
		state <= IDLE;
		R <= 1;
		finish <= 0;
	end
	else begin
		state <= nextstate;
		R <= next_R;
		finish <= next_finish;
	end
end

always_comb begin
	case(state)
		IDLE : begin
			next_R = R;
			next_finish = finish;
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
				next_finish = 1;
				nextstate = IDLE;
			end
		end
		default : nextstate = IDLE;
	endcase
end

assign R_out = R;
assign done = finish; 

endmodule;
