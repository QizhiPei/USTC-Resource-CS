# 第二关

## 分析与设计

* 根据`Flex`的规则,编写词法规范文件

* 利用宏`LEXERGEN`来选择用手工编写的词法分析函数，还是由`Flex`生成的词法分析函数。当定义了宏`LEXERGEN`时,则调用`Flex`生成的`lex.yy.c`里的`getsym`函数,若未定义则使用第一关的函数(第一关的函数被放在labLexer-2.c中)

## 头文件labLexer-2.h
* 仅用来声明`getsym()`函数

## relop.lex
* 用`[^\n\r<>=]+`来匹配`other`串,用`">"`来匹配`>`,其余`relop`符类似,用`[\n\r]`来匹配最后的换行符
* 当匹配到`other`串时,输出`other`以及对应的长度`yyleng`,当匹配到关系符号时,输出`relop`以及对应的符号,当匹配到换行符时,`return`返回0
* 在`.lex`文件最后的部分定义`getsym()`函数,内部为一个`while`循环,当`sym = yylex()`为0时循环结束

## 大致代码如下(labLexer-2.cpp)

```C++
#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include "labLexer-2.h"

using namespace std;

struct pairs{
    char name[6];
    char content[4];
};

pairs EQ = {"relop", "="};
pairs NE = {"relop", "<>"};
pairs LE = {"relop", "<="};
pairs LT = {"relop", "<"};
pairs GE = {"relop", ">="};
pairs GT = {"relop", ">"};


int main(int argc, char *argv[]) {
#ifdef LEXERGEN
    getsym();
#endif

#ifndef LEXERGEN

    int i, length;
    int flag = 0;
    vector<pairs> tuples;
    char s1[1000];
    memset(s1, '\0', 1000);
    //memset(s2, '\0', 1000);

    for(i = 0; i < 1000; ++i){
        s1[i] = getchar();
        if(s1[i] == '\n' || s1[i] == '\r') break;
    }

    s1[i] = '\0';

    length = strlen(s1);

    for (int j = 0; j < length; ++j) {
        if(s1[j] == '='){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(EQ);
            flag = j + 1;
        }
        else if (s1[j] == '<' && s1[j+1] == '='){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(LE);
            flag = j + 2;
            j++;
        }
        else if (s1[j] == '>' && s1[j+1] == '='){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(GE);
            flag = j + 2;
            j++;
        }
        else if (s1[j] == '<' && s1[j+1] == '>'){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(NE);
            flag = j + 2;
            j++;
        }
        else if(s1[j] == '>'){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(GT);
            flag = j + 1;
        }

        else if(s1[j] == '<'){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(LT);
            flag = j + 1;
        }

    }
    pairs temp;
    strcpy(temp.name, "other");
    sprintf(temp.content, "%d" , length - flag);
    //itoa(length - flag, temp.content, 10);
    if((length - flag) > 0)
        tuples.push_back(temp);

    for(i = 0; i < tuples.size(); ++i){
        cout<<'('<<tuples[i].name<<','<<tuples[i].content<<')';
    }
#endif

    return 0;
}

```

## 遇到的问题

* C与C++特性的不同.在头文件中定义共用的变量时,C只需要像示例中那样在头文件中定义变量、声明函数,在其他`.c`文件中便可以直接使用.而在C++中,最好的做法是在`.c`文件中定义变量,而在头文件中进行`extern`,以标示变量的定义在别的文件中，提示编译器遇到此变量时在其他模块中寻找其定义
* 之前对宏理解很肤潜，通过这一关自己对宏、条件编译有了更深刻的理解
* 对正则表达式不是很熟悉,通过学习了解了正则表达式的语法规则
* 开始时对示例中代码的逻辑不是很理解,不知道主函数是如何跳出`while`循环的,后来在提出`issue`后理解了(感谢王章瀚同学的回答).在`lex.yy.c`中会有一个`YY_STATE_EOF`状态来处理读到文件结束符的情况,返回0,所以可以跳出`while`循环
* 在`Makefile`中，每次生成文件前最好执行一次`clean`操作，否则可能会出现奇怪的bug（`make`可能会自动省略一些中间过程）
* `\`和`/`要区分开来，前者是换行符的一部分，后者一般用来表示路径,且Windows系统和Linux系统表示文件路径分别使用的是`\`和`/`，在网页的URL中一般使用类似Linux的路径表示`/`

