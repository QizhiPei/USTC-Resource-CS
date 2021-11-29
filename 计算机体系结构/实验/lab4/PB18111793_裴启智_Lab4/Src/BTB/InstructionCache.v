// asm file name: QuickSort.S
module InstructionCache(
    input wire clk,
    input wire write_en,
    input wire [31:2] addr, debug_addr,
    input wire [31:0] debug_input,
    output reg [31:0] data, debug_data
);

    // local variable
    wire addr_valid = (addr[31:14] == 18'h0);
    wire debug_addr_valid = (debug_addr[31:14] == 18'h0);
    wire [11:0] dealt_addr = addr[13:2];
    wire [11:0] dealt_debug_addr = debug_addr[13:2];
    // cache content
    reg [31:0] inst_cache[0:4095];


    initial begin
        data = 32'h0;
        debug_data = 32'h0;
        inst_cache[       0] = 32'h10004693;
        inst_cache[       1] = 32'h00001137;
        inst_cache[       2] = 32'h00004533;
        inst_cache[       3] = 32'h000045b3;
        inst_cache[       4] = 32'hfff68613;
        inst_cache[       5] = 32'h00261613;
        inst_cache[       6] = 32'h024000ef;
        inst_cache[       7] = 32'h00068293;
        inst_cache[       8] = 32'h00050313;
        inst_cache[       9] = 32'h00229293;
        inst_cache[      10] = 32'h00231313;
        inst_cache[      11] = 32'h00032383;
        inst_cache[      12] = 32'h00430313;
        inst_cache[      13] = 32'hfe534ce3;
        inst_cache[      14] = 32'h0000006f;
        inst_cache[      15] = 32'h0cc5da63;
        inst_cache[      16] = 32'h0005e333;
        inst_cache[      17] = 32'h000663b3;
        inst_cache[      18] = 32'h006502b3;
        inst_cache[      19] = 32'h0002a283;
        inst_cache[      20] = 32'h04735263;
        inst_cache[      21] = 32'h00750e33;
        inst_cache[      22] = 32'h000e2e03;
        inst_cache[      23] = 32'h005e4663;
        inst_cache[      24] = 32'hffc38393;
        inst_cache[      25] = 32'hfedff06f;
        inst_cache[      26] = 32'h00650eb3;
        inst_cache[      27] = 32'h01cea023;
        inst_cache[      28] = 32'h02735263;
        inst_cache[      29] = 32'h00650e33;
        inst_cache[      30] = 32'h000e2e03;
        inst_cache[      31] = 32'h01c2c663;
        inst_cache[      32] = 32'h00430313;
        inst_cache[      33] = 32'hfedff06f;
        inst_cache[      34] = 32'h00750eb3;
        inst_cache[      35] = 32'h01cea023;
        inst_cache[      36] = 32'hfc7340e3;
        inst_cache[      37] = 32'h00650eb3;
        inst_cache[      38] = 32'h005ea023;
        inst_cache[      39] = 32'hffc10113;
        inst_cache[      40] = 32'h00112023;
        inst_cache[      41] = 32'hffc10113;
        inst_cache[      42] = 32'h00b12023;
        inst_cache[      43] = 32'hffc10113;
        inst_cache[      44] = 32'h00c12023;
        inst_cache[      45] = 32'hffc10113;
        inst_cache[      46] = 32'h00612023;
        inst_cache[      47] = 32'hffc30613;
        inst_cache[      48] = 32'hf7dff0ef;
        inst_cache[      49] = 32'h00012303;
        inst_cache[      50] = 32'h00410113;
        inst_cache[      51] = 32'h00012603;
        inst_cache[      52] = 32'h00410113;
        inst_cache[      53] = 32'h00012583;
        inst_cache[      54] = 32'hffc10113;
        inst_cache[      55] = 32'h00c12023;
        inst_cache[      56] = 32'hffc10113;
        inst_cache[      57] = 32'h00612023;
        inst_cache[      58] = 32'h00430593;
        inst_cache[      59] = 32'hf51ff0ef;
        inst_cache[      60] = 32'h00012303;
        inst_cache[      61] = 32'h00410113;
        inst_cache[      62] = 32'h00012603;
        inst_cache[      63] = 32'h00410113;
        inst_cache[      64] = 32'h00012583;
        inst_cache[      65] = 32'h00410113;
        inst_cache[      66] = 32'h00012083;
        inst_cache[      67] = 32'h00410113;
        inst_cache[      68] = 32'h00008067;
end

    always@(posedge clk)
    begin
        data <= addr_valid ? inst_cache[dealt_addr] : 32'h0;
        debug_data <= debug_addr_valid ? inst_cache[dealt_debug_addr] : 32'h0;
        if(write_en & debug_addr_valid) 
            inst_cache[dealt_debug_addr] <= debug_input;
    end

endmodule
