library verilog;
use verilog.vl_types.all;
entity Banco_Registradores is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        habilita_escrita: in     vl_logic;
        endereco_leitura_A: in     vl_logic_vector(1 downto 0);
        endereco_leitura_B: in     vl_logic_vector(1 downto 0);
        endereco_escrita: in     vl_logic_vector(1 downto 0);
        dado_escrita    : in     vl_logic_vector(7 downto 0);
        dado_leitura_A  : out    vl_logic_vector(7 downto 0);
        dado_leitura_B  : out    vl_logic_vector(7 downto 0)
    );
end Banco_Registradores;
