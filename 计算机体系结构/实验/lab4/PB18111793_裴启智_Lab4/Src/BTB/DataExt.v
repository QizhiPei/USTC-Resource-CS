`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: DataExt 
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: Data Extension module
//////////////////////////////////////////////////////////////////////////////////
//功能说明
    //DataExt是用来处理非字对齐load的情形，同时根据load的不同模式对Data Mem中load的数进行符号或者无符号拓展，组合逻辑电路
//输入
    //IN                    是从Data Memory中load的32bit字
    //LoadedBytesSelect     //等价于AluOutM[1:0]，是读Data Memory地址的低两位，
                            //因为DataMemory是按字（32bit）进行访问的，所以需要把字节地址转化为字地址传给DataMem
                            //DataMem一次返回一个字，低两位地址用来从32bit字中挑选出我们需要的字节
    //RegWriteW             表示不同的寄存器写入模式 ，所有模式定义在Parameters.v中
//输出
    //OUT表示要写入寄存器的最终值
//实验要求  
    //补全模块  

`include "Parameters.v"   
module DataExt(
    input wire [31:0] IN,
    input wire [1:0] LoadedBytesSelect,
    input wire [2:0] RegWriteW,
    output reg [31:0] OUT
    );    
        
    // 请补全此处代码
    wire [31:0] IN_Sel_8;
    wire [31:0] IN_Sel_16;
    //取低8位，根据LoadedBytesSelect对IN进行右移，将要取的部分放到低8位，下同
    assign IN_Sel_8 = (IN >> (32'h8 * LoadedBytesSelect)) & 32'h000000ff;
    assign IN_Sel_16 = (IN >> (32'h8 * LoadedBytesSelect)) & 32'h0000ffff;
    
    always@(*)
    begin
        case(RegWriteW)
            //8bits，有符号
            `LB: OUT <= {{24{IN_Sel_8[7]}}, IN_Sel_8[7:0]};
            //16bits,有符号
            `LH: OUT <= {{16{IN_Sel_16[15]}}, IN_Sel_16[15:0]};

            `LW: OUT <= IN;
            //8bits,无符号
            `LBU: OUT <= {24'b0, IN_Sel_8[7:0]};
            //16bits,无符号
            `LHU: OUT <= {16'b0, IN_Sel_16[15:0]};

            default:OUT = 32'hxxxxxxxx;
        endcase
    end

endmodule

