module local_adder(
	input clk,
	input en,
	input rst,
	input [1023:0] din,

	output reg [1030:0] dout
);

always@(posedge clk) 
	begin

		if(en==1'b1) 
		begin
			if(rst==1'b1) 
				dout<=1031'b0;
			else if(din===1024'bx) 
				dout<=dout;
			else 
				begin 
					dout<=dout+din;
				end
		end

	end
endmodule
