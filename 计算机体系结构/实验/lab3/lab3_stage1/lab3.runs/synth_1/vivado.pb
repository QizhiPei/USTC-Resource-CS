
s
Command: %s
53*	vivadotcl2B
.synth_design -top cache -part xc7a100tcsg324-12default:defaultZ4-113h px? 
:
Starting synth_design
149*	vivadotclZ4-321h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-349h px? 
?
%s*synth2?
sStarting Synthesize : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 469.879 ; gain = 172.492
2default:defaulth px? 
?
synthesizing module '%s'%s4497*oasys2
cache2default:default2
 2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
32default:default8@Z8-6157h px? 
b
%s
*synth2J
6	Parameter LINE_ADDR_LEN bound to: 3 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter SET_ADDR_LEN bound to: 3 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter TAG_ADDR_LEN bound to: 6 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter WAY_CNT bound to: 4 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter STRATEGY bound to: 0 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter MEM_ADDR_LEN bound to: 9 - type: integer 
2default:defaulth p
x
? 
e
%s
*synth2M
9	Parameter UNUSED_ADDR_LEN bound to: 18 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter WAY_ADDR_LEN bound to: 2 - type: integer 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter LINE_SIZE bound to: 8 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter SET_SIZE bound to: 8 - type: integer 
2default:defaulth p
x
? 
?
-case statement is not full and has no default155*oasys2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1282default:default8@Z8-155h px? 
?
synthesizing module '%s'%s4497*oasys2
main_mem2default:default2
 2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
22default:default8@Z8-6157h px? 
b
%s
*synth2J
6	Parameter LINE_ADDR_LEN bound to: 3 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter ADDR_LEN bound to: 9 - type: integer 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter RD_CYCLE bound to: 50 - type: integer 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter WR_CYCLE bound to: 50 - type: integer 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter LINE_SIZE bound to: 8 - type: integer 
2default:defaulth p
x
? 
?
synthesizing module '%s'%s4497*oasys2
mem2default:default2
 2default:default2T
>D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/mem.sv2default:default2
22default:default8@Z8-6157h px? 
^
%s
*synth2F
2	Parameter ADDR_LEN bound to: 12 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter MEM_SIZE bound to: 4096 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
mem2default:default2
 2default:default2
12default:default2
12default:default2T
>D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/mem.sv2default:default2
22default:default8@Z8-6155h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2 
rd_delay_reg2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
362default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2 
wr_delay_reg2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
372default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[0]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[1]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[2]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[3]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[4]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[5]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[6]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
rd_line_reg[7]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[0]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[1]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[2]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[3]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[4]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[5]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[6]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2(
rd_line_latch_reg[7]2default:default2
main_mem2default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
872default:default8@Z8-5788h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
main_mem2default:default2
 2default:default2
22default:default2
12default:default2Y
CD:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/main_mem.sv2default:default2
22default:default8@Z8-6155h px? 
?
n3D RAM %s  for this pattern/configuration is not supported. This will most likely be implemented in registers
4275*oasys2
	dirty_reg2default:defaultZ8-5856h px? 
?
n3D RAM %s  for this pattern/configuration is not supported. This will most likely be implemented in registers
4275*oasys2
	valid_reg2default:defaultZ8-5856h px? 
?
n3D RAM %s  for this pattern/configuration is not supported. This will most likely be implemented in registers
4275*oasys2
	order_reg2default:defaultZ8-5856h px? 
?
n3D RAM %s  for this pattern/configuration is not supported. This will most likely be implemented in registers
4275*oasys2!
cache_mem_reg2default:defaultZ8-5856h px? 
?
n3D RAM %s  for this pattern/configuration is not supported. This will most likely be implemented in registers
4275*oasys2"
cache_tags_reg2default:defaultZ8-5856h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[0][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[0][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[0][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[0][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[1][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[1][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[1][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[1][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[2][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[2][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[2][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[2][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[3][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[3][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[3][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[3][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[4][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[4][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[4][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[4][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[5][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[5][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[5][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[5][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[6][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[6][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[6][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[6][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[7][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[7][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[7][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
dirty_reg[7][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1152default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[0][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[0][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[0][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[0][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[1][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[1][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[1][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[1][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[2][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[2][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[2][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[2][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[3][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[3][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[3][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[3][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[4][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[4][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[4][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[4][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[5][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[5][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[5][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[5][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[6][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[6][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[6][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[6][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[7][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[7][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[7][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
valid_reg[7][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1162default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[0][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[0][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[0][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[0][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[1][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[1][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[1][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[1][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[2][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[2][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[2][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[2][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[3][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[3][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[3][2]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[3][3]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[4][0]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
order_reg[4][1]2default:default2
cache2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
1172default:default8@Z8-5788h px? 
?
?Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2 
Synth 8-57882default:default2
1002default:defaultZ17-14h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
cache2default:default2
 2default:default2
32default:default2
12default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
32default:default8@Z8-6155h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[31]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[30]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[29]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[28]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[27]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[26]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[25]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[24]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[23]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[22]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[21]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[20]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[19]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[18]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[17]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[16]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[15]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[14]2default:defaultZ8-3331h px? 
{
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[1]2default:defaultZ8-3331h px? 
{
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[0]2default:defaultZ8-3331h px? 
?
%s*synth2?
sFinished Synthesize : Time (s): cpu = 00:00:13 ; elapsed = 00:00:14 . Memory (MB): peak = 644.340 ; gain = 346.953
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
~Finished Constraint Validation : Time (s): cpu = 00:00:14 ; elapsed = 00:00:15 . Memory (MB): peak = 644.340 ; gain = 346.953
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Loading part: xc7a100tcsg324-1
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Loading Part and Timing Information : Time (s): cpu = 00:00:14 ; elapsed = 00:00:15 . Memory (MB): peak = 644.340 ; gain = 346.953
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
W
Loading part %s157*device2$
xc7a100tcsg324-12default:defaultZ21-403h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2"
cache_stat_reg2default:default2
cache2default:defaultZ8-802h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                    IDLE |                             0001 | 00000000000000000000000000000000
2default:defaulth p
x
? 
?
%s
*synth2s
_                SWAP_OUT |                             0010 | 00000000000000000000000000000001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 SWAP_IN |                             0100 | 00000000000000000000000000000010
2default:defaulth p
x
? 
?
%s
*synth2s
_              SWAP_IN_OK |                             1000 | 00000000000000000000000000000011
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2"
cache_stat_reg2default:default2
one-hot2default:default2
cache2default:defaultZ8-3354h px? 
?
!inferring latch for variable '%s'327*oasys2 
way_addr_reg2default:default2V
@D:/study/architecture/ustc_ca2021_lab/lab3/CacheSrcCode/cache.sv2default:default2
892default:default8@Z8-327h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:29 ; elapsed = 00:00:27 . Memory (MB): peak = 724.648 ; gain = 427.262
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      3 Bit       Adders := 2     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               32 Bit    Registers := 318   
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               12 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                9 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                6 Bit    Registers := 33    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                2 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 65    
2default:defaulth p
x
? 
8
%s
*synth2 
+---RAMs : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	             128K Bit         RAMs := 1     
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 143   
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input     32 Bit        Muxes := 50    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     12 Bit        Muxes := 6     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      9 Bit        Muxes := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      6 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      2 Bit        Muxes := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      2 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 656   
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      1 Bit        Muxes := 455   
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Y
%s
*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Hierarchical RTL Component report 
2default:defaulth p
x
? 
:
%s
*synth2"
Module cache 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               32 Bit    Registers := 298   
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                9 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                6 Bit    Registers := 33    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                2 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 64    
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 136   
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input     32 Bit        Muxes := 50    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      9 Bit        Muxes := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      6 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      2 Bit        Muxes := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      2 Bit        Muxes := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 646   
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      1 Bit        Muxes := 455   
2default:defaulth p
x
? 
8
%s
*synth2 
Module mem 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
? 
8
%s
*synth2 
+---RAMs : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	             128K Bit         RAMs := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
Module main_mem 
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      3 Bit       Adders := 2     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               32 Bit    Registers := 19    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               12 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                9 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 7     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input     12 Bit        Muxes := 6     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 10    
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
[
%s
*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2k
WPart Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB18 80 RAMB36 40)
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
]
%s
*synth2E
1Warning: Parallel synthesis criteria is not met 
2default:defaulth p
x
? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[31]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[30]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[29]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[28]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[27]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[26]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[25]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[24]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[23]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[22]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[21]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[20]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[19]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[18]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[17]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[16]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[15]2default:defaultZ8-3331h px? 
|
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[14]2default:defaultZ8-3331h px? 
{
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[1]2default:defaultZ8-3331h px? 
{
!design %s has unconnected port %s3331*oasys2
cache2default:default2
addr[0]2default:defaultZ8-3331h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:01:10 ; elapsed = 00:01:08 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?---------------------------------------------------------------------------------
Start ROM, RAM, DSP and Shift Register Reporting
2default:defaulth px? 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px? 
e
%s*synth2M
9
Block RAM: Preliminary Mapping  Report (see note below)
2default:defaulth px? 
?
%s*synth2?
?+------------+--------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth px? 
?
%s*synth2?
?|Module Name | RTL Object   | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
2default:defaulth px? 
?
%s*synth2?
?+------------+--------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth px? 
?
%s*synth2?
?|mem:        | ram_cell_reg | 4 K x 32(READ_FIRST)   | W | R |                        |   |   | Port A           | 0      | 4      | 
2default:defaulth px? 
?
%s*synth2?
?+------------+--------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

2default:defaulth px? 
?
%s*synth2?
?Note: The table above is a preliminary report that shows the Block RAMs at the current stage of the synthesis flow. Some Block RAMs may be reimplemented as non Block RAM primitives later in the synthesis flow. Multiple instantiated Block RAMs are reported only once. 
2default:defaulth px? 
?
%s*synth2?
?---------------------------------------------------------------------------------
Finished ROM, RAM, DSP and Shift Register Reporting
2default:defaulth px? 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2A
-main_mem_instance/i_0/mem_inst/ram_cell_reg_02default:default2
Block2default:defaultZ8-6837h px? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2A
-main_mem_instance/i_0/mem_inst/ram_cell_reg_12default:default2
Block2default:defaultZ8-6837h px? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2A
-main_mem_instance/i_0/mem_inst/ram_cell_reg_22default:default2
Block2default:defaultZ8-6837h px? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2A
-main_mem_instance/i_0/mem_inst/ram_cell_reg_32default:default2
Block2default:defaultZ8-6837h px? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
|Finished Timing Optimization : Time (s): cpu = 00:01:16 ; elapsed = 00:01:14 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2?
?---------------------------------------------------------------------------------
Start ROM, RAM, DSP and Shift Register Reporting
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
N
%s
*synth26
"
Block RAM: Final Mapping  Report
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+--------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth p
x
? 
?
%s
*synth2?
?|Module Name | RTL Object   | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+--------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth p
x
? 
?
%s
*synth2?
?|mem:        | ram_cell_reg | 4 K x 32(READ_FIRST)   | W | R |                        |   |   | Port A           | 0      | 4      | 
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+--------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

2default:defaulth p
x
? 
?
%s
*synth2?
?---------------------------------------------------------------------------------
Finished ROM, RAM, DSP and Shift Register Reporting
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2=
)main_mem_instance/mem_inst/ram_cell_reg_02default:default2
Block2default:defaultZ8-6837h px? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2=
)main_mem_instance/mem_inst/ram_cell_reg_12default:default2
Block2default:defaultZ8-6837h px? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2=
)main_mem_instance/mem_inst/ram_cell_reg_22default:default2
Block2default:defaultZ8-6837h px? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the block ram. Providing additional output register may help in improving timing.
4693*oasys2=
)main_mem_instance/mem_inst/ram_cell_reg_32default:default2
Block2default:defaultZ8-6837h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
{Finished Technology Mapping : Time (s): cpu = 00:01:26 ; elapsed = 00:01:24 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
uFinished IO Insertion : Time (s): cpu = 00:01:32 ; elapsed = 00:01:29 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
? 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Instances : Time (s): cpu = 00:01:32 ; elapsed = 00:01:29 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Rebuilding User Hierarchy : Time (s): cpu = 00:01:32 ; elapsed = 00:01:30 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Ports : Time (s): cpu = 00:01:32 ; elapsed = 00:01:30 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:01:35 ; elapsed = 00:01:33 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Nets : Time (s): cpu = 00:01:35 ; elapsed = 00:01:33 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
? 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px? 
F
%s*synth2.
+------+---------+------+
2default:defaulth px? 
F
%s*synth2.
|      |Cell     |Count |
2default:defaulth px? 
F
%s*synth2.
+------+---------+------+
2default:defaulth px? 
F
%s*synth2.
|1     |BUFG     |     1|
2default:defaulth px? 
F
%s*synth2.
|2     |CARRY4   |    37|
2default:defaulth px? 
F
%s*synth2.
|3     |LUT1     |     5|
2default:defaulth px? 
F
%s*synth2.
|4     |LUT2     |   158|
2default:defaulth px? 
F
%s*synth2.
|5     |LUT3     |   118|
2default:defaulth px? 
F
%s*synth2.
|6     |LUT4     |   426|
2default:defaulth px? 
F
%s*synth2.
|7     |LUT5     |   640|
2default:defaulth px? 
F
%s*synth2.
|8     |LUT6     |  4241|
2default:defaulth px? 
F
%s*synth2.
|9     |MUXF7    |   928|
2default:defaulth px? 
F
%s*synth2.
|10    |RAMB36E1 |     4|
2default:defaulth px? 
F
%s*synth2.
|11    |FDCE     |  1487|
2default:defaulth px? 
F
%s*synth2.
|12    |FDPE     |     4|
2default:defaulth px? 
F
%s*synth2.
|13    |FDRE     |  8968|
2default:defaulth px? 
F
%s*synth2.
|14    |LD       |     2|
2default:defaulth px? 
F
%s*synth2.
|15    |IBUF     |    48|
2default:defaulth px? 
F
%s*synth2.
|16    |OBUF     |    33|
2default:defaulth px? 
F
%s*synth2.
+------+---------+------+
2default:defaulth px? 
E
%s
*synth2-

Report Instance Areas: 
2default:defaulth p
x
? 
[
%s
*synth2C
/+------+--------------------+---------+------+
2default:defaulth p
x
? 
[
%s
*synth2C
/|      |Instance            |Module   |Cells |
2default:defaulth p
x
? 
[
%s
*synth2C
/+------+--------------------+---------+------+
2default:defaulth p
x
? 
[
%s
*synth2C
/|1     |top                 |         | 17100|
2default:defaulth p
x
? 
[
%s
*synth2C
/|2     |  main_mem_instance |main_mem |  1089|
2default:defaulth p
x
? 
[
%s
*synth2C
/|3     |    mem_inst        |mem      |     4|
2default:defaulth p
x
? 
[
%s
*synth2C
/+------+--------------------+---------+------+
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Writing Synthesis Report : Time (s): cpu = 00:01:35 ; elapsed = 00:01:33 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
t
%s
*synth2\
HSynthesis finished with 0 errors, 0 critical warnings and 449 warnings.
2default:defaulth p
x
? 
?
%s
*synth2?
~Synthesis Optimization Runtime : Time (s): cpu = 00:01:35 ; elapsed = 00:01:33 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth p
x
? 
?
%s
*synth2?
Synthesis Optimization Complete : Time (s): cpu = 00:01:35 ; elapsed = 00:01:33 . Memory (MB): peak = 980.738 ; gain = 683.352
2default:defaulth p
x
? 
B
 Translating synthesized netlist
350*projectZ1-571h px? 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
9712default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
?
?Netlist '%s' is not ideal for floorplanning, since the cellview '%s' contains a large number of primitives.  Please consider enabling hierarchy in synthesis if you want to do floorplanning.
310*netlist2
cache2default:default2
cache2default:defaultZ29-101h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0072default:default2
980.7382default:default2
0.0002default:defaultZ17-268h px? 
?
!Unisim Transformation Summary:
%s111*project2Y
E  A total of 2 instances were transformed.
  LD => LDCE: 2 instances
2default:defaultZ1-111h px? 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
272default:default2
1472default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:01:462default:default2
00:01:452default:default2
980.7382default:default2
683.3522default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0072default:default2
980.7382default:default2
0.0002default:defaultZ17-268h px? 
K
"No constraints selected for write.1103*constraintsZ18-5210h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2J
6G:/vivadoprogram/arch/lab3/lab3.runs/synth_1/cache.dcp2default:defaultZ17-1381h px? 
?
%s4*runtcl2t
`Executing : report_utilization -file cache_utilization_synth.rpt -pb cache_utilization_synth.pb
2default:defaulth px? 
?
Exiting %s at %s...
206*common2
Vivado2default:default2,
Sun May 30 17:08:15 20212default:defaultZ17-206h px? 


End Record