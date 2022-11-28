%{
  #include <stdio.h>
  #include "y.tab.h"
  %}
id        [_a-zA-Z][_a-zA-Z0-9]*
wspc      [ \t\n]+
semi      [;]
comma     [,]
%%
int       { return INT; }
char      { return CHAR; }
float     { return FLOAT; }
{comma}   { return COMMA; }
{semi}    { return SEMI; }
{id}      { return ID; }
{wspc}    {;}
%%
main()
{
yylex();
printf("processando lex");
}
