module cluster(

	// AXI lines
	input 					ACLK,
	input 					ARESET,
	output 		  			S_AXIS_TREADY,
	input  		[127:0] 	S_AXIS_TDATA,
	input 		  			S_AXIS_TVALID,
	input 		  			M_AXIS_TREADY,
	output reg  [127:0] 	M_AXIS_TDATA,
	output 		  			M_AXIS_TVALID,

	// To the input buffer (DMA data lines)
	input 		[127:0] 	IB_1,
	input 		[127:0] 	IB_2,
	input 		[127:0] 	IB_3,
	input 		[127:0] 	IB_4,

	// To the digital computing unit
	output reg 	[1030:0] D_OUT,	// width to be reduced

	// 2D mesh Data lines
	input 		[127:0] 	N_din,
	input 		[127:0] 	E_din,
	input		[127:0] 	S_din,
	input 		[127:0] 	W_din,

	output 		[127:0] 	N_dout,
	output 		[127:0] 	E_dout,
	output 		[127:0] 	S_dout,
	output 		[127:0] 	W_dout,

	// DFT lines
	output 		[3:0] 		dft_state
);


wire [127:0] addr;

wire [127:0] pe_bond_12_e2w;
wire [127:0] pe_bond_12_w2e;

wire [127:0] pe_bond_34_e2w;
wire [127:0] pe_bond_34_w2e;

wire [127:0] pe_bond_13_n2s;
wire [127:0] pe_bond_13_s2n;

wire [127:0] pe_bond_24_n2s;
wire [127:0] pe_bond_24_s2n;

wire [4:0] Mux_sel_1;
wire [4:0] Mux_sel_2;
wire [4:0] Mux_sel_3;
wire [4:0] Mux_sel_4;

wire [127:0] Row_mask_1;
wire [127:0] Row_mask_2;
wire [127:0] Row_mask_3;
wire [127:0] Row_mask_4;

wire [24:0] Rt_sel_1;
wire [24:0] Rt_sel_2;
wire [24:0] Rt_sel_3;
wire [24:0] Rt_sel_4;

wire [127:0] R1_dout;
wire [127:0] R2_dout;
wire [127:0] R3_dout;
wire [127:0] R4_dout;

wire [127:0] MP1_dout;
wire [127:0] MP2_dout;
wire [127:0] MP3_dout;
wire [127:0] MP4_dout;

wire [127:0] IR1_dout;
wire [127:0] IR2_dout;
wire [127:0] IR3_dout;
wire [127:0] IR4_dout;

wire [1023:0] PE1_dout;
wire [1023:0] PE2_dout;
wire [1023:0] PE3_dout;
wire [1023:0] PE4_dout;

wire [9:0] control;

reg [3:0] LA_mask; 

wire [1030:0] LA_OUT_1;
wire [1030:0] LA_OUT_2;
wire [1030:0] LA_OUT_3;
wire [1030:0] LA_OUT_4;

wire com_done_1;
wire com_done_2;
wire com_done_3;
wire com_done_4;

wire com_done;
assign com_done = com_done_1 & com_done_2 & com_done_3 & com_done_4;

always @(*)
begin
	LA_mask <= 4'b0001; 

	if (LA_mask[0]==1'b1)
		D_OUT <= LA_OUT_1;
	else if (LA_mask[1]==1'b1)
		D_OUT <= LA_OUT_2;
	else if (LA_mask[2]==1'b1)
		D_OUT <= LA_OUT_3;
	else if (LA_mask[3]==1'b1)
		D_OUT <= LA_OUT_4;
end


router r1(.Local_din(IB_1),
		.RT_en(control[4]),
		.Local_dout(R1_dout),
		.clk(ACLK),
		.Local_out_dire(Rt_sel_1[24:20]),
		.N_din(N_din),
		.E_din(E_din),
		.S_din(pe_bond_13_s2n),
		.W_din(pe_bond_12_w2e),
		.N_out_dire(Rt_sel_1[19:15]),
		.E_out_dire(Rt_sel_1[14:10]),
		.S_out_dire(Rt_sel_1[9:5]),
		.W_out_dire(Rt_sel_1[4:0]),
		.N_dout(N_dout),
		.E_dout(E_dout),
		.S_dout(pe_bond_13_n2s),
		.W_dout(pe_bond_12_e2w));

router r2(.Local_din(IB_2),
		.RT_en(control[4]),
		.Local_dout(R2_dout),
		.clk(ACLK),
		.Local_out_dire(Rt_sel_2[24:20]),
		.N_din(N_din),
		.E_din(pe_bond_12_e2w),
		.S_din(pe_bond_24_s2n),
		.W_din(W_din),
		.N_out_dire(Rt_sel_2[19:15]),
		.E_out_dire(Rt_sel_2[14:10]),
		.S_out_dire(Rt_sel_2[9:5]),
		.W_out_dire(Rt_sel_2[4:0]),
		.N_dout(N_dout),
		.E_dout(pe_bond_12_w2e),
		.S_dout(pe_bond_24_n2s),
		.W_dout(W_dout));

router r3(.Local_din(IB_3),
		.RT_en(control[4]),
		.Local_dout(R3_dout),
		.clk(ACLK),
		.Local_out_dire(Rt_sel_3[24:20]),
		.N_din(pe_bond_13_n2s),
		.E_din(E_din),
		.S_din(S_din),
		.W_din(pe_bond_34_w2e),
		.N_out_dire(Rt_sel_3[19:15]),
		.E_out_dire(Rt_sel_3[14:10]),
		.S_out_dire(Rt_sel_3[9:5]),
		.W_out_dire(Rt_sel_3[4:0]),
		.N_dout(pe_bond_13_s2n),
		.E_dout(E_dout),
		.S_dout(S_dout),
		.W_dout(pe_bond_34_e2w));

router r4(.Local_din(IB_4),
		.RT_en(control[4]),
		.Local_dout(R4_dout),
		.clk(ACLK),
		.Local_out_dire(Rt_sel_4[24:20]),
		.N_din(pe_bond_24_n2s),
		.E_din(pe_bond_34_e2w),
		.S_din(S_din),
		.W_din(W_din),
		.N_out_dire(Rt_sel_4[19:15]),
		.E_out_dire(Rt_sel_4[14:10]),
		.S_out_dire(Rt_sel_4[9:5]),
		.W_out_dire(Rt_sel_4[4:0]),
		.N_dout(pe_bond_24_s2n),
		.E_dout(pe_bond_34_w2e),
		.S_dout(S_dout),
		.W_dout(W_dout));

// din1 (N)  din2 (E)  din3 (S)  din4 (W)

multiplexer MP1(
		.clk(ACLK),
		.din1(R1_dout),
		.din2(R2_dout),
		.din3(R3_dout),
		.din4(R4_dout),
		.din_ib(IB_1),
		.sel(Mux_sel_1),
		.dout(MP1_dout));

multiplexer MP2(
		.clk(ACLK),
		.din1(R1_dout),
		.din2(R2_dout),
		.din3(R3_dout),
		.din4(R4_dout),
		.din_ib(IB_2),
		.sel(Mux_sel_2),
		.dout(MP2_dout));

multiplexer MP3(
		.clk(ACLK),
		.din1(R1_dout),
		.din2(R2_dout),
		.din3(R3_dout),
		.din4(R4_dout),
		.din_ib(IB_3),
		.sel(Mux_sel_3),
		.dout(MP3_dout));

multiplexer MP4(
		.clk(ACLK),
		.din1(R1_dout),
		.din2(R2_dout),
		.din3(R3_dout),
		.din4(R4_dout),
		.din_ib(IB_4),
		.sel(Mux_sel_4),
		.dout(MP4_dout));

input_reg IR1(
		.clk(ACLK),
		.wr_en(control[2]),
		.sh_en(control[3]),
		.row_mask(Row_mask_1),
		.din(MP1_dout),
		.data(IR1_dout),
		.rewr_en(control[1]));

input_reg IR2(
		.clk(ACLK),
		.wr_en(control[2]),
		.sh_en(control[3]),
		.row_mask(Row_mask_2),
		.din(MP2_dout),
		.data(IR2_dout),
		.rewr_en(control[1]));

input_reg IR3(
		.clk(ACLK),
		.wr_en(control[2]),
		.sh_en(control[3]),
		.row_mask(Row_mask_3),
		.din(MP3_dout),
		.data(IR3_dout),
		.rewr_en(control[1]));

input_reg IR4(
		.clk(ACLK),
		.wr_en(control[2]),
		.sh_en(control[3]),
		.row_mask(Row_mask_4),
		.din(MP4_dout),
		.data(IR4_dout),
		.rewr_en(control[1]));

com_mem PE1(.clk(ACLK),
		.cm_en(control[5]),
		.pe_en(control[7]),
		.din(IR1_dout),
		.dout(PE1_dout),
		.we_en(control[6]),
		.done(com_done_1),
		.addr(addr)
		);

com_mem PE2(.clk(ACLK),
		.cm_en(control[5]),
		.pe_en(control[7]),
		.din(IR2_dout),
		.dout(PE2_dout),
		.we_en(control[6]),
		.done(com_done_2),
		.addr(addr)
		);

com_mem PE3(.clk(ACLK),
		.cm_en(control[5]),
		.pe_en(control[7]),
		.din(IR3_dout),
		.dout(PE3_dout),
		.we_en(control[6]),
		.done(com_done_3),
		.addr(addr)
		);

com_mem PE4(.clk(ACLK),
		.cm_en(control[5]),
		.pe_en(control[7]),
		.din(IR4_dout),
		.dout(PE4_dout),
		.we_en(control[6]),
		.done(com_done_4),
		.addr(addr)
		);

local_adder LA1(
		.clk(ACLK),
		.rst(control[8]),
		.din(PE1_dout),
		.dout(LA_OUT_1),
		.en(control[9]));

local_adder LA2(
		.clk(ACLK),
		.rst(control[8]),
		.din(PE2_dout),
		.dout(LA_OUT_2),
		.en(control[9]));

local_adder LA3(
		.clk(ACLK),
		.rst(control[8]),
		.din(PE3_dout),
		.dout(LA_OUT_3),
		.en(control[9]));

local_adder LA4(
		.clk(ACLK),
		.rst(control[8]),
		.din(PE4_dout),
		.dout(LA_OUT_4),
		.en(control[9]));

fsm FSM(
		.clk(ACLK),
		.areset(ARESET),
		.out(control),
		.data(S_AXIS_TDATA),
		.mux_sel_1(Mux_sel_1),
		.mux_sel_2(Mux_sel_2),
		.mux_sel_3(Mux_sel_3),
		.mux_sel_4(Mux_sel_4),
		.row_mask_1(Row_mask_1),
		.row_mask_2(Row_mask_2),
		.row_mask_3(Row_mask_3),
		.row_mask_4(Row_mask_4),
		.rt_sel_1(Rt_sel_1),
		.rt_sel_2(Rt_sel_2),
		.rt_sel_3(Rt_sel_3),
		.rt_sel_4(Rt_sel_4),
		.dft_state(dft_state),
		.col_addr(addr),
		.com_done(com_done));

endmodule
