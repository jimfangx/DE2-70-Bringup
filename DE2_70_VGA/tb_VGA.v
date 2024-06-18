`timescale 1ns/1ps
module tb_VGA ();

reg clock_in;
// reg reset_in;

wire [9:0] red_out;
wire [9:0] green_out;
wire [9:0] blue_out;

wire hsync_out;
wire vsync_out;
wire vga_sync_out; // unused
wire blank_out;
wire vga_clock_out;

// init DUT
VGA_Draw inst1(
    .iCLK(clock_in),
    // .iRST(reset_in),
    .oVGA_R(red_out),
    .oVGA_G(green_out),
    .oVGA_B(blue_out),
    .oVGA_HS(hsync_out),
    .oVGA_VS(vsync_out),
    .oVGA_SYNC_N(vga_sync_out),
    .oVGA_BLANK_N(blank_out),
    .oVGA_CLOCK(vga_clock_out)
);

initial begin
    // reset_in = 1;
    clock_in = 0;

    // #40

    // reset_in = 0;

    // red_out = 0;
    // green_out = 0;
    // blue_out = 0;

    // hsync_out = 0;
    // vsync_out = 0;
    // vga_sync_out = 0;
    // blank_out = 0;
    // vga_clock_out = 0;
end

initial begin
    forever begin
        #20 clock_in = ~clock_in;
    end
end



endmodule