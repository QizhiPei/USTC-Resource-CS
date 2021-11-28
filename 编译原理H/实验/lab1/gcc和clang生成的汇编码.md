# gcc和clang生成的汇编码

* `gcc`生成的64位汇编的详细注释

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

