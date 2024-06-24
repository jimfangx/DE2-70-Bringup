module VGA_Controller (	
	// Host Side
	iRed,
	iGreen,
	iBlue,

	oCurrent_X,
	oCurrent_Y,

	//	VGA Side to ADV7123
	oVGA_R,
	oVGA_G,
	oVGA_B,
	oVGA_H_SYNC,
	oVGA_V_SYNC,
	oVGA_SYNC,
	oVGA_BLANK,
	oVGA_CLOCK,

	//	Control Signal
	iCLK,
	iRST_N
);

// Host Side
output reg [9:0] oCurrent_X;
output reg [9:0] oCurrent_Y;

input [9:0] iRed;
input [9:0] iGreen;
input [9:0] iBlue;

// VGA Side to ADV7123
output [9:0] oVGA_R;
output [9:0] oVGA_G;
output [9:0] oVGA_B;
output reg oVGA_H_SYNC;
output reg oVGA_V_SYNC;
output oVGA_SYNC;
output reg oVGA_BLANK;
output oVGA_CLOCK;

//	Control Signals
input iCLK;
input iRST_N;

reg [9:0] R_final;
reg [9:0] G_final;
reg [9:0] B_final;

reg [9:0] x_next;
reg [9:0] y_next;

assign oVGA_SYNC = 1'b0; // pin unused
assign oVGA_CLOCK = iCLK;

assign oVGA_R = R_final;
assign oVGA_G = G_final;
assign oVGA_B = B_final;

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

// Thanks to Piasa (.piasa) from Digital Design HQ Discord for the help!
// https://canary.discord.com/channels/545823859006242826/709779445845721199/1253873210181554298
always @(*) begin
    if (oCurrent_X == TOTAL_PIX_IN_LINE) begin
        x_next = 0;
        y_next = (oCurrent_Y == TOTAL_LINES) ? 0 : oCurrent_Y + 1;
    end else begin
        x_next = oCurrent_X + 1;
        y_next = oCurrent_Y;
    end
end

//	calculate current x, y position 
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		oCurrent_X <= 0;
        oCurrent_Y <= 0;
	end else if (oCurrent_X == TOTAL_PIX_IN_LINE) begin // last pixel on line
        oCurrent_X <= 0;
        oCurrent_Y <= (oCurrent_Y == TOTAL_LINES) ? 0 : oCurrent_Y + 1; // if current y <= # of lines, then y + 1 (since total lines is 1 less than actual total lines), else y = 0
    end else begin
        oCurrent_X <= oCurrent_X + 1; // advance by 1 pix
    end
end


always @(posedge oVGA_CLOCK, negedge iRST_N) begin

    if (!iRST_N) begin
        oVGA_H_SYNC <= 0;
        oVGA_V_SYNC <= 0;
        oVGA_BLANK <= 0;
    end else begin
        // set hsync & vsync
        oVGA_H_SYNC <= ~((oCurrent_X >= H_SYNC_START) && (oCurrent_X < H_SYNC_END)); // negative polarity: https://electronics.stackexchange.com/questions/522053/what-does-it-mean-positive-or-negative-polarity-in-vgas-hsynch-and-vsynch

        oVGA_V_SYNC <= ~((oCurrent_Y >= V_SYNC_START) && (oCurrent_Y < V_SYNC_END)); // neg polarity

        oVGA_BLANK <= ((oCurrent_X <= H_DISPLAY) && (oCurrent_Y <= V_DISPLAY)); // see ADV7123 datasheet pg 9: while blank is logic 0, RGB inputs are ignored
    end
end


always @(posedge oVGA_CLOCK, negedge iRST_N) begin
    if (!iRST_N) begin
        R_final <= 0;
        G_final <= 0;
        B_final <= 0;
    end else begin
        R_final <= ((oCurrent_X >= 0) && (oCurrent_X <= H_DISPLAY) && (oCurrent_Y >= 0) && (oCurrent_Y <= V_DISPLAY)) ? iRed : 0;
        G_final <= ((oCurrent_X >= 0) && (oCurrent_X <= H_DISPLAY) && (oCurrent_Y >= 0) && (oCurrent_Y <= V_DISPLAY)) ? iGreen : 0;
        B_final <= ((oCurrent_X >= 0) && (oCurrent_X <= H_DISPLAY) && (oCurrent_Y >= 0) && (oCurrent_Y <= V_DISPLAY)) ? iBlue : 0;
    end
end


endmodule