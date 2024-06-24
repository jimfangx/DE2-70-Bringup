module VGA_Draw (
	input iCLK_50, // 50 MHz
	input iCLK_28, // 28 MHz for PLL option

	output oVGA_CLOCK,
	output oVGA_HS, // VGA H_SYNC
	output oVGA_VS, // VGA V_SYNC
	output oVGA_BLANK_N, // VGA BLANK (negated)
	output oVGA_SYNC_N, // VGA SYNC (negated, pin not used)
	output [9:0] oVGA_R, // VGA Red[9:0]
	output [9:0] oVGA_G,	// VGA Green[9:0]
	output [9:0] oVGA_B // VGA Blue[9:0]
);

wire iVGA_25_CLOCK;
wire iRST_N;

reg [9:0] paint_r, paint_g, paint_b;
reg [9:0] iVGA_R, iVGA_G, iVGA_B;
wire [9:0] oCurrent_X, oCurrent_Y;

Reset_Delay rst_delay (
	.iCLK(iCLK_50),
	.oRESET(iRST_N)
);

// Clock divider implementation using the 50 MHz clock
clock_25 vga_clock (
    .iCLK(iCLK_50),
    .iRST(iRST_N),
    .oCLK_25(iVGA_25_CLOCK)
);

// PLL implementation using the 28 MHz clock
/*
VGA_PLL vga_clock(
	.areset(~iRST_N),
	.inclk0(iCLK_28),
	.c0(iVGA_25_CLOCK)
);
*/

//	VGA Controller
VGA_Controller controller (	
	.iRed(iVGA_R),
	.iGreen(iVGA_G),
	.iBlue(iVGA_B),

	.oCurrent_X(oCurrent_X),
	.oCurrent_Y(oCurrent_Y),

	// To ADV7123
	.oVGA_R(oVGA_R),
	.oVGA_G(oVGA_G),
	.oVGA_B(oVGA_B),
	.oVGA_H_SYNC(oVGA_HS),
	.oVGA_V_SYNC(oVGA_VS),
	.oVGA_SYNC(oVGA_SYNC_N),
	.oVGA_BLANK(oVGA_BLANK_N),
	.oVGA_CLOCK(oVGA_CLOCK),

	// Control Signals
	.iCLK(iVGA_25_CLOCK),
	.iRST_N(iRST_N)
);

always @(*) begin
	if (oCurrent_X < 640 && oCurrent_Y < 384) begin
		paint_r = ((oCurrent_X % 64) * 4) * 4;
		paint_g = ((oCurrent_Y % 64) * 4) * 4;
		paint_b = (((oCurrent_X / 64) * 4) + ((oCurrent_Y / 64) * 40)) * 4;
	end 
	else if (oCurrent_X < 256 && oCurrent_Y < 448) begin
		paint_r = ((oCurrent_X % 64) * 4) * 4;
		paint_g = ((oCurrent_Y % 64) * 4) * 4;
		paint_b = (((oCurrent_X / 64) * 4) + 240) * 4;
	end 
	else if (oCurrent_X < 640 && oCurrent_Y < 448) begin
		paint_r = 1023;
		paint_g = 1023;
		paint_b = 1023;
	end
	else begin  // background colour
		paint_r = 0;
		paint_g = 0;
		paint_b = 0;
	end
end

// paint when not in blanking interval
always @(*) begin
    iVGA_R = (oVGA_BLANK_N) ? paint_r : 10'h0;
	iVGA_G = (oVGA_BLANK_N) ? paint_g : 10'h0;
	iVGA_B = (oVGA_BLANK_N) ? paint_b : 10'h0;
end

endmodule

