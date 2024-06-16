library verilog;
use verilog.vl_types.all;
entity BasicTests is
    port(
        iSW             : in     vl_logic_vector(17 downto 0);
        oLEDR           : out    vl_logic_vector(17 downto 0)
    );
end BasicTests;
