`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: ImmOperandUnit
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: Generate different type of Immediate Operand
//////////////////////////////////////////////////////////////////////////////////
//功能说明
    //ImmOperandUnit利用正在被译码的指令的部分编码值，生成不同类型的32bit立即数
//输入
    //IN        是指令除了opcode以外的部分编码值
    //Type      表示立即数编码类型，全部类型定义在Parameters.v中
//输出
    //OUT       表示指令对应的立即数32bit实际值
//实验要求  
    //补全ImmOperandUnit模块，需补全的片段截取如下  
    //always@(*)
    //begin
    //    case(Type)
    //        `ITYPE: Out<={ {21{In[31]}}, In[30:20] };
    //        //......                                        //请完善代码
    //        default:Out<=32'hxxxxxxxx;
    //    endcase
    //end

`include "Parameters.v"   
module ImmOperandUnit(
    input wire [31:7] In,
    input wire [2:0] Type,
    output reg [31:0] Out
    );
    //
    always@(*)
    begin
        case(Type)
            `ITYPE: Out <= { {21{In[31]}}, In[30:20] };
            //请完善代码
            `STYPE: Out <= { {21{In[31]}}, In[30:25], In[11:7] };
            `BTYPE: Out <= { {20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0 };
            `UTYPE: Out <= { In[31:12], 12'b0 };
            `JTYPE: Out <= { {12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0 };
            default: Out <= 32'hxxxxxxxx;
        endcase
    end
    
endmodule

