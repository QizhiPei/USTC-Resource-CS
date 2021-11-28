#include <iostream>

#include "antlr4-runtime.h"
#include "labLexer.h"

using namespace antlr4;

int main(int argc, const char* argv[]) {
    ANTLRInputStream input(stdin);
    labLexer lexer(&input);
    CommonTokenStream tokens(&lexer);

    /*tokens.fill();
    for (auto token : tokens.getTokens()) {
        std::cout << token->toString() << std::endl;
    }*/

    return 0;
}