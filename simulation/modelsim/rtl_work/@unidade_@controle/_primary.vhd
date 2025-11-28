library verilog;
use verilog.vl_types.all;
entity Unidade_Controle is
    port(
        Opcode          : in     vl_logic_vector(2 downto 0);
        Funct           : in     vl_logic;
        RegDst          : out    vl_logic;
        RegWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        MemWrite        : out    vl_logic;
        Branch          : out    vl_logic;
        Jump            : out    vl_logic;
        ULASrc          : out    vl_logic;
        Halt            : out    vl_logic;
        ULAOp           : out    vl_logic_vector(1 downto 0)
    );
end Unidade_Controle;
