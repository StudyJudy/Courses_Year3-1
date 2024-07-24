%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#ifndef YYSTYPE
#define YYSTYPE char*
#endif

char numStr[50]; // 用于存储数字的字符串
char idStr[50]; // 用于存储标识符的字符串
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}

%token ADD
%token SUB
%token MUL
%token DIV
%token UMINUS
%token LEFT
%token RIGHT
%token NUMBER
%token ID

%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines   :   lines expr ';' {printf("%s\n", $2);}
        |   lines ';'
        |   
        ;
        
expr    :   expr ADD expr           {
                                    $$ = (char*) malloc (50*sizeof(char)); // 分配内存
                                    strcpy($$, $1); // 复制第一个表达式的字符串
                                    strcat($$, $3); // 连接第三个表达式的字符串
                                    strcat($$, "+ "); // 添加加号
                                    }
        |   expr SUB expr           {
                                    $$ = (char*) malloc (50*sizeof(char));
                                    strcpy($$, $1);
                                    strcat($$, $3);
                                    strcat($$, "- ");
                                    }
        |   expr MUL expr           {
                                    $$ = (char*) malloc (50*sizeof(char));
                                    strcpy($$, $1);
                                    strcat($$, $3);
                                    strcat($$, "* ");
                                    }
        |   expr DIV expr           {
                                    $$ = (char*) malloc (50*sizeof(char));
                                    strcpy($$, $1);
                                    strcat($$, $3);
                                    strcat($$, "/ ");
                                    }
        |   LEFT expr RIGHT         {
                                    $$ = (char*) malloc (50*sizeof(char));
                                    strcpy($$, $2); // 复制括号内的表达式的字符串
                                    strcat($$, " "); // 添加空格
                                    }
        |   SUB expr %prec UMINUS   {
                                    $$ = (char*) malloc (50*sizeof(char));
                                    strcpy($$, "0"); // 设置字符串为 "0"
                                    strcat($$, $2); // 连接负号和表达式的字符串
                                    strcat($$, "-");
                                    }
        |   NUMBER                  {
                                    $$ = (char*) malloc (50*sizeof(char));
                                    strcpy($$, $1); // 复制数字的字符串
                                    strcat($$, " ");
                                    }
        |   ID                      {
                                    $$ = (char*) malloc (50*sizeof(char));
                                    strcpy($$, $1); // 复制标识符的字符串
                                    strcat($$, " ");
                                    }
        ;

%%

int yylex()
{
    int t;
    while(1) {
        t = getchar();
        if(t == ' ' || t == '\t' || t =='\n');
        else if (isdigit(t)) // 处理数字,<ctype.h>
        /* else if (t >= '0' && t <= '9') */
        {
            int ti = 0;//追踪当前字符在 numStr 数组中的位置。
            while(isdigit(t))
            /* while(t >= '0' && t <= '9') */
            {
                numStr[ti] = t; //当前数字字符 t 存储在 numStr 数组的适当位置（通过 ti 索引）
                t = getchar(); //从输入中读取下一个字符 t，并重复步骤 2 和 3 直到不再有连续的数字字符
                ti++;
            }
            numStr[ti] = '\0'; 
            yylval = numStr; //将 numStr 中存储的数字字符串存储在 yylval 中，这是用于在语法分析器中传递值的变量。
            ungetc(t, stdin); // 将读取的字符放回输入流
            return NUMBER; // 返回数字终结符
        }
        else if (isalpha(t) || t == '_') // 处理标识符,<ctype.h>
        /* else if (t >= 'a' && t <= 'z' || t >='A' && t <= 'Z' || t == '_') */
        {
            int ti = 0;
            while(isalpha(t) || isdigit(t) || t == '_')
            /* while(t >= 'a' && t <= 'z' || t >='A' && t <= 'Z' || t == '_' || t >= '0' && t <= '9' ) */
            {
                idStr[ti] = t;
                t = getchar();
                ti++;
            }
            idStr[ti] = '\0';
            yylval = idStr;
            ungetc(t, stdin);
            return ID;
        }
        else if (t == '+')
        {
            return ADD;
        }
        else if(t == '-')
        {
            return SUB;
        }
        else if (t == '*')
        {
            return MUL;
        }
        else if (t == '/')
        {
            return DIV;
        }
        else if (t == '(')
        {
            return LEFT;
        }
        else if (t == ')')
        {
            return RIGHT;
        }
        else
        {
            return t;
        }
    }
}

int main()
{
    yyin = stdin;
    do {
        yyparse();
    } while(!feof(yyin));
    return 0;
}

void yyerror(const char* s)
{
    fprintf(stderr, "Parse error:%s\n", s);
    exit(1);
}
