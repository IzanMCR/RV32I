module RAMController(

    );

    // IDDR_2CLK: Dual-Clock, Input Double Data Rate Input Register with
    //            Set, Reset and Clock Enable.
    //            Artix-7
    // Xilinx HDL Language Template, version 2025.2

    IDDR_2CLK #(
        .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                        //    or "SAME_EDGE_PIPELINED" 
        .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
        .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
        .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
    ) IDDR_2CLK_inst (
        .Q1(), // 1-bit output for positive edge of clock
        .Q2(), // 1-bit output for negative edge of clock
        .C(ClkP),   // 1-bit primary clock input
        .CB(ClkN), // 1-bit secondary clock input
        .CE(CE), // 1-bit clock enable input
        .D(D),   // 1-bit DDR data input
        .R(Rst),   // 1-bit reset
        .S(1'b0)    // 1-bit set
    );

    // End of IDDR_2CLK_inst instantiation

endmodule