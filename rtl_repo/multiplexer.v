module multiplexer(
	input clk,
	input [127:0] din1,
	input [127:0] din2,
	input [127:0] din3,
	input [127:0] din4,
	input [127:0] din_ib,

	input [4:0] sel,

	output reg [127:0] dout
);

always@ (posedge clk) begin
	case(sel)
		5'b00001: dout <= din_ib;
		5'b00010: dout <= din1;
		5'b00100: dout <= din2;
		5'b01000: dout <= din3;
		5'b10000: dout <= din4;
	endcase
end

endmodule
