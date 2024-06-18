library verilog;
use verilog.vl_types.all;
entity VGA_Controller is
    generic(
        H_DISPLAY       : integer := 639;
        H_BACK          : integer := 48;
        H_FRONT         : integer := 16;
        H_SYNC          : integer := 96;
        H_SYNC_START    : vl_notype;
        H_SYNC_END      : vl_notype;
        TOTAL_PIX_IN_LINE: integer := 799;
        V_DISPLAY       : integer := 479;
        V_BACK          : integer := 33;
        V_FRONT         : integer := 10;
        V_SYNC          : integer := 2;
        V_SYNC_START    : vl_notype;
        V_SYNC_END      : vl_notype;
        TOTAL_LINES     : integer := 524
    );
    port(
        iRed            : in     vl_logic_vector(9 downto 0);
        iGreen          : in     vl_logic_vector(9 downto 0);
        iBlue           : in     vl_logic_vector(9 downto 0);
        iCLK            : in     vl_logic;
        iRST            : in     vl_logic;
        oCurrent_X      : out    vl_logic_vector(9 downto 0);
        oCurrent_Y      : out    vl_logic_vector(9 downto 0);
        oVGA_R          : out    vl_logic_vector(9 downto 0);
        oVGA_G          : out    vl_logic_vector(9 downto 0);
        oVGA_B          : out    vl_logic_vector(9 downto 0);
        oVGA_H_SYNC     : out    vl_logic;
        oVGA_V_SYNC     : out    vl_logic;
        oVGA_SYNC       : out    vl_logic;
        oVGA_BLANK      : out    vl_logic;
        oVGA_CLOCK      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of H_DISPLAY : constant is 1;
    attribute mti_svvh_generic_type of H_BACK : constant is 1;
    attribute mti_svvh_generic_type of H_FRONT : constant is 1;
    attribute mti_svvh_generic_type of H_SYNC : constant is 1;
    attribute mti_svvh_generic_type of H_SYNC_START : constant is 3;
    attribute mti_svvh_generic_type of H_SYNC_END : constant is 3;
    attribute mti_svvh_generic_type of TOTAL_PIX_IN_LINE : constant is 1;
    attribute mti_svvh_generic_type of V_DISPLAY : constant is 1;
    attribute mti_svvh_generic_type of V_BACK : constant is 1;
    attribute mti_svvh_generic_type of V_FRONT : constant is 1;
    attribute mti_svvh_generic_type of V_SYNC : constant is 1;
    attribute mti_svvh_generic_type of V_SYNC_START : constant is 3;
    attribute mti_svvh_generic_type of V_SYNC_END : constant is 3;
    attribute mti_svvh_generic_type of TOTAL_LINES : constant is 1;
end VGA_Controller;
