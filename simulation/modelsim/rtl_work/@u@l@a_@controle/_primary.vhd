library verilog;
use verilog.vl_types.all;
entity ULA_Controle is
    port(
        ULAOp           : in     vl_logic_vector(1 downto 0);
        Funct           : in     vl_logic;
        ULA_Control     : out    vl_logic_vector(1 downto 0)
    );
end ULA_Controle;
