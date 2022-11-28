%option yywrap
      #include <stdio.h>
      #include "accumulator.tab.h"
%%
[0-9]+   {printf("lido %s",yytext);yylval=atoi(yytext); return(NUMBER); }
\n       return(LINEEND);
"+"      return(PLUS);
"-"      return(MINUS);
"*"	     return(TIMES);
"/"	     return(DIVIDE);
"="      return(EQUAL);
end      return(0);
.        ;

