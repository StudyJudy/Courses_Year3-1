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

double value;

class SymbolTable {
    unordered_map<string, double> symbolTable;
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
    if(res.second){
        cout << "Initialize " << identifier << "=" << value << endl; // 插入成功（标识符之前不存在）
        cout << "x dd 0"<< endl;
    }
    else{
        cout << "Update " << identifier << ":" << symbolTable[identifier] << "->" << value << endl; //标识符已存在于符号表中，进行更新
        cout <<"mov eax, "<<value << endl;
        cout << "mov [x], eax" << endl;
        symbolTable[identifier] = value;
        printAll();
    }
    cout<<endl;
}
    double getValue(string identifier)  // 获取标识符对应的值
    {
    if(symbolTable.find(identifier) == symbolTable.end()) {
        return 0.0;//标识符不存在于符号表中，返回 DBL_MIN（double 类型的最小值）
    }
    return symbolTable.find(identifier)->second; // 返回标识符对应的值
    }
    void printAll() // 打印所有符号表项,遍历符号表，打印每个标识符及其对应的值
    {
    cout<<"PrintAll(): "<<endl;
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

//标识符赋值语句
stmt    :   IDENTIFIER ASSIGN expr SEMI {
                                            symTable.insert(any_cast<string>($1), any_cast<double>($3));
                                        }
        ;
        
//定义了表达式的语法规则
expr    :   expr ADD expr               {//$$ = any_cast<double>($1) + any_cast<double>($3);
                                         // 获取表达式的值
                                         double leftValue = any_cast<double>($1);
                                         double rightValue = any_cast<double>($3);

                                         // 执行加法操作并将结果存储在eax中
                                         cout << "mov eax, " << leftValue << endl;    // 将左操作数加载到寄存器eax
                                         cout << "add eax, " << rightValue << endl;   // 将右操作数与eax相加

                                         // 将结果存储在$$中
                                         $$ = leftValue + rightValue;    
                                        }
        |   expr SUB expr               {//$$ = any_cast<double>($1) - any_cast<double>($3);
                                        // 获取表达式的值
                                         double leftValue = any_cast<double>($1);
                                         double rightValue = any_cast<double>($3);

                                         // 执行加法操作并将结果存储在eax中
                                         cout << "mov eax, " << leftValue << endl;    // 将左操作数加载到寄存器eax
                                         cout << "sub eax, " << rightValue << endl;   // 将右操作数与eax相加

                                         // 将结果存储在$$中
                                         $$ = leftValue + rightValue;
                                        }
        |   expr MUL expr               {//$$ = any_cast<double>($1) * any_cast<double>($3);
                                         //获取表达式的值
                                         double leftValue = any_cast<double>($1);
                                         double rightValue = any_cast<double>($3);

                                         // 执行乘法操作并将结果存储在eax中
                                         cout << "mov eax, " << leftValue << endl;    // 将左操作数加载到寄存器eax
                                         cout << "imul eax, " << rightValue << endl;  // 与eax中的值相乘（带符号整数乘法）

                                         // 将结果存储在$$中
                                         $$ = leftValue * rightValue;
                                        }
        |   expr DIV expr               {//$$ = any_cast<double>($1) / any_cast<double>($3);
                                         // 获取表达式的值
                                         double leftValue = any_cast<double>($1);
                                         double rightValue = any_cast<double>($3);

                                         // 检查右操作数是否为零，如果是，则发出错误消息
                                         if (rightValue == 0) 
                                         {
                                             cout << "ERROR! Division by zero." << endl;
                                             $$ = 0.0; // 设置结果为零，或者您可以采取其他错误处理措施
                                         } 
                                         else 
                                         {
                                             // 执行除法操作并将结果存储在eax中
                                             cout << "mov eax, " << leftValue << endl;    // 将左操作数加载到寄存器eax
                                             cout << "cdq" << endl;  // 将eax的值扩展到edx:eax中（带符号扩展）
                                             cout << "idiv eax, " << rightValue << endl;  // 除以右操作数并将商存储在eax中

                                             // 将结果存储在$$中
                                             $$ = leftValue / rightValue;
                                        }
                                        }
        |   LEFT expr RIGHT             {//$$ = any_cast<double>($2);
                                         // 获取括号内表达式的值
                                         double exprValue = any_cast<double>($2);

                                         // 在汇编中，括号不会影响值的计算，因此无需执行其他操作
                                         // 只需将括号内的值存储在$$中
                                          $$ = exprValue;
                                        }
        |   SUB expr %prec UMINUS       {//$$ = -1 * any_cast<double>($2);
                                         // 获取表达式的值
                                         double exprValue = any_cast<double>($2);

                                         // 执行减法操作（负数操作）并将结果存储在eax中
                                         cout << "mov eax, 0" << endl;        // 将寄存器eax清零
                                         cout << "sub eax, " << exprValue << endl; // 从eax中减去表达式的值

                                         // 将结果存储在$$中
                                         $$ = -exprValue; // 为了确保结果为负数，将表达式值取反
                                        }
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
            std::string str = "";
            while(isalpha(t) || isdigit(t) || t == '_')
            /* while(t >= 'a' && t <= 'z' || t >='A' && t <= 'Z' || t == '_' || t >= '0' && t <= '9' ) */
            {
                str.push_back(t);
                t = getchar();
            }
            ungetc(t, stdin);
            if(str=="END") {
                return END;
            }
            else{
                if(!symTable.lookup(str)){
                    symTable.insert(str, 0);
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
