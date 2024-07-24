%{
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <cfloat>
#include <string>
#include <any>
#include <unordered_map>

using namespace std;

#ifndef YYSTYPE
#define YYSTYPE any
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);

class SymbolTable {
    unordered_map<string, double> symbolTable;//存储键值对的集合,元素在容器中的存储顺序不是有序的，根据键的哈希值来确定存储位置
public:
    bool lookup(string identifier) // 查找标识符是否存在于符号表中
    {
    if(symbolTable.find(identifier) == symbolTable.end()){
        return false;
    }
    return true;
}
    void insert(string identifier, double value) // 插入标识符和对应的值
    {
    auto res = symbolTable.insert(pair<string, double>(identifier, value));
    if(res.second){//标识符 identifier 在符号表中不存在（即插入成功），那么 res.second 将为 true，表示插入成功，然后输出 "Initialize" 信息。
        cout << "Initialize " << identifier << "=" << value << endl; // 插入成功（标识符之前不存在）
    }
    else{
        cout << "Update " << identifier << ":" << symbolTable[identifier] << "->" << value << endl; //标识符已存在于符号表中，进行更新
        symbolTable[identifier] = value;
    }
    printAll();
}
    double getValue(string identifier)  // 获取标识符对应的值
    {
    if(symbolTable.find(identifier) == symbolTable.end()) {
        return 0.0;//标识符不存在于符号表中，返回0.0）
    }
    return symbolTable.find(identifier)->second; // 返回标识符对应的值
    }
    void printAll() // 打印所有符号表项,遍历符号表，打印每个标识符及其对应的值
    {
    for (auto &item : symbolTable){
        cout << item.first << " = " << item.second << endl;
    }
    }
};

SymbolTable symTable;

%}

%token ADD
%token SUB
%token MUL
%token DIV
%token UMINUS
%token LEFT
%token RIGHT
%token NUMBER
%token IDENTIFIER
%token ASSIGN
%token SEMI
%token END

%left ADD SUB
%left MUL DIV
%right UMINUS

%%

//程序的语法规则，包括程序结束、语句列表和单独的语句
program :   program END                 {
                                            cout << "The symbol table:" << endl;
                                            symTable.printAll();
                                        }
        |   program stmt
        |   stmt
        ;

//标识符赋值语句eg a=5;
stmt    :   IDENTIFIER ASSIGN expr SEMI {
                                            symTable.insert(any_cast<string>($1), any_cast<double>($3));
                                        }
        ;
        
//定义了表达式的语法规则
expr    :   expr ADD expr               {$$ = any_cast<double>($1) + any_cast<double>($3);}
        |   expr SUB expr               {$$ = any_cast<double>($1) - any_cast<double>($3);}
        |   expr MUL expr               {$$ = any_cast<double>($1) * any_cast<double>($3);}
        |   expr DIV expr               {$$ = any_cast<double>($1) / any_cast<double>($3);}
        |   LEFT expr RIGHT             {$$ = any_cast<double>($2);}
        |   SUB expr %prec UMINUS       {$$ = -1 * any_cast<double>($2);}
        |   NUMBER                      {$$ = any_cast<double>($1);}
        |   IDENTIFIER                  {
                                            string identifier = any_cast<string>($1);
                                            if(!symTable.lookup(identifier)){
                                                cout << "ERROR! " << identifier << " NOT DEFINED!" << endl;
                                            }
                                            else{
                                                $$ = symTable.getValue(identifier);
                                            }
                                        }
        ;

%%

int yylex()
{
    char t;
    while(1) {
        t = getchar();
        if(t == ' ' || t == '\t' || t =='\n');
        else if (isdigit(t)){
            double num = 0;
            while(isdigit(t))
             /* else if (t >= '0' && t <= '9') */
            {
                num = num * 10 + t - '0';
                t = getchar();
            }
            yylval = num;
            ungetc(t, stdin);
            return NUMBER;
        }
        else if (isalpha(t) || t == '_')
        /* else if (t >= 'a' && t <= 'z' || t >='A' && t <= 'Z' || t == '_') */
        {
            string str = ""; //用于存储标识符
            while(isalpha(t) || isdigit(t) || t == '_')
            /* while(t >= 'a' && t <= 'z' || t >='A' && t <= 'Z' || t == '_' || t >= '0' && t <= '9' ) */
            {
                str.push_back(t); // 将当前字符添加到标识符字符串
                t = getchar(); // 读取下一个字符,直到不再是有效的标识符字符为止
            }
            ungetc(t, stdin); // 将读取的字符放回输入流，因为当前字符不属于标识符

            if(str=="END") {
                return END; // 返回 "END" 终结符
            }
            else{
                if(!symTable.lookup(str)){ // 如果标识符不在符号表中
                    symTable.insert(str, 0); // 初始化标识符并将其值设置为0
                }
                yylval = str;
                return IDENTIFIER;
            }
        }
        else if (t == '+'){
            return ADD;
        }
        else if(t == '-'){
            return SUB;
        }
        else if (t == '*'){
            return MUL;
        }
        else if (t == '/'){
            return DIV;
        }
        else if (t == '('){
            return LEFT;
        }
        else if (t == ')'){
            return RIGHT;
        }
        else if (t == '='){
            return ASSIGN;
        }
        else if (t == ';'){
            return SEMI;
        }
        else{
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
