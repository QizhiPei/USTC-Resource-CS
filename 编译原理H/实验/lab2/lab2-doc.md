# lab2-doc

## 第一关

* 刚开始未仔细考虑转换图中`<>`和`><`的情况，后来看老师的PPT发现转换图对这两种情况有各自的处理，将`<>`视为不等号,`><`可直接先把`>`提取出来,后面的再重新分析即可
* 需要在CMakeList.txt中调整CMake版本以及文件名称、路径
* 需要在对应的doc文件中建立要求的文件才能通过平台的编译
* itoa函数是windows特有的函数。Linux内核中只有atoi()函数，被包含在stdlib.h头文件中，而没有itoa()函数。itoa()函数的功能可以用sprintf()函数代替

## 第二关

* C与C++特性的不同，是否试探性定义
* 在Makefile中，每次生成文件前最好执行一次clean，否则可能会出现奇怪的bug（make可能会省略一些过程）
* `\`和`/`要区分开来，前者是换行符的一部分，后者一般用来表示路径

## 第三关

* antlr语法的学习，看全英文的文档比较难受
* 对c++不是特别熟悉，一些类、方法运用不熟练
* 刚开始想要仿照flex在.g4文件中输出，但发现不太容易处理other匹配到的串的长度，后来在cpp文件中，根据tokens来进行输出操作