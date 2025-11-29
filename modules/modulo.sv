/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off UNOPTFLAT */
/* verilator lint_off LATCH */


module modulo #(parameter DATA_WIDTH = 8)(
  input logic [2*DATA_WIDTH:0]  a,
  input logic [DATA_WIDTH-1:0]  modulant,
  input logic 				    clk,
  input logic				    start,
  output logic [DATA_WIDTH-1:0] out,
  output logic					done
);

typedef enum logic [1:0] {IDLE=2'b00, ALIGN=2'b01, SUBSTRACT=2'b10} statetype;

statetype state;
statetype nextstate;

logic finish;
logic next_finish;
logic [7:0] shift;
logic [7:0] next_shift;
logic [2*DATA_WIDTH:0] dividend;
logic [2*DATA_WIDTH:0] next_dividend;
logic [2*DATA_WIDTH:0] divisor;
logic [2*DATA_WIDTH:0] next_divisor;

always_ff @(posedge clk) begin
	if(start) begin
		state <= IDLE;
		shift <=  8'd0;
		dividend <= a;
		divisor <= modulant;
		finish <= 1'b0;
	end
	else begin
		state <= nextstate;
		shift <= next_shift;
		dividend <= next_dividend;
		divisor <= next_divisor;
		finish <= next_finish;
	end
end

always_comb begin

	case(state)
		IDLE: begin
			next_shift = shift;
			next_dividend = dividend;
			next_divisor = divisor;
			next_finish = finish;
			if(finish == 0)
				nextstate = ALIGN;
		end
		ALIGN: begin
			if(divisor <= dividend) begin
				next_divisor = divisor << 1;
				next_shift = shift + 1;
			end
			else
				nextstate = SUBSTRACT;
		end
		SUBSTRACT: begin
			if(dividend >= divisor)
				next_dividend = dividend - divisor;
			next_divisor = divisor >> 1;
			next_shift = shift - 1;
			if(shift == 1) begin
				next_finish = 1;
				nextstate = IDLE;
			end
		end
		default : nextstate = IDLE;
	endcase
end

assign done = finish;
assign out = dividend >= modulant ? dividend - modulant : dividend;

endmodule;


