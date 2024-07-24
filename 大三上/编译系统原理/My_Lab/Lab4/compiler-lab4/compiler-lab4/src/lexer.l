%option noyywrap
%option nounput
%option noinput
%top{
    #include <stdarg.h>
    #include "common.h"
    #include "parser.h"
    #include <string>
    #include <sstream>
    #include <ostream>
    #include <fstream>
    using namespace std;
}
%{
    extern FILE *yyin; 
    extern FILE *yyout;
    extern bool dump_tokens;

    int offset = 1;

    void DEBUG_FOR_LAB4(std::string token, std::string lexeme){
        fprintf(yyout, "[DEBUG LAB4]:  %10s%10s%10d%10d\n",token.c_str(), lexeme.c_str(), yylineno, offset);
    }
%}

INTEGER ([1-9][0-9]*|0)
OCTAL (0[1-7][0-7]*|0)
HEXAL (0(x|X)[1-9a-fA-F][0-9a-fA-F]*|0)
FLOATING ((([0-9]*[.][0-9]*([eE][+-]?[0-9]+)?)|([0-9]+[eE][+-]?[0-9]+))[fLlL]?)
HEXADECIMAL_FLOAT (0[xX](([0-9A-Fa-f]*[.][0-9A-Fa-f]*([pP][+-]?[0-9]+)?)|([0-9A-Fa-f]+[pP][+-]?[0-9]+))[fLlL]?)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
COMMENT (\/\/[^\n]*)
commentbegin "/*"
commentelement .
commentline \n
commentend "*/"
%x COMMENT
%x COMBLOCK

%%
{commentbegin} {BEGIN COMMENT;}
<COMMENT>{commentelement} {}
<COMMENT>{commentline} {yylineno++;}
<COMMENT>{commentend} {BEGIN INITIAL;}

"int" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("TYPE_INT", "int");
        offset+=strlen(yytext);
    }
    return TYPE_INT;
}
"float" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("TYPE_FLOAT", "float");
        offset+=strlen(yytext);
    }
    return TYPE_FLOAT;
}
"void" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("TYPE_VOID", "void");
        offset+=strlen(yytext);
    } 
    return TYPE_VOID;
}
"const" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("CONST", "const");
        offset+=strlen(yytext);
    }
    return CONST;
}
"if" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("IF", "if");
        offset+=strlen(yytext);
    }
    return IF;
}
"else" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("ELSE", "else");
        offset+=strlen(yytext);
    }
    return ELSE;
}
"while" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("WHILE", "while");
        offset+=strlen(yytext);
    }
    return WHILE;
}
"break" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("BREAK", "break");
        offset+=strlen(yytext);
    }
    return BREAK;
}
"continue" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("CONTINUE", "continue");
        offset+=strlen(yytext);
    }
    return CONTINUE;
}
"return" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("RETURN", "return");
        offset+=strlen(yytext);
    }
    return RETURN;
}
"=" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("ASSIGN", "=");
        offset+=strlen(yytext);
    }
    return ASSIGN;
}
"==" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("EQ", "==");
        offset+=strlen(yytext);
    }
    return EQ;
}
"!=" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("NEQ", "!=");
        offset+=strlen(yytext);
    }
    return NEQ;
}
"<" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("LESS", "<");
        offset+=strlen(yytext);
    }
    return LESS;
}
"<=" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("LESSEQ", "<=");
        offset+=strlen(yytext);
    }
    return LESSEQ;
}
">" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("GREAT", ">");
        offset+=strlen(yytext);
    }
    return GREAT;
}
">=" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("GREATEQ", ">=");
        offset+=strlen(yytext);
    }
    return GREATEQ;
}
"+" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("ADD", "+");
        offset+=strlen(yytext);
    }
    return ADD;
}
"-" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("SUB", "-");
        offset+=strlen(yytext);
    }
    return SUB;
}
"*" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("MUL", "*");
        offset+=strlen(yytext);
    }
    return MUL;
}
"/" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("DIV", "/");
        offset+=strlen(yytext);
    }
    return DIV;
}
"%" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("MOD", "%");
        offset+=strlen(yytext);
    }
    return MOD;
}
"||" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("OR", "||");
        offset+=strlen(yytext);
    }
    return OR;
}
"&&" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("AND", "&&");
        offset+=strlen(yytext);
    }
    return AND;
}
"!" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("NOT", "!");
        offset+=strlen(yytext);
    }
    return NOT;
}
"," {
    if(dump_tokens){
        DEBUG_FOR_LAB4("COMMA", ",");
        offset+=strlen(yytext);
    }
    return COMMA;
}
";" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("SEMICOLON", ";");
        offset+=strlen(yytext);
    }
    return SEMICOLON;
}
"(" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("LPAREN", "(");
        offset+=strlen(yytext);
    }
    return LPAREN;
}
")" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("RPAREN", ")");
        offset+=strlen(yytext);
    }   
    return RPAREN;
}
"[" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("LBRACKET", "[");
        offset+=strlen(yytext);
    }
    return LBRACKET;
}
"]" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("RBRACKET", "]");
        offset+=strlen(yytext);
    }   
    return RBRACKET;
}
"{" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("LBRACE", "{");
        offset+=strlen(yytext);
    }
    return LBRACE;
}
"}" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("RBRACE", "}");
        offset+=strlen(yytext);
    }
    return RBRACE;
}
"getint" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("ID", "getint");
        offset+=strlen(yytext);
    }
    char *lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    Type* funcType = new FunctionType(TypeSystem::intType, {});//返回类型int，无参数
    SymbolTable* globalTable;    //全域符号表
    for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
    SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
    globalTable->install(yytext, entry);
    return ID;
}
"getch" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "getch");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        Type* funcType = new FunctionType(TypeSystem::intType, {});//返回类型int，无参数
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"getfloat" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "getfloat");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        Type* funcType = new FunctionType(TypeSystem::floatType, {});//返回类型int，无参数
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"getarray" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "getarray");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        std::vector<Type*> vec; //形参类型表
        Type* arrayType = new IntArrayType();
        ((IntArrayType*)arrayType)->pushBackDimension(-1);
        vec.push_back(arrayType);
        Type* funcType = new FunctionType(TypeSystem::intType, vec);//返回类型int，参数[int array]
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"getfarray" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "getfarray");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        std::vector<Type*> vec; //形参类型表
        Type* arrayType = new FloatArrayType();
        ((FloatArrayType*)arrayType)->pushBackDimension(-1);
        vec.push_back(arrayType);
        Type* funcType = new FunctionType(TypeSystem::intType, vec);//返回类型int，参数[float array]
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"putint" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "putint");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::intType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int]
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"putch" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "putch");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::intType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int]
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"putfloat" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "putfloat");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::floatType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int]
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"putarray" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "putarray");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::intType);
        Type* arrayType = new IntArrayType();
        ((IntArrayType*)arrayType)->pushBackDimension(-1);
        vec.push_back(arrayType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int, int array]
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
"putfarray" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "putfarray");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        std::vector<Type*> vec; //形参类型表
        vec.push_back(TypeSystem::intType);
        Type* arrayType = new FloatArrayType();
        ((FloatArrayType*)arrayType)->pushBackDimension(-1);
        vec.push_back(arrayType);
        Type* funcType = new FunctionType(TypeSystem::voidType, vec);//返回类型void，参数表[int, float array]
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;
}
"putf" {
    if(dump_tokens){
        DEBUG_FOR_LAB4("ID", "putf");
        offset+=strlen(yytext);
    }
}
"starttime" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "starttime");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        Type* funcType = new FunctionType(TypeSystem::voidType, {});//返回类型void，无参数
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;
}
"stoptime" {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", "stoptime");
            offset+=strlen(yytext);
        }
        char *lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        Type* funcType = new FunctionType(TypeSystem::voidType, {});//返回类型void，无参数
        SymbolTable* globalTable;    //全域符号表
        for(globalTable = identifiers;globalTable->getPrev();globalTable = globalTable->getPrev()); //全域符号表
        SymbolEntry* entry = new IdentifierSymbolEntry(funcType, yytext, 0);//作用域GLOBAL(0)
        globalTable->install(yytext, entry);
        return ID;

}
{INTEGER} {
    if(dump_tokens){
        DEBUG_FOR_LAB4("INTEGER", ""+std::string(yytext));
        offset+=strlen(yytext);
    }
    yylval.itype = atoi(yytext);
    return INTEGER;

}
{FLOATING} {
        if(dump_tokens){
            DEBUG_FOR_LAB4("FLOATING", ""+std::string(yytext));
            offset+=strlen(yytext);
        }
        float temp;
        sscanf(yytext, "%f", &temp);
        yylval.ftype = double(temp);
        return FLOATING;

}
{HEXADECIMAL_FLOAT} {
        if(dump_tokens){
            DEBUG_FOR_LAB4("FLOATING", ""+std::string(yytext));
            offset+=strlen(yytext);
        }
        float temp;
        sscanf(yytext, "%f", &temp);
        yylval.ftype = double(temp);
        return FLOATING;

}
{ID} {
        if(dump_tokens){
            DEBUG_FOR_LAB4("ID", ""+std::string(yytext));
            offset+=strlen(yytext);
        }
        char* lexeme = new char[strlen(yytext) + 1];
        strcpy(lexeme, yytext);
        yylval.strtype = lexeme;
        return ID;

}
{OCTAL} {
    char* stop;
    int dec = strtol(yytext, &stop, 8);
    if(dump_tokens){
        DEBUG_FOR_LAB4("DECIMAL", ""+to_string(dec));
        offset+=strlen(yytext);
    }
    yylval.itype = dec;
    return INTEGER;

}
{HEXAL} {
    char* stop;
    int dec = strtol(yytext, &stop, 16);
    if(dump_tokens){
        DEBUG_FOR_LAB4("DECIMAL", ""+to_string(dec));
        offset+=strlen(yytext);
    }
    yylval.itype = dec;
    return INTEGER;

}
{EOL} {
    if(dump_tokens){
        yylineno++;
        offset=1;
    }
}
{WHITE} {
    if(dump_tokens){
        if(yytext[0] == 32)
            offset+=1;
        else
            offset+=4;
    }
}
{COMMENT}
%%