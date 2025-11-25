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

typedef enum logic [2:0] {IDLE=3'b000, ALIGN=3'b001, SUBSTRACT=3'b010, SUBSTRACT_TWO=3'b011, FINISH=3'b100} statetype;

statetype state;
statetype nextstate;

logic finish;
logic next_finish;
logic [7:0] shift;
logic [7:0] next_shift;
logic [DATA_WIDTH-1:0] dividend;
logic [DATA_WIDTH-1:0] next_dividend;
logic [DATA_WIDTH-1:0] divisor;
logic [DATA_WIDTH-1:0] next_divisor;

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
			else
				nextstate = IDLE;
		end
		ALIGN: begin
			if((divisor <= dividend)&&(~divisor[DATA_WIDTH-1])&&(shift < DATA_WIDTH)) begin
				next_divisor = divisor << 1;
				next_shift = shift + 1;
				nextstate = ALIGN;
			end
			else
				nextstate = SUBSTRACT;
		end
		SUBSTRACT: begin
			if(dividend >= divisor)
				next_dividend = dividend - divisor;
			next_divisor = divisor >> 1;
			next_shift = shift - 1;
			nextstate = SUBSTRACT_TWO;
		end
		SUBSTRACT_TWO : begin
			if((dividend < divisor)||(shift == 0)||(shift >= DATA_WIDTH))
				nextstate = FINISH;
			else
				nextstate = SUBSTRACT;
		end
		FINISH: begin
			next_finish = 1;
			nextstate = IDLE;
		end
		default : nextstate = IDLE;
	endcase
end

assign done = finish;
assign out = dividend >= modulant ? dividend - modulant : dividend;

endmodule;


