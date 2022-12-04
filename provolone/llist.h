#include <stdio.h>

typedef struct line{
    short cmd;
    char *v1;
    char *v2;
}LINE;

typedef struct llist{
    struct llist *ant;
    struct llist *prox;
    LINE line;
}LLIST;

void addLLISTend(llist *newC, llist *llist){

    llist *temp = llist;

    while (temp->prox != NULL){
        temp = temp->prox;
    }

    temp->prox = newC;
    newC->ant = temp;
}

void addLLISTstart(llist *newC, llist *llist){

    llist->prev = newC;
    newC->next = llist;
}