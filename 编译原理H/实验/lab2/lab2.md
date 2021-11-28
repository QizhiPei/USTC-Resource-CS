# lab2

## 第一关

- [任务描述](https://www.educoder.net/tasks/gzm8ys72nu6p#任务描述)
- 相关知识
  - [在线实训图形化界面](https://www.educoder.net/tasks/gzm8ys72nu6p#在线实训图形化界面)
- [编程要求](https://www.educoder.net/tasks/gzm8ys72nu6p#编程要求)
- [测试说明](https://www.educoder.net/tasks/gzm8ys72nu6p#测试说明)

------

#### 任务描述

本关任务：编写一个词法分析程序，它能对输入的一行**字符流**进行**词法分析**，依次识别出其中的**关系运算符和其他符号**，并输出对应的**记号序列**。例如，若输入的字符流为：

```
if (a<=b) a=b
```

则输出：

```
(other,5)(relop,<=)(other,4)(relop,=)(other,1)
```

这里`(other,5)`表示一个非关系运算符的子串，其中可能含有**空格等空白符**。识别关系运算符的转换图如图1所示： 

![图1](https://www.educoder.net/api/attachments/388666)
图 1 关系运算符的转换图





#### 相关知识

为了完成本关任务，你需要掌握如何使用在线实训平台提供的虚拟远程图形化界面。

##### 在线实训图形化界面

在线实训图形化界面提供一个虚拟桌面供你实验，虚拟桌面的右上方有一排命令按钮图标： ![,](https://www.educoder.net/api/attachments/1176999) 其中第一行从左至右依次为**实验已持续的时间、复制版本库地址、重置实训、退出实训**。

虚拟桌面的右下方有“评测”按钮，点击该按钮，在线实训平台将执行本实训项目预置的脚本进行自动评测。过程如下：

- 双击桌面的`workspace`文件夹图标，即可进入实训项目的工作目录，它位于`/data`目录下。`workspace/XXX/YYY`目录下面即存放实训项目在本桌面虚拟环境下的本地版本库；
- 你可以双击桌面上的图标按钮![img](https://www.educoder.net/api/attachments/1177097)来打开文件系统，进入虚拟环境的文件管理器的根目录；
- 你可以点击桌面左上方的命令按钮 ![img](https://www.educoder.net/api/attachments/392638)来打开终端进行命令行操作；
- 你可以点击在虚拟桌面右上角的复制按钮![img](https://www.educoder.net/api/attachments/1174041)，获得诸如:`https://git.educoder.net/XXX/YYY.git`的版本库地址；
- 你可以在虚拟桌面的终端或者你本地的终端执行`git clone https://git.educoder.net/XXX/YYY.git`拉取版本库。如果你复制了版本库地址，再`git clone`到本地，你就可以在本地开展实验，再用`git push`提交；
- 你可以在终端启用vi等编辑器来打开某文件，并在编辑器中修改文件内容。

> 注意：

- > 在版本库里面的修改无需使用`git`提交即可进行评测；

- > 在修改完之后需使用`git`进行提交(`git push`)，以免环境被销毁后导致所做修改消失；

- > 第一次`git push`前，需先使用`git pull --unshallow`命令从远程库拉取完整内容到虚拟桌面环境，因为平台缺省地只拉取了最近一次的提交。

#### 编程要求

请仔细阅读相关知识，掌握在线实训图形化界面并完成词法分析程序的编写任务。请按如下目录结构来组织本关卡的提交文件，目录结构如下：

```
<your repo>  |-- labLexer>>  |-- src/     # 增加你编写的词法分析器源码>>  |-- test/     # 增加你的测试例子>>  |-- doc/     # 增加文档描述实验中遇到的问题、分析和设计，文件名前缀为labLexer-1>>  |-- CMakeLists-1.txt     # 写的CMakeLists-1.txt    |-- 其他文件     # README、shell脚本等
```

> ![image-20200923225226655](D:\DellOnedrive\OneDrive - mail.ustc.edu.cn\TyporaImages\image-20200923225226655.png)
>
> 注意：你需要把你在本关卡使用的`CMakeLists.txt`改名为`CMakeLists-1.txt`进行提交，以避免和本实训项目其他关卡的文件相冲突。`cmake`命令默认是从当前目录找`CMakeLists.txt`来进行执行。

助教会借助脚本来实现对实训项目的半自动检查，会将你所上传的`CMakeLists-1.txt`复制为`CMakeLists.txt`来进行编译并检查。因此，你实训环境中的`CMakeLists.txt`在评测后可能会被更改。请一定严格按照本节要求组织实训项目的目录和文件，否则会影响本次实验成绩。 

**注意事项：**

- **换行符**标识字符流结束；
- 输出为1行，中间**不包含任何空格符**，末尾**不用输出换行符**；
- 请特别注意**行尾的处理**，正确地处理`CRLF`（回车/r）和`LF`(换行/n)两种换行符；
- 生成的目标可执行程序名为`labLexer-1`。

#### 测试说明

平台会对你的代码进行运行测试。



## 第二关

- [任务描述](https://www.educoder.net/tasks/qbmrt9jsvhcw#任务描述)
- [相关知识](https://www.educoder.net/tasks/qbmrt9jsvhcw#相关知识)
- [编程要求](https://www.educoder.net/tasks/qbmrt9jsvhcw#编程要求)
- [测试说明](https://www.educoder.net/tasks/qbmrt9jsvhcw#测试说明)

------

#### 任务描述

本关任务：

1. 熟悉本实训项目版本库中`flex-examples`子目录下提供的表达式语言的词法分析例子，查看词法规范文件`expr.lex`和`Makefile`，阅读`README`并按其中的提示进行词法分析器的构造和运行；
2. 针对第1关的关系运算符的识别需求，用`Flex`自动生成相应的词法分析器源码并编译和测试。

> 注意：需要利用**宏`LEXERGEN`**来选择是用手工编写的词法分析函数，还是由`Flex`生成的词法分析函数。

#### 相关知识

为了完成本关任务，你需要掌握：

1. `Flex`的输入词法规范文件的格式；
2. 如何用`Flex`为所给定的词法规范文件构造词法分析器并使用。

请阅读 [Flex manual](http://westes.github.io/flex/manual/) 和本实训项目提供的简单的表达式语言的词法分析例子（位于版本库的`flex-examples`子目录下），了解`Flex`的输入词法规范文件的格式。

#### 编程要求

请仔细阅读相关知识，使用`Flex`完成自动生成相应的词法分析器。请按如下目录结构来组织本关卡的提交文件，目录结构如下：

```
<your repo>  |-- labLexer>>  |-- grammar/     # 增加你编写的词法规范描述文件>>  |-- src/      # 增加你编写的词法分析器源码>>  |-- test/      # 增加你的测试例子>>  |-- doc/     # 增加文档描述实验中遇到的问题、分析和设计，文件名前缀为labLexer-2>>  |-- Makefile     # 增加你编写的Makefile文件    |-- 其他文件     # README、shell脚本等
```

**注意事项**：

- 本关输入输出与关卡1一致；
- 编写词法规范描述文件`relop.lex`并存入提交目录`labLexer`下的 `grammar`子目录；
- 参照`flex-examples`子目录下的`expr.c`，编写`labLexer-2.c`。其中包含`main`函数，它在宏`LEXERGEN`定义时调用`Flex`生成的词法分析函数，在该宏未定义时调用你在第1关手工编写的词法分析函数；
- 本关使用`make`进行编译，你可以参照`flex-examples`子目录下的`Makefile`，编写`Makefile`来进行编译和测试。

> 注意：使用`Flex`生成的词法分析函数对应的目标可执行程序名为`labLexer-2`，而使用第1关手工编写的词法分析函数对应的目标可执行程序名需要命名为`labLexer-2m`（该`Makefile`在使用`make`命令时应该生成这两个可执行程序）。

## 第三关

- [任务描述](https://www.educoder.net/tasks/ufe6tq4ym3sa#任务描述)
- 相关知识
  - [本地实验的环境配置方法](https://www.educoder.net/tasks/ufe6tq4ym3sa#本地实验的环境配置方法)
- [编程要求](https://www.educoder.net/tasks/ufe6tq4ym3sa#编程要求)
- [测试说明](https://www.educoder.net/tasks/ufe6tq4ym3sa#测试说明)

------

#### 任务描述

本关任务：

1. 熟悉本实训项目版本库中`antlr4-examples`子目录下提供的词法分析例子，查看词法**规范文件**`labLexer.g4`、主程序文件`main.cpp`和`CMakeLists.txt`，阅读`README.md`并按其中的提示进行词法分析器的构造和运行；
2. 针对第1关的关系运算符的识别需求，用`antlr4`自动生成相应的词法分析器源码并编译和测试。

#### 相关知识

为了完成本关任务，你需要掌握：

1. `antlr4`的输入词法规范文件的格式，参照`antlr4-examples`中的`g4`文件以及 [Lexer Rules](https://github.com/antlr/antlr4/blob/master/doc/lexer-rules.md)；
2. 学习使用`antlr4`所给定的词法规范文件构造词法分析器并使用之：
   - 参考官方的 [demo](https://github.com/antlr/antlr4/tree/master/runtime/Cpp/demo)；
   - 参考`antlr4-examples`；
   - 参考编译过程中生成的文件。
3. ANTLR v4 具备独立测试语法文件及将分析图和分析结果可视化的功能。为可视化分析图，推荐使用`Visual Studio Code`作为编辑器，安装 ANTLR 插件。在一个`.g4`文件的编辑窗口中右键，你会看到几个选项，点击即可。

为测试语法文件并可视化分析结果，你首先需要按照`Environment`页面中的要求配置好 ANTLR v4 的工作环境。在此前提下，按如下步骤完成测试（在`src/grammar`目录中）：

```
# Compile grammar to Java source codeantlr4 *.g4# Compile Java source codejavac *.java# Testing lexer, testfile is the file you create# Lexer is the name of g4 file without postfix ".g4"grun [Lexer] tokens -tokens [testfile]
```

##### 本地实验的环境配置方法

平台已配置好所需的各种软件，`antlr-4.8-complete.jar`在`/usr/local/lib`目录下。

**1. Java 环境安装** ANTLR 工具需要 JVM 才能执行，此外为了方便使用 ANTLR 的`grun`，你需要一个能够编译 java 源文件的环境。因此，你需要一个完整的`Java Development Kit`：

- 如果你使用 Linux，推荐通过包管理器安装 OpenJDK 8。在你的包管理器中通过搜索来确定包名，如 Ubuntu，下包名为`openjdk-8-jdk`, 安装即可；
- 如果你使用 Mac，你需要手动安装一个 JDK。

**2. ANTLR 下载与安装**

- 你需要从 [ANTLR Download](http://www.antlr.org/download/) 下载`antlr-4.8-complete.jar`；
- 你需要将该`jar`包的存放路径加入到环境变量`CLASSPATH`中，即可以 `Bash`中执行`export CLASSPATH=".:/path/to/your/antlr-4.8-complete.jar:$CLASSPATH"`；
- 你可以考虑将这一命令加入`.bashrc`（对于`Bash`），以省去你每次配置的麻烦。

**3. 定义`antlr4`和`grun`工具**

- 可以定义别名`antlr4`表示`ANTLR`工具，即`alias antlr4='java org.antlr.v4.Tool'`；
- `grun` 本质上是一个别名，可以定义如下：`alias grun='java org.antlr.v4.gui.TestRig'`；
- 同样的，你可以将这些别名命令加入到`.bashrc`，以节省你配置和使用的时间。

#### 编程要求

请仔细阅读相关知识，使用`antlr4`完成自动生成相应的词法分析器。请按如下目录结构来组织本关卡的提交文件，目录结构如下：

```
<your repo>  |-- labLexer>>  |-- grammar/     # 增加你编写的词法规范描述文件>>  |-- src/     # 增加你编写的词法分析器源码>>  |-- test/     # 增加你的测试例子>>  |-- doc/     # 增加文档描述实验中遇到的问题、分析和设计，文件名前缀为labLexer-3>>  |-- CMakeLists-3.txt     # 增加你编写的CMakeLists.txt文件    |-- 其他文件      # README、shell脚本等
```

> 注意：你需要把你在本关卡使用的`CMakeLists.txt`改名为`CMakeLists-3.txt`进行提交，以避免和本实训项目其他关卡的文件相冲突。`cmake`命令默认是从当前目录找`CMakeLists.txt`来进行执行。

助教会借助脚本来实现对实训项目的半自动检查，会将你所上传的`CMakeLists-3.txt`复制为`CMakeLists.txt`来进行编译并检查。因此，你实训环境中的`CMakeLists.txt`在评测后可能会被更改。请一定严格按照本节要求组织实训项目的目录和文件，否则会影响本次实验成绩。 

**注意事项**

- 在开展本关实验前，请完整编译运行`antlr4-examples`子目录下的例子。请阅读该子目录下的`README.md`来了解编译和运行过程，你需要进一步理解该子目录下各个文件以及生成的文件之间的关系，理解整个编译构建过程；

  > 注：`README.md`里面的`cmake`命令`-D`后面少了`ANTLR_EXECUTABLE`，完整应该是`cmake .. -DANTLR_EXECUTABLE=/full/path/to/antlr-4.8-complete.jar`。

- 编写词法规范描述文件`relop.g4`并存入提交目录`labLexer`下的 `grammar`子目录 (此步骤可独立完成，并依据**相关知识**来判断正确性)；

- 参照`antlr4-examples`子目录下的`main.cpp`，编写`labLexer-3.cpp`，输入输出与前两关是一样的；

- 编写`CMakeLists.txt`以及测试脚本，生成的最终可执行程序为`labLexer-3`，注意其中不需定义`ANTLR_EXECUTABLE`，评测脚本会进行定义；

- 在链接`antlr4`运行时动态库时，使用平台系统已安装的`antlr4-runtime`，不要使用自己编译生成的或者`antlr4-examples`子目录下提供的`libantlr4-runtime.so.4.8`，以防评测脚本出现错误；

  > 注：使用命令`target_link_libraries(XXX antlr4-runtime)`

- 你可以复用`antlr4-examples`子目录下提供的`FindANTLR.cmake`。

#### 测试说明

平台会对你的代码进行运行测试。





