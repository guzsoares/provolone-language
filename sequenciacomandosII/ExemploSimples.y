%{
  #include <stdio.h>
  #include <stdlib.h>
  %}
%start   line
%token   CHAR
%token COMMA
%token FLOAT
%token ID
%token INF
%token SEMI
   %%

line : type ID list
   { printf("Compilou !!!!\n"); } ;
list :COMMA ID list | SEMI ;
type : CHAR | FLOAT;
%%
