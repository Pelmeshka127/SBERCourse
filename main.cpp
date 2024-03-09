#include <iostream>
#include <fstream>

#include <FlexLexer.h>

int yyFlexLexer::yywrap() { return 1; }

int main(int argc, char** argv) 
{
    std::ifstream file{};

    file.open(argv[1]);

    FlexLexer *lexer = new yyFlexLexer;

    while (lexer->yylex(&file) != 0) 
    {
        // do nothing for now, all is in rules
    }

    delete lexer;

    file.close();
}