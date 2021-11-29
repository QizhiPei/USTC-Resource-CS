`timescale 1ns/100ps
//correct read result:
// 00000038 00000021 0000003b 0000001c 00000009 00000039 0000003c 00000017 00000029 00000000 0000003a 0000000d 0000002d 0000003c 00000037 00000011

module cache_tb();

`define DATA_COUNT (16)
`define RDWR_COUNT (6*`DATA_COUNT)

reg wr_cycle           [`RDWR_COUNT];
reg rd_cycle           [`RDWR_COUNT];
reg [31:0] addr_rom    [`RDWR_COUNT];
reg [31:0] wr_data_rom [`RDWR_COUNT];
reg [31:0] validation_data [`DATA_COUNT];

initial begin
    // 16 sequence write cycles
    rd_cycle[    0] = 1'b0;  wr_cycle[    0] = 1'b1;  addr_rom[    0]='h00000000;  wr_data_rom[    0]='h0000001b;
    rd_cycle[    1] = 1'b0;  wr_cycle[    1] = 1'b1;  addr_rom[    1]='h00000004;  wr_data_rom[    1]='h0000003d;
    rd_cycle[    2] = 1'b0;  wr_cycle[    2] = 1'b1;  addr_rom[    2]='h00000008;  wr_data_rom[    2]='h00000020;
    rd_cycle[    3] = 1'b0;  wr_cycle[    3] = 1'b1;  addr_rom[    3]='h0000000c;  wr_data_rom[    3]='h00000016;
    rd_cycle[    4] = 1'b0;  wr_cycle[    4] = 1'b1;  addr_rom[    4]='h00000010;  wr_data_rom[    4]='h00000033;
    rd_cycle[    5] = 1'b0;  wr_cycle[    5] = 1'b1;  addr_rom[    5]='h00000014;  wr_data_rom[    5]='h0000001c;
    rd_cycle[    6] = 1'b0;  wr_cycle[    6] = 1'b1;  addr_rom[    6]='h00000018;  wr_data_rom[    6]='h0000002b;
    rd_cycle[    7] = 1'b0;  wr_cycle[    7] = 1'b1;  addr_rom[    7]='h0000001c;  wr_data_rom[    7]='h0000002b;
    rd_cycle[    8] = 1'b0;  wr_cycle[    8] = 1'b1;  addr_rom[    8]='h00000020;  wr_data_rom[    8]='h0000003b;
    rd_cycle[    9] = 1'b0;  wr_cycle[    9] = 1'b1;  addr_rom[    9]='h00000024;  wr_data_rom[    9]='h00000000;
    rd_cycle[   10] = 1'b0;  wr_cycle[   10] = 1'b1;  addr_rom[   10]='h00000028;  wr_data_rom[   10]='h00000005;
    rd_cycle[   11] = 1'b0;  wr_cycle[   11] = 1'b1;  addr_rom[   11]='h0000002c;  wr_data_rom[   11]='h0000000d;
    rd_cycle[   12] = 1'b0;  wr_cycle[   12] = 1'b1;  addr_rom[   12]='h00000030;  wr_data_rom[   12]='h00000006;
    rd_cycle[   13] = 1'b0;  wr_cycle[   13] = 1'b1;  addr_rom[   13]='h00000034;  wr_data_rom[   13]='h00000003;
    rd_cycle[   14] = 1'b0;  wr_cycle[   14] = 1'b1;  addr_rom[   14]='h00000038;  wr_data_rom[   14]='h00000037;
    rd_cycle[   15] = 1'b0;  wr_cycle[   15] = 1'b1;  addr_rom[   15]='h0000003c;  wr_data_rom[   15]='h0000003a;
    // 48 random read and write cycles
    rd_cycle[   16] = 1'b0;  wr_cycle[   16] = 1'b1;  addr_rom[   16]='h00000034;  wr_data_rom[   16]='h0000000c;
    rd_cycle[   17] = 1'b0;  wr_cycle[   17] = 1'b1;  addr_rom[   17]='h0000000c;  wr_data_rom[   17]='h00000020;
    rd_cycle[   18] = 1'b0;  wr_cycle[   18] = 1'b1;  addr_rom[   18]='h00000010;  wr_data_rom[   18]='h0000002f;
    rd_cycle[   19] = 1'b0;  wr_cycle[   19] = 1'b1;  addr_rom[   19]='h0000003c;  wr_data_rom[   19]='h0000001c;
    rd_cycle[   20] = 1'b0;  wr_cycle[   20] = 1'b1;  addr_rom[   20]='h00000020;  wr_data_rom[   20]='h0000001c;
    rd_cycle[   21] = 1'b1;  wr_cycle[   21] = 1'b0;  addr_rom[   21]='h00000010;  wr_data_rom[   21]='h00000000;
    rd_cycle[   22] = 1'b0;  wr_cycle[   22] = 1'b1;  addr_rom[   22]='h00000004;  wr_data_rom[   22]='h00000008;
    rd_cycle[   23] = 1'b1;  wr_cycle[   23] = 1'b0;  addr_rom[   23]='h00000010;  wr_data_rom[   23]='h00000000;
    rd_cycle[   24] = 1'b0;  wr_cycle[   24] = 1'b1;  addr_rom[   24]='h00000000;  wr_data_rom[   24]='h0000001c;
    rd_cycle[   25] = 1'b1;  wr_cycle[   25] = 1'b0;  addr_rom[   25]='h00000028;  wr_data_rom[   25]='h00000000;
    rd_cycle[   26] = 1'b1;  wr_cycle[   26] = 1'b0;  addr_rom[   26]='h00000038;  wr_data_rom[   26]='h00000000;
    rd_cycle[   27] = 1'b0;  wr_cycle[   27] = 1'b1;  addr_rom[   27]='h00000014;  wr_data_rom[   27]='h00000039;
    rd_cycle[   28] = 1'b0;  wr_cycle[   28] = 1'b1;  addr_rom[   28]='h00000028;  wr_data_rom[   28]='h00000016;
    rd_cycle[   29] = 1'b0;  wr_cycle[   29] = 1'b1;  addr_rom[   29]='h0000003c;  wr_data_rom[   29]='h0000000c;
    rd_cycle[   30] = 1'b1;  wr_cycle[   30] = 1'b0;  addr_rom[   30]='h00000000;  wr_data_rom[   30]='h00000000;
    rd_cycle[   31] = 1'b0;  wr_cycle[   31] = 1'b1;  addr_rom[   31]='h00000000;  wr_data_rom[   31]='h00000034;
    rd_cycle[   32] = 1'b1;  wr_cycle[   32] = 1'b0;  addr_rom[   32]='h0000000c;  wr_data_rom[   32]='h00000000;
    rd_cycle[   33] = 1'b1;  wr_cycle[   33] = 1'b0;  addr_rom[   33]='h00000004;  wr_data_rom[   33]='h00000000;
    rd_cycle[   34] = 1'b0;  wr_cycle[   34] = 1'b1;  addr_rom[   34]='h00000004;  wr_data_rom[   34]='h00000006;
    rd_cycle[   35] = 1'b0;  wr_cycle[   35] = 1'b1;  addr_rom[   35]='h00000018;  wr_data_rom[   35]='h0000002b;
    rd_cycle[   36] = 1'b0;  wr_cycle[   36] = 1'b1;  addr_rom[   36]='h00000010;  wr_data_rom[   36]='h0000003a;
    rd_cycle[   37] = 1'b1;  wr_cycle[   37] = 1'b0;  addr_rom[   37]='h00000014;  wr_data_rom[   37]='h00000000;
    rd_cycle[   38] = 1'b0;  wr_cycle[   38] = 1'b1;  addr_rom[   38]='h00000000;  wr_data_rom[   38]='h00000038;
    rd_cycle[   39] = 1'b0;  wr_cycle[   39] = 1'b1;  addr_rom[   39]='h00000008;  wr_data_rom[   39]='h0000002a;
    rd_cycle[   40] = 1'b1;  wr_cycle[   40] = 1'b0;  addr_rom[   40]='h00000034;  wr_data_rom[   40]='h00000000;
    rd_cycle[   41] = 1'b0;  wr_cycle[   41] = 1'b1;  addr_rom[   41]='h00000008;  wr_data_rom[   41]='h00000025;
    rd_cycle[   42] = 1'b0;  wr_cycle[   42] = 1'b1;  addr_rom[   42]='h0000003c;  wr_data_rom[   42]='h00000011;
    rd_cycle[   43] = 1'b0;  wr_cycle[   43] = 1'b1;  addr_rom[   43]='h00000010;  wr_data_rom[   43]='h00000009;
    rd_cycle[   44] = 1'b0;  wr_cycle[   44] = 1'b1;  addr_rom[   44]='h00000028;  wr_data_rom[   44]='h0000003a;
    rd_cycle[   45] = 1'b0;  wr_cycle[   45] = 1'b1;  addr_rom[   45]='h0000001c;  wr_data_rom[   45]='h00000017;
    rd_cycle[   46] = 1'b0;  wr_cycle[   46] = 1'b1;  addr_rom[   46]='h00000020;  wr_data_rom[   46]='h00000029;
    rd_cycle[   47] = 1'b1;  wr_cycle[   47] = 1'b0;  addr_rom[   47]='h00000018;  wr_data_rom[   47]='h00000000;
    rd_cycle[   48] = 1'b0;  wr_cycle[   48] = 1'b1;  addr_rom[   48]='h00000008;  wr_data_rom[   48]='h0000003b;
    rd_cycle[   49] = 1'b0;  wr_cycle[   49] = 1'b1;  addr_rom[   49]='h00000030;  wr_data_rom[   49]='h0000002d;
    rd_cycle[   50] = 1'b1;  wr_cycle[   50] = 1'b0;  addr_rom[   50]='h00000004;  wr_data_rom[   50]='h00000000;
    rd_cycle[   51] = 1'b1;  wr_cycle[   51] = 1'b0;  addr_rom[   51]='h00000030;  wr_data_rom[   51]='h00000000;
    rd_cycle[   52] = 1'b0;  wr_cycle[   52] = 1'b1;  addr_rom[   52]='h0000000c;  wr_data_rom[   52]='h0000001c;
    rd_cycle[   53] = 1'b1;  wr_cycle[   53] = 1'b0;  addr_rom[   53]='h0000000c;  wr_data_rom[   53]='h00000000;
    rd_cycle[   54] = 1'b1;  wr_cycle[   54] = 1'b0;  addr_rom[   54]='h00000010;  wr_data_rom[   54]='h00000000;
    rd_cycle[   55] = 1'b1;  wr_cycle[   55] = 1'b0;  addr_rom[   55]='h00000018;  wr_data_rom[   55]='h00000000;
    rd_cycle[   56] = 1'b0;  wr_cycle[   56] = 1'b1;  addr_rom[   56]='h00000018;  wr_data_rom[   56]='h0000003c;
    rd_cycle[   57] = 1'b1;  wr_cycle[   57] = 1'b0;  addr_rom[   57]='h00000010;  wr_data_rom[   57]='h00000000;
    rd_cycle[   58] = 1'b1;  wr_cycle[   58] = 1'b0;  addr_rom[   58]='h0000003c;  wr_data_rom[   58]='h00000000;
    rd_cycle[   59] = 1'b1;  wr_cycle[   59] = 1'b0;  addr_rom[   59]='h00000038;  wr_data_rom[   59]='h00000000;
    rd_cycle[   60] = 1'b1;  wr_cycle[   60] = 1'b0;  addr_rom[   60]='h00000000;  wr_data_rom[   60]='h00000000;
    rd_cycle[   61] = 1'b0;  wr_cycle[   61] = 1'b1;  addr_rom[   61]='h00000034;  wr_data_rom[   61]='h0000003c;
    rd_cycle[   62] = 1'b1;  wr_cycle[   62] = 1'b0;  addr_rom[   62]='h00000038;  wr_data_rom[   62]='h00000000;
    rd_cycle[   63] = 1'b0;  wr_cycle[   63] = 1'b1;  addr_rom[   63]='h00000004;  wr_data_rom[   63]='h00000021;
    // 16 silence cycles
    rd_cycle[   64] = 1'b0;  wr_cycle[   64] = 1'b0;  addr_rom[   64]='h00000000;  wr_data_rom[   64]='h00000000;
    rd_cycle[   65] = 1'b0;  wr_cycle[   65] = 1'b0;  addr_rom[   65]='h00000000;  wr_data_rom[   65]='h00000000;
    rd_cycle[   66] = 1'b0;  wr_cycle[   66] = 1'b0;  addr_rom[   66]='h00000000;  wr_data_rom[   66]='h00000000;
    rd_cycle[   67] = 1'b0;  wr_cycle[   67] = 1'b0;  addr_rom[   67]='h00000000;  wr_data_rom[   67]='h00000000;
    rd_cycle[   68] = 1'b0;  wr_cycle[   68] = 1'b0;  addr_rom[   68]='h00000000;  wr_data_rom[   68]='h00000000;
    rd_cycle[   69] = 1'b0;  wr_cycle[   69] = 1'b0;  addr_rom[   69]='h00000000;  wr_data_rom[   69]='h00000000;
    rd_cycle[   70] = 1'b0;  wr_cycle[   70] = 1'b0;  addr_rom[   70]='h00000000;  wr_data_rom[   70]='h00000000;
    rd_cycle[   71] = 1'b0;  wr_cycle[   71] = 1'b0;  addr_rom[   71]='h00000000;  wr_data_rom[   71]='h00000000;
    rd_cycle[   72] = 1'b0;  wr_cycle[   72] = 1'b0;  addr_rom[   72]='h00000000;  wr_data_rom[   72]='h00000000;
    rd_cycle[   73] = 1'b0;  wr_cycle[   73] = 1'b0;  addr_rom[   73]='h00000000;  wr_data_rom[   73]='h00000000;
    rd_cycle[   74] = 1'b0;  wr_cycle[   74] = 1'b0;  addr_rom[   74]='h00000000;  wr_data_rom[   74]='h00000000;
    rd_cycle[   75] = 1'b0;  wr_cycle[   75] = 1'b0;  addr_rom[   75]='h00000000;  wr_data_rom[   75]='h00000000;
    rd_cycle[   76] = 1'b0;  wr_cycle[   76] = 1'b0;  addr_rom[   76]='h00000000;  wr_data_rom[   76]='h00000000;
    rd_cycle[   77] = 1'b0;  wr_cycle[   77] = 1'b0;  addr_rom[   77]='h00000000;  wr_data_rom[   77]='h00000000;
    rd_cycle[   78] = 1'b0;  wr_cycle[   78] = 1'b0;  addr_rom[   78]='h00000000;  wr_data_rom[   78]='h00000000;
    rd_cycle[   79] = 1'b0;  wr_cycle[   79] = 1'b0;  addr_rom[   79]='h00000000;  wr_data_rom[   79]='h00000000;
    // 16 sequence read cycles
    rd_cycle[   80] = 1'b1;  wr_cycle[   80] = 1'b0;  addr_rom[   80]='h00000000;  wr_data_rom[   80]='h00000000;
    rd_cycle[   81] = 1'b1;  wr_cycle[   81] = 1'b0;  addr_rom[   81]='h00000004;  wr_data_rom[   81]='h00000000;
    rd_cycle[   82] = 1'b1;  wr_cycle[   82] = 1'b0;  addr_rom[   82]='h00000008;  wr_data_rom[   82]='h00000000;
    rd_cycle[   83] = 1'b1;  wr_cycle[   83] = 1'b0;  addr_rom[   83]='h0000000c;  wr_data_rom[   83]='h00000000;
    rd_cycle[   84] = 1'b1;  wr_cycle[   84] = 1'b0;  addr_rom[   84]='h00000010;  wr_data_rom[   84]='h00000000;
    rd_cycle[   85] = 1'b1;  wr_cycle[   85] = 1'b0;  addr_rom[   85]='h00000014;  wr_data_rom[   85]='h00000000;
    rd_cycle[   86] = 1'b1;  wr_cycle[   86] = 1'b0;  addr_rom[   86]='h00000018;  wr_data_rom[   86]='h00000000;
    rd_cycle[   87] = 1'b1;  wr_cycle[   87] = 1'b0;  addr_rom[   87]='h0000001c;  wr_data_rom[   87]='h00000000;
    rd_cycle[   88] = 1'b1;  wr_cycle[   88] = 1'b0;  addr_rom[   88]='h00000020;  wr_data_rom[   88]='h00000000;
    rd_cycle[   89] = 1'b1;  wr_cycle[   89] = 1'b0;  addr_rom[   89]='h00000024;  wr_data_rom[   89]='h00000000;
    rd_cycle[   90] = 1'b1;  wr_cycle[   90] = 1'b0;  addr_rom[   90]='h00000028;  wr_data_rom[   90]='h00000000;
    rd_cycle[   91] = 1'b1;  wr_cycle[   91] = 1'b0;  addr_rom[   91]='h0000002c;  wr_data_rom[   91]='h00000000;
    rd_cycle[   92] = 1'b1;  wr_cycle[   92] = 1'b0;  addr_rom[   92]='h00000030;  wr_data_rom[   92]='h00000000;
    rd_cycle[   93] = 1'b1;  wr_cycle[   93] = 1'b0;  addr_rom[   93]='h00000034;  wr_data_rom[   93]='h00000000;
    rd_cycle[   94] = 1'b1;  wr_cycle[   94] = 1'b0;  addr_rom[   94]='h00000038;  wr_data_rom[   94]='h00000000;
    rd_cycle[   95] = 1'b1;  wr_cycle[   95] = 1'b0;  addr_rom[   95]='h0000003c;  wr_data_rom[   95]='h00000000;
end

initial begin
    validation_data[    0] = 'h00000038; 
    validation_data[    1] = 'h00000021; 
    validation_data[    2] = 'h0000003b; 
    validation_data[    3] = 'h0000001c; 
    validation_data[    4] = 'h00000009; 
    validation_data[    5] = 'h00000039; 
    validation_data[    6] = 'h0000003c; 
    validation_data[    7] = 'h00000017; 
    validation_data[    8] = 'h00000029; 
    validation_data[    9] = 'h00000000; 
    validation_data[   10] = 'h0000003a; 
    validation_data[   11] = 'h0000000d; 
    validation_data[   12] = 'h0000002d; 
    validation_data[   13] = 'h0000003c; 
    validation_data[   14] = 'h00000037; 
    validation_data[   15] = 'h00000011; 

end


reg clk = 1'b1, rst = 1'b1;
initial #4 rst = 1'b0;
always  #1 clk = ~clk;

wire  miss;
wire [31:0] rd_data;
reg  [31:0] index = 0, wr_data = 0, addr = 0;
reg  rd_req = 1'b0, wr_req = 1'b0;
reg rd_req_ff = 1'b0, miss_ff = 1'b0;
reg [31:0] validation_count = 0;

always @ (posedge clk or posedge rst)
    if(rst) begin
        rd_req_ff <= 1'b0;
        miss_ff   <= 1'b0;
    end else begin
        rd_req_ff <= rd_req;
        miss_ff   <= miss;
    end

always @ (posedge clk or posedge rst)
    if(rst) begin
        validation_count <= 0;
    end else begin
        if(validation_count>=`DATA_COUNT) begin
            validation_count <= 'hffffffff;
        end else if(rd_req_ff && (index>(4*`DATA_COUNT))) begin
            if(~miss_ff) begin
                if(validation_data[validation_count]==rd_data)
                    validation_count <= validation_count+1;
                else
                    validation_count <= 0;
            end
        end else begin
            validation_count <= 0;
        end
    end

always @ (posedge clk or posedge rst)
    if(rst) begin
        index   <= 0;
        wr_data <= 0;
        addr    <= 0;
        rd_req  <= 1'b0;
        wr_req  <= 1'b0;
    end else begin
        if(~miss) begin
            if(index<`RDWR_COUNT) begin
                if(wr_cycle[index]) begin
                    rd_req  <= 1'b0;
                    wr_req  <= 1'b1;
                end else if(rd_cycle[index]) begin
                    wr_data <= 0;
                    rd_req  <= 1'b1;
                    wr_req  <= 1'b0;
                end else begin
                    wr_data <= 0;
                    rd_req  <= 1'b0;
                    wr_req  <= 1'b0;
                end
                wr_data <= wr_data_rom[index];
                addr    <= addr_rom[index];
                index <= index + 1;
            end else begin
                wr_data <= 0;
                addr    <= 0;
                rd_req  <= 1'b0;
                wr_req  <= 1'b0;
            end
        end
    end

cache #(
    .LINE_ADDR_LEN  ( 3             ),
    .SET_ADDR_LEN   ( 2             ),
    .TAG_ADDR_LEN   ( 12            ),
    .WAY_CNT        ( 3             )
) cache_test_instance (
    .clk            ( clk           ),
    .rst            ( rst           ),
    .miss           ( miss          ),
    .addr           ( addr          ),
    .rd_req         ( rd_req        ),
    .rd_data        ( rd_data       ),
    .wr_req         ( wr_req        ),
    .wr_data        ( wr_data       )
);

endmodule

