lexer grammar labLexer;

tokens {
    LT,
    LE,
    EQ,
    NE,
    GT,
    GE,
    OTHER
}


LT: '<'  {System.out.println("(relop,<)");};
LE: '<=' {System.out.println("(relop,<=)");};
EQ: '='  {System.out.println("(relop,=)");};
NE: '<>' {System.out.println("(relop,<>)");};
GT: '>'  {System.out.println("(relop,>)");};
GE: '>=' {System.out.println("(relop,>=)");};
OTHER: [^\n\r<>=]+ expr {System.out.println($expr.text.length());};
WhiteSpace: [\n\r] -> skip;
}