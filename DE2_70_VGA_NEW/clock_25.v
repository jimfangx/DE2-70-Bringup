module clock_25 (
    input iCLK,
    input iRST,
    output oCLK_25
);

reg pixel_reg;
wire pixel_next;

always @(posedge iCLK, negedge iRST) begin
    if (!iRST) begin
        pixel_reg <= 1;
    end else begin
        pixel_reg <= pixel_next;
    end
end

assign pixel_next = ~pixel_reg;
assign oCLK_25 = (pixel_reg === 0);

endmodule