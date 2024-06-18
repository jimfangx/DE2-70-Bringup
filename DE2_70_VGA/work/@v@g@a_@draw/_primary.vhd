library verilog;
use verilog.vl_types.all;
entity VGA_Draw is
    port(
        iCLK            : in     vl_logic;
        oVGA_R          : out    vl_logic_vector(9 downto 0);
        oVGA_G          : out    vl_logic_vector(9 downto 0);
        oVGA_B          : out    vl_logic_vector(9 downto 0);
        oVGA_HS         : out    vl_logic;
        oVGA_VS         : out    vl_logic;
        oVGA_SYNC_N     : out    vl_logic;
        oVGA_BLANK_N    : out    vl_logic;
        oVGA_CLOCK      : out    vl_logic
    );
end VGA_Draw;
