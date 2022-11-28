
%{
      #include <stdio.h>

float accum=0;
int yylex();
void yyerror(const char *s){
      fprintf(stderr, "%s\n", s);
   };
 void output(float value)
{
    printf("accum=%f\n", value);
}
%}
%token NUMBER
%token PLUS 
%token MINUS
%token EQUAL
%token LINEEND
%token TIMES
%token DIVIDE

%start lines
%%
lines : line
       | lines line
       ;
line  : LINEEND
       | expression LINEEND {output(accum);}
       ;
expression : NUMBER {accum+=$1;}
	 | PLUS NUMBER {accum+=$2;}
	 | MINUS NUMBER {accum-=$2;}
	 | TIMES NUMBER {accum*=$2;}
	 | DIVIDE NUMBER {accum/=$2;}
	 | EQUAL NUMBER {accum=$2;}
	 ;

%%



int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}
