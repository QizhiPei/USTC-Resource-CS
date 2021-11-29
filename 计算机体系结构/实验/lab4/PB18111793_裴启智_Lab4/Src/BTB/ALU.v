`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: ALU
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: ALU unit of RISCV CPU
//////////////////////////////////////////////////////////////////////////////////

//功能和接口说明
	//ALU接受两个操作数，根据AluContrl的不同，进行不同的计算操作，将计算结果输出到AluOut
	//AluContrl的类型定义在Parameters.v中
//推荐格式：
    //case()
    //    `ADD:        AluOut<=Operand1 + Operand2; 
    //   	.......
    //    default:    AluOut <= 32'hxxxxxxxx;                          
    //endcase
//实验要求  
    //补全模块

`include "Parameters.v"   
module ALU(
    input wire [31:0] Operand1,
    input wire [31:0] Operand2,
    input wire [3:0] AluContrl,
    output reg [31:0] AluOut
    );    
    
    //请补全此处代码

    //将输入转化为有符号数
    wire signed [31:0] Operand1_Signed = $signed(Operand1);
    wire signed [31:0] Operand2_Signed = $signed(Operand2);

    always@(*) 
    begin
        case (AluContrl)
            `ADD: AluOut <= Operand1 + Operand2;
            `SUB: AluOut <= Operand1 - Operand2;
            `XOR: AluOut <= Operand1 ^ Operand2;
            `OR: AluOut <= Operand1 | Operand2;
            `AND: AluOut <= Operand1 & Operand2;
            //逻辑左移
            `SLL: AluOut <= Operand1 << (Operand2[4:0]);
            //逻辑右移
            `SRL: AluOut <= Operand1 >> (Operand2[4:0]);
            //算术右移
            `SRA: AluOut <= Operand1_Signed >>> (Operand2[4:0]);
            //有符号数比较
            `SLT: AluOut <= Operand1_Signed < Operand2_Signed ? 32'd1 : 32'd0;
            //无符号数比较
            `SLTU: AluOut <= Operand1 < Operand2 ? 32'd1 : 32'd0;
            //构建32位常数，使用U类格式
            `LUI: AluOut <= {Operand2[31:12], 12'b0};
            //CSR
            `CLR: AluOut <= ~Operand1 & Operand2;
            `REG1:AluOut <= Operand1;
            default:  AluOut <= 32'hxxxxxxxx;
        endcase
    end
endmodule

