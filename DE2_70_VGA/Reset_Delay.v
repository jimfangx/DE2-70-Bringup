module	Reset_Delay(iCLK,oRESET);
input		iCLK;
output reg	oRESET;
reg	[3:0]	Cont;

always @(posedge iCLK) begin
	if (Cont === 4'bxxxx) begin
        Cont <= 1;
        oRESET <= 1'b1;
    end else if (Cont<=4'h1) begin
		Cont	<=	Cont+1;
		oRESET	<=	1'b1;
    end else begin
	    oRESET	<=	1'b0;
    end
end

endmodule