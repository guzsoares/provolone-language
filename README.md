## Alunos

Gustavo Molina Soares (2020209)
Felipe Maia Meiga (2011460)

# Compilador para linguagem Provolone

Compilador que utiliza as ferramentas Yacc/Lex para realizar a leitura e a compilação de uma linguagem
chamada provolone

Trabalho realizado em para o período de 2022.2 como trabalho final para a matéria
INF1022 - Analisadores Léxicos e Sintáticos

Nota recebida ??/10

## Linguagem

A linguagem provolone possui uma gramática básica e implementamos algumas outras funções, aqui estão:

* *program* -> ENTRADA *varlist* SAIDA *varlist* *cmds* FIM
* *varlist* -> ID *varlist*
* *varlist* -> ID
* *cmds* -> *cmds* cmd
* *cmds* -> *cmd*
* *cmd* -> ENQUANTO ID FACA *cmds* FIM
* *cmd* -> ID = ID
* *cmd* -> SQRD(ID)
* *cmd* -> IMULL(ID)
* *cmd* -> DEC(ID)
* *cmd* -> INC(ID)
* *cmd* -> ZERA(ID)
* *cmd* -> FACA ID VEZES *cmds* FIM
* *cmd* -> SE ID ENTAO *cmds* FIM
* *cmd* -> SE ID ENTAO *cmds* SENAO ENTAO *cmds* FIM

## Documentação de requisitos

Para poder gerar o compilador, é preciso utilizar o *Bison* e *Flex*

Aqui está como realizar a instalação dos dois:

```shell
sudo apt-get install bison flex
```

## Execução

```shell
yacc -d grammar.y
lex lexic.l
gcc -c lex.yy.c y.tab.c
gcc -o compile lex.yy.o y.tab.o -ll
```
O comando irá gerar um objeto compile, que precisa de um arquivo provolone.

A linguagem provolone será compilada para a linguagem C.

Exemplo:

```shell
./compile program.provolone
```
