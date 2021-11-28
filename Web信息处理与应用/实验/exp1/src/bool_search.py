from nltk.stem.porter import PorterStemmer
porter_stemmer = PorterStemmer()


def AND(p1,p2):
    #对两个倒排表求交
    answer=[]
    len1=len(p1)
    len2=len(p2)
    i1=0
    i2=0
    while i1<len1 and i2<len2:
        if p1[i1]==p2[i2]:
            answer.append(p1[i1])
            i1=i1+1
            i2=i2+1
        elif p1[i1]<p2[i2]:
            i1=i1+1
        else:
            i2=i2+1
    return answer

def OR(p1,p2):
    #对两个倒排表求并，注意去重
    answer=[]
    len1=len(p1)
    len2=len(p2)
    i1=0
    i2=0
    while i1<len1 and i2<len2:
        if p1[i1]==p2[i2]:
            answer.append(p1[i1])
            i1=i1+1
            i2=i2+1
        elif p1[i1]<p2[i2]:
            answer.append(p1[i1])
            i1=i1+1
        else:
            answer.append(p2[i2])
            i2=i2+1
    if i1<len1:
        while i1<len1:
           answer.append(p1[i1])
           i1+=1
    else:
        while i2<len2:
            answer.append(p2[i2]) 
            i2+=1
    return answer

def NOT(p1):
    #对一个倒排表求补
    answer=[]
    i1=0
    i2=0
    length=len(p1)
    while i1<517391 and i2<length:
        if i1==p1[i2]:
            i1+=1
            i2+=1
        else: #i1<p1[i2]
            answer.append(i1)
            i1+=1
    while i1<517391:
        answer.append(i1)
        i1+=1
    return answer


def handle_query(query):
    #参数为bool查询字符串query
    #返回对应的文档序号列表
    querylist=query.split(" ")
    return exp(querylist)

'''
表达式：由单独的"项"或者"项"与"OR"运算符连接形成；
项：由单独的"因子"或"因子"和&运算符连接而成；
因子：可以是单独的V或F，也可以是用括号括起来的"表达式"。
'''

def exp(querylist):#读入一个表达式并返回其结果文档列表
    global i
    result=item(querylist)
    #print(result)
    while(i<len(querylist)  and querylist[i]=="OR" ):
        i=i+1
        result=OR(result,item(querylist))
    return result


def item(querylist):#//读入一个项并返回其结果文档
    global i
    result=factor(querylist)
    #print(result)
    while(i<len(querylist) and querylist[i]=="AND"):
        i=i+1
        result=AND(result,factor(querylist))
    return result


def factor(querylist):#//读入一个因子并返回其结果文档
    global i,inverted_table
    if querylist[i]=="(":
        i=i+1
        result= exp(querylist)
        i=i+1
        return result
    elif querylist[i]=="NOT":
        i=i+1
        return notExp(querylist)
    else:
        i=i+1
        return inverted_table[porter_stemmer.stem(querylist[i-1])]

def notExp(querylist):#取反操作
    global i,inverted_table
    if querylist[i]=="(":
        i=i+1
        result=NOT(exp(querylist))
        i=i+1
        return result
    elif querylist[i]=="NOT":
        i=i+1
        return NOT(notExp(querylist))
    else:
        i=i+1
        return NOT(inverted_table[porter_stemmer.stem(querylist[i-1])])


if __name__ == "__main__":
    i=0
    inverted_table={}
    with open("../output/inverted_table.txt") as file:
        for line in file.readlines():
            line = line.strip().split(" ")
            word=line[0]
            del line[0]#去掉开头的词项以及冒号
            del line[0]
            j=0
            while j<len(line):
                line[j]=int(line[j])
                j=j+1
            inverted_table[word]=line
        #print(inverted_table['mgusa'])

    with open("../input/bool_search.txt") as file:
        for line in file.readlines():
            line = line.strip()
            print(line)
            doc_list=handle_query(line)
            i=0
            if len(doc_list)<10:
                print(doc_list)
            else:
                print(doc_list[0:10])