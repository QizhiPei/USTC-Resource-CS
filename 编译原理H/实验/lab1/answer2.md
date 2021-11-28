## **问题2-1**：

1. `-nostdinc`选项的用处是什么？
2. 请列出 EduCoder 平台上 `gcc` C程序默认的头文件查找路径
3. 如何在使用了`-nostdinc`选项的同时使得上述命令编译通过? 请进一步说明通过的原因（不能修改源文件）。

***

* `-nostdinc`选项的用处是不搜索默认路径头文件，只搜索`-I`选项指定的目录

* 1.内定路径

  `/usr/include`

  `/usr/include/x86_64-linux-gnu`

  `/usr/lib/gcc/x86_64-linux-gnu/5/include`

  `usr/local/include`

  `/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed`

  2.环境变量 C_INCLUDE_PATH 或 CPLUS_INCLUDE_PATH 包含的路径

  3.`gcc`的`-I`参数指定的路径

  4.当前所运行文件所在路径

  

* 先使用`gcc --print-file-name=include` 输出路径，即位于`/usr/lib/gcc/x86_64-linux-gnu/5/include`目录下，再使用`gcc -I`来制定头文件的路径：`gcc -E -I/usr/include -I/usr/lib/gcc/x86_64-linux-gnu/5/include -nostdinc sample-io.c -o sample-io.i`，即可通过编译。
  
  * 通过原因：原来的文件预处理需要使用`stdio.h`和`stddef.h`两个头文件，但使用`-nostdinc`后就不会搜索头文件的默认路径了，所以需要通过`-I`来指定要搜索的路径

## **问题2-2**：

1. `-nostdlib`选项的用处是什么？
2. 请列出 EduCoder 平台上 `gcc` C程序默认链接的库
3. 如何在使用了`-nostdlib`选项的同时使得上述命令编译通过？请进一步说明通过的原因（不能修改源文件）。

***

*  不链接系统标准启动文件和标准库文件，只把指定的文件传递给连接器。与系统库有关的特定的连接选项（例如-static-libgcc 和 -shared-libgcc ）将会被忽略

* 默认链接的库

  ```
  /usr/lib/gcc/x86_64-linux-gnu/5/
  /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/
  /usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib/
  /lib/x86_64-linux-gnu/
  /lib/../lib/
  /usr/lib/x86_64-linux-gnu/
  /usr/lib/../lib/
  /opt/llvm10/antlr4-cpp/dist/
  /usr/lib/gcc/x86_64-linux-gnu/5/../../../
  /lib/
  /usr/lib/
  ```
  
* `-nostdlib`告诉`gcc`告诉编译器不要包含标准库，根据第一关里的描述，利用`-Wl`参数将其后面的参数传递给链接器，首先链接上运行时所需要CRT库文件，分别为`crt1.o``crti.o``crtn.o`，分别包含入口函数`start`、`_init()`函数和`_finit`函数，再用`-lc`参数链接上运行时所需要的C库，即可通过编译并顺利运行。

  命令如下
  
  `gcc -nostdlib -Wl,/usr/lib/x86_64-linux-gnu/crt1.o,/usr/lib/x86_64-linux-gnu/crti.o,/usr/lib/x86_64-linux-gnu/crtn.o -lc sample-io.c -o sample-io`

