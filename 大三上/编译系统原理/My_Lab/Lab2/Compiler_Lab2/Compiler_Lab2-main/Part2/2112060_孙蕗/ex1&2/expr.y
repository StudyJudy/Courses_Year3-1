%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();//词法分析
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}
//注意先后定义的优先级区别
%token ADD
%token SUB
%token MUL
%token DIV
%token UMINUS
%token LEFT
%token RIGHT
%token NUMBER

%left ADD SUB
%left MUL DIV
%right UMINUS

%%
//语法分析
lines   :   lines expr ';' {printf("%f\n", $2);}//解析到一个表达式后，打印表达式的值并带有分号。这里的 printf 语句用于输出表达式的值。
        |   lines ';'//解析到一个分号，但没有表达式。这可能是一种语法上的规定，例如表示空语句。
        |   //表示没有任何内容，即空行或空程序
        ;

expr    :   expr ADD expr           {$$ = $1 + $3;}
        |   expr SUB expr           {$$ = $1 - $3;}
        |   expr MUL expr           {$$ = $1 * $3;}
        |   expr DIV expr {
            if ($3 == 0) {
                yyerror("division by zero");
                $$ = 0; 
            } else {
                $$ = $1 / $3;
            }
        }
        |   LEFT expr RIGHT         {$$ = $2;}
        |   SUB expr %prec UMINUS   {$$ = -$2;}
        |   NUMBER                  {$$ = $1;}
        ;

%%

// programs section,词法分析,从输入流中读取字符并将它们转换成标记（token）。读取字符，识别数字、标识符、运算符等，并返回相应的标记类型。
int yylex()
{
    int t;
    while(1) {
        t = getchar();
        if(t == ' ' || t == '\t' || t =='\n'); // 忽略空格、制表符和换行符
        else if (isdigit(t))
        {
            yylval = 0;
            while(isdigit(t))
            {
                yylval = yylval * 10 + t - '0'; //读取数字字符并将其转换为数字
                t = getchar();
            }
            ungetc(t, stdin); // 将读取的字符放回输入流
            return NUMBER;
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
    yyin = stdin; // 设置输入为标准输入
    do {
        yyparse(); // 调用Bison解析器进行语法分析
    } while(!feof(yyin));
    return 0;
}

void yyerror(const char* s)
{
    fprintf(stderr, "Parse error:%s\n", s);
    exit(1);
}
