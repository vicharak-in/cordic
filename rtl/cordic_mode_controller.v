module cordic_mode_controller (
input             clk,
input             empty,
input [47:0]      Cor_in_data,  
output            i_call_1, 
output            i_call_2,
output            i_call_3,
output            i_call_4,
output            i_call_5,
output            i_call_6,
output            i_call_7,
output            i_call_8,
output reg        reset_n = 0,
output reg        RD_en = 0,
output reg        wr_en = 0,
output reg [31:0] i_data = 0,
output reg [31:0] i_data2 = 0,
output reg [47:0] wr_data = 0
);

reg        i_call = 0;
reg [1:0]  count = 0;
reg [7:0]  mode = 0;
reg [47:0] rdata = 0;
reg [1:0]  rd_state = 0;
reg [47:0] out_data = 0;
reg [31:0] out_data_tan = 0;
reg [2:0]  wr_state = 0; 

localparam RD_IDLE = 2'b00;
localparam RD_HOLD = 2'b01; 
localparam RD_SAMPLE = 2'b10;
localparam RD_ACCUM = 2'b11;
localparam W_IDLE = 3'h0; 
localparam W_SEND = 3'h1;

wire o_done_1;
wire o_done_2;
wire o_done_3;
wire o_done_4;
wire o_done_5;
wire o_done_6;
wire o_done_7;
wire o_done_8;

wire [31:0] o_cos;
wire [31:0] o_sin;
wire [31:0] o_tanh;
wire [31:0] o_exp;
wire [31:0] o_arcsin;
wire [31:0] o_ln;
wire [31:0] o_sqrt;
wire [31:0] o_arccos;
wire [31:0] o_arctan;
wire [31:0] o_cosht;
wire [31:0] o_sinht;
wire [31:0] o_cosh;
wire [31:0] o_sinh;
wire [31:0] o_deg;
wire [31:0] o_y;
wire [31:0] o_x;
  
always @(posedge clk) begin
    case (rd_state)
        RD_IDLE: begin 
            if (!empty) begin 
                RD_en <= 1;
                rd_state <= RD_HOLD;
            end
        end
        
        RD_HOLD: begin
            RD_en <= 0;
            rd_state <= RD_SAMPLE;
        end
        
        RD_SAMPLE: begin
            rdata <= Cor_in_data; 
            mode <=  Cor_in_data[39:32];
            rd_state <= RD_ACCUM;   
        end
        
        RD_ACCUM: begin
            if (rdata[39:32] == 8) begin
                if (!count) begin
                    i_data <= rdata[31:0];
                    count <= 1;
                    rd_state <= RD_IDLE;
                end else if (count == 1) begin
                    i_data2 <= rdata[31:0];
                    i_call <= 1;
                    reset_n <= 1;
                    count <= 2;
                end else begin
                    if (o_done_8) begin
                        rd_state <= RD_IDLE;
                        i_call <= 0;
                        reset_n <= 0;
                        count <= 0;
                        i_data <= 0;
                        i_data2 <= 0;
                    end
                end
            end else begin 
                i_data <= rdata[31:0];
                i_call <= 1;
                reset_n <= 1;
            end 
            if (o_done_1 || o_done_2 || o_done_3 || o_done_4 || o_done_5 ||
                    o_done_6 || o_done_7) begin
                rd_state <= RD_IDLE;
                i_call <= 0;
                reset_n <= 0;
                i_data <= 0;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (mode == 1 || mode == 2 || mode == 4 || mode == 9 || mode == 10 || mode == 11) begin
        case (wr_state)
            W_IDLE: begin 
                wr_en <= 0;
                wr_data <= 0;
                if (mode == 1) begin
                    if (o_done_1) begin
                        out_data <= {16'h000a,o_sin};
                        wr_state <= W_SEND;
                    end
                end else if (mode == 2) begin
                    if (o_done_2) begin
                        out_data <= {16'h000a,o_sinh};
                        wr_state <= W_SEND;
                    end
                end else if (mode == 4)begin
                    if (o_done_4) begin
                        out_data <= {16'h000a,o_arcsin};
                        wr_state <= W_SEND;
                    end 
                end else if (mode == 9)begin
                    if (o_done_1) begin
                        out_data <= {16'h000c,o_cos};
                        wr_state <= W_SEND;
                    end 
                end  else if (mode == 10)begin
                    if (o_done_2) begin
                        out_data <= {16'h000c,o_cosh};
                        wr_state <= W_SEND;
                    end 
                end else begin
                    if (o_done_4) begin
                        out_data <= {16'h000c,o_arccos};
                        wr_state <= W_SEND;
                    end 
                end 
            end 

            W_SEND: begin
                wr_data <= out_data; //sin
                wr_en <= 1;
                wr_state <= W_IDLE;
            end
        endcase
    end 
    
    else if (mode == 3) begin 
        case (wr_state)
            W_IDLE: begin 
                wr_en <= 0;
                wr_data <= 0;
                if (o_done_3) begin
                    out_data_tan <= o_tanh;
                    wr_state <= W_SEND;
                end
            end 

            W_SEND: begin
                wr_data <= {16'h000b,out_data_tan}; //tanh
                wr_state <= W_IDLE;
           end
        endcase
    end 
    
    else if (mode == 5|| mode == 6 || mode == 7 || mode == 8) begin
        case (wr_state)
            W_IDLE: begin 
                wr_en <= 0;
                wr_data <= 0;
                if (mode == 5) begin
                    if (o_done_5) begin
                        out_data_tan <= {o_exp};
                        wr_state <= W_SEND;
                    end
                end
                if (mode == 6) begin
                    if (o_done_6) begin
                        out_data_tan <= {o_ln};
                        wr_state <= W_SEND;
                    end
                end
                if (mode == 7) begin
                    if (o_done_7) begin
                        out_data_tan <= {o_sqrt};
                        wr_state <= W_SEND;
                    end
                end
                if (mode == 8) begin
                    if (o_done_8) begin
                        out_data_tan <= {o_arctan};
                        wr_state <= W_SEND;
                    end
                end
            end 
             
            W_SEND: begin
                if (mode == 5) wr_data <= {16'h000e, out_data_tan}; //exp
                else if (mode == 6) wr_data <= {16'h000f, out_data_tan};//ln
                else if (mode == 7) wr_data <= {16'h000d, out_data_tan}; // sqrt
                else wr_data <= {16'h000b, out_data_tan}; //arctan
                wr_en <= 1;
                wr_state <= W_IDLE;
            end
        endcase
    end else begin 
        wr_data <= 0;
        wr_en <= 0;
    end 
end

assign i_call_1 = ((mode == 1) || (mode == 9)) ? i_call: 0;
assign i_call_2 = ((mode == 2) || (mode == 10)) ? i_call: 0;
assign i_call_3 = (mode == 3) ? i_call: 0;
assign i_call_4 = ((mode == 4) || (mode == 11)) ? i_call: 0;
assign i_call_5 = (mode == 5) ? i_call: 0;
assign i_call_6 = (mode == 6) ? i_call: 0;
assign i_call_7 = (mode == 7) ? i_call: 0;
assign i_call_8 = (mode == 8) ? i_call: 0;
    
cordic_sin_cos sin (
    .clk        (clk),
    .reset_n    (reset_n),
    .i_call     (i_call_1),
    .i_data     (i_data),
    .o_done     (o_done_1),
    .o_cos      (o_cos),
    .o_sin      (o_sin)
);

cordic_sinh_cosh sinh(
    .clk        (clk),
    .reset_n    (reset_n),
    .i_call     (i_call_2),
    .i_data     (i_data),
    .o_done     (o_done_2),
    .o_cosh     (o_cosh),
    .o_sinh     (o_sinh)
);

cordic_tanh tanh(
    .clk         (clk),
    .reset_n     (reset_n),
    .i_call      (i_call_3),
    .i_data      (i_data),
    .o_done      (o_done_3),
    .o_cosh      (o_cosht),
    .o_sinh      (o_sinht),
    .o_tanh      (o_tanh)
);

cordic_arcsin_arccos arcsin (
    .clk        (clk),
    .reset_n    (reset_n),
    .i_call     (i_call_4),
    .i_data     (i_data),
    .o_done     (o_done_4),
    .o_arccos   (o_arccos),
    .o_arcsin   (o_arcsin)
);

cordic_exp exp (
    .clk        (clk),
    .reset_n    (reset_n),
    .i_call     (i_call_5),
    .i_data     (i_data),
    .o_done     (o_done_5),
    .o_exp      (o_exp)
);

cordic_ln ln (
    .clk        (clk),
    .reset_n    (reset_n),
    .i_call     (i_call_6),
    .i_data     (i_data),
    .o_done     (o_done_6),
    .o_ln       (o_ln)
);

cordic_sqrt sqrt (
    .clk        (clk),
    .reset_n    (reset_n),
    .i_call     (i_call_7),
    .i_data     (i_data),
    .o_done     (o_done_7),
    .o_sqrt     (o_sqrt)
);

cordic_arctan arctan(
    .clk        (clk),
    .reset_n    (reset_n),
    .i_call     (i_call_8),
    .i_x        (i_data),
    .i_y        (i_data2),
    .o_done     (o_done_8),
    .o_arctan   (o_arctan)
);

endmodule

