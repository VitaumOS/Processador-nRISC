library verilog;
use verilog.vl_types.all;
entity Memoria_Instrucao is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        endereco        : in     vl_logic_vector(7 downto 0);
        instrucao_saida : out    vl_logic_vector(7 downto 0)
    );
end Memoria_Instrucao;
