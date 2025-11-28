library verilog;
use verilog.vl_types.all;
entity nRisc is
    port(
        CLK             : in     vl_logic;
        RESET           : in     vl_logic
    );
end nRisc;
