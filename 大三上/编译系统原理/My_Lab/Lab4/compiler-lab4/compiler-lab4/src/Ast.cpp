#include <iostream>
#include <string>
#include "Ast.h"
#include "SymbolTable.h"
#include "Type.h"

extern FILE *yyout;
int Node::counter = 0;

Node::Node()
{
    seq = counter++;     // 给每个新节点分配一个递增的序号，使用counter++实现
}

void Ast::output()
{
    fprintf(yyout, "program\n");
    if(root != nullptr)
        root->output(4);
}

Type* ExprNode::getType()   //表达式
{
    return symbolEntry->getType();// 返回该表达式节点关联的符号条目的类型
}

void BinaryExpr::output(int level)  //二元表达式
{
    std::string op_str;
    switch(op)
    {
        case ADD:
            op_str = "add";
            break;
        case SUB:
            op_str = "sub";
            break;
        case MUL:
            op_str = "mul";
            break;
        case DIV:
            op_str = "div";
            break;
        case MOD:
            op_str = "mod";
            break;
        case AND:
            op_str = "and";
            break;
        case OR:
            op_str = "or";
            break;
        case LESS:
            op_str = "less";
            break;
        case LESSEQ:
            op_str = "lesseq";
            break;
        case GREAT:
            op_str = "great";
            break;
        case GREATEQ:
            op_str = "greateq";
            break;
        case EQ:
            op_str = "eq";
            break;
        case NEQ:
            op_str = "neq";
            break;
    }
    fprintf(yyout, "%*cBinaryExpr\top: %s\ttype: %s\n", level, ' ', op_str.c_str(), symbolEntry->getType()->toStr().c_str());
    expr1->output(level + 4);
    expr2->output(level + 4);
}

void OneOpExpr::output(int level) { //一元表达式
    std::string op_str;
    switch (op) {
        case ADD:
            op_str = "uplus";
            break;
        case NOT:
            op_str = "not";
            break;
        case SUB:
            op_str = "uminus";
            break;
    }
    fprintf(yyout, "%*cOneOpExpr\top: %s\ttype: %s\n", level, ' ', op_str.c_str(), symbolEntry->getType()->toStr().c_str());
    expr->output(level + 4);
}

void Constant::output(int level)
{
    std::string type, value;
    type = symbolEntry->getType()->toStr();// 获取符号类型的字符串表示
    value = symbolEntry->toStr(); // 获取符号值的字符串表示
    fprintf(yyout, "%*cIntegerLiteral\tvalue: %s\ttype: %s\n", level, ' ',
            value.c_str(), type.c_str());
}

bool Id::isArray()// 检查标识符是否为数组类型
{
    return getType()->isArray();
}

void Id::output(int level)
{
    std::string name, type;
    int scope;
    name = symbolEntry->toStr();// 获取标识符的字符串表示
    type = symbolEntry->getType()->toStr(); // 获取标识符类型的字符串表示
    scope = dynamic_cast<IdentifierSymbolEntry*>(symbolEntry)->getScope();// 获取标识符的作用域
    fprintf(yyout, "%*cId\tname: %s\tscope: %d\ttype: %s\n", level, ' ',
            name.c_str(), scope, type.c_str());
    if(isArray() && indices!=nullptr){
        indices->output(level+4);  // 如果是数组类型且有索引，则输出索引信息
    }
}

void EmptyStmt::output(int level)//空语句
{
    fprintf(yyout, "%*cEmptyStmt\n", level, ' ');
}

void ExprStmtNode::addNext(ExprNode* next)//表达式语句节点
{
    exprList.push_back(next);
}

void ExprStmtNode::output(int level)
{
    fprintf(yyout, "%*cExprStmtNode\n", level, ' ');
    for(auto expr : exprList)
    {
        expr->output(level+4);
    }
}

void FuncCallNode::output(int level)    //函数调用节点
{
    std::string name, type;
    int scope;
    SymbolEntry* funcEntry = funcId->getSymbolEntry();
    name = funcEntry->toStr();
    type = funcEntry->getType()->toStr();
    scope = dynamic_cast<IdentifierSymbolEntry*>(funcEntry)->getScope();
    fprintf(yyout, "%*cFuncCallNode\tfuncName: %s\t funcType: %s\tscope: %d\n", 
            level, ' ', name.c_str(), type.c_str(), scope);
    if(params!=nullptr){
        params->output(level+4);
    }
    else{
        fprintf(yyout, "%*cFuncCallParamsNode NULL\n", level+4, ' ');
    }
}

void FuncCallParamsNode::addNext(ExprNode* next)//函数调用的参数列表节点
{
    paramsList.push_back(next);
}

void FuncCallParamsNode::output(int level)
{
    fprintf(yyout, "%*cFuncCallParamsNode\n", level, ' ');
    for(auto param : paramsList){
        param->output(level+4);
    }
}

void CompoundStmt::output(int level)//符合语句
{
    fprintf(yyout, "%*cCompoundStmt\n", level, ' ');
    if(stmt == nullptr){
        fprintf(yyout, "%*cNull Stmt\n", level+4, ' ');
    }
    else{
        stmt->output(level + 4);
    }
}

void SeqNode::addNext(StmtNode* next)//语句序列节点
{
    stmtList.push_back(next);
}

void SeqNode::output(int level)
{
    fprintf(yyout, "%*cSequence\n", level, ' ');
    for(auto stmt : stmtList)
    {
        stmt->output(level + 4);
    }
}

void DeclStmt::addNext(DefNode* next)//声明语句
{
    defList.push_back(next);
}

void DeclStmt::output(int level)
{
    fprintf(yyout, "%*cDeclStmt\n", level, ' ');
    for(auto def : defList){
        def->output(level+4);
    }
}

void DefNode::output(int level)//定义节点，输出相关标识符和初始值
{
    std::string constStr = isConst ? "true" : "false";//是否为常量
    std::string arrayStr = isArray ? "true" : "false";//是否为数组
    fprintf(yyout, "%*cDefNode\tisConst:%s\tisArray:%s\n", level, ' ', constStr.c_str(), arrayStr.c_str());
    id->output(level+4);
    if(initVal == nullptr){
        fprintf(yyout, "%*cnull\n", level+4, ' ');
    }
    else{
        initVal->output(level+4);
    }
}

void InitValNode::addNext(InitValNode* next)//初始化值
{
    innerList.push_back(next);
}

void InitValNode::output(int level)
{
    std::string constStr = isConst ? "true" : "false";
    fprintf(yyout, "%*cInitValNode\tisConst:%s\n", level, ' ', constStr.c_str());
    for(auto child : innerList)
    {
        child->output(level+4);
    }
    if(leafNode!=nullptr){
        leafNode->output(level+4);
    }
}

void InitValNode::setLeafNode(ExprNode* leaf)
{
    leafNode = leaf;
}

bool InitValNode::isLeaf()
{
    return innerList.empty();
}

void IfStmt::output(int level)
{
    fprintf(yyout, "%*cIfStmt\n", level, ' ');
    cond->output(level + 4);
    thenStmt->output(level + 4);
}

void IfElseStmt::output(int level)
{
    fprintf(yyout, "%*cIfElseStmt\n", level, ' ');
    cond->output(level + 4);
    thenStmt->output(level + 4);
    elseStmt->output(level + 4);
}

void WhileStmt::output(int level)
{
    fprintf(yyout, "%*cWhileStmt\n", level, ' ');
    cond->output(level+4);
    bodyStmt->output(level+4);
}

void BreakStmt::output(int level)
{
    fprintf(yyout, "%*cBreakStmt\n", level, ' ');
}

void ContinueStmt::output(int level)
{
    fprintf(yyout, "%*cContinueStmt\n", level, ' ');
}

void ReturnStmt::output(int level)
{
    fprintf(yyout, "%*cReturnStmt\n", level, ' ');
    if(retValue!=nullptr) retValue->output(level + 4);
}

void AssignStmt::output(int level)
{
    fprintf(yyout, "%*cAssignStmt\n", level, ' ');
    lval->output(level + 4);
    expr->output(level + 4);
}

void FuncDefParamsNode::addNext(Id* next)//函数参数列表节点
{
    paramsList.push_back(next);
}

std::vector<Type*> FuncDefParamsNode::getParamsType()//获取参数类型
{
    std::vector<Type*> typeArray;
    for(auto param : paramsList){
        typeArray.push_back(param->getType());
    }
    return typeArray;
}

void FuncDefParamsNode::output(int level)//输出函数参列表
{
    fprintf(yyout, "%*cFuncDefParamsNode\n", level, ' ');
    for(auto param : paramsList){
        param->output(level+4);
    }
}

void FunctionDef::output(int level)
{
    std::string name, type;
    name = se->toStr();
    type = se->getType()->toStr();
    fprintf(yyout, "%*cFunctionDefine function name: %s, type: %s\n", level, ' ', 
            name.c_str(), type.c_str());
    if(params!=nullptr){
        params->output(level+4);
    }
    else{
        fprintf(yyout, "%*cFuncDefParamsNode NULL\n", level+4, ' ');
    }
    stmt->output(level + 4);
}
