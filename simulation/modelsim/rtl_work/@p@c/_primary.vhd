library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        novo_PC         : in     vl_logic_vector(7 downto 0);
        pc_atual        : out    vl_logic_vector(7 downto 0)
    );
end PC;
