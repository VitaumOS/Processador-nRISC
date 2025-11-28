library verilog;
use verilog.vl_types.all;
entity Porta_AND is
    port(
        d1              : in     vl_logic;
        d2              : in     vl_logic;
        saida           : out    vl_logic
    );
end Porta_AND;
