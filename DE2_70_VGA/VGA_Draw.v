/*
Top level module, drawing code
*/

module VGA_Draw (
    input iCLK,

    output [9:0] oVGA_R,
    output [9:0] oVGA_G,
    output [9:0] oVGA_B,
    output oVGA_HS,
    output oVGA_VS,
    output oVGA_SYNC_N,
    output oVGA_BLANK_N,
    output oVGA_CLOCK
);

wire iRST;
reg [9:0] paint_r, paint_g, paint_b;
wire [9:0] VGA_X, VGA_Y;
reg square;

Reset_Delay reset(
    .iCLK(iCLK),
    .oRESET(iRST)
);

VGA_Controller controller(
    .iRed(paint_r),
    .iGreen(paint_g),
    .iBlue(paint_b),

    .iCLK(iCLK),
    .iRST(iRST),
    
    .oCurrent_X(VGA_X),
    .oCurrent_Y(VGA_Y),

    .oVGA_R(oVGA_R),
	.oVGA_G(oVGA_G),
	.oVGA_B(oVGA_B),
	.oVGA_H_SYNC(oVGA_HS),
	.oVGA_V_SYNC(oVGA_VS),
	.oVGA_SYNC(oVGA_SYNC_N),
	.oVGA_BLANK(oVGA_BLANK_N),
	.oVGA_CLOCK(oVGA_CLOCK)
);

always @(*) begin
    square = (VGA_X > 220 && VGA_X < 420) && (VGA_Y > 140 && VGA_Y < 340);
    paint_r = (square) ? 10'hF : 10'h1;
    paint_g = (square) ? 10'hF : 10'h3;
    paint_b = (square) ? 10'hF : 10'h7;
end
    
endmodule