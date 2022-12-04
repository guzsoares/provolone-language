%option yywrap

    #include <stdio.h>
    #include "y.tab.h"

%%

[[:space:]]
ENTRADA     { return ENTRADA; }
SAIDA       { return SAIDA; }
FACA        { return FACA; }
ENQUANTO    { return ENQUANTO; }
FIM         { return FIM; }
ZERA        { return ZERA; }
SE          { return SE; }
VEZES       { return VEZES; }
ENTAO       { return ENTAO; }
SENAO       { return SENAO; }
INC         { return INC;}
\(           { return ABRE; }
\)           { return FECHA; }
=           { return IGUAL; }
[a-zA-Z]    {yylval.content = strdup(yytext); return (ID);}
