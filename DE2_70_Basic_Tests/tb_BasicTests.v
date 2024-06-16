`timescale 100ns/100ns
module tb_BasicTests ();

reg [17:0] iSW;
wire [17:0] output_oLEDR; // https://stackoverflow.com/questions/24581892/illegal-output-or-inout-port-error-when-trying-to-simulate-counter

// init DUT
BasicTests instance1(iSW, output_oLEDR);

initial begin
    iSW = 18'b111111111111111111;
    #1
    iSW = 18'b000000000000000000;
end

endmodule