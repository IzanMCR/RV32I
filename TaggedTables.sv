module TaggedTables #(parameter TableSize)(
    input logic [31:0] PCAddress;
    );

    logic [TableSize - 1:0] Table;

endmodule