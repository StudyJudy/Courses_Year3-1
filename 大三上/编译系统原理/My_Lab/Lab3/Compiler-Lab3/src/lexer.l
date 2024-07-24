%option noyywrap
%option nounput
%option noinput
%top{
    #include <stdarg.h>
    #include "common.h"
    #include <string>
    #include <sstream>
    #include <ostream>
    #include <fstream>
    #include <malloc.h>
    #include <unordered_map>
    extern FILE *yyin; 
    extern FILE *yyout;
    class SymbolTable 
{
    std::unordered_map<std::string, double*> symbolTable;
public:
    bool lookup(std::string identifier)// 查找标识符是否存在于符号表中
    {
    if(symbolTable.find(identifier) == symbolTable.end()){// 使用 find() 函数在符号表中查找标识符
        return false;//不存在返回false
    }
    return true;//存在返回true
    }

    void insert(std::string identifier, double value)// 插入或更新标识符及其对应的值到符号表中
    {
    double* addr = new double(value); // 创建一个新的 double 类型的变量，并将其地址存储在符号表中
    auto res = symbolTable.insert(std::pair<std::string, double*>(identifier, addr));
    if(res.second){}
    }
    //double getValue(std::string identifier);// 获取标识符对应的值
    //void printAll();// 打印符号表中的所有标识符及其对应的值
    double* getAddress(std::string identifier, double value)
    {
    
     if (symbolTable.find(identifier) == symbolTable.end()) {
        insert(identifier, value);
        getAddress(identifier, value);
    }
    return symbolTable[identifier]; // 返回标识符对应的地址
    }
};
    SymbolTable symTable;
}
%{
    /* Your code here, if desired (lab3). */
    int offset = 1; // 设置行偏移量初始值
     // 输出调试信息，包括标记（token）、词素（lexeme）、行号和行偏移
    void DEBUG_FOR_LAB3(std::string token, std::string lexeme){
        fprintf(yyout, "%20s%20s%20d%20d\n",token.c_str(), lexeme.c_str(), yylineno, offset);
    }
    // 输出调试信息，包括标记（token）、词素（lexeme）、行号、行偏移和值
    void DEBUG_FOR_LAB3_DECIMAL(std::string token, std::string lexeme, std::string value){
        fprintf(yyout, "%20s%20s%20d%20d%20s\n",token.c_str(), lexeme.c_str(), yylineno, offset, value.c_str());
    }
    // 输出调试信息，包括标记（token）、词素（lexeme）、行号、行偏移和地址
    void DEBUG_FOR_LAB3_ID(std::string token, std::string lexeme, double* p){
        fprintf(yyout, "%20s%20s%20d%20d\t%20p\n",token.c_str(), lexeme.c_str(), yylineno, offset, p);
    }

%}

DECIMAL ([1-9][0-9]*|0)
OCTAL (0[1-7][0-7]*|0)
HEXAL (0(x|X)[1-9a-fA-F][0-9a-fA-F]*|0)
FLOAT ((((0(x|X)[0-9a-fA-F]*[.][0-9a-fA-F]*|[0-9a-fA-F]*[.][0-9a-fA-F]*)*([eE][+-]?[0-9a-fA-F]+)?)|([0-9a-fA-F]+[eE][+-]?[0-9a-fA-F]+))[fLlL]?)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]

COMMENT (\/\/[^\n]*)
commentbegin "/*"
commentelement . 
commentline \n
commentend "*/"

%x COMMENT

%%
{commentbegin} {BEGIN COMMENT;}// 进入多行注释状态
<COMMENT>{commentelement} {}// 多行注释状态中的任意字符被忽略
<COMMENT>{commentline} {yylineno++;}// 多行注释中的换行增加行号
<COMMENT>{commentend} {BEGIN INITIAL;}// 离开多行注释状态

"int" {
    DEBUG_FOR_LAB3("TYPE_INT", "int");
    offset+=strlen(yytext);
}

"float" {
    DEBUG_FOR_LAB3("TYPE_FLOAT", "float");
    offset+=strlen(yytext);
}

"void" {
    DEBUG_FOR_LAB3("TYPE_VOID", "void");
    offset+=strlen(yytext);
}

"if" {
    DEBUG_FOR_LAB3("IF", "if");
    offset+=strlen(yytext);
}

"else" {
    DEBUG_FOR_LAB3("ELSE", "else");
    offset+=strlen(yytext);
}

"while" {
    DEBUG_FOR_LAB3("WHILE", "while");
    offset+=strlen(yytext);
}

"break" {
    DEBUG_FOR_LAB3("BREAK", "break");
    offset+=strlen(yytext);
}

"continue" {
    DEBUG_FOR_LAB3("CONTINUE", "continue");
    offset+=strlen(yytext);
}

"return" {
        DEBUG_FOR_LAB3("RETURN", "return");
        offset+=strlen(yytext);
}

"=" {
        DEBUG_FOR_LAB3("ASSIGN", "=");
        offset+=strlen(yytext);
}

"==" {
        DEBUG_FOR_LAB3("EQ", "==");
        offset+=strlen(yytext);
}
"!=" {
        DEBUG_FOR_LAB3("NEQ", "!=");
        offset+=strlen(yytext);
}
"<" {
        DEBUG_FOR_LAB3("LESS", "<");
        offset+=strlen(yytext);
}
"<=" {
        DEBUG_FOR_LAB3("LESSEQ", "<=");
        offset+=strlen(yytext);
}
">" {
        DEBUG_FOR_LAB3("GREAT", ">");
        offset+=strlen(yytext);
}
">=" {
        DEBUG_FOR_LAB3("GREATEQ", ">=");
        offset+=strlen(yytext);
}
"+" {
        DEBUG_FOR_LAB3("ADD", "+");
        offset+=strlen(yytext);
}
"-" {
        DEBUG_FOR_LAB3("SUB", "-");
        offset+=strlen(yytext);
}
"*" {
        DEBUG_FOR_LAB3("MUL", "*");
        offset+=strlen(yytext);
}
"/" {
        DEBUG_FOR_LAB3("DIV", "/");
        offset+=strlen(yytext);
}
"%" {
        DEBUG_FOR_LAB3("MOD", "%");
        offset+=strlen(yytext);
}
"||" {
        DEBUG_FOR_LAB3("OR", "||");
        offset+=strlen(yytext);
}
"&&" {
        DEBUG_FOR_LAB3("AND", "&&");
        offset+=strlen(yytext);
}
"!" {
        DEBUG_FOR_LAB3("NOT", "!");
        offset+=strlen(yytext);
}
"," {
        DEBUG_FOR_LAB3("COMMA", ",");
        offset+=strlen(yytext);
}
";" {
    DEBUG_FOR_LAB3("SEMICOLON", ";");
    offset+=strlen(yytext);
}
"(" {
    DEBUG_FOR_LAB3("LPAREN", "(");
    offset+=strlen(yytext);
}
")" {
        DEBUG_FOR_LAB3("RPAREN", ")");
        offset+=strlen(yytext);
}
"[" {
        DEBUG_FOR_LAB3("LBRACKET", "[");
        offset+=strlen(yytext);
}
"]" {
        DEBUG_FOR_LAB3("RBRACKET", "]");
        offset+=strlen(yytext);
}
"{" {
        DEBUG_FOR_LAB3("LBRACE", "{");
        offset+=strlen(yytext);
}
"}" {
        DEBUG_FOR_LAB3("RBRACE", "}");
        offset+=strlen(yytext);
}

{DECIMAL} {
        DEBUG_FOR_LAB3_DECIMAL("DECIMAL", ""+std::string(yytext), ""+std::string(yytext));
        offset+=strlen(yytext);
}
{FLOAT} {
        DEBUG_FOR_LAB3_DECIMAL("FLOAT", ""+std::string(yytext), ""+std::string(yytext));
        offset+=strlen(yytext);
}
{ID} {
        //DEBUG_FOR_LAB4("ID", ""+std::string(yytext));
        std::string str = yytext;
        //double* p=symTable.getAddress(str,1);
        DEBUG_FOR_LAB3_ID("ID",""+std::string(yytext), symTable.getAddress(str,1));
        offset+=strlen(yytext);
}
{OCTAL} {
        char* stop;
        int dec = strtol(yytext, &stop, 8);
        DEBUG_FOR_LAB3_DECIMAL("OCTAL", ""+std::string(yytext), ""+std::to_string(dec));
        offset+=strlen(yytext);
}
{HEXAL} {
        char* stop;
        int dec = strtol(yytext, &stop, 16);
        DEBUG_FOR_LAB3_DECIMAL("HEXAL", ""+std::string(yytext), ""+std::to_string(dec));
        offset+=strlen(yytext);
}
{EOL} yylineno++,offset=1;
{WHITE} {
    if(yytext[0] == 32)
        offset+=1;
    else
        offset+=4;
}
{COMMENT}
%%

