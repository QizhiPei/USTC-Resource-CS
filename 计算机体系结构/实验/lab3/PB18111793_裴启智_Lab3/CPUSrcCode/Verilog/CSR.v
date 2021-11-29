`timescale 1ns / 1ps
// CSR Reg,在时钟下降沿写寄存器

//  功能说明
    //  CSR寄存器，提供读写端口
// 输入
    // clk               时钟信号
    // rst               寄存器重置信号
    // CSR_Write         寄存器写使能
    // Read_addr         读地址
    // Write_addr        写回地址
    // Write_data        写回数据
// 输出
    // Out           读数据
`include "Parameters.v"   
module CSR_Reg(
    input wire clk,
    input wire rst,
    input wire CSR_write,
    input wire CSR_read,
    input wire [11:0] Read_addr,
    input wire [11:0] Write_addr,
    input wire [31:0] Write_data,
    output wire [31:0] Out
);
    integer i;
    //2^12次方个单元，每个单元12bit
    reg [31:0] CSR_file[4095:0];

    initial 
    begin
        for(i = 0; i < 4096; i = i + 1)
            CSR_file[i][31:0] <= 32'b0;
    end

    always@(negedge clk or posedge rst) 
    begin 
        if (rst)
            for (i = 0; i < 4096; i = i + 1) 
                CSR_file[i][31:0] <= 32'b0;
        else if(CSR_write)
            CSR_file[Write_addr] <= Write_data;   
    end
    
    //attention
    assign Out = CSR_read ? CSR_file[Read_addr] : 32'b0;
endmodule