library verilog;
use verilog.vl_types.all;
entity Extensor_Sinal_3b8 is
    port(
        entrada         : in     vl_logic_vector(2 downto 0);
        saida           : out    vl_logic_vector(7 downto 0)
    );
end Extensor_Sinal_3b8;
