`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB 
// Engineer: Wu Yuzhang
// 
// Design Name: RISCV-Pipline CPU
// Module Name: ControlUnit
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: RISC-V Instruction Decoder
//////////////////////////////////////////////////////////////////////////////////
//功能和接口说明
    //ControlUnit       是本CPU的指令译码器，组合逻辑电路
//输入
    // Op               是指令的操作码部分
    // Fn3              是指令的func3部分
    // Fn7              是指令的func7部分
//输出
    // JalD==1          表示Jal指令到达ID译码阶段
    // JalrD==1         表示Jalr指令到达ID译码阶段
    // RegWriteD        表示ID阶段的指令对应的寄存器写入模式
    // MemToRegD==1     表示ID阶段的指令需要将data memory读取的值写入寄存器,
    // MemWriteD        共4bit，为1的部分表示有效，对于data memory的32bit字按byte进行写入,MemWriteD=0001表示只写入最低1个byte，和xilinx bram的接口类似
    // LoadNpcD==1      表示将NextPC输出到ResultM
    // RegReadD         表示A1和A2对应的寄存器值是否被使用到了，用于forward的处理
    // BranchTypeD      表示不同的分支类型，所有类型定义在Parameters.v中
    // AluContrlD       表示不同的ALU计算功能，所有类型定义在Parameters.v中
    // AluSrc2D         表示Alu输入源2的选择
    // AluSrc1D         表示Alu输入源1的选择
    // ImmType          表示指令的立即数格式
//实验要求  
    //补全模块  

`include "Parameters.v"   
module ControlUnit(
    input wire [6:0] Op,
    input wire [2:0] Fn3,
    input wire [6:0] Fn7,
    //CSR
    input wire [4:0] Rs1D,
    input wire [4:0] RdD,
    output wire JalD,
    output wire JalrD,
    output reg [2:0] RegWriteD,
    //CSR modify
    output wire [1:0] MemToRegD,

    output reg [3:0] MemWriteD,
    output wire LoadNpcD,
    output reg [1:0] RegReadD,
    output reg [2:0] BranchTypeD,
    output reg [3:0] AluContrlD,
    output wire [1:0] AluSrc2D,
    //CSR modify
    output wire [1:0] AluSrc1D,
    output reg [2:0] ImmType,
    //CSR 
    output reg CSRReadD,
    output reg CSRWriteD
    ); 
    
    // 请补全此处代码
    //Load类指令
    assign MemToRegD = (Op == 7'b0000011) ? 2'b01 : 
                        (Op == 7'b1110011) ? 2'b10 : 2'b00;
    //将NextPC输出到ResultM
    assign LoadNpcD = JalD | JalrD;

    assign JalD = (Op==7'b1101111) ? 1'b1 : 1'b0;
    assign JalrD = (Op==7'b1100111) ? 1'b1 : 1'b0;
    // AUIPC指令对应01，CSRRWI、CSRRSI、CSRRCi指令对应10
    assign AluSrc1D = (Op == 7'b1110011 && Fn3[2] == 1) ? 
                        2'b10 :
                        ((Op == 7'b0010111) ? 2'b01 : 2'b00);


    //若为立即数位移运算，则Op == 7'b0010011，且Fn3[1:0] == 2'b01，则对应SLLI、SRLI、SRAI
    //若为R类指令或Branch指令，则对应2'b00
    //其他立即数类指令，对应2'b10
    assign AluSrc2D = ((Op == 7'b0110011) || (Op == 7'b1100011)) ? 2'b00 :
                    (((Op == 7'b0010011) && (Fn3[1:0] == 2'b01))? 2'b01 : 
                    ((Op == 7'b1110011) ? 2'b11 : 2'b10));
                    
    
    always@(*)
    begin
        if(Op == 7'b1100011)      //判断是Branch指令
        begin    
            case(Fn3)
            3'b000: BranchTypeD <= `BEQ;    
            3'b001: BranchTypeD <= `BNE;    
            3'b100: BranchTypeD <= `BLT;    
            3'b101: BranchTypeD <= `BGE;    
            3'b110: BranchTypeD <= `BLTU;  
            3'b111: BranchTypeD <= `BGEU;                                                     
            endcase
        end
        else BranchTypeD <= `NOBRANCH;
    end
    
    
    
    //表示A1和A2对应的寄存器值是否被使用到了，用于forward的处理
    always@(*)
    begin
        case(ImmType)
            `UTYPE: RegReadD = 2'b00;
            `JTYPE: RegReadD = 2'b00;
            //I类指令，表示用到了A1，没有用到A2
            `ITYPE: RegReadD = 2'b10;
            `RTYPE: RegReadD = 2'b11;
            `STYPE: RegReadD = 2'b11;
            `BTYPE: RegReadD = 2'b11;

            default: RegReadD = 2'b00;                                      
        endcase
    end   

    //CSRRead and CSRWrite
    //当rs=0时，不对CSR进行操作
    always@(*) 
    begin
        if(Op == 7'b1110011 && Rs1D != 5'b0)
        begin
            CSRReadD <= 1;
            CSRWriteD <= 1;
        end
        else if(Op == 7'b1110011 && Rs1D == 5'b0 && Fn3[1] != 1'b0)
        begin
            CSRReadD <= 1;
            CSRWriteD <= 0;
        end
        else if(Op == 7'b1110011 && RdD == 5'b0 && Fn3[1] == 1'b0)
        begin
            CSRReadD <= 1;
            CSRWriteD <= 0;
        end
        else 
        begin
            CSRReadD <= 1;
            CSRWriteD <= 0;
        end
    end

    always@(*)
    begin
        case(Op)
            7'b0110011: //寄存器型运算
            begin    
                ImmType <= `RTYPE;
                RegWriteD <= `LW;
                MemWriteD <= 4'b0000;
                
                case(Fn3)
                    3'b000:
                    begin
                        if(Fn7[5] == 0)
                            AluContrlD <=`ADD;   
                        else
                            AluContrlD <=`SUB;  
                    end
                    3'b001: AluContrlD <= `SLL;    
                    3'b010: AluContrlD <= `SLT;    
                    3'b011: AluContrlD <= `SLTU;    
                    3'b100: AluContrlD <= `XOR;    
                    3'b101:
                    begin
                        if(Fn7[5] == 0)
                            AluContrlD <=`SRL;   
                        else
                            AluContrlD <=`SRA;   
                    end  
                    3'b110: AluContrlD <= `OR;    
                    3'b111: AluContrlD <= `AND;  
                endcase
            end

            7'b0010011: //移位 立即数
            begin    
                ImmType <= `ITYPE;
                RegWriteD <= `LW;
                MemWriteD <= 4'b0000;
                
                case(Fn3)
                    3'b000: AluContrlD <=`ADD;  
                    3'b001: AluContrlD <=`SLL;  
                    3'b010: AluContrlD <=`SLT;  
                    3'b011: AluContrlD <=`SLTU; 
                    3'b100: AluContrlD <=`XOR;  
                    3'b101:
                        if(Fn7[5]==1)
                            AluContrlD <=`SRA;   
                        else
                            AluContrlD <=`SRL;  
                    3'b110: AluContrlD <=`OR;   
                    3'b111: AluContrlD <=`AND;                                                     
                endcase
            end

            7'b0000011: //存储器读
            begin    
                ImmType <= `ITYPE;
                MemWriteD <= 4'b0000;
                AluContrlD <= `ADD;
                
                case(Fn3)
                    3'b000: RegWriteD <=`LB;    
                    3'b001: RegWriteD <=`LH;    
                    3'b010: RegWriteD <=`LW;    
                    3'b100: RegWriteD <=`LBU;    
                    3'b101: RegWriteD <=`LHU;     
                    default: RegWriteD <= `LW;                                                           
                endcase
            end

            7'b0100011:  //存储器写
            begin   
                ImmType <= `STYPE; 
                RegWriteD <= `NOREGWRITE;
                AluContrlD <= `ADD;
                
                case(Fn3)
                    3'b000: MemWriteD <= 4'b0001;    //SB
                    3'b001: MemWriteD <= 4'b0011;    //SH
                    3'b010: MemWriteD <= 4'b1111;    //SW   
                    default: MemWriteD <= 4'b1111;   //SW                                            
                endcase
            end

            7'b1101111: //JAL
            begin    
                ImmType <= `JTYPE; 
                RegWriteD <= `LW;
                MemWriteD <= 4'b0000;
                AluContrlD <= `ADD;
            end

            7'b1100111:  //JALR
            begin   
                ImmType <= `ITYPE;       
                RegWriteD <= `LW;
                MemWriteD <= 4'b0000;
                AluContrlD <= `ADD;
                        
            end
            7'b1100011: //Branch
            begin    
                ImmType <= `BTYPE;
                RegWriteD <= `NOREGWRITE;
                MemWriteD <= 4'b0000;
                AluContrlD <= `ADD;   
            end

            7'b0110111: //LUI
            begin    
                RegWriteD <= `LW;
                MemWriteD <= 4'b0000;
                AluContrlD <= `LUI;
                ImmType <= `UTYPE;     
            end 

            7'b0010111: //AUIPC，通过ADD来实现
            begin    
                RegWriteD <= `LW;
                MemWriteD <= 4'b0000;
                AluContrlD <= `ADD;
                ImmType <= `UTYPE;
            end

            7'b1110011: //CSR
            begin
                
                RegWriteD <= `LW;
                ImmType <= `ITYPE;  
                case (Fn3)
                    3'b001: AluContrlD <= `REG1;  
                    3'b010: AluContrlD <= `OR; 
                    3'b011: AluContrlD <= `CLR;
                    3'b101: AluContrlD <= `REG1;  
                    3'b110: AluContrlD <= `OR;   
                    3'b111: AluContrlD <= `CLR;   
                    default: AluContrlD <= `CLR;
            endcase
            end
            default:
            begin       //无效指令 or 空指令
                ImmType <= `ITYPE;
                RegWriteD <= `NOREGWRITE;
                MemWriteD <= 4'b0000;
                AluContrlD <= `ADD;
            end   

        endcase
    end

endmodule

