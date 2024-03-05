%option c++

%{

#include <iostream>

using std::cout;
using std::endl;

%}

WS      [ \t\n\v]+

NUMBER          0|[1-9][0-9]*
VAR             [a-z][a-zA-Z_0-9_]*
ID_TYPE         [A-Z][a-zA-Z_0-9_]*
STRING          \"[^\0]*\"

IF              [Ii][Ff]
THEN            [Tt][Hh][Ee][Nn]
ELSE            [Ee][Ll][Ss][Ee]
LOOP            [Ll][Oo][Oo][Pp]
WHILE           [Ww][Hh][Ii][Ll][Ee]
NOT             [Nn][Oo][Tt]
PRINT           [Pp][Rr][Ii][Nn][Tt]
PRINTLN         [Pp][Rr][Ii][Nn][Tt][Ll][Nn]


TRUE            [t][r][u][e]
FALSE           [f][a][l][s][e]

%%

{WS}                /* skip blanks and tabs */

"+"|"-"|"*"|"/"|"="|">="|">"|"<="|"<"|"=="|"!="|"|" {
    cout << "Token class: OP, Token value: " << yytext << endl;
}

{ELSE}|{FALSE}|{IF}|{LOOP}|{THEN}|{WHILE}|{NOT}|{TRUE}|{PRINT}|{PRINTLN} {
    cout << "Token class: KEYWORD, Token value: " << yytext << endl;
}

{NUMBER}            { cout << "Token class: NUMBER, Token value: " << yytext << endl; }

{VAR}               { cout << "Token class: ID, Token value: " << yytext << endl; }

{ID_TYPE}           { cout << "Token class: TYPE_ID, Token value: " << yytext << endl; }

{STRING}            { cout << "Token class: STRING, Token value: " << yytext << endl; }

"("                {     
    char symbol = 0;
    
    int comment = 1;

    cout << "Token class: OPEN_COMMENT" << endl;

    while (comment != 0) 
    {
        if ((symbol = yyinput()) == '(') 
        {
            cout << "Token class: OPEN_COMMENT" << endl;
            
            comment++;

            continue;
        }

        if (symbol == ')') 
        {
            cout << "Token class: CLOSE_COMMENT" << endl;
            
            comment--;
            
            continue;
        }

        if (symbol == '\0') 
            cout << "Error" << endl;

    }
}

"--"        {
    char symbol = yyinput();
    
    cout << "Token class: OPEN_COMMENT" << endl;

    while (symbol != '\n' && symbol != '\0') 
    {
        symbol = yyinput();
    }
    
    cout << "Token class: CLOSE_COMMENT" << endl;
}

.   { cout << "UNKNOWN " << yytext << endl; }

%%