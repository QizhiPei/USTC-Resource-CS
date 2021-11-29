`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: WBSegReg
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: Write Back Segment Register
//////////////////////////////////////////////////////////////////////////////////
//功能说明
    //WBSegReg是Write Back段寄存器，
    //类似于IDSegReg.V中对Bram的调用和拓展，它同时包含了一个同步读写的Bram
    //（此处你可以调用我们提供的InstructionRam，它将会自动综合为block memory，你也可以替代性的调用xilinx的bram ip核）。
    //同步读memory 相当于 异步读memory 的输出外接D触发器，需要时钟上升沿才能读取数据。
    //此时如果再通过段寄存器缓存，那么需要两个时钟上升沿才能将数据传递到Ex段
    //因此在段寄存器模块中调用该同步memory，直接将输出传递到WB段组合逻辑
    //调用mem模块后输出为RD_raw，通过assign RD = stall_ff ? RD_old : (clear_ff ? 32'b0 : RD_raw );
    //从而实现RD段寄存器stall和clear功能
//实验要求  
    //你需要补全WBSegReg模块，需补全的片段截取如下
    //DataRam DataRamInst (
    //    .clk    (???),                      //请完善代码
    //    .wea    (???),                      //请完善代码
    //    .addra  (???),                      //请完善代码
    //    .dina   (???),                      //请完善代码
    //    .douta  ( RD_raw         ),
    //    .web    ( WE2            ),
    //    .addrb  ( A2[31:2]       ),
    //    .dinb   ( WD2            ),
    //    .doutb  ( RD2            )
    //);   
//注意事项
    //输入到DataRam的addra是字地址，一个字32bit
    //请配合DataExt模块实现非字对齐字节load
    //请通过补全代码实现非字对齐store


module WBSegReg(
    input wire clk,
    input wire en,
    input wire clear,
    //Data Memory Access
    input wire [31:0] A,
    input wire [31:0] WD,
    input wire [3:0] WE,
    output wire [31:0] RD,
    output reg [1:0] LoadedBytesSelect,
    //Data Memory Debug
    input wire [31:0] A2,
    input wire [31:0] WD2,
    input wire [3:0] WE2,
    output wire [31:0] RD2,
    //input control signals
    input wire [31:0] ResultM,
    output reg [31:0] ResultW, 
    input wire [4:0] RdM,
    output reg [4:0] RdW,
    //output constrol signals
    input wire [2:0] RegWriteM,
    output reg [2:0] RegWriteW,
    //CSR modify
    input wire [1:0] MemToRegM,
    output reg [1:0] MemToRegW,
    //CSR
    input wire [11:0] CSRAddrM,
    output reg [11:0] CSRAddrW,
    input wire [31:0] CSROutM,
    output reg [31:0] CSROutW,
    input wire CSRWriteM,
    output reg CSRWriteW,
    output wire CacheMiss
    );
    
    //
    initial begin
        LoadedBytesSelect = 2'b00;
        RegWriteW         =  1'b0;
        MemToRegW         =  2'b0;
        ResultW           =     0;
        RdW               =  5'b0;
        //CSR
        CSRAddrW          = 12'b0;
        CSROutW           = 32'b0;
        CSRWriteW         =  1'b0;
    end
    //
    always@(posedge clk)
        if(en) begin
            LoadedBytesSelect <= clear ? 2'b00 : A[1:0];
            RegWriteW         <= clear ?  1'b0 : RegWriteM;
            MemToRegW         <= clear ?  2'b0 : MemToRegM;
            ResultW           <= clear ?     0 : ResultM;
            RdW               <= clear ?  5'b0 : RdM;
            //CSR
            CSRAddrW          <= clear ? 12'b0 : CSRAddrM;
            CSROutW           <= clear ? 32'b0 : CSROutM;
            CSRWriteW         <= clear ?  1'b0 : CSRWriteM;
        end

    wire [31:0] RD_raw;
    //A[1:0]控制选哪个字节
    // DataRam DataRamInst (
    //     .clk    ( clk ),                      //请完善代码
    //     //WE接口和MemWriteE相连，对应非字对齐store，但二者位数不同
    //     //MemWriteE共4bit，为1的部分表示有效，而wea只接收一位信号，所以要取出来1
        
    //     .wea    ( WE << A[1:0] ),                      //请完善代码
    //     .addra  ( A[31:2]),                      //请完善代码
    //     .dina   ( WD << (32'h8 * A[1:0]) ),                      //请完善代码
    //     .douta  ( RD_raw         ),
    //     .web    ( WE2            ),
    //     .addrb  ( A2[31:2]       ),
    //     .dinb   ( WD2            ),
    //     .doutb  ( RD2            )
    // );   

    cache #(
    .LINE_ADDR_LEN  ( 5             ),
    .SET_ADDR_LEN   ( 2             ),
    .TAG_ADDR_LEN   ( 6             ),
    .WAY_CNT        ( 4             ),
    .STRATEGY       ( 0             )
    ) cache_test_instance (
    .clk            ( clk           ),
    .rst            ( clear         ),
    .miss           ( CacheMiss     ),
    .addr           ( A             ),
    .rd_req         ( MemToRegM     ),
    .rd_data        ( RD_raw        ),
    .wr_req         ( |WE           ),
    .wr_data        ( WD            )
    );

    // 统计 Cache 缺失率
    reg [31:0] hit_count = 0, miss_count = 0;
    // 
    reg [31:0] last_addr = 0;  
    // 是否有对 Cache 的读or写请求
    wire cache_rd_wr = (|WE) | MemToRegM;
    always @(posedge clk or posedge clear) 
    begin
        if(clear) 
        begin
            last_addr <= 0;
        end 
        else 
        begin
            if(cache_rd_wr)
            begin
                
                last_addr <= A;
            end
        end
    end

    always @(posedge clk or posedge clear) 
    begin
        if(clear) 
        begin
            hit_count  <= 0;
            miss_count <= 0;
        end 
        else 
        begin
            // 读写需要多个时钟周期，保证只统计一次
            if(cache_rd_wr & (last_addr != A)) 
            begin
                if(CacheMiss)
                    miss_count <= miss_count + 1;
                else
                    hit_count  <= hit_count + 1;
            end
        end
    end

    // Add clear and stall support
    // if chip not enabled, output output last read result
    // else if chip clear, output 0
    // else output values from bram
    // 以下部分无需修改
    reg stall_ff= 1'b0;
    reg clear_ff= 1'b0;
    reg [31:0] RD_old=32'b0;
    always @ (posedge clk)
    begin
        stall_ff<=~en;
        clear_ff<=clear;
        RD_old<=RD_raw;
    end    
    assign RD = stall_ff ? RD_old : (clear_ff ? 32'b0 : RD_raw );

endmodule