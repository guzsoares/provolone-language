%option yywrap

    #include <stdio.h>
    #include "y.tab.h"

%%

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
'('         { return '('; }
')'         { return ')'; }
'='         { return '='; }
[a-zA-Z]    {yylval.content = strdup(yytext); return (ID);}