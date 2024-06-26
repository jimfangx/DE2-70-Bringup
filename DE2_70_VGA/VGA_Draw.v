// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2_70_Default
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
//   V2.0 :| Perly HU          :| 08/12/2010:| Revision to Quartus II 10.0
// --------------------------------------------------------------------

module VGA_Draw
	(
		////////////////////	Clock Input	 	////////////////////	 
		// iCLK_28,							//  28.63636 MHz
		iCLK_50,							//	50 MHz
		
		////////////////////	VGA		////////////////////////////
		oVGA_CLOCK,   					//	VGA Clock
		oVGA_HS,							//	VGA H_SYNC
		oVGA_VS,							//	VGA V_SYNC
		oVGA_BLANK_N,					//	VGA BLANK
		oVGA_SYNC_N,					//	VGA SYNC
		oVGA_R,   						//	VGA Red[9:0]
		oVGA_G,	 						//	VGA Green[9:0]
		oVGA_B,  						//	VGA Blue[9:0]
		
	   
	);

//===========================================================================
// PARAMETER declarations
//===========================================================================


//===========================================================================
// PORT declarations
//===========================================================================
////////////////////////	Clock Input	 	////////////////////////
// input			iCLK_28;					//  28.63636 MHz
input			iCLK_50;					//	50 MHz


////////////////////////	VGA			////////////////////////////
output			oVGA_CLOCK;   			//	VGA Clock
output			oVGA_HS;					//	VGA H_SYNC
output			oVGA_VS;					//	VGA V_SYNC
output			oVGA_BLANK_N;			//	VGA BLANK
output			oVGA_SYNC_N;			//	VGA SYNC
output	[9:0]	oVGA_R;   				//	VGA Red[9:0]
output	[9:0]	oVGA_G;	 				//	VGA Green[9:0]
output	[9:0]	oVGA_B;   				//	VGA Blue[9:0]


///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================


// wire	CPU_CLK;
// wire	CPU_RESET;
// wire	CLK_18_4;
// wire	CLK_25;

//	For Audio CODEC
// wire		AUD_CTRL_CLK;	//	For Audio Controller

// wire [31:0]	mSEG7_DIG;
// reg  [31:0]	Cont;
wire		VGA_CTRL_CLK;
wire [9:0]	mVGA_R;
wire [9:0]	mVGA_G;
wire [9:0]	mVGA_B;
wire [19:0]	mVGA_ADDR;
wire		DLY_RST;

//	For VGA Controller
// wire			VGA_CLK;
// wire	[9:0]	mRed;
// wire	[9:0]	mGreen;
// wire	[9:0]	mBlue;
// wire			VGA_Read;	//	VGA data request

//	For Down Sample
// wire	[3:0]	Remain;
// wire	[9:0]	Quotient;

// wire			mDVAL;

// reg  [3:0]  DP;
// reg			oHEX0_DP;				//  Seven Segment Digit 0 decimal point
// reg			oHEX1_DP;				//  Seven Segment Digit 1 decimal point
// reg			oHEX2_DP;				//  Seven Segment Digit 2 decimal point
// reg			oHEX3_DP;				//  Seven Segment Digit 3 decimal point
// reg			oHEX4_DP;				//  Seven Segment Digit 4 decimal point
// reg			oHEX5_DP;				//  Seven Segment Digit 5 decimal point
// reg			oHEX6_DP;				//  Seven Segment Digit 6 decimal point
// reg			oHEX7_DP;				//  Seven Segment Digit 7 decimal point

// DEFAULT LCD       //

// wire      LCD_ON_1  ;
// wire      LCD_BLON_1;
// wire [7:0]LCD_D_1   ;
// wire      LCD_RW_1  ;
// wire      LCD_EN_1  ;
// wire      LCD_RS_1  ;

//=============================================================================
// Structural coding
//=============================================================================
// initial //

// assign DRAM_DQ 			= 32'hzzzzzzzz;
 
// assign GPIO_CLKOUT_N0 	= 1'bz;     		  	
// assign GPIO_CLKOUT_P0 	= 1'bz;     		         
 		          
// assign GPIO_CLKOUT_N1 	= 1'bz;     		         
// assign GPIO_CLKOUT_P1  	= 1'bz;     		         
// assign AUD_ADCLRCK    	= 1'bz;     					
    					
// assign AUD_DACLRCK 		= 1'bz;     					
// assign oAUD_DACDAT 		= 1'bz;     					
// assign AUD_BCLK 		= 1'bz;     						
// assign oAUD_XCK 		= 1'bz;     				
// assign ENET_D 			= 16'hzzzz;			
   						
// assign I2C_SDAT 		= 1'bz;     						
// assign oI2C_SCLK 		= 1'bz;     						
// assign SD_DAT 			= 1'bz;     							
// assign SD_DAT3 			= 1'bz;     						
// assign SD_CMD 			= 1'bz;     						
// assign oSD_CLK 			= 1'bz;     						
// assign OTG_D   			= 16'hzzzz;	
// assign SRAM_DQ 			= 32'hzzzzzzzz;				

// assign LCD_ON_1 = 1'b1;
// assign LCD_BLON_1 = 1'b1;

// always@(posedge iCLK_50 or negedge iKEY[0])
//     begin
//         if(!iKEY[0])
//         Cont	<=	0;
//         else
//         Cont	<=	Cont+1;
//     end

//	All inout port turn to tri-state
// assign	SD_DAT		=	1'bz;
// assign	GPIO_0		=	32'hzzzzzzzz;
// assign	GPIO_1		=	32'hzzzzzzzz;

//	Disable USB speed select
// assign	OTG_FSPEED	=	1'bz;
// assign	OTG_LSPEED	=	1'bz;

//	Turn On TV Decoder
// assign	oTD2_RESET_N	=	1'b1;

//	Set SD Card to SD Mode
// assign	SD_DAT3		=	1'b1;

//	Enable TV Decoder
// assign	oTD1_RESET_N	=	iKEY[0];

//	All inout port turn to tri-state
// assign	DRAM_DQ		=	16'hzzzz;
// assign	SRAM_DQ		=	16'hzzzz;
// assign	SD_DAT		=	1'bz;

// assign	oAUD_XCK	=	AUD_CTRL_CLK;
// assign	AUD_ADCLRCK	=	AUD_DACLRCK;

// assign	mSEG7_DIG	=	{	Cont[27:24],Cont[27:24],Cont[27:24],Cont[27:24],
// 							Cont[27:24],Cont[27:24],Cont[27:24],Cont[27:24]	};
// assign	oLEDR		=	{	Cont[25:23],Cont[25:23],Cont[25:23],
// 							Cont[25:23],Cont[25:23],Cont[25:23]	};
// assign	oLEDG		=	{	Cont[25:23],Cont[25:23],Cont[25:23]	};

// always @ (posedge oLEDG[8])
//     begin
//         oHEX0_DP <= ~oHEX0_DP;
//         oHEX1_DP <= ~oHEX1_DP;
//         oHEX2_DP <= ~oHEX2_DP;
//         oHEX3_DP <= ~oHEX3_DP;
//         oHEX4_DP <= ~oHEX4_DP;
//         oHEX5_DP <= ~oHEX5_DP;
//         oHEX6_DP <= ~oHEX6_DP;
//         oHEX7_DP <= ~oHEX7_DP;
//     end

// //	7 segment LUT
// SEG7_LUT_8 			u0	(	.oSEG0(oHEX0_D),
// 							.oSEG1(oHEX1_D),
// 							.oSEG2(oHEX2_D),
// 							.oSEG3(oHEX3_D),
// 							.oSEG4(oHEX4_D),
// 							.oSEG5(oHEX5_D),
// 							.oSEG6(oHEX6_D),
// 							.oSEG7(oHEX7_D),
// 							.iDIG(mSEG7_DIG) );

//	Reset Delay Timer
Reset_Delay			r0	(	.iCLK(iCLK_50),.oRESET(DLY_RST)	);

// VGA_Audio_PLL 		p1	(	.areset(~DLY_RST),.inclk0(iTD1_CLK27),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);

clock_25 vga_clock(
    .iCLK(iCLK_50),
    .iRST(DLY_RST),
    .oCLK_25(VGA_CTRL_CLK)
);

//	VGA Controller
VGA_Controller		u1	(	//	Host Side
							.iCursor_RGB_EN(4'h7),
							.oAddress(mVGA_ADDR),
							.iRed(10'b0000000000), //mVGA_R
							.iGreen(10'b0010000000), // mVGA_G 
							.iBlue(10'b0000000000), // mVGA_B
							//	VGA Side
							.oVGA_R(oVGA_R),
							.oVGA_G(oVGA_G),
							.oVGA_B(oVGA_B),
							.oVGA_H_SYNC(oVGA_HS),
							.oVGA_V_SYNC(oVGA_VS),
							.oVGA_SYNC(oVGA_SYNC_N),
							.oVGA_BLANK(oVGA_BLANK_N),
							.oVGA_CLOCK(oVGA_CLOCK),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST)	);

// VGA_OSD_RAM			u2	(	//	Read Out Side
// 							.oRed(mVGA_R),
// 							.oGreen(mVGA_G),
// 							.oBlue(mVGA_B),
// 							.iVGA_ADDR(mVGA_ADDR),
// 							.iVGA_CLK(VGA_CLK),
// 							//	CLUT
// 							.iON_R(1023),
// 							.iON_G(1023),
// 							.iON_B(1023),
// 							.iOFF_R(0),
// 							.iOFF_G(0),
// 							.iOFF_B(512),
// 							//	Control Signals
// 							.iRST_N(DLY_RST)	);
							
//	Audio CODEC and video decoder setting
// I2C_AV_Config 		u3	(	//	Host Side
// 							.iCLK(iCLK_50),
// 							.iRST_N(iKEY[0]),
// 							//	I2C Side
// 							.I2C_SCLK(oI2C_SCLK),
// 							.I2C_SDAT(I2C_SDAT)	);

// AUDIO_DAC 			u4	(	//	Audio Side
// 							.oAUD_BCK(AUD_BCLK),
// 							.oAUD_DATA(oAUD_DACDAT),
// 							.oAUD_LRCK(AUD_DACLRCK),
// 							//	Control Signals
// 							.iSrc_Select(iSW[17]),
// 				            .iCLK_18_4(AUD_CTRL_CLK),
// 							.iRST_N(DLY_RST)	);

// DEFAULT FLASH  TEST //

// flash_default_tester flash1(
//     //CONTROL SIDE //
// 	.iDEFAULT    (iIRDA_RXD ),
// 	.iBUSSW      (iKEY[0]  ),
// 	.iTRIKEY     (iKEY[3]|iKEY[1]  ),
// 	.iCLK_28     (iCLK_28  ),

//     //FLASH ROM SIDE //
// 	.FLASH_DQ      (FLASH_DQ      ),		
// 	.FLASH_DQ15_AM1(FLASH_DQ15_AM1),	
// 	.oFLASH_A      (oFLASH_A      ),
// 	.iFLASH_RY_N   (iFLASH_RY_N   ),
// 	.oFLASH_WE_N   (oFLASH_WE_N   ),	
// 	.oFLASH_RST_N  (oFLASH_RST_N  ),	
// 	.oFLASH_WP_N   (oFLASH_WP_N   ),	
// 	.oFLASH_BYTE_N (oFLASH_BYTE_N ),	
// 	.oFLASH_OE_N   (oFLASH_OE_N   ),	
// 	.oFLASH_CE_N   (oFLASH_CE_N   ),	
             
// 	//LCD SIDE//
// 	.oLCD_ON  (oLCD_ON  ),
// 	.oLCD_BLON(oLCD_BLON),
// 	.LCD_D    (LCD_D    ),
// 	.oLCD_RW  (oLCD_RW  ),
// 	.oLCD_EN  (oLCD_EN  ),
// 	.oLCD_RS  (oLCD_RS  ),

//     //DEFAULT SIDE//
// 	.iLCD_ON_1  (LCD_ON_1  ),
// 	.iLCD_BLON_1(LCD_BLON_1),
// 	.LCD_D_1    (LCD_D_1    ),
// 	.iLCD_RW_1  (LCD_RW_1  ),
// 	.iLCD_EN_1  (LCD_EN_1  ),
// 	.iLCD_RS_1  (LCD_RS_1  )

// );        

// LCD_TEST 			u5	(	//	Host Side
// 							.iCLK(iCLK_50),
// 							.iRST_N(DLY_RST),
// 							//	LCD Side
// 							.LCD_DATA(LCD_D_1),
// 							.LCD_RW(LCD_RW_1),
// 							.LCD_EN(LCD_EN_1),
// 							.LCD_RS(LCD_RS_1)	);


endmodule

