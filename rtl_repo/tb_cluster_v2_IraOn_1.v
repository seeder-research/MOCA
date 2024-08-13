`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps



module tb_cluster_v2_IraOn_1();
	
	localparam period = 6;
	localparam half_period = 3;

	// AXI lines
	reg 					ACLK;
	reg 					ARESET;
	wire 		  			S_AXIS_TREADY;
	reg  		[127:0] 	S_AXIS_TDATA;
	reg 		  			S_AXIS_TVALID;
	reg 		  			M_AXIS_TREADY;
	wire 		  [127:0] 	M_AXIS_TDATA;
	wire 		  			M_AXIS_TVALID;

	// To the input buffer (DMA data lines)
	reg 		[127:0] 	IB_1;
	reg 		[127:0] 	IB_2;
	reg 		[127:0] 	IB_3;
	reg 		[127:0] 	IB_4;

	// To the digital computing unit
	wire 	[1030:0] D_OUT;	        // width to be reduced

	// 2D mesh Data lines
	reg 		[127:0] 	N_din;
	reg 		[127:0] 	E_din;
	reg			[127:0] 	S_din;
	reg 		[127:0] 	W_din;

	wire 		[127:0] 	N_dout;
	wire 		[127:0] 	E_dout;
	wire 		[127:0] 	S_dout;
	wire 		[127:0] 	W_dout;

	// DFT lines
	wire 		[3:0] 		dft_state;



	cluster DUT(
		.ACLK(ACLK),
		.ARESET(ARESET),
		.S_AXIS_TREADY(S_AXIS_TREADY),
		.S_AXIS_TDATA(S_AXIS_TDATA),
		.S_AXIS_TVALID(S_AXIS_TVALID),
		.M_AXIS_TREADY(M_AXIS_TREADY),
		.M_AXIS_TDATA(M_AXIS_TDATA),
		.M_AXIS_TVALID(M_AXIS_TVALID),

		.IB_1(IB_1),
		.IB_2(IB_2),
		.IB_3(IB_3),
		.IB_4(IB_4),

		.D_OUT(D_OUT),

		.N_din(N_din),
		.E_din(E_din),
		.S_din(S_din),
		.W_din(W_din),

		.N_dout(N_dout),
		.E_dout(E_dout),
		.S_dout(S_dout),
		.W_dout(W_dout),

		.dft_state(dft_state)
	);


/* for reference only
    localparam NUM_ROW_START = 0;
    localparam NUM_ROW_END = 6;
    localparam NUM_COL_START = 7;
    localparam NUM_COL_END = 13;
    localparam IS_PROGRAM = 14;
    localparam IS_LOCAL_ADD = 15;
    localparam IS_REUSE = 16;
    localparam IS_SHIFT = 17;
    localparam IS_REMASK = 18;
    localparam NUM_TRIAL_START = 19;
    localparam NUM_TRIAL_END = 26;
*/
	
	localparam num_col = 16;		// the number of columns
	localparam num_trial = 5;		// the number of trials
	localparam is_program = 0;		// flag of programming

	initial
	begin
		ACLK = 0;
		#period;
		ACLK = 1;
	end
	
	integer i;

	always #half_period ACLK =~ ACLK;

	initial 
	begin
		ARESET = 0;
		# period;
		ARESET = 1;
		# period;
		if (is_program == 1)
			S_AXIS_TDATA = 32'b100_0_1101_0010000_0011001;		// IraOn-1 config_mem
		else
			S_AXIS_TDATA = 32'b100_0_1100_0010000_0011001;		// IraOn-1 config_mem
		IB_1 = 128'b0;
		IB_2 = 128'b0;
		IB_3 = 128'b0;
		IB_4 = 128'b0;
		N_din = 128'b0;
		E_din = 128'b0;
		S_din = 128'b0;
		W_din = 128'b0;
		# period;
		ARESET = 0;

		if (is_program == 1)
		begin
		# period;
	    for(i=0; i<num_col; i=i+1)
		    begin
				# period;
				S_AXIS_TDATA = $urandom() % 7'b1111111;		// programming
			end
		end
		else
		begin
			# period;
		end

		# period;
		S_AXIS_TDATA = 128'b1_000;		// mux_sel

		# period;
		S_AXIS_TDATA = 128'b00001_00001_00001_00001;		// mux_sel (under partial unicast)
		
		# period;
		S_AXIS_TDATA = 128'b1_001;		// rt_sel

		# period;
		//                 /RT1: L    N     E     S    W /RT2: L    N     E     S    W /RT3: L    N     E     S    W /RT4: L    N     E     S    W /
		S_AXIS_TDATA = 128'b10000_00000_00000_00000_00000_10000_00000_00000_00000_00000_10000_00000_00000_00000_00000_10000_00000_00000_00000_00000;		// rt_sel

		# period;
		S_AXIS_TDATA = 128'b1_010;		// row_mask

		# period;
		S_AXIS_TDATA = 128'b00001_00001_00001_00001_00001;		// row_mask_1

		# period;
		S_AXIS_TDATA = 128'b00001_00001_00001_00001_00001;		// row_mask_2

		# period;
		S_AXIS_TDATA = 128'b00001_00001_00001_00001_00001;		// row_mask_3

		# period;
		S_AXIS_TDATA = 128'b00001_00001_00001_00001_00001;		// row_mask_4

		# period;
		S_AXIS_TDATA = 128'b0_011;		// col_mask

		# period;
		S_AXIS_TDATA = 128'b1111_1111_1111_1111;		// col_mask_1

		# period;
		S_AXIS_TDATA = 128'b1111_1111_1111_1111;		// col_mask_2

		# period;
		S_AXIS_TDATA = 128'b1111_1111_1111_1111;		// col_mask_3

		# period;
		S_AXIS_TDATA = 128'b1111_1111_1111_1111;		// col_mask_4
		
		# period;
	    for(i=0; i<num_trial-1; i=i+1)
		begin
		# period; # period; # period; # period; # period; # period;
		// shifting here
		
		# period;
		IB_1 = $urandom() % 7'b1111111;
		IB_2 = $urandom() % 7'b1111111;
		IB_3 = $urandom() % 7'b1111111;
		IB_4 = $urandom() % 7'b1111111;
		
		end
	end

endmodule