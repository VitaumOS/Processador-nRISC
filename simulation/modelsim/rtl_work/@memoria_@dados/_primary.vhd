library verilog;
use verilog.vl_types.all;
entity Memoria_Dados is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        habilita_escrita: in     vl_logic;
        habilita_leitura: in     vl_logic;
        endereco        : in     vl_logic_vector(7 downto 0);
        dado_entrada    : in     vl_logic_vector(7 downto 0);
        dado_saida      : out    vl_logic_vector(7 downto 0)
    );
end Memoria_Dados;
