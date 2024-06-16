module BasicTests (
    input [17:0] iSW,    //  Toggle Switch[17:0]
    output[17:0] oLEDR // LED Red[17:0]
);

    // make switches inverse
    assign oLEDR[17:0] = ~iSW[17:0];
    
endmodule