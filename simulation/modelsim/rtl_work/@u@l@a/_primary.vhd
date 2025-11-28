library verilog;
use verilog.vl_types.all;
entity ULA is
    port(
        d1              : in     vl_logic_vector(7 downto 0);
        d2              : in     vl_logic_vector(7 downto 0);
        ULA_Control     : in     vl_logic_vector(1 downto 0);
        Resultado       : out    vl_logic_vector(7 downto 0);
        COND            : out    vl_logic
    );
end ULA;
