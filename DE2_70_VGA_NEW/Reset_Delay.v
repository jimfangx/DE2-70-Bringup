module Reset_Delay (
	input iCLK,
	output reg oRESET
);

reg [19:0] counter;

always @(posedge iCLK) begin
	if(counter != 20'hFFFFF) begin
		counter <= counter+1;
		oRESET <= 1'b0;
	end
	else begin
		oRESET	<=	1'b1;
	end
end

endmodule