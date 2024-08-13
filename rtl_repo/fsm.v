module fsm(
    input clk,
    input areset,    // Asynchronous reset to state B
    input [127:0] data,
    input com_done,

    // mux_sel (5*4 = 20 bits)
    output reg [4:0] mux_sel_1,
    output reg [4:0] mux_sel_2,
    output reg [4:0] mux_sel_3,
    output reg [4:0] mux_sel_4,

    // rt_sel (25*4 = 100 bits)
    output reg [24:0] rt_sel_1,
    output reg [24:0] rt_sel_2,
    output reg [24:0] rt_sel_3,
    output reg [24:0] rt_sel_4,

    // row_mask (128*4 = 512 bits)
    output reg [127:0] row_mask_1,
    output reg [127:0] row_mask_2,
    output reg [127:0] row_mask_3,
    output reg [127:0] row_mask_4,

    // col_mask (128*4 = 512 bits)
    output reg [127:0] col_mask_1,
    output reg [127:0] col_mask_2,
    output reg [127:0] col_mask_3,
    output reg [127:0] col_mask_4,

    // output reg [127:0] row_addr,
    output reg [127:0] col_addr,

    output reg [3:0] dft_state,
    output reg [9:0] out
    );
    
    
    
    parameter
    STATE_INIT = 4'b0000,
    STATE_BRAN = 4'b0001,
    STATE_PROG = 4'b0010,
    STATE_CONF = 4'b0011,
    STATE_READ_IR = 4'b0100,
    STATE_READ_PE = 4'b0101,
    STATE_COM = 4'b0110,
    STATE_LOC_ADD = 4'b0111,
    STATE_OUT = 4'b1000,
    STATE_REUSE = 4'b1001,
    STATE_END = 4'b1010;



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



    reg [31:0] config_mem;
    reg [3:0] next_state;
    
    reg is_prog_done;
    reg is_prog_row_en;

    reg [2:0] read_word_count;
    reg [2:0] config_word_id;
    reg config_word_continue;

    reg [6:0] num_used_col;
    reg [6:0] idx_cur_col;

    reg [7:0] trial_count;  // unused at this moment
    reg [1:0] state_read_count;
    reg [1:0] next_state_read_count;


    always @(posedge clk or posedge areset)
    begin
        if(areset)
            begin
                next_state <= STATE_INIT;
                out <= 10'b00_0000_0000;
                trial_count <= 0;
                idx_cur_col <= 0;
                read_word_count <= 0;
            end

        else
        begin
            case (next_state)
                STATE_INIT:
                begin
                    config_mem <= data [31:0];      // Initialize the config_mem
                    next_state <= STATE_BRAN;
                end

                STATE_BRAN:
                begin
                    num_used_col <= config_mem [NUM_COL_END:NUM_COL_START] - 1;
                    if (config_mem [IS_PROGRAM] == 1)
                    begin
                        next_state <= STATE_PROG;
                        is_prog_done <= 0;
                        idx_cur_col <= 0;

                        mux_sel_1 <= 5'b00001;  // connected to input buffer
                        mux_sel_2 <= 5'b00001;
                        mux_sel_3 <= 5'b00001;
                        mux_sel_4 <= 5'b00001;

                        rt_sel_1 <= 25'b10000_00000_00000_00000_00000;
                        rt_sel_2 <= 25'b10000_00000_00000_00000_00000;
                        rt_sel_3 <= 25'b10000_00000_00000_00000_00000;
                        rt_sel_4 <= 25'b10000_00000_00000_00000_00000;

                        out <= 10'b00_0000_0000;    // to be double-checked
                    end
                    else
                    begin
                        next_state <= STATE_CONF;
                        read_word_count <= 0;
                    end
                end

                STATE_PROG:
                begin
                    if (idx_cur_col >= num_used_col)
                    begin
                        next_state <= STATE_CONF;
                        out <= 10'b00_1100_0000;        // pe_en = 1 && wr_en = 1
                        idx_cur_col <= 0;
                        // is_prog_done <= 1;
                        read_word_count <= 0;
                    end
                    else
                    begin
                        next_state <= STATE_PROG;
                        out <= 10'b00_1100_0000;        // pe_en = 1 && wr_en = 1
                        idx_cur_col <= idx_cur_col + 1;
                        // is_prog_done <= 0;
                        read_word_count <= 0;
                    end
                end

                STATE_CONF:
                begin
                    if (read_word_count == 0)
                    begin
                        config_word_id <= data [2:0];
                        config_word_continue <= data [3];
                        next_state <= STATE_CONF;
                        read_word_count <= 1;
                    end
                    else if (read_word_count == 1)
                    begin
                        case (config_word_id)
                            0:
                            begin
                                mux_sel_1 <= data [4:0];
                                mux_sel_2 <= data [9:5];
                                mux_sel_3 <= data [14:10];
                                mux_sel_4 <= data [19:15];

                                if (config_word_continue == 1'b1)
                                begin
                                    next_state <= STATE_CONF;
                                    read_word_count <=0;
                                end
                                else
                                begin
                                    next_state <= STATE_READ_IR;
                                    state_read_count <= 0;
                                end
                            end

                            1:
                            begin
                                rt_sel_1 <= data [24:0];
                                rt_sel_2 <= data [49:25];
                                rt_sel_3 <= data [74:50];
                                rt_sel_4 <= data [99:75];

                                if (config_word_continue == 1'b1)
                                begin
                                    next_state <= STATE_CONF;
                                    read_word_count <=0;
                                end
                                else
                                begin
                                    next_state <= STATE_READ_IR;
                                    state_read_count <= 0;
                                end
                            end

                            2:
                            begin
                                row_mask_1 <= data;

                                next_state <= STATE_CONF;
                                read_word_count <=2;
                            end

                            3: 
                            begin
                                col_mask_1 <= data;

                                next_state <= STATE_CONF;
                                read_word_count <=2;
                            end
                        endcase
                    end
                    else if (read_word_count == 2)
                    begin
                        case (config_word_id)
                            2:
                            begin
                                row_mask_2 <= data;

                                next_state <= STATE_CONF;
                                read_word_count <=3;
                            end

                            3: 
                            begin
                                col_mask_2 <= data;

                                next_state <= STATE_CONF;
                                read_word_count <=3;
                            end
                        endcase
                    end
                    else if (read_word_count == 3)
                    begin
                        case (config_word_id)
                            2:
                            begin
                                row_mask_3 <= data;

                                next_state <= STATE_CONF;
                                read_word_count <=4;
                            end

                            3: 
                            begin
                                col_mask_3 <= data;

                                next_state <= STATE_CONF;
                                read_word_count <=4;
                            end
                        endcase
                    end
                    else if (read_word_count == 4)
                    begin
                        case (config_word_id)
                            2:
                            begin
                                row_mask_4 <= data;

                                if (config_word_continue == 1'b1)
                                begin
                                    next_state <= STATE_CONF;
                                    read_word_count <=0;
                                end
                                else
                                begin
                                    next_state <= STATE_READ_IR;
                                    state_read_count <= 0;
                                end
                            end

                            3: 
                            begin
                                col_mask_4 <= data;

                                if (config_word_continue == 1'b1)
                                begin
                                    next_state <= STATE_CONF;
                                    read_word_count <=0;
                                end
                                else
                                begin
                                    next_state <= STATE_READ_IR;
                                    state_read_count <= 0;
                                end
                            end
                        endcase
                    end
                end

                STATE_READ_IR:
                begin
                    if (trial_count == 0)
                    begin
                        out <= 10'b00_0000_0100;        // (IR) wr_en = 1       // to be updated
                        next_state <= STATE_READ_PE;
                    end
                    else
                    begin 
                        out <= 10'b00_0000_0010;        // (IR) rewr_en = 1       // to be updated
                        next_state <= STATE_READ_PE;
                    end
                end

                STATE_READ_PE:
                begin
                    if (trial_count == 0)
                    begin
                        out <= 10'b00_1100_0000;        // (PE) pe_en = 1 && wr_en = 1       // to be updated
                        next_state <= STATE_COM;
                    end
                    else
                    begin 
                        out <= 10'b00_1100_0000;        // pe_en = 1 && wr_en = 1       // to be updated
                        next_state <= STATE_COM;
                    end
                end

                STATE_COM:
                begin
                    out <= 10'b00_1010_0000;        // pe_en = 1 && cm_en = 1

                    if (com_done == 1)
                    begin
                        if (config_mem [IS_LOCAL_ADD] == 1)
                            next_state <= STATE_LOC_ADD;
                        else
                            next_state <= STATE_OUT;
                    end
                    else
                    begin
                        next_state <= STATE_COM;
                    end
                end

                STATE_LOC_ADD:
                begin
                    out <= 10'b01_0000_0000;        // la_en = 1
                    next_state <= STATE_OUT;
                end

                STATE_OUT:
                begin
                    trial_count <= trial_count + 1;

                    if (trial_count >= config_mem [NUM_TRIAL_END:NUM_TRIAL_START])
                    begin
                        next_state <= STATE_END;
                    end
                    else if (config_mem [IS_REUSE] == 1)
                    begin
                        next_state <= STATE_REUSE;
                        read_word_count <= 0;
                    end
                    else
                    begin
                        next_state <= STATE_READ_IR;
                        state_read_count <= 0;
                    end
                end

                STATE_REUSE:
                begin
                    if (config_mem [IS_SHIFT] == 1)
                    begin
                        out <= 10'b00_0000_1000;        // sh_en = 1
                        next_state <= STATE_READ_IR;
                        state_read_count <= 0;
                    end
                    else if (config_mem [IS_REMASK] == 1)
                    begin
                        if (read_word_count == 0)
                        begin
                            mux_sel_1 <= data [4:0];
                            mux_sel_2 <= data [9:5];
                            mux_sel_3 <= data [14:10];
                            mux_sel_4 <= data [19:15];

                            next_state <= STATE_REUSE;
                            read_word_count <=1;
                        end
                        else if (read_word_count == 1)
                        begin
                            rt_sel_1 <= data [24:0];
                            rt_sel_2 <= data [49:25];
                            rt_sel_3 <= data [74:50];
                            rt_sel_4 <= data [99:75];

                            next_state <= STATE_READ_IR;
                            state_read_count <= 0;
                            read_word_count <=0;
                        end
                    end

                end

                STATE_END:
                begin
                    next_state <= STATE_END;
                end

            endcase
        end
    end



    always @(*)
    begin
        dft_state <= next_state;
    end


endmodule
