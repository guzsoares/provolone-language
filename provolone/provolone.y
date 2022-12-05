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
#define CODE_DEC 10
#define CODE_IMULL 11
#define CODE_SQRD 12
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
    openFile();
    fprintf(cFile,"#include <stdio.h>\nint main(void) {\n");
    while(llist != NULL) {
        switch(llist->line.cmd){
            case CODE_OPR_ZERO: {
                fprintf(cFile, "%s = 0;\n", llist->line.v1);
                break;
            }
            case CODE_SQRD: {
                fprintf(cFile, "%s = %s * %s;\n", llist->line.v1, llist->line.v1, llist->line.v1);
                break;
            }
            case CODE_IMULL: {
                fprintf(cFile, "%s = %s * 2;\n", llist->line.v1, llist->line.v1);
                break;
            }
            case CODE_DEC: {
                fprintf(cFile, "%s = %s - 1;\n",llist->line.v1, llist->line.v1);
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
            case CODE_END: {
                fprintf(cFile, "}\n");
                break;
            }
            case CODE_WHILE: {
                fprintf(cFile, "while (%s > 0) {\n", llist->line.v1);
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
            case CODE_IF: {
                fprintf(cFile,"if (%s != 0) {\n", llist->line.v1);
                break;
            }
            case CODE_IF_NOT: {
                fprintf(cFile, "} else {\n");
                break;
            }
            case CODE_REPEAT: {
                fprintf(cFile, "for (int i = 0; i < %s; i++) {\n", llist->line.v1);
                break;
            }
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
%token DEC
%token IMULL
%token SQRD

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

    | FACA ID VEZES cmds FIM {

        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING LOOP");
            exit(-1);
        }

        llist->line.v1 = $2;
        llist->line.cmd = CODE_REPEAT;
        addLLISTend($4,llist);

        LLIST *aux = (LLIST*)malloc(sizeof(LLIST));
        if (aux == NULL){
            printf("ERROR READING END");
            exit(-1);
        }

        aux->line.cmd = CODE_END;
        addLLISTend(aux,llist);
        $$ = llist;
        
    }

    | SE ID cmds FIM {

        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING IF");
            exit(-1);
        }

        llist->line.v1 = $2;
        llist->line.cmd = CODE_IF;
        addLLISTend($3,llist);

        LLIST *aux = (LLIST*)malloc(sizeof(LLIST));
        if (aux == NULL){
            printf("ERROR READING END");
            exit(-1);
        }

        aux->line.cmd = CODE_END;
        addLLISTend(aux,llist);
        $$ = llist;

    }

    | SE ID cmds SENAO cmds FIM {
        
        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING IF IF NOT");
            exit(-1);
        }

        llist->line.v1 = $2;
        llist->line.cmd = CODE_IF;
        addLLISTend($3,llist);

        LLIST *aux = (LLIST*)malloc(sizeof(LLIST));
        if (aux == NULL){
            printf("ERROR READING IFNOT ");
            exit(-1);
        }

        aux->line.cmd = CODE_IF_NOT;
        addLLISTend(aux,llist);
        addLLISTend($5,llist);

        aux->line.cmd = CODE_END;
        addLLISTend(aux,llist);

        $$ = llist;
    }

    | ZERA ABRE ID FECHA {
        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING ZERO");
            exit(-1);
        }

        llist->line.v1 = $3;
        llist->line.cmd = CODE_OPR_ZERO;
        $$ = llist;
    }

    | DEC ABRE ID FECHA {
        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING DEC");
            exit(-1);
        }

        llist->line.v1 = $3;
        llist->line.cmd = CODE_DEC;
        $$ = llist;
    }

    | IMULL ABRE ID FECHA {
        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING IMULL");
            exit(-1);
        }

        llist->line.v1 = $3;
        llist->line.cmd = CODE_IMULL;
        $$ = llist;
    }

    | SQRD ABRE ID FECHA {
        LLIST *llist = (LLIST*)malloc(sizeof(LLIST));
        if (llist == NULL){
            printf("ERROR READING SQRD");
            exit(-1);
        }

        llist->line.v1 = $3;
        llist->line.cmd = CODE_SQRD;
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
