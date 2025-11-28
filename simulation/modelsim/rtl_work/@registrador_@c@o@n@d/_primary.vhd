library verilog;
use verilog.vl_types.all;
entity Registrador_COND is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        cond_ULA        : in     vl_logic;
        reset_cond      : in     vl_logic;
        cond_atual      : out    vl_logic
    );
end Registrador_COND;
