library verilog;
use verilog.vl_types.all;
entity Reset_Delay is
    port(
        iCLK            : in     vl_logic;
        oRESET          : out    vl_logic
    );
end Reset_Delay;
