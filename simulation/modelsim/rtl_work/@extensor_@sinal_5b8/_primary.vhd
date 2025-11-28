library verilog;
use verilog.vl_types.all;
entity Extensor_Sinal_5b8 is
    port(
        entrada         : in     vl_logic_vector(4 downto 0);
        saida           : out    vl_logic_vector(7 downto 0)
    );
end Extensor_Sinal_5b8;
