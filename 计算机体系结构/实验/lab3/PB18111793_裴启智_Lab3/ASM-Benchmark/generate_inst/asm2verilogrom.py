# -*- coding:utf-8 -*-
# Python2 or Python3
# Author : WangXuan
# 
# 功能： 使用 Windows 版的 RISCV 工具链将汇编编译成 指令 Cache 的 Verilog 文件
# 


import os, sys, binascii

verilog_head = '''// asm file name: %s
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
'''

verilog_tail = '''end

    always@(posedge clk)
    begin
        data <= addr_valid ? inst_cache[dealt_addr] : 32'h0;
        debug_data <= debug_addr_valid ? inst_cache[dealt_debug_addr] : 32'h0;
        if(write_en & debug_addr_valid) 
            inst_cache[dealt_debug_addr] <= debug_input;
    end

endmodule
'''

RISCV_TOOLCHAIN_PATH = '.\\riscv32-gnu-toolchain-windows\\'

if len(sys.argv) != 3:
    print('    Usage:\n        python asm2verilog.py [INPUT ASM file] [OUTPUT Verilog file]')
    print('    Example:\n        python asm2verilog.py QuickSort.S InstructionCache.v')
else:
    INPUT  = sys.argv[1]
    OUTPUT = sys.argv[2]

    res = os.system( '%sriscv32-elf-as %s            -o compile_tmp.o   -march=rv32i' % (RISCV_TOOLCHAIN_PATH, INPUT) )
    if res != 0:
        print('\n    Assembling Error!')
        sys.exit()
    os.system( '%sriscv32-elf-ld compile_tmp.o -o compile_tmp.om'               % (RISCV_TOOLCHAIN_PATH       ) )
    os.system( 'del compile_tmp.o'   )
    os.system( '%sriscv32-elf-objcopy -O binary compile_tmp.om compile_tmp.bin' % (RISCV_TOOLCHAIN_PATH,      ) )
    os.system( 'del compile_tmp.om'  )
    s = binascii.b2a_hex( open('compile_tmp.bin', 'rb').read() )
    os.system( 'del compile_tmp.bin' )

    def byte_wise_reverse(b):
        return b[6:8] + b[4:6] + b[2:4] + b[0:2]
        return b[6:8] + b[4:6] + b[2:4] + b[0:2]

    with open(OUTPUT, 'w') as f:
        f.write(verilog_head % (INPUT,))
        for i in range(0, len(s), 8):
            instr_string = str(byte_wise_reverse(s[i:i+8]))
            if instr_string[1] == "'":
                instr_string = instr_string[2:]
            instr_string = instr_string.strip("'")
            f.write('        inst_cache[%8d] = 32\'h%s;\n' % (i//8, instr_string, ))
        f.write(verilog_tail)
    