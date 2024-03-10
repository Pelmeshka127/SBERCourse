%option c++

%{

#include <iostream>

#include "lexmessage.hpp"

using std::cout;
using std::endl;

int comment_count;

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

%x              HYPHEN_COMMENT BRACKET_COMMENT


TRUE            [t][r][u][e]
FALSE           [f][a][l][s][e]

%%

{WS}                /* skip blanks and tabs */

"+"|"-"|"*"|"/"|"="|">="|">"|"<="|"<"|"=="|"!="|"|" {
    PrintMessage("OP", yytext);
}

{ELSE}|{FALSE}|{IF}|{LOOP}|{THEN}|{WHILE}|{NOT}|{TRUE}|{PRINT}|{PRINTLN} {
    PrintMessage("KEYWORD", yytext);
}

{NUMBER}            { PrintMessage("NUMBER", yytext); }

{VAR}               { PrintMessage("ID", yytext); }

{ID_TYPE}           { PrintMessage("TYPE_ID", yytext); }

{STRING}            { 
        yytext++;
        yytext[strlen(yytext) - 1] = '\0';
        PrintMessage("STRING", yytext); 
}




"--"        {
    BEGIN(HYPHEN_COMMENT);
}

<HYPHEN_COMMENT>{
    [^<<EOF>>\n]+

    <<EOF>>  BEGIN(INITIAL);

    \n    BEGIN(INITIAL);
}




"("             {
    comment_count = 1;        
    BEGIN(BRACKET_COMMENT);
}

<BRACKET_COMMENT>{

"("    comment_count++;
    
")"                     {
    comment_count--;

    if (comment_count == 0) {
        BEGIN(INITIAL);
    }
}

[^)]

}



.   { cout << "UNKNOWN " << yytext << endl; }

%%