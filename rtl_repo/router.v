module router(
	input RT_en,	// unused here
	
	input[127:0] N_din,
	input[127:0] E_din,
	input[127:0] S_din,
	input[127:0] W_din,
	input[127:0] Local_din,

	input[4:0] N_out_dire,
	input[4:0] E_out_dire,
	input[4:0] S_out_dire,
	input[4:0] W_out_dire,
	input[4:0] Local_out_dire,

	output reg[127:0] N_dout,
	output reg[127:0] E_dout,
	output reg[127:0] S_dout,
	output reg[127:0] W_dout,
	output reg[127:0] Local_dout,
	input clk
);

reg [127:0] N_data;
reg [127:0] E_data;
reg [127:0] S_data;
reg [127:0] W_data;
reg [127:0] Local_data;
always @(posedge clk) begin

N_data=N_din;
E_data=E_din;
S_data=S_din;
W_data=W_din;
Local_data=Local_din;



case(N_out_dire)
	5'b00001: N_dout=N_din;
	5'b00010: N_dout=E_din;
	5'b00100: N_dout=S_din;
	5'b01000: N_dout=W_din;
	5'b10000: N_dout=Local_din;
endcase

case(E_out_dire)
	5'b00001: E_dout=N_din;
	5'b00010: E_dout=E_din;
	5'b00100: E_dout=S_din;
	5'b01000: E_dout=W_din;
	5'b10000: E_dout=Local_din;
endcase

case(S_out_dire)
	5'b00001: S_dout=N_din;
	5'b00010: S_dout=E_din;
	5'b00100: S_dout=S_din;
	5'b01000: S_dout=W_din;
	5'b10000: S_dout=Local_din;
endcase

case(W_out_dire)
	5'b00001: W_dout=N_din;
	5'b00010: W_dout=E_din;
	5'b00100: W_dout=S_din;
	5'b01000: W_dout=W_din;
	5'b10000: W_dout=Local_din;
endcase

case(Local_out_dire)
	5'b00001: Local_dout=N_din;
	5'b00010: Local_dout=E_din;
	5'b00100: Local_dout=S_din;
	5'b01000: Local_dout=W_din;
	5'b10000: Local_dout=Local_din;
endcase
end

endmodule