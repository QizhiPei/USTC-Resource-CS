void S'(){
    syntaxTreeNode *in
    *in = 0;
    S(in);
}

syntaxTreeNode * S(syntaxTreeNode *in){
    syntaxTreeNode *out, *in1, *out1; //out表示S.out,in1和out1分别为L的继承属性和综合属性
    if(lookahead == 'a'){ //产生式S->a
        match('a');
        *out = *in + 1;
        print(*out);       
    }
    else{  //产生式S->(L)
        *in1 = *in + 1;
        match('(');
        out1 = L(in1);
        match(')');
        *out = *out1 + 1;
    }
    return out;
}

syntaxTreeNode * L(syntaxTreeNode * i){
    syntaxTreeNode *out, *in1, *out1, *in2, *out2;   //out表示L.out,in1和out1分别为S的继承属性和综合属性,in2和out2分别为L1的继承属性和综合属性
    *in1 = *in;
    out1 = S(in1);
    *in2 = *out1;
    out2 = L1(in2);
    *out = *out2;
    return out;
}

syntaxTreeNode * L1(syntaxTreeNode * in){
    syntaxTreeNode *out, *in1, *out1, *in2, *out2;   //out表示L1.out,in1和out1分别为S的继承属性和综合属性,in2和out2分别为产生式右部L1（记作L2）的继承属性和综合属性
    if(lookahead == ','){   //产生式L1->,S L1
        *in1 = *in + 1;
        match(',');
        out1 = S(in1);
        *in2 = *out1;
        out2 = L1(in2);
        *out = *out2;
    }
    else{   //产生式L1->ε
        *out = *in;       
    }
    return out;
}