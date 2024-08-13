module output_reg # (parameter DATA_DIGITS=4,parameter INDEX_DEGITS=2)
(
input [DATA_DIGITS-1:0] din,
output reg [DATA_DIGITS-1:0] dout,
input [DATA_DIGITS-1:0] col_mask,
input ad_en,
input clk
);

always @(posedge clk) begin
	if(col_mask[0]==1'b1) dout[0]<=din[0];
	if(col_mask[1]==1'b1) dout[1]<=din[1];
	if(col_mask[2]==1'b1) dout[2]<=din[2];
	if(col_mask[3]==1'b1) dout[3]<=din[3];
end

endmodule
