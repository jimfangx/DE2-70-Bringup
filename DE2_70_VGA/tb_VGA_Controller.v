`timescale 1ns/1ps

module tb_VGA_Controller ();
    
    reg [9:0] iRed_in;
    reg [9:0] iGreen_in;
    reg [9:0] iBlue_in;

    reg clock_in;
    reg reset_in;

    wire [9:0] curr_x_out;
    wire [9:0] curr_y_out;

    wire [9:0] oVGA_R_out;
    wire [9:0] oVGA_G_out;
    wire [9:0] oVGA_B_out;

    wire oVGA_H_SYNC_out;
    wire oVGA_V_SYNC_out;
    
    wire oVGA_SYNC_out;
    
    wire oVGA_BLANK_out;

    wire oVGA_CLOCK_out;
    

// dut
VGA_Controller instance1(

    .iRed(iRed_in),
    .iGreen(iGreen_in),
    .iBlue(iBlue_in),

    .iCLK(clock_in),
    .iRST(reset_in),

    .oCurrent_X(curr_x_out),
    .oCurrent_Y(curr_y_out),

    .oVGA_R(oVGA_R_out),
    .oVGA_G(oVGA_G_out),
    .oVGA_B(oVGA_B_out),
    .oVGA_H_SYNC(oVGA_H_SYNC_out),
	.oVGA_V_SYNC(oVGA_V_SYNC_out),
	.oVGA_SYNC(oVGA_SYNC_out),
	.oVGA_BLANK(oVGA_BLANK_out),
	.oVGA_CLOCK(oVGA_CLOCK_out)
);

initial begin
    reset_in = 1;  
    iRed_in = 0;
    iGreen_in = 0;
    iBlue_in = 0;
    clock_in = 0;
    // curr_x_out = 0;
    // curr_y_out = 0;
    // oVGA_H_SYNC_out = 0;
    // oVGA_V_SYNC_out = 0;
    // oVGA_BLANK_out = 0;

    #40

    reset_in = 0;
end

initial begin
    forever begin
        #20 clock_in = ~clock_in;
    end
end

endmodule