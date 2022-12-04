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
#define YYDEBUG 1

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
    printf("oi\n");
    openFile();
    fprintf(cFile,"#include <stdio.h>\nint main(void) {\n");
    while(llist != NULL) {
        printf("%d",llist->line.cmd);
        switch(llist->line.cmd){
            case CODE_OPR_ZERO: {
                fprintf(cFile, "%s = 0;\n", llist->line.v1);
                break;
            }
            case CODE_EQUAL: {
                fprintf(cFile, "%s = %s;\n",llist->line.v1, llist->line.v2);
                break;
            }
            case CODE_OPR_ADD: {
                fprintf(cFile, "%s = %s + 1;\n", llist->line.v1, llist->line.v1);
                break;
            }
            case CODE_FUNCTION: {
                char *v1 = strtok(llist->line.v1, " ");

                while (v1 != NULL){

                    fprintf(cFile, "int %s;\n",v1);
                    fprintf(cFile, "printf(\"Entrada [%s]: \");\n", v1);
                    fprintf(cFile, "scanf(\"%s\",&%s);\n", "%d", v1);

                    v1 = strtok(NULL, " ");
                }
                break;
            }
            case CODE_EXIT: {
                

                char *v1 = strtok(llist->line.v1, " ");
                while (v1 != NULL) {
                    fprintf(cFile, "printf(\"Saida: [%s] = %s \\n\", %s);\n", v1, "%d", v1);
                    v1 = strtok(NULL, " ");
                }
                fprintf(cFile,"return 0;\n}");
                break;
            }
            default:
                printf("af\n");
                break;
        }
        if(llist->prox == NULL){
            printf("monkey time\n");
        }
        llist = llist->prox;
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
%token ABRE
%token FECHA
%token IGUAL
%token ENTAO
%token INC
%token <content> ID
%token VEZES
%token SE
%token SENAO

%union{
    int var;
    char *content;
    struct llist *llistvar;
}

%type <var> program
%type <content> varlist
%type <llistvar> cmds
%type <llistvar> cmd

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
    addLLISTstart(llist, $5);

    LLIST *aux = (LLIST *)malloc(sizeof(LLIST));
    if (aux == NULL){
        printf("ERROR READING PROGRAM EXIT ENTRY\n");
    }
    aux->line.v1 = $4;
    aux->line.cmd = CODE_EXIT;
    addLLISTend(aux, llist);

    cWriter(llist);
};

varlist : varlist ID {
    char buffer[50];
    snprintf(buffer, 50, "%s %s", $1, $2);
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
}

    | ID IGUAL ID {
        LLIST *llist = (LLIST *)malloc(sizeof(LLIST));

        if (llist == NULL){
            printf("ERROR READING ATTRIBUTION\n");
            exit(-1);
        }

        llist->line.v1 = $1;
        llist->line.v2 = $3;
        llist->line.cmd = CODE_EQUAL;
        $$ = llist;
    }

    | INC ABRE ID FECHA {
        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING INCREMENT");
            exit(-1);
        }
        llist->line.v1 = $3;
        llist->line.cmd = CODE_OPR_ADD;
        $$ = llist;
    }
%%

int main(int argc, char **argv){

    FILE *provol_code = fopen(argv[1], "r");

    openFile();

    yyin = provol_code;
    yyparse();

    return 0;
    
}
