%code top{
    #include <iostream>
    #include <assert.h>
    #include "parser.h"
    extern Ast ast;
    int yylex();
    int yyerror( char const * );

    Type* currentType;
}

%code requires {
    #include "Ast.h"
    #include "SymbolTable.h"
    #include "Type.h"
}

%union {
    int itype;
    double ftype;
    char* strtype;
    StmtNode* stmttype;
    ExprNode* exprtype;
    Type* type;
}

%start Program
%token <strtype> ID 
%token <itype> INTEGER
%token <ftype> FLOATING
%token CONST
%token TYPE_INT TYPE_FLOAT TYPE_VOID
%token IF ELSE WHILE BREAK CONTINUE RETURN
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE COMMA SEMICOLON
%token ADD SUB MUL DIV MOD AND OR NOT LESS LESSEQ GREAT GREATEQ EQ NEQ ASSIGN

%type <stmttype> Stmts Stmt AssignStmt ExpStmt BlockStmt IfStmt WhileStmt BreakStmt ContinueStmt ReturnStmt
%type <stmttype> DeclStmt ConstDefList ConstDef ConstInitVal VarDefList VarDef VarInitVal FuncDef FuncParams FuncParam FuncRParams
%type <stmttype> ArrConstIndices ArrValIndices ConstInitValList VarInitValList
%type <exprtype> Exp ConstExp AddExp MulExp UnaryExp PrimaryExp LVal Cond LOrExp LAndExp EqExp RelExp
%type <type> Type

%precedence THEN
%precedence ELSE
%%

// 程序
Program
    :   Stmts{
            ast.setRoot($1);
        }
    ;

// 语句序列
Stmts
    :   Stmts Stmt{
            SeqNode* node = (SeqNode*)$1;
            node->addNext((StmtNode*)$2);
            $$ = (StmtNode*) node;
        }
    |   Stmt{
            SeqNode* node = new SeqNode();
            node->addNext((StmtNode*)$1);
            $$ = (StmtNode*) node;
        }
    ;

// 语句
Stmt
    :   AssignStmt {$$=$1;} //赋值语句
    |   ExpStmt SEMICOLON{$$=$1;}   //表达式语句
    |   BlockStmt {$$=$1;}  //语句块
    |   IfStmt {$$=$1;} //if语句
    |   WhileStmt {$$=$1;}  //while语句
    |   BreakStmt {$$=$1;}  //break语句
    |   ContinueStmt {$$=$1;}   //continue语句
    |   ReturnStmt {$$=$1;} //return语句
    |   DeclStmt {$$=$1;}   //
    |   FuncDef {$$=$1;}    //
    |   SEMICOLON {$$ = new EmptyStmt();}   //
    ;

// 赋值操作的左值
LVal
    :   ID {    //标识符
            SymbolEntry *se;
            se = identifiers->lookup($1);
            if(se == nullptr)
            {
                fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
                delete [](char*)$1;
                assert(se != nullptr);
            }
            $$ = new Id(se);
            delete []$1;
        }
    |   ID ArrValIndices {  //数组元素
            SymbolEntry *se;
            se = identifiers->lookup($1);
            if(se == nullptr)
            {
                fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
                delete [](char*)$1;
                assert(se != nullptr);
            }
            Id* newId = new Id(se);
            newId->addIndices((ExprStmtNode*)$2);
            $$ =  newId;
            delete []$1;
        }
    ;

// 赋值语句
AssignStmt
    :   LVal ASSIGN Exp SEMICOLON {
            $$ = new AssignStmt($1, $3);
        }
    ;

// 表达式语句
ExpStmt
    :   ExpStmt COMMA Exp { //多个表达式
            ExprStmtNode* node = (ExprStmtNode*)$1;
            node->addNext($3);
            $$ = node;
        }
    |   Exp {   //单个表达式
            ExprStmtNode* node = new ExprStmtNode();
            node->addNext($1);
            $$ = node;
        }
    ;

// 语句块，由{}包围
BlockStmt
    :   LBRACE {
            identifiers = new SymbolTable(identifiers);
        } 
        Stmts RBRACE {
            $$ = new CompoundStmt($3);
            SymbolTable *top = identifiers;
            identifiers = identifiers->getPrev();
            delete top;
        }
    |   LBRACE RBRACE {
            $$ = new CompoundStmt(nullptr);
        }
    ;

// if语句，带和不带else的情况
IfStmt
    :   IF LPAREN Cond RPAREN Stmt %prec THEN {
            $$ = new IfStmt($3, $5);
        }
    |   IF LPAREN Cond RPAREN Stmt ELSE Stmt {
            $$ = new IfElseStmt($3, $5, $7);
        }
    ;

//while 语句
WhileStmt
    :   WHILE LPAREN Cond RPAREN Stmt {
            $$ = new WhileStmt($3,$5);
        }
    ;

//break 语句
BreakStmt
    :   BREAK SEMICOLON {
            $$ = new BreakStmt();
        }
    ;

//continue 语句
ContinueStmt
    :   CONTINUE SEMICOLON{
            $$ = new ContinueStmt();
        }
    ;


// return 语句，带返回值和不带返回值
ReturnStmt
    :   RETURN Exp SEMICOLON {
            $$ = new ReturnStmt($2);
        }
    |   RETURN SEMICOLON {
            $$ = new ReturnStmt(nullptr);
        }
    ;

// 变量表达式
Exp
    :   AddExp {
            $$ = $1;
        }
    ;

// 常量表达式
ConstExp
    :   AddExp {
            $$ = $1;
        }
    ;

// 加法级表达式，加法，减法
AddExp
    :   MulExp {
            $$ = $1;
        }
    |   AddExp ADD MulExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::ADD, $1, $3);
        }
    |   AddExp SUB MulExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::SUB, $1, $3);
        }
    ;

// 乘法级表达式，乘法，除法
MulExp
    :   UnaryExp {
            $$ = $1;
        }
    |   MulExp MUL UnaryExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::MUL, $1, $3);
        }
    |   MulExp DIV UnaryExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::DIV, $1, $3);
        }
    |   MulExp MOD UnaryExp {
            SymbolEntry *se;
            if($1->getType()->isInt() && $3->getType()->isInt()){
                se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            }
            else{
                se = new TemporarySymbolEntry(TypeSystem::floatType, SymbolTable::getLabel());
            }
            $$ = new BinaryExpr(se, BinaryExpr::MOD, $1, $3);
        }
    ;

// 一元表达式，单目运算符
UnaryExp
    :   PrimaryExp {
            $$ = $1;
        }
    |   ID LPAREN FuncRParams RPAREN {
            SymbolEntry *se;
            se = identifiers->lookup($1);
            if(se == nullptr)
            {
                fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
                delete [](char*)$1;
                assert(se != nullptr);
            }
            SymbolEntry *tmp = new TemporarySymbolEntry(se->getType(), SymbolTable::getLabel());
            $$ = new FuncCallNode(tmp, new Id(se), (FuncCallParamsNode*)$3);
        }
    |   ADD UnaryExp {
            //$$ = $2;
            SymbolEntry *tmp = new TemporarySymbolEntry($2->getType(), SymbolTable::getLabel());
            $$ = new OneOpExpr(tmp, OneOpExpr::ADD, $2);
        }
    |   SUB UnaryExp {
            SymbolEntry *tmp = new TemporarySymbolEntry($2->getType(), SymbolTable::getLabel());
            $$ = new OneOpExpr(tmp, OneOpExpr::SUB, $2);
        }
    |   NOT UnaryExp {
            SymbolEntry *tmp = new TemporarySymbolEntry($2->getType(), SymbolTable::getLabel());
            $$ = new OneOpExpr(tmp, OneOpExpr::NOT, $2);
        }
    ;

// 原始表达式
PrimaryExp
    :   LVal {
            $$ = $1;
        }
    |   LPAREN Exp RPAREN {
            $$ = $2;
        }
    |   INTEGER {
            SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::intType, $1);
            $$ = new Constant(se);
        }
    |   FLOATING {
            SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::floatType, $1);
            $$ = new Constant(se);
        }
    ;

// 函数调用时的参数列表
FuncRParams
    :   FuncRParams COMMA Exp {
            FuncCallParamsNode* node = (FuncCallParamsNode*) $1;
            node->addNext($3);
            $$ = node;
        }
    |   Exp {
            FuncCallParamsNode* node = new FuncCallParamsNode();
            node->addNext($1);
            $$ = node;
        }
    |   %empty {
            $$ = nullptr;
        }
    ;

// 条件表达式，使用了递归和运算符优先级的方式来构建对应的语法树节点
Cond
    :   LOrExp {$$ = $1;}
    ;

// 或运算表达式
LOrExp
    :   LAndExp {
            $$ = $1;
        }
    |   LOrExp OR LAndExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::OR, $1, $3);
        }
    ;

// 与运算表达式
LAndExp
    :   EqExp {
            $$ = $1;
        }
    |   LAndExp AND EqExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::AND, $1, $3);
        }
    ;

// 相等判断表达式
EqExp
    :   RelExp {
            $$ = $1;
        }
    |   EqExp EQ RelExp {
            SymbolEntry* se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::EQ, $1, $3);
        }
    |   EqExp NEQ RelExp {
            SymbolEntry* se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::NEQ, $1, $3);
        }
    ;

// 关系表达式
RelExp
    :   AddExp {
            $$ = $1;
        }
    |   RelExp LESS AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::LESS, $1, $3);
        }
    |   RelExp LESSEQ AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::LESSEQ, $1, $3);
        }
    |   RelExp GREAT AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::GREAT, $1, $3);
        }
    |   RelExp GREATEQ AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::GREATEQ, $1, $3);
        }
    ;

// 类型，int，float，void
Type
    :   TYPE_INT {
            $$ = TypeSystem::intType;
            currentType = TypeSystem::intType;
        }
    |   TYPE_FLOAT {
            $$ = TypeSystem::floatType;
            currentType = TypeSystem::floatType;
        }
    |   TYPE_VOID {
            $$ = TypeSystem::voidType;
        }
    ;

// 数组的常量下标表示
ArrConstIndices 
    :   ArrConstIndices LBRACKET ConstExp RBRACKET {
            ExprStmtNode* node = (ExprStmtNode*)$1;
            node->addNext($3);
            $$ = node;          
        }
    |   LBRACKET ConstExp RBRACKET {
            ExprStmtNode* node = new ExprStmtNode();
            node->addNext($2);
            $$ = node;
        }
    ;

// 数组的变量下标表示
ArrValIndices 
    :   ArrValIndices LBRACKET Exp RBRACKET {
            ExprStmtNode* node = (ExprStmtNode*)$1;
            node->addNext($3);
            $$ = node;          
        }
    |   LBRACKET Exp RBRACKET {
            ExprStmtNode* node = new ExprStmtNode();
            node->addNext($2);
            $$ = node;
        }
    ;

// 声明语句
DeclStmt
    :   CONST Type ConstDefList SEMICOLON { //常量声明
            $$ = $3;
        }
    |   Type VarDefList SEMICOLON { //变量声明
            $$ = $2;
        }
    ;

// 常量定义列表
ConstDefList
    :   ConstDefList COMMA ConstDef {
            DeclStmt* node = (DeclStmt*) $1;
            node->addNext((DefNode*)$3);
            $$ = node;
        }
    |   ConstDef {
            DeclStmt* node = new DeclStmt(true);
            node->addNext((DefNode*)$1);
            $$ = node;
        }
    ;

// 常量定义
ConstDef
    :   ID ASSIGN ConstExp {
            Type* type;
            if(currentType->isInt()){
                type = TypeSystem::constIntType;
            }
            else{
                type = TypeSystem::constFloatType;
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            $$ = new DefNode(new Id(se), (Node*)$3, true, false);//类型向上转换
        }
    |   ID ArrConstIndices ASSIGN ConstInitVal{ 
            Type* type;
            if(currentType->isInt()){
                type = new ConstIntArrayType();
            }
            else{
                type = new ConstFloatArrayType();
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            Id* id = new Id(se);
            id->addIndices((ExprStmtNode*)$2);
            $$ = new DefNode(id, (Node*)$4, true, true);//类型向上转换
        }
    ;

// 常量的初始化值的可能形式
ConstInitVal
    :   ConstExp {
            InitValNode* newNode = new InitValNode(true);
            newNode->setLeafNode((ExprNode*)$1);
            $$ = newNode;
        }
    |   LBRACE ConstInitValList RBRACE{
            $$ = $2;
        }
    |   LBRACE RBRACE{
            $$ = new InitValNode(true);
    }
    ;

// 数组常量初始化列表
ConstInitValList
    :   ConstInitValList COMMA ConstInitVal{
            InitValNode* node = (InitValNode*)$1;
            node->addNext((InitValNode*)$3);
            $$ = node;
        }
    |   ConstInitVal{
            InitValNode* newNode = new InitValNode(true);
            newNode->addNext((InitValNode*)$1);
            $$ = newNode;
        }
    ;

// 变量定义列表
VarDefList
    :   VarDefList COMMA VarDef {   //多个用逗号分隔
            DeclStmt* node = (DeclStmt*) $1;
            node->addNext((DefNode*)$3);
            $$ = node;
        }
    |   VarDef {
            DeclStmt* node = new DeclStmt(true);
            node->addNext((DefNode*)$1);
            $$ = node;
        }
    ;

// 变量定义
VarDef
    :   ID {
            Type* type;
            if(currentType->isInt()){
                type = TypeSystem::intType;
            }
            else{
                type = TypeSystem::floatType;
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            $$ = new DefNode(new Id(se), nullptr, false, false);
        }
    |   ID ASSIGN Exp {
            Type* type;
            if(currentType->isInt()){
                type = TypeSystem::intType;
            }
            else{
                type = TypeSystem::floatType;
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            $$ = new DefNode(new Id(se), (Node*)$3, false, false);//类型向上转换
        }
    |   ID ArrConstIndices {
            Type* type;
            if(currentType->isInt()){
                type = new IntArrayType();
            }
            else{
                type = new FloatArrayType();
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            Id* id = new Id(se);
            id->addIndices((ExprStmtNode*)$2);
            $$ = new DefNode(id, nullptr, false, true);//类型向上转换
        }
    |   ID ArrConstIndices ASSIGN VarInitVal{
            Type* type;
            if(currentType->isInt()){
                type = new IntArrayType();
            }
            else{
                type = new FloatArrayType();
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            Id* id = new Id(se);
            id->addIndices((ExprStmtNode*)$2);
            $$ = new DefNode(id, (Node*)$4, false, true);//类型向上转换
        }
    ;

// 变量初始化值
VarInitVal
    :   Exp {
            InitValNode* node = new InitValNode(false);
            node->setLeafNode((ExprNode*)$1);
            $$ = node;
        }
    |   LBRACE VarInitValList RBRACE{   //数组变量初始化
            $$ = $2;
        }
    |   LBRACE RBRACE{
            $$ = new InitValNode(false);
    }
    ; 

// 数组变量初始化列表
VarInitValList
    :   VarInitValList COMMA VarInitVal{
            InitValNode* node = (InitValNode*)$1;
            node->addNext((InitValNode*)$3);
            $$ = node;
        }
    |   VarInitVal{
            InitValNode* newNode = new InitValNode(false);
            newNode->addNext((InitValNode*)$1);
            $$ = newNode;
        }
    ;

// 函数定义，函数名、参数列表和函数体
FuncDef
    :   Type ID {
            Type *funcType;
            funcType = new FunctionType($1,{});
            SymbolEntry *se = new IdentifierSymbolEntry(funcType, $2, identifiers->getLevel());
            identifiers->install($2, se);
            identifiers = new SymbolTable(identifiers);
        }
        LPAREN FuncParams{
            SymbolEntry *se;
            se = identifiers->lookup($2);
            assert(se != nullptr);
            if($5!=nullptr){
                //将函数参数类型写入符号表
                ((FunctionType*)(se->getType()))->setparamsType(((FuncDefParamsNode*)$5)->getParamsType());
            }   
        } 
        RPAREN BlockStmt {
            SymbolEntry *se;
            se = identifiers->lookup($2);
            assert(se != nullptr);
            $$ = new FunctionDef(se, (FuncDefParamsNode*)$5, $8);
            SymbolTable *top = identifiers;
            identifiers = identifiers->getPrev();
            delete top;
            delete []$2;
        }
    ;

// 函数参数列表
FuncParams
    :   FuncParams COMMA FuncParam {
            FuncDefParamsNode* node = (FuncDefParamsNode*)$1;
            node->addNext(((DefNode*)$3)->getId());
            $$ = node;
        }
    |   FuncParam {
            FuncDefParamsNode* node = new FuncDefParamsNode();
            node->addNext(((DefNode*)$1)->getId());
            $$ = node;
        }
    |   %empty {
            $$ = nullptr;
        }
    ;

// 函数参数，参数类型和参数名，数组类型的参数还包括数组的维度信息
FuncParam
    :   Type ID {
            SymbolEntry *se = new IdentifierSymbolEntry($1, $2, identifiers->getLevel());
            identifiers->install($2, se);
            $$ = new DefNode(new Id(se), nullptr, false, false);
        }
    //数组函数参数
    |   Type ID LBRACKET RBRACKET ArrConstIndices{
            if($1==TypeSystem::intType){
                Type* arrayType; 
                arrayType = new IntArrayType();
                ((IntArrayType*)arrayType)->pushBackDimension(-1);
                //最高维未指定，记为默认值-1
                SymbolEntry *se = new IdentifierSymbolEntry(arrayType, $2, identifiers->getLevel());
                identifiers->install($2, se);
                Id* id = new Id(se);
                id->addIndices((ExprStmtNode*)$5);
                $$ = new DefNode(id, nullptr, false, true);
            }
            else if($1==TypeSystem::floatType){
                Type* arrayType; 
                arrayType = new FloatArrayType();
                ((FloatArrayType*)arrayType)->pushBackDimension(-1);
                //最高维未指定，记为默认值-1
                SymbolEntry *se = new IdentifierSymbolEntry(arrayType, $2, identifiers->getLevel());
                identifiers->install($2, se);
                Id* id = new Id(se);
                id->addIndices((ExprStmtNode*)$5);
                $$ = new DefNode(id, nullptr, false, true);
            }
        }
    |   Type ID LBRACKET RBRACKET{
            if($1==TypeSystem::intType){
                Type* arrayType; 
                arrayType = new IntArrayType();
                ((IntArrayType*)arrayType)->pushBackDimension(-1);
                //最高维未指定，记为默认值-1
                SymbolEntry *se = new IdentifierSymbolEntry(arrayType, $2, identifiers->getLevel());
                identifiers->install($2, se);
                Id* id = new Id(se);
                $$ = new DefNode(id, nullptr, false, true);
            }
            else if($1==TypeSystem::floatType){
                Type* arrayType; 
                arrayType = new FloatArrayType();
                ((FloatArrayType*)arrayType)->pushBackDimension(-1);
                //最高维未指定，记为默认值-1
                SymbolEntry *se = new IdentifierSymbolEntry(arrayType, $2, identifiers->getLevel());
                identifiers->install($2, se);
                Id* id = new Id(se);
                $$ = new DefNode(id, nullptr, false, true);
            }
            
            
        }
    ;
    
%%

int yyerror(char const* message)
{
    std::cerr<<message<<std::endl;
    return -1;
}
