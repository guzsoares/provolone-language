/* A Bison parser, made by GNU Bison 3.7.5.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ENTRADA = 258,                 /* ENTRADA  */
    SAIDA = 259,                   /* SAIDA  */
    FIM = 260,                     /* FIM  */
    ENQUANTO = 261,                /* ENQUANTO  */
    FACA = 262,                    /* FACA  */
    ZERA = 263,                    /* ZERA  */
    ABRE = 264,                    /* ABRE  */
    FECHA = 265,                   /* FECHA  */
    IGUAL = 266,                   /* IGUAL  */
    ENTAO = 267,                   /* ENTAO  */
    INC = 268,                     /* INC  */
    ID = 269,                      /* ID  */
    VEZES = 270,                   /* VEZES  */
    SE = 271,                      /* SE  */
    SENAO = 272,                   /* SENAO  */
    DEC = 273,                     /* DEC  */
    IMULL = 274,                   /* IMULL  */
    SQRD = 275                     /* SQRD  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define ENTRADA 258
#define SAIDA 259
#define FIM 260
#define ENQUANTO 261
#define FACA 262
#define ZERA 263
#define ABRE 264
#define FECHA 265
#define IGUAL 266
#define ENTAO 267
#define INC 268
#define ID 269
#define VEZES 270
#define SE 271
#define SENAO 272
#define DEC 273
#define IMULL 274
#define SQRD 275

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 151 "provolone.y"

    int var;
    char *content;
    struct llist *llistvar;

#line 113 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
