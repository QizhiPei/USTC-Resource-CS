`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: HarzardUnit
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: Deal with harzards in pipline
//////////////////////////////////////////////////////////////////////////////////
//功能说明
    //HarzardUnit用来处理流水线冲突，通过插入气泡，forward以及冲刷流水段解决数据相关和控制相关，组合逻辑电路
    //可以最后实现。前期测试CPU正确性时，可以在每两条指令间插入四条空指令，然后直接把本模块输出定为，不forward，不stall，不flush 
//输入
    //CpuRst                                    外部信号，用来初始化CPU，当CpuRst==1时CPU全局复位清零（所有段寄存器flush），Cpu_Rst==0时cpu开始执行指令
    //ICacheMiss, DCacheMiss                    为后续实验预留信号，暂时可以无视，用来处理cache miss
    //BranchE, JalrE, JalD                      用来处理控制相关
    //Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW     用来处理数据相关，分别表示源寄存器1号码，源寄存器2号码，目标寄存器号码
    //RegReadE                    RegReadD[1]==1表示A1对应的寄存器值被使用到了，RegReadD[0]==1表示A2对应的寄存器值被使用到了，用于forward的处理
    //RegWriteM, RegWriteW                      用来处理数据相关，RegWrite!=3'b0说明对目标寄存器有写入操作
    //MemToRegE                                 表示Ex段当前指令 从Data Memory中加载数据到寄存器中
//输出
    //StallF, FlushF, StallD, FlushD, StallE, FlushE, StallM, FlushM, StallW, FlushW    控制五个段寄存器进行stall（维持状态不变）和flush（清零）
    //Forward1E, Forward2E                                                              控制forward
//实验要求  
    //补全模块  
    
    
module HarzardUnit(
    input wire CpuRst, ICacheMiss, DCacheMiss, 
    input wire BranchE, JalrE, JalD, 
    input wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
    input wire [1:0] RegReadE,
    //CSR modify
    input wire [1:0] MemToRegE,
    input wire [2:0] RegWriteM, RegWriteW,
    //CSR
    input wire [11:0] CSRSrcE, CSRSrcM, CSRSrcW,
    input wire CSRReadE, CSRWriteM, CSRWriteW,

    output reg StallF, FlushF, StallD, FlushD, StallE, FlushE, StallM, FlushM, StallW, FlushW,
    output reg [1:0] Forward1E, Forward2E,
    //CSR
    output reg [1:0] Forward3E,
    // BTB
    input wire BRPredictedE,
    // BHT
    input wire BRPredictedTakenE
    );
    
    //请补全此处代码
    //这里需要注意转发优先级，应优先转发离当前指令近的
    //Forward1E
    always@(*)
    begin
        
        if((RdM == Rs1E) && (RegWriteM != 3'b0) && (RegReadE[1] == 1) && (RdM != 5'b0))
            Forward1E <= 2'b10;
        //当前指令EX段需要用到之前指令MEM段得到的值,且这个值要写回寄存器，且当前用到了这个值，且写回的不是0号寄存器
        else if((RdW == Rs1E) && (RegWriteW != 3'b0) && (RegReadE[1] == 1) && (RdW != 5'b0))
            Forward1E <= 2'b01;
        else
            Forward1E <= 2'b00;
    end
    
    //Forward2E
    always@(*)
    begin

        if((RdM == Rs2E) && (RegWriteM != 3'b0) && (RegReadE[0] == 1) && (RdM != 5'b0))
            Forward2E <= 2'b10;
        else if((RdW == Rs2E) && (RegWriteW != 3'b0) && (RegReadE[0] == 1) && (RdW != 5'b0))
            Forward2E <= 2'b01;
        else
            Forward2E <= 2'b00;
    end

    //Forward3E，用以处理读写CSR带来的冲突（RAW）
    always @(*) 
    begin
        if(CSRReadE && CSRWriteM && CSRSrcM == CSRSrcE)
            Forward3E <= 2'b10;
        else if(CSRReadE && CSRWriteW && CSRSrcW == CSRSrcE)
            Forward3E <= 2'b01;
        else
            Forward3E <= 2'b00;    
    end

    //Stall and Flush
    always@(*)
    begin
        //当CpuRst==1时CPU全局复位清零（所有段寄存器flush），Cpu_Rst==0时cpu开始执行指令
        if (CpuRst) 
        begin
            StallF <= 1'b0;
            FlushF <= 1'b1;
            StallD <= 1'b0;
            FlushD <= 1'b1;
            StallE <= 1'b0;
            FlushE <= 1'b1;
            StallM <= 1'b0;
            FlushM <= 1'b1;
            StallW <= 1'b0;
            FlushW <= 1'b1;
        end
        // cache miss时，流⽔线 Stall
        else if(DCacheMiss | ICacheMiss)
        begin
            StallF <= 1'b1;
            FlushF <= 1'b0;
            StallD <= 1'b1;
            FlushD <= 1'b0;
            StallE <= 1'b1;
            FlushE <= 1'b0;
            StallM <= 1'b1;
            FlushM <= 1'b0;
            StallW <= 1'b1;
            FlushW <= 1'b0;
        end
        //Jalr和Branch在EX段结束，需要刷新FlushD和FlushE
        //进行预测但预测结果和实际跳转结果不一致
        //没有预测但实际跳转了
        else if (JalrE || (BRPredictedE && (BranchE ^ BRPredictedTakenE)) || (~BRPredictedE && BranchE)) 
        begin
            StallF <= 1'b0;
            FlushF <= 1'b0;
            StallD <= 1'b0;
            FlushD <= 1'b1;
            StallE <= 1'b0;
            FlushE <= 1'b1;
            StallM <= 1'b0;
            FlushM <= 1'b0;
            StallW <= 1'b0;
            FlushW <= 1'b0;
        end
        //无法通过旁路解决的RAW相关,插入一个bubble
        //停止读指令，停止解码，刷新EX段，MEM和WB不变使得Load指令再执行一个cycle
        else if (((RdE == Rs1D) || (RdE == Rs2D)) && MemToRegE[0]) 
        begin
            StallF <= 1'b1;
            FlushF <= 1'b0;
            StallD <= 1'b1;
            FlushD <= 1'b0;
            StallE <= 1'b0;
            FlushE <= 1'b1;
            StallM <= 1'b0;
            FlushM <= 1'b0;
            StallW <= 1'b0;
            FlushW <= 1'b0;
        end

        //Jal在ID段结束，只需刷新FlushD
        else if (JalD) 
        begin
            StallF <= 1'b0;
            FlushF <= 1'b0;
            StallD <= 1'b0;
            FlushD <= 1'b1;
            StallE <= 1'b0;
            FlushE <= 1'b0;
            StallM <= 1'b0;
            FlushM <= 1'b0;
            StallW <= 1'b0;
            FlushW <= 1'b0;
        end

        //其他情况
        else
        begin
            StallF <= 1'b0;
            FlushF <= 1'b0;
            StallD <= 1'b0;
            FlushD <= 1'b0;
            StallE <= 1'b0;
            FlushE <= 1'b0;
            StallM <= 1'b0;
            FlushM <= 1'b0;
            StallW <= 1'b0;
            FlushW <= 1'b0;
        end
    end

endmodule
