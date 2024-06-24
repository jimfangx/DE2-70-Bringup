/*
Handle assigning all pins to vga dac
does not handle drawing - this will be one in another module
*/


module VGA_Controller (
    // inputs to controller
    input [9:0] iRed,
    input [9:0] iGreen,
    input [9:0] iBlue, // these will be set by the drawing module
    
    // input from fpga (passed thru by drawing module)
    input iCLK, // 50mhz clock, passed thru from drawing module
    input iRST, // passed thru to from drawing module

    // controller outputs host side
    // output oPIX_POS_UPDATE, // see vga clock
    output reg [9:0] oCurrent_X, 
    output reg [9:0] oCurrent_Y,

    // outputs to VGA DAC ADV7123
    output [9:0] oVGA_R,
    output [9:0] oVGA_G,
    output [9:0] oVGA_B,
    output reg oVGA_H_SYNC, // set by sync
    output reg oVGA_V_SYNC, // set by sync
    output oVGA_SYNC, // blank bit unused
    output reg oVGA_BLANK, // set by sync
    output oVGA_CLOCK // set by sync
);
    

// horizontal params    
parameter H_DISPLAY = 639;
parameter H_BACK = 48; // H_LEFT BORDER
parameter H_FRONT = 16; // H_RIGHT BORDER
parameter H_SYNC = 96; // H_SYNC
parameter H_SYNC_START = H_DISPLAY + H_FRONT;
parameter H_SYNC_END = H_DISPLAY + H_FRONT + H_SYNC;
parameter TOTAL_PIX_IN_LINE = 799;

// vertical params
parameter V_DISPLAY = 479;
parameter V_BACK = 33; // V TOP
parameter V_FRONT = 10; // V BOT
parameter V_SYNC = 2;
parameter V_SYNC_START = V_DISPLAY + V_FRONT;
parameter V_SYNC_END = V_DISPLAY + V_FRONT + V_SYNC;
parameter TOTAL_LINES = 524;

// set passthru & const params
assign oVGA_R =	iRed;
assign oVGA_G =	iGreen;
assign oVGA_B =	iBlue;
assign oVGA_SYNC = 1'b1; // unused pin


// Mod 2 clock for VGA pixel clock of 25 MHz
reg pixel_reg;
wire pixel_next;

always @(posedge iCLK, posedge iRST) begin
    if (iRST) begin
        pixel_reg <= 1;
    end else begin
        pixel_reg <= pixel_next;
    end
end

assign pixel_next = ~pixel_reg;
assign oVGA_CLOCK = (pixel_reg === 0);

always @(*) begin

// set hsync & vsync
oVGA_H_SYNC = ~((oCurrent_X >= H_SYNC_START) && (oCurrent_X < H_SYNC_END)); // negative polarity: https://electronics.stackexchange.com/questions/522053/what-does-it-mean-positive-or-negative-polarity-in-vgas-hsynch-and-vsynch

oVGA_V_SYNC = ~((oCurrent_Y >= V_SYNC_START) && (oCurrent_Y < V_SYNC_END)); // neg polarity

oVGA_BLANK = (oCurrent_X <= H_DISPLAY) && (oCurrent_Y <= V_DISPLAY); // see ADV7123 datasheet pg 9: while blank is logic 0, RGB inputs are ignored
end

// calculate x & y position
always @(posedge oVGA_CLOCK, posedge iRST) begin
    if (iRST) begin // last assignment wins in verilog
        oCurrent_X <= 0;
        oCurrent_Y <= 0;
        // pixel_reg <= 0;
    end else if (oCurrent_X == TOTAL_PIX_IN_LINE) begin // last pixel on line
        oCurrent_X <= 0;
        oCurrent_Y <= (oCurrent_Y <= TOTAL_LINES) ? oCurrent_Y + 1 : 0; // if current y <= # of lines, then y + 1 (since total lines is 1 less than actual total lines), else y = 0
    end else begin
        oCurrent_X <= oCurrent_X + 1; // advance by 1 pix
    end
end

endmodule