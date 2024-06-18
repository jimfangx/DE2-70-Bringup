`timescale 1ns/1ps
module tb_reset_delay ();
    
reg clock_in;
wire reset_out;

// dut
Reset_Delay inst2(
    .iCLK(clock_in),
    .oRESET(reset_out)
);

initial begin
    clock_in = 0;
end

initial begin
    forever begin
        #20 clock_in = ~clock_in;
    end
end

endmodule