library verilog;
use verilog.vl_types.all;
entity MUX is
    port(
        d1              : in     vl_logic_vector(7 downto 0);
        d2              : in     vl_logic_vector(7 downto 0);
        seletor         : in     vl_logic;
        saida           : out    vl_logic_vector(7 downto 0)
    );
end MUX;
