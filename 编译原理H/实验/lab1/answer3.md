## 在`HW/H3/answer.md`中回答本题，指出不同编译选项（主要是`-S`选项下结合`-m32`、`-m64`）下输出的汇编码，并对汇编码加注释。

- `GCC/Clang`均需要使用，重点在说明**两个编译器汇编码的不同**

- 对一个汇编码详细注释，其他汇编码**挑重点和不同注释**即可

  > 注释至少要说明不同汇编命令的含义、源程序中的变量、中间结果、**函数调用参数的传递和使用**在汇编码中的对应。

***

* 下面是对`gcc`生成的32位汇编的详细注释

```assembly
.file   "sort.c"
        .text
        .globl  sort
        .type   sort, @function
sort:
.LFB2:
        .cfi_startproc
        pushl   %ebp	#保存基址寄存器ebp
        .cfi_def_cfa_offset 8
        .cfi_offset 5, -8
        movl    %esp, %ebp #把栈顶寄存器的值存入ebp
        .cfi_def_cfa_register 5
        subl    $16, %esp	#在栈顶分配16字节的空间
        movl    $0, -12(%ebp)	#i=0
        jmp     .L2	#跳转到外层循环
.L6:
        movl    $0, -8(%ebp)	#将立即数0存入局部变量j
        jmp     .L3		#跳转到L3
.L5:
		movl    -8(%ebp), %eax	#将j的值存入eax寄存器
        leal    0(,%eax,4), %edx	#edx=j*4
        movl    8(%ebp), %eax	#将数组首地址a放入eax
        addl    %edx, %eax	#计算a[j]的地址
        movl    (%eax), %edx	#将a[j]存入edx寄存器
        movl    -8(%ebp), %eax	#将j的值存入eax寄存器
        addl    $1, %eax	#j++
        leal    0(,%eax,4), %ecx	#ecx=j*4（注意j已经加一）
        movl    8(%ebp), %eax	#将数组首地址a放入eax
        addl    %ecx, %eax	#计算a[j+1]的地址
        movl    (%eax), %eax	#将a[j+1]存入eax寄存器
        cmpl    %eax, %edx	#比较a[j]和a[j+1]
        jle     .L4	#如果不满足a[j]>a[j+1]，即如果a[j+1]≤a[j]
        movl    -8(%ebp), %eax	#取j到eax
        addl    $1, %eax	#j++
        leal    0(,%eax,4), %edx	#edx=j*4
        movl    8(%ebp), %eax	#将数组首地址a放入eax
        addl    %edx, %eax	#计算a[j+1]的地址
        movl    (%eax), %eax	#将a[j+1]放入eax寄存器
        movl    %eax, -4(%ebp)	#将a[j+1]暂存在ebp-4的位置,即temp=a[j+1]
        movl    -8(%ebp), %eax	#取j到eax
        addl    $1, %eax	#j++
        leal    0(,%eax,4), %edx	#edx=j*4
        movl    8(%ebp), %eax	#将数组首地址a放入eax
        addl    %eax, %edx		#计算a[j+1]的地址放入edx
        movl    -8(%ebp), %eax	#取j到eax
        leal    0(,%eax,4), %ecx	#ecx=j*4
        movl    8(%ebp), %eax	#取出数组首地址a放入eax
        addl    %ecx, %eax		#计算出a[j]的地址，放入eax
        movl    (%eax), %eax	#将a[j]的值放入eax
        movl    %eax, (%edx)	#a[j+1]=a[j]
        movl    -8(%ebp), %eax	#取j到eax
        leal    0(,%eax,4), %edx	#edx=j*4
        movl    8(%ebp), %eax	#取出数组首地址a放入eax
        addl    %eax, %edx		#计算出a[j]的地址，放入eax
        movl    -4(%ebp), %eax	#将temp的值放入eax寄存器
        movl    %eax, (%edx)	#a[j]=temp
.L4:
        addl    $1, -8(%ebp)	#j++
.L3:
        movl    12(%ebp), %eax	#将n的值放入eax
        subl    $1, %eax	#计算n-1
        subl    -12(%ebp), %eax#计算n-1-i
        cmpl    -8(%ebp), %eax #比较j和n-1-i
        jg      .L5	#如果j<n-i-1,，跳转到L5
        addl    $1, -12(%ebp) #i++
.L2:
        movl    12(%ebp), %eax	#将n的值存入eax寄存器
        subl    $1, %eax	#计算n-1
        cmpl    -12(%ebp), %eax	#比较i和n-1的大小
        jg      .L6	#如果i<n-1,则跳转到L6
        nop
        leave	#结束sort函数
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
.LFE2:
        .size   sort, .-sort
        .section        .rodata
.LC0:
        .string "%d"
.LC1:
        .string "%d "
        .text
        .globl  main
        .type   main, @function
main:
.LFB3:
        .cfi_startproc
        leal    4(%esp), %ecx
        .cfi_def_cfa 1, 0
        andl    $-16, %esp
        pushl   -4(%ecx)	#将ecx-4的值入栈
        pushl   %ebp	#保存基址寄存器ebp
        .cfi_escape 0x10,0x5,0x2,0x75,0
        movl    %esp, %ebp	#把栈顶寄存器的值存入ebp
        pushl   %ecx	#ecx入栈
        .cfi_escape 0xf,0x3,0x75,0x7c,0x6
        subl    $20, %esp	#在栈顶分配20字节的空间
        movl    %gs:20, %eax
        movl    %eax, -12(%ebp)
        xorl    %eax, %eax
        subl    $8, %esp	#在栈顶分配8个字节的空间
        leal    -24(%ebp), %eax	#将n的值要放入的位置放入eax
        pushl   %eax	#将eax入栈
        pushl   $.LC0	#将“%d”入栈
        call    __isoc99_scanf	#调用scanf，读入n到ebp-24的位置
        addl    $16, %esp	#栈指针回退16个字节，相当于两次pop
        movl    -24(%ebp), %eax	#将读入的n放入eax寄存器
        sall    $2, %eax	#相当于n*sizeof（int）
        subl    $12, %esp	#在栈顶分配12个字节的空间
        pushl   %eax	#eax入栈
        call    malloc	#调用malloc函数
        addl    $16, %esp	#栈指针回退16个字节，相当于两次pop
        movl    %eax, -16(%ebp)	#将malloc得到的数组首地址a放入ebp-16的位置
        movl    $0, -20(%ebp)	#初始化i=0
        jmp     .L8
.L9:
        movl    -20(%ebp), %eax	#将i的值放入eax寄存器
        leal    0(,%eax,4), %edx	#edx=i*4(即根据32位标准计算数组的物理偏移)
        movl    -16(%ebp), %eax	#将a的地址放入eax中
        addl    %edx, %eax	#计算a+i*4
        subl    $8, %esp	#在栈顶分配8个字节的空间
        pushl   %eax	#将eax入栈
        pushl   $.LC0	#将“%d”入栈
        call    __isoc99_scanf	#调用scanf
        addl    $16, %esp	#栈指针回退16个字节，相当于两次pop
        addl    $1, -20(%ebp)	#i++
.L8:
        movl    -24(%ebp), %eax	#将n的值放入eax寄存器中
        cmpl    %eax, -20(%ebp)	#判断i和n的大小
        jl      .L9	#如果i<n，则跳转到L9，循环scanf读入要排序的数
        movl    -24(%ebp), %eax	#将n的值放入eax寄存器
        subl    $8, %esp	#在栈顶分配8个字节的空间
        pushl   %eax #eax寄存器入栈
        pushl   -16(%ebp)	#a的地址入栈
        call    sort	#参数均入栈，调用排序函数sort
        addl    $16, %esp	#栈指针回退16个字节，相当于两次pop
        movl    $0, -20(%ebp)	#将i的值（即0）存入ebp-20的位置
        jmp     .L10	#跳转到L10
.L11:	#printf部分
		movl    -20(%ebp), %eax	#将i的值放入eax
        leal    0(,%eax,4), %edx	#edx=i*4(即根据32位标准计算数组的物理偏移)
        movl    -16(%ebp), %eax	#将数组首地址a放入eax
        addl    %edx, %eax	#计算a+i*4
        movl    (%eax), %eax	#将上述地址的值放入eax
        subl    $8, %esp	#在栈顶分配8个字节的空间
        pushl   %eax	#将eax入栈
        pushl   $.LC1	#将“%d”入栈
        call    printf	#调用printf
        addl    $16, %esp		#栈指针回退16个字节，相当于两次pop
        addl    $1, -20(%ebp)	#i++
.L10:
        movl    -24(%ebp), %eax	#将n的值放入eax寄存器
        cmpl    %eax, -20(%ebp)	#比较i和n的大小
        jl      .L11 #若i<n则跳转到L11，循环printf
        movl    $0, %eax	
        movl    -12(%ebp), %ecx
        xorl    %gs:20, %ecx
        je      .L13
        call    __stack_chk_fail	#检查栈是否溢出
 .L13:
        movl    -4(%ebp), %ecx	#返回值0
        .cfi_def_cfa 1, 0
        leave			#相当于movl %ebp,%esp; popl %ebp
        .cfi_restore 5
        leal    -4(%ecx), %esp
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
        .LFE3:
        .size   main, .-main
        .ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
        .section        .note.GNU-stack,"",@progbits
```



* `gcc`生成的64位汇编的注释

```assembly
.file   "sort.c"
        .text
        .globl  sort
        .type   sort, @function
sort:
.LFB2:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        movq    %rdi, -24(%rbp)	#将rdi保存在rbp-24的位置
        movl    %esi, -28(%rbp) #将esi保存在rbp-28的位置
        movl    $0, -12(%rbp)
        jmp     .L2
.L6:
        movl    $0, -8(%rbp)
        jmp     .L3
.L5:
        movl    -8(%rbp), %eax
        cltq	#清理标记，下同
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rdx, %rax
        movl    (%rax), %edx
        movl    -8(%rbp), %eax
        cltq	
        addq    $1, %rax
        leaq    0(,%rax,4), %rcx
        movq    -24(%rbp), %rax
        addq    %rcx, %rax
        movl    (%rax), %eax
        cmpl    %eax, %edx
        jle     .L4
        movl    -8(%rbp), %eax
        cltq
        addq    $1, %rax
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rdx, %rax
        movl    (%rax), %eax
        movl    %eax, -4(%rbp)
        movl    -8(%rbp), %eax
        cltq
        addq    $1, %rax
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        cltq
        leaq    0(,%rax,4), %rcx
        movq    -24(%rbp), %rax
        addq    %rcx, %rax
        movl    (%rax), %eax
        movl    %eax, (%rdx)
        movl    -8(%rbp), %eax
        cltq
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rax, %rdx
        movl    -4(%rbp), %eax
        movl    %eax, (%rdx)
.L4:
        addl    $1, -8(%rbp)
.L3:
        movl    -28(%rbp), %eax
        subl    $1, %eax
        subl    -12(%rbp), %eax
        cmpl    -8(%rbp), %eax
        jg      .L5
        addl    $1, -12(%rbp)
.L2:
        movl    -28(%rbp), %eax
        subl    $1, %eax
        cmpl    -12(%rbp), %eax
        jg      .L6
        nop
        popq    %rbp	#将rbp退栈
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE2:
        .size   sort, .-sort
        .section        .rodata
.LC0:
        .string "%d"
.LC1:
        .string "%d "
        .text
        .globl  main
        .type   main, @function
main:
.LFB3:
        .cfi_startproc
        pushq   %rbp	
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        subq    $32, %rsp
        movq    %fs:40, %rax
        movq    %rax, -8(%rbp)
        xorl    %eax, %eax
        leaq    -24(%rbp), %rax
        #为调用scanf准备参数
        movq    %rax, %rsi #将rax的值放入rsi中
        movl    $.LC0, %edi	#将“%d”放入edi
        movl    $0, %eax	#将0放入eax
        call    __isoc99_scanf
        movl    -24(%rbp), %eax
        cltq
        salq    $2, %rax
        movq    %rax, %rdi #为调用malloc准备参数
        call    malloc
        movq    %rax, -16(%rbp)
        movl    $0, -20(%rbp)
        jmp     .L8
.L9:
        movl    -20(%rbp), %eax
        cltq
        leaq    0(,%rax,4), %rdx
        movq    -16(%rbp), %rax
        addq    %rdx, %rax
        #为调用scanf准备参数
        movq    %rax, %rsi
        movl    $.LC0, %edi
        movl    $0, %eax
        call    __isoc99_scanf
        addl    $1, -20(%rbp)
.L8:
        movl    -24(%rbp), %eax
        cmpl    %eax, -20(%rbp)
        jl      .L9
        movl    -24(%rbp), %edx
        #为调用sort准备参数
        movq    -16(%rbp), %rax
        movl    %edx, %esi
        movq    %rax, %rdi
        call    sort
        movl    $0, -20(%rbp)
        jmp     .L10
.L11:
        movl    -20(%rbp), %eax
        cltq
        leaq    0(,%rax,4), %rdx
        movq    -16(%rbp), %rax
        addq    %rdx, %rax
        movl    (%rax), %eax
        #为调用printf准备参数
        movl    %eax, %esi
        movl    $.LC1, %edi
        movl    $0, %eax
        call    printf
        addl    $1, -20(%rbp)
.L10:
        movl    -24(%rbp), %eax
        cmpl    %eax, -20(%rbp)
        jl      .L11
        movl    $0, %eax
        movq    -8(%rbp), %rcx
        xorq    %fs:40, %rcx
        je      .L13
        call    __stack_chk_fail
.L13:
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE3:
        .size   main, .-main
        .ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
        .section        .note.GNU-stack,"",@progbits
```

* `clang`生成的32位汇编

```assembly
.text
        .file   "sort.c"
        .globl  sort                    # -- Begin function sort
        .p2align        4, 0x90
        .type   sort,@function
sort:                                   # @sort
# %bb.0:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $12, %esp
        movl    12(%ebp), %eax #将n的值放入eax
        movl    8(%ebp), %ecx	#将数组首地址a放入ecx
        movl    $0, -4(%ebp) #i=0
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
        movl    -4(%ebp), %eax #将i的值放入eax
        movl    12(%ebp), %ecx #n的值放入ecx
        subl    $1, %ecx #n=n-1
        cmpl    %ecx, %eax #比较i和n-1
        jge     .LBB0_10
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
        movl    $0, -8(%ebp)	#j=0
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
        movl    -8(%ebp), %eax	#将j放入eax
        movl    12(%ebp), %ecx	#将n放入exc
        subl    $1, %ecx	#n=n-1
        subl    -4(%ebp), %ecx	#ecx=n-i-1
        cmpl    %ecx, %eax #比较i和n-j-1
        jge     .LBB0_8
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
        movl    8(%ebp), %eax	#将数组首地址a放入eax
        movl    -8(%ebp), %ecx	#将j放入ecx
        movl    (%eax,%ecx,4), %eax	#将a[j]放入eax
        movl    8(%ebp), %ecx	
        movl    -8(%ebp), %edx
        cmpl    4(%ecx,%edx,4), %eax	#比较a[j]和a[j+1]
        jle     .LBB0_6
# %bb.5:                                #   in Loop: Header=BB0_3 Depth=2
        movl    8(%ebp), %eax	
        movl    -8(%ebp), %ecx
        movl    4(%eax,%ecx,4), %eax	#eax=a[j+1]
        movl    %eax, -12(%ebp)	#temp=a[j+1]
        movl    8(%ebp), %eax
        movl    -8(%ebp), %ecx
        movl    (%eax,%ecx,4), %eax	#eax=a[j]
        movl    8(%ebp), %ecx
        movl    -8(%ebp), %edx
        movl    %eax, 4(%ecx,%edx,4)	#a[j+1]=a[j]
        movl    -12(%ebp), %eax	#eax=temp
        movl    8(%ebp), %ecx
        movl    -8(%ebp), %edx	
        movl    %eax, (%ecx,%edx,4)	#a[j]=temp
.LBB0_6:                                #   in Loop: Header=BB0_3 Depth=2
        jmp     .LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_3 Depth=2
        movl    -8(%ebp), %eax
        addl    $1, %eax
        movl    %eax, -8(%ebp)
        jmp     .LBB0_3
.LBB0_8:                                #   in Loop: Header=BB0_1 Depth=1
        jmp     .LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_1 Depth=1
        movl    -4(%ebp), %eax	#eax=i
        addl    $1, %eax	#i++
        movl    %eax, -4(%ebp)	#更新i
        jmp     .LBB0_1
.LBB0_10:
        addl    $12, %esp	#释放栈空间
        popl    %ebp
        retl
.Lfunc_end0:
        .size   sort, .Lfunc_end0-sort
                                        # -- End function
        .globl  main                    # -- Begin function main
        .p2align        4, 0x90
        .type   main,@function
main:                                   # @main
# %bb.0:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $40, %esp	#在栈顶分配40字节的空间
        movl    $0, -4(%ebp)	#返回值0
        leal    .L.str, %eax	#将"%d"的地址放入eax
        movl    %eax, (%esp)	#将eax放入esp所指的位置
        leal    -8(%ebp), %eax	#将要存入n的地址放入eax
        movl    %eax, 4(%esp)	#将eax放入esp+4所指的位置
        calll   __isoc99_scanf
        movl    -8(%ebp), %ecx	#ecx=n
        shll    $2, %ecx	#n*sizeof(int)
        movl    %ecx, (%esp)	#将n*sizeof(int)放入esp所指的位置
        movl    %eax, -20(%ebp)         # 4-byte Spill
        calll   malloc
        movl    %eax, -16(%ebp)	
        movl    $0, -12(%ebp)
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
        movl    -12(%ebp), %eax	#将i放入eax
        cmpl    -8(%ebp), %eax	#比较i和n
        jge     .LBB1_4	
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
        movl    -16(%ebp), %eax	#a放入eax
        movl    -12(%ebp), %ecx	#将i放入ecx
        shll    $2, %ecx	#i*4
        addl    %ecx, %eax
        leal    .L.str, %ecx	
        movl    %ecx, (%esp)
        movl    %eax, 4(%esp)
        calll   __isoc99_scanf
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
        movl    -12(%ebp), %eax	#eax=i
        addl    $1, %eax	#i++
        movl    %eax, -12(%ebp)	#更新i
        jmp     .LBB1_1
.LBB1_4:
        movl    -16(%ebp), %eax	#eax=a
        movl    -8(%ebp), %ecx #ecx=n
        movl    %eax, (%esp)
        movl    %ecx, 4(%esp)
        calll   sort
        movl    $0, -12(%ebp)
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
        movl    -12(%ebp), %eax	#eax=i
        cmpl    -8(%ebp), %eax	#比较i和n
        jge     .LBB1_8
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
        movl    -16(%ebp), %eax	#eax=a
        movl    -12(%ebp), %ecx	#ecx=i
        movl    (%eax,%ecx,4), %eax
        leal    .L.str.1, %ecx
        movl    %ecx, (%esp)
        movl    %eax, 4(%esp)
        calll   printf
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
        movl    -12(%ebp), %eax
        addl    $1, %eax	
        movl    %eax, -12(%ebp)
        jmp     .LBB1_5
.LBB1_8:
        movl    -4(%ebp), %eax	#返回0
        addl    $40, %esp	#释放栈空间
        popl    %ebp
        retl
.Lfunc_end1:
        .size   main, .Lfunc_end1-main
                                        # -- End function
        .type   .L.str,@object          # @.str
        .section        .rodata.str1.1,"aMS",@progbits,1
.L.str:
        .asciz  "%d"
        .size   .L.str, 3

        .type   .L.str.1,@object        # @.str.1
.L.str.1:
        .asciz  "%d "
        .size   .L.str.1, 4

        .ident  "clang version 10.0.1 "
        .section        ".note.GNU-stack","",@progbits
        .addrsig
        .addrsig_sym sort
        .addrsig_sym __isoc99_scanf
        .addrsig_sym malloc
        .addrsig_sym printf
```

* `clang`生成的64位汇编

```assembly
.text
        .file   "sort.c"
        .globl  sort                    # -- Begin function sort
        .p2align        4, 0x90
        .type   sort,@function
sort:                                   # @sort
        .cfi_startproc
# %bb.0:
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset %rbp, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register %rbp
        movq    %rdi, -8(%rbp)	#将a的值放入rbp-8的位置
        movl    %esi, -12(%rbp) #将n的值放入rbp-12的位置
        movl    $0, -16(%rbp)	#i=0
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
        movl    -16(%rbp), %eax	#eax=i
        movl    -12(%rbp), %ecx	#ecx=n
        subl    $1, %ecx	#n-1
        cmpl    %ecx, %eax
        jge     .LBB0_10
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
        movl    $0, -20(%rbp)
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
        movl    -20(%rbp), %eax	#eax=j
        movl    -12(%rbp), %ecx	
        subl    $1, %ecx	#n-1
        subl    -16(%rbp), %ecx	#n-1-i
        cmpl    %ecx, %eax
        jge     .LBB0_8
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
        movq    -8(%rbp), %rax	#rax=a
        movslq  -20(%rbp), %rcx	#rcx=j
        movl    (%rax,%rcx,4), %edx	#edx=a[j]
        movq    -8(%rbp), %rax
        movl    -20(%rbp), %esi
        addl    $1, %esi
        movslq  %esi, %rcx
        cmpl    (%rax,%rcx,4), %edx	#比较a[j]和a[j+1]
        jle     .LBB0_6
# %bb.5:                                #   in Loop: Header=BB0_3 Depth=2
        movq    -8(%rbp), %rax
        movl    -20(%rbp), %ecx
        addl    $1, %ecx
        movslq  %ecx, %rdx
        movl    (%rax,%rdx,4), %ecx	
        movl    %ecx, -24(%rbp)	#temp=a[j+1]
        movq    -8(%rbp), %rax
        movslq  -20(%rbp), %rdx
        movl    (%rax,%rdx,4), %ecx
        movq    -8(%rbp), %rax
        movl    -20(%rbp), %esi
        addl    $1, %esi
        movslq  %esi, %rdx
        movl    %ecx, (%rax,%rdx,4)	#a[j+1]=a[j]
        movl    -24(%rbp), %ecx
        movq    -8(%rbp), %rax
        movslq  -20(%rbp), %rdx
        movl    %ecx, (%rax,%rdx,4)	#a[j]=temp
.LBB0_6:                                #   in Loop: Header=BB0_3 Depth=2
        jmp     .LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_3 Depth=2
        movl    -20(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -20(%rbp)	#j++
        jmp     .LBB0_3
.LBB0_8:                                #   in Loop: Header=BB0_1 Depth=1
        jmp     .LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_1 Depth=1
        movl    -16(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -16(%rbp)	#i++
        jmp     .LBB0_1
.LBB0_10:
        popq    %rbp
        .cfi_def_cfa %rsp, 8
        retq
.Lfunc_end0:
        .size   sort, .Lfunc_end0-sort
        .cfi_endproc
                                        # -- End function
        .globl  main                    # -- Begin function main
        .p2align        4, 0x90
        .type   main,@function
main:                                   # @main
        .cfi_startproc
# %bb.0:
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset %rbp, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register %rbp
        subq    $32, %rsp
        movl    $0, -4(%rbp)
        #为scanf作准备
        movabsq $.L.str, %rdi
        leaq    -8(%rbp), %rsi
        movb    $0, %al
        callq   __isoc99_scanf
        movslq  -8(%rbp), %rcx
        shlq    $2, %rcx
        #为malloc作准备
        movq    %rcx, %rdi
        movl    %eax, -28(%rbp)         # 4-byte Spill
        callq   malloc
        movq    %rax, -24(%rbp)
        movl    $0, -12(%rbp)
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
        movl    -12(%rbp), %eax
        cmpl    -8(%rbp), %eax
        jge     .LBB1_4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
        movq    -24(%rbp), %rax
        movslq  -12(%rbp), %rcx
        shlq    $2, %rcx
        #循环scanf
        addq    %rcx, %rax
        movabsq $.L.str, %rdi
        movq    %rax, %rsi
        movb    $0, %al
        callq   __isoc99_scanf
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
        movl    -12(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -12(%rbp)
        jmp     .LBB1_1
.LBB1_4:
        movq    -24(%rbp), %rdi
        movl    -8(%rbp), %esi
        callq   sort
        movl    $0, -12(%rbp)
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
        movl    -12(%rbp), %eax
        cmpl    -8(%rbp), %eax
        jge     .LBB1_8
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
        movq    -24(%rbp), %rax
        movslq  -12(%rbp), %rcx
        movl    (%rax,%rcx,4), %esi
        movabsq $.L.str.1, %rdi
        movb    $0, %al
        callq   printf
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
        movl    -12(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -12(%rbp)
        jmp     .LBB1_5
.LBB1_8:
        movl    -4(%rbp), %eax	#返回值0
        addq    $32, %rsp	#释放栈空间
        popq    %rbp
        .cfi_def_cfa %rsp, 8
        retq
.Lfunc_end1:
        .size   main, .Lfunc_end1-main
        .cfi_endproc
                                        # -- End function
        .type   .L.str,@object          # @.str
        .section        .rodata.str1.1,"aMS",@progbits,1
.L.str:
        .asciz  "%d"
        .size   .L.str, 3

        .type   .L.str.1,@object        # @.str.1
.L.str.1:
        .asciz  "%d "
        .size   .L.str.1, 4

        .ident  "clang version 10.0.1 "
        .section        ".note.GNU-stack","",@progbits
        .addrsig
        .addrsig_sym sort
        .addrsig_sym __isoc99_scanf
        .addrsig_sym malloc
        .addrsig_sym printf
```

* 总得来看(具体区别参见注释)

  * 32位汇编需要显示分配栈空间，且参数传递是通过栈来实现的，而64位汇编不需要显示分配栈空间，可以直接使用，且传递参数主要是通过寄存器来实现的

  * `gcc`和`clang`的区别主要体现在

    * 参数传递
    * 计算数组元素地址
    * 循环跳转的判断

    