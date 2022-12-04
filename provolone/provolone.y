%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "llist.h"

#define CODE_FUNCTION 1
#define CODE_EXIT 2
#define CODE_OPR_ADD 3
#define CODE_OPR_ZERO 4
#define CODE_WHILE 5
#define CODE_EQUAL 6
#define CODE_REPEAT 7
#define CODE_IF 8
#define CODE_IF_NOT 9
#define CODE_END -1
#define YYDEBUG 0

extern int yylex();
extern FILE *yyin;
extern int yyparse();
FILE *cFile;

void yyerror(const char *s){
    fprintf(stderr, "%s\n", s);
    exit(errno);
}

void openFile(){
    cFile = fopen("cProgram.c","w+");

    if (cFile == NULL){
        printf("Erro ao gerar arquivo");
        exit(-1);
    }
}

void cWriter(LLIST *llist){
    openFile();
    fprintf(cFile,"#include <stdio.h>\nint main(void) {\n");
    while(llist != NULL) {
        switch(llist->line.cmd){
            case CODE_OPR_ZERO: {
                fprintf(cFile, "%s = 0;\n", e->line.v1);
            }
        }
    }
    fclose(cFile);
}

void yyparserDebugger(LLIST *llist){
    if (YYDEBUG == 0){
        while (llist != NULL){
            printf("%d [[%s]] [[%s]]\n", llist->line.cmd, llist->line.v1, llist->line.v2);
        }
    }
}

%}

%token ENTRADA
%token SAIDA
%token FIM
%token ENQUANTO
%token FACA
%token ZERA
%token '('
%token ')'
%token '='
%token INC
%token <content> ID
%token VEZES
%token SE
%token SENAO

%union{
    int var;
    char *content;
    LLIST *llistvar;
}

%type <var> program
%type <content> varlist
%type <llistvar> cmds
%type <llistvar> cmd

%start program
%%

program : ENTRADA varlist SAIDA varlist cmds FIM {
    LLIST *llist = (LLIST *)malloc(sizeof(LLIST));
    if (llist == NULL){
        printf("ERROR READING PROGRAM FUNCTION ENTRY\n");
        exit(-1);
    }
    llist->line.v1 = $2;
    llist->line.v2 = $4;
    llist->line.cmd = CODE_FUNCTION;
    addLLISTend(llist, $5);

    LLIST *aux = (LLIST *)malloc(sizeof(LLIST));
    if (aux == NULL){
        printf("ERROR READING PROGRAM EXIT ENTRY\n");
    }
    aux->line.v1 = $4;
    aux->line.cmd = CODE_EXIT;
    addLLISTend(aux, llist);

    cWriter(cFile);
};

varlist : varlist ID {
    char buffer[50];
    sprintf(buffer, 50, "%s %s", $1, $2);
    $$ = buffer;
    }

    | ID    {$$ = $1;};

cmds : cmds cmd     { addLLISTend($2, $1); $$ = $1; }

    | cmd { $$ = $1;};

cmd : ENQUANTO ID FACA cmds FIM {
    LLIST *llist = (LLIST *)malloc(sizeof(LLIST));
    if (llist == NULL){
        printf("ERROR READGING COMMAND ENTRY");
        exit(-1);
    }

    llist->line.v1 = $2;
    llist->line.cmd = CODE_WHILE;
    addLLISTend($4, llist);

    LLIST * aux = (LLIST *)malloc(sizeof(LLIST));
    if (aux == NULL){
        printf("ERROR READING END ENTRY");
        exit(-1);
    }

    aux->line.cmd = CODE_END;
    addLLISTend(aux, llist);
    $$ = llist;
};
%%

int main(int argc, char **argv){

    FILE *provol_code = fopen(argv[1], "r");

    openFile();

    yyin = provol_code;
    yyparse();

    return 0;
    
}
