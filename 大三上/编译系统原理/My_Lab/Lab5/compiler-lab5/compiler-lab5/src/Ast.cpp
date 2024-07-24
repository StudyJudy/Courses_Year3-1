// 负责输出语法树
// 编写输出output函数
#include "Ast.h"
#include "SymbolTable.h"
#include "Unit.h"
#include "Instruction.h"
#include "IRBuilder.h"
#include <string>
#include "Type.h"
#include <assert.h>

extern FILE *yyout;
int Node::counter = 0;
IRBuilder *Node::builder = nullptr;

bool in_func = 0;

SymbolEntry *se_const0 = new ConstantSymbolEntry(TypeSystem::intType, 0);
ExprNode *temp_const0 = new Constant(se_const0);
Operand *src0_const0 = temp_const0->getOperand();

std::vector<Instruction *> global;

Node::Node()// 初始化结点的序列号和下一个结点指针
{
    seq = counter++;
    // 初始化为空
    next = nullptr;
}

void Node::setNext(Node *node)// 将一个结点添加到结点链表末尾
{
    Node *temp = this;
    // 找到结点链表串的最后一个结点
    while (temp->getNext())
    {
        temp = temp->getNext();
    }
    temp->next = node;
}

Node *Node::getNext()// 获取下一个结点
{
    return next;
}

// 回填函数，在跳转语句生成后，将跳转目标地址回填到跳转指令中
void Node::backPatch(std::vector<Instruction *> &list, BasicBlock *bb, bool branch)
{
    // 判断是处理条件跳转的 true 分支还是 false 分支
    if (branch)
        for (auto &inst : list)
        {
            // 如果是条件跳转指令，将其真实分支设置为参数提供的基本块
            // 如果是无条件跳转指令，将其跳转目标设置为参数提供的基本块
            if (inst->isCond())
                dynamic_cast<CondBrInstruction *>(inst)->setTrueBranch(bb);
            else if (inst->isUncond())
                dynamic_cast<UncondBrInstruction *>(inst)->setBranch(bb);
        }
    else
        for (auto &inst : list)
        {
            // 如果是条件跳转指令，将其假分支设置为参数提供的基本块
            // 如果是无条件跳转指令，将其跳转目标设置为参数提供的基本块
            if (inst->isCond())
                dynamic_cast<CondBrInstruction *>(inst)->setFalseBranch(bb);
            else if (inst->isUncond())
                dynamic_cast<UncondBrInstruction *>(inst)->setBranch(bb);
        }
}

// 合并两个指令向量
std::vector<Instruction *> Node::merge(std::vector<Instruction *> &list1, std::vector<Instruction *> &list2)
{
    std::vector<Instruction *> res(list1);
    res.insert(res.end(), list2.begin(), list2.end());
    return res;
}

// 根节点开始的中间代码生成函数
// 初始化IRBuilder，并调用根结点的genCode()
void Ast::genCode(Unit *unit)
{
    fprintf(stderr, "Ast::genCode\n");
    //用于生成中间代码
    IRBuilder *builder = new IRBuilder(unit);
    // Node类的IRBuilder指针为当前创建builder对象
    Node::setIRBuilder(builder);
    // 生成根节点的中间代码
    root->genCode();

    // 声明链接库
    fprintf(yyout, "declare i32 @getint()\n");
    fprintf(yyout, "declare void @putint(i32)\n");
    fprintf(yyout, "declare i32 @getch()\n");
    fprintf(yyout, "declare void @putch(i32)\n");
    fprintf(yyout, "declare void @putf(i32)\n\n");

    // 输出全局指令
    int s = global.size();
    for (int i = 0; i < s; i++)
    {
        // 输出全局指令的中间代码
        global[i]->output();
    }
}

//  函数定义中间代码生成函数
//生成函数的入口块、参数中间代码和函数体中间代码、进行流图构造
void FunctionDef::genCode()
{
    fprintf(stderr, "FunctionDef::genCode\n");
    // 获取当前函数的单元（IRBuilder）
    Unit *unit = builder->getUnit();
    // 创建一个新的函数对象，使用函数的符号表项（SymbolEntry）和当前单元
    Function *func = new Function(unit, se);
    // 获取函数的入口基本块
    BasicBlock *entry = func->getEntry();

    // 设置当前的插入基本块为函数的入口基本块
    builder->setInsertBB(entry);

    // 函数参数中间代码生成
    if (FuncDefParams)
        FuncDefParams->genCode();

    // 函数体中间代码生成
    if (stmt)
        stmt->genCode();

    // 根据基本块的前驱、后继关系进行流图的构造
    for (auto block = func->begin(); block != func->end(); block++)
    {
        // 获取该块的第一条和最后一条指令
        Instruction *i = (*block)->begin();
        Instruction *last = (*block)->rbegin();

        // 遍历块中的指令，移除块中的跳转指令
        while (i != last)
        {
            if (i->isCond() || i->isUncond())
            {
                // 移除块中跳转指令
                (*block)->remove(i);
            }
            i = i->getNext();
        }

        // 处理有条件跳转
        if (last->isCond())
        {
            BasicBlock *truebranch, *falsebranch;
            // 获取有条件跳转的真分支和假分支
            truebranch = dynamic_cast<CondBrInstruction *>(last)->getTrueBranch();
            falsebranch = dynamic_cast<CondBrInstruction *>(last)->getFalseBranch();
            
            // 处理空块
            if (truebranch->empty())
            {
                // 在真分支上生成返回指令
                new RetInstruction(nullptr, truebranch);
            }
            else if (falsebranch->empty())
            {
                // 在假分支上生成返回指令
                new RetInstruction(nullptr, falsebranch);
            }
            // 更新前驱和后继关系
            (*block)->addSucc(truebranch);
            (*block)->addSucc(falsebranch);
            truebranch->addPred(*block);
            falsebranch->addPred(*block);
        }
        // 处理无条件跳转
        else if (last->isUncond())
        {
            // 获取要跳转的基本块
            BasicBlock *dst = dynamic_cast<UncondBrInstruction *>(last)->getBranch();

            // 更新前驱和后继关系
            (*block)->addSucc(dst);
            dst->addPred(*block);

            // 处理空块
            if (dst->empty())
            {
                // 根据函数的返回类型生成相应的返回指令
                if (((FunctionType *)(se->getType()))->getRetType() == TypeSystem::intType)
                    new RetInstruction(new Operand(new ConstantSymbolEntry(TypeSystem::intType, 0)), dst);
                else if (((FunctionType *)(se->getType()))->getRetType() == TypeSystem::voidType)
                    new RetInstruction(nullptr, dst);
            }
        }
        // 处理最后一条语句不是返回以及跳转
        else if (!last->isRet())
        {
            // 如果函数的返回类型为 void，则在当前块上生成返回指令
            if (((FunctionType *)(se->getType()))->getRetType() == TypeSystem::voidType)
            {
                new RetInstruction(nullptr, *block);
            }
        }
    }
}

// 函数调用中间代码生成函数
// 生成函数调用指令
void FuncCallExpr::genCode()
{
    fprintf(stderr, "FuncCallExpr::genCode\n");
    // 用于存储函数调用的参数
    std::vector<Operand *> operands;

    // 遍历参数表达式列表，生成参数的中间代码
    ExprNode *temp = param;
    while (temp)
    {
        // 参数中间代码生成
        temp->genCode();
        operands.push_back(temp->getOperand());
        temp = ((ExprNode *)temp->getNext());
    }
    // 获取当前插入基本块
    BasicBlock *bb = builder->getInsertBB();

    // 生成函数调用的中间代码
    new CallInstruction(dst, symbolEntry, operands, bb);
}

// 二元运算表达式中间代码生成函数
// 根据运算符类型生成相应的中间代码
// 逻辑运算、比较运算、算术运算
void BinaryExpr::genCode()
{
    fprintf(stderr, "BinaryExpr::genCode\n");
    // 获取当前插入基本块
    BasicBlock *bb = builder->getInsertBB();

    // 获取当前所处的函数
    Function *func = bb->getParent();

    if (op == AND)
    {
        // 生成第一个表达式的中间代码
        expr1->genCode();

        // 如果第一个表达式的结果为空，报错
        if (expr1->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr1->getOperand() != nullptr);
        }

        // 获取当前基本块的最后一条指令
        Instruction *test = bb->rbegin();

        // 考虑 if(2 && 3)，第一个表达式为算术表达式
        if (!test->isCond() && !test->isUncond())
        {
            int opcode = CmpInstruction::NE;
            Operand *src1 = expr1->getOperand();
            Operand *src2 = src0_const0;

            // 目的寄存器
            SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            Operand *dst = new Operand(tse);
            Operand *n1 = src1;

            // bool 转 int 的类型转换
            if (src1->getType() == TypeSystem::boolType)
            {
                SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
                n1 = new Operand(s);
                new ZextInstruction(n1, src1, bb); // 零拓展
            }

            // 跟 0 比较，判断表达式真假
            new CmpInstruction(opcode, dst, n1, src2, bb);
            Instruction *temp = new CondBrInstruction(nullptr, nullptr, dst, bb);

            // trueList 和 falseList 均为目标地址未确定的跳转指令的向量
            expr1->trueList().push_back(temp);
            expr1->falseList().push_back(temp);
        }

         // 新建一个基本块 trueBB，如果第一个表达式的结果为真，那么跳到这个基本块
        BasicBlock *trueBB = new BasicBlock(func);

        // 将 trueList 中的跳转指令回填到 trueBB
        backPatch(expr1->trueList(), trueBB, true);

        // 设置当前的新的指令（第二个表达式对应的指令）要插入到的基本块为 trueBB
        builder->setInsertBB(trueBB);

        // trueBB 与当前基本块连接
        trueBB->addPred(bb);
        bb->addSucc(trueBB);

        // 生成第二个表达式的中间代码
        expr2->genCode();

        // 如果第二个表达式的结果为空，报错
        if (expr2->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr2->getOperand() != nullptr);
        }

        // 更新当前基本块
        bb = builder->getInsertBB();
        test = bb->rbegin();

        if (!test->isCond() && !test->isUncond())
        {
            int opcode = CmpInstruction::NE;
            Operand *src1 = expr2->getOperand();
            Operand *src2 = src0_const0;

            // 目的寄存器
            SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            Operand *dst = new Operand(tse);
            Operand *n1 = src1;

            if (src1->getType() == TypeSystem::boolType)
            {
                SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
                n1 = new Operand(s);
                new ZextInstruction(n1, src1, bb);
            }

            // 跟 0 比较，判断表达式真假
            new CmpInstruction(opcode, dst, n1, src2, bb);
            Instruction *temp = new CondBrInstruction(nullptr, nullptr, dst, bb);

            expr2->trueList().push_back(temp);
            expr2->falseList().push_back(temp);
        }

        // true_list 为 expr2 的 trueList，false_list 为 expr1 的 falseList 与 expr2 的 falseList 合并后的结果
        true_list = expr2->trueList();
        false_list = merge(expr1->falseList(), expr2->falseList());
    }
    else if (op == OR)
    {
         // 生成第一个表达式的中间代码
        expr1->genCode();

        // 如果第一个表达式的结果为空，报错
        if (expr1->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr1->getOperand() != nullptr);
        }

        // 获取当前基本块的最后一条指令
        Instruction *test = bb->rbegin();

        if (!test->isCond() && !test->isUncond())
        {
            int opcode = CmpInstruction::NE;
            Operand *src1 = expr1->getOperand();
            Operand *src2 = src0_const0;

            // 目的寄存器
            SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            Operand *dst = new Operand(tse);
            Operand *n1 = src1;

            if (src1->getType() == TypeSystem::boolType)
            {
                SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
                n1 = new Operand(s);
                new ZextInstruction(n1, src1, bb); // 零拓展
            }
            //比较
            new CmpInstruction(opcode, dst, n1, src2, bb);

            //条件跳转
            Instruction *temp = new CondBrInstruction(nullptr, nullptr, dst, bb); // 条件跳转
            expr1->trueList().push_back(temp);
            expr1->falseList().push_back(temp);
        }

        // 新建一个基本块 ntrueBB，如果第一个表达式的结果为假，那么跳到这个基本块
        BasicBlock *ntrueBB = new BasicBlock(func);

        // 与 AND 逻辑区别，将 falseList 中的跳转指令回填到 ntrueBB
        backPatch(expr1->falseList(), ntrueBB, false);

        // 设置当前的新的指令（第二个表达式对应的指令）要插入到的基本块为 ntrueBB
        builder->setInsertBB(ntrueBB);

        // ntrueBB 与当前基本块连接
        ntrueBB->addPred(bb);
        bb->addSucc(ntrueBB);

        // 生成第二个表达式的中间代码
        expr2->genCode();

        // 如果第二个表达式的结果为空，报错
        if (expr2->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr2->getOperand() != nullptr);
        }

        // 更新当前基本块
        bb = builder->getInsertBB();
        test = bb->rbegin();

        if (!test->isCond() && !test->isUncond())
        {
            int opcode = CmpInstruction::NE;
            Operand *src1 = expr2->getOperand();
            Operand *src2 = src0_const0;

            // 目的寄存器
            SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            Operand *dst = new Operand(tse);
            Operand *n1 = src1;

            if (src1->getType() == TypeSystem::boolType)
            {
                SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
                n1 = new Operand(s);
                new ZextInstruction(n1, src1, bb);
            }

            // 比较
            new CmpInstruction(opcode, dst, n1, src2, bb);
            Instruction *temp = new CondBrInstruction(nullptr, nullptr, dst, bb);
            expr2->trueList().push_back(temp);
            expr2->falseList().push_back(temp);
        }

        // 与 AND 逻辑区别，true_list 为 expr1 的 trueList 与 expr2 的 trueList 合并后的结果，false_list 为 expr2 的 falseList
        false_list = expr2->falseList();
        true_list = merge(expr1->trueList(), expr2->trueList());
    }
    else if (op >= LESS && op <= NE) // LESS, MORE, LEQ, MEQ, EQ, NE
    {
        // 生成两个表达式的中间代码
        expr1->genCode();
        expr2->genCode();

        // 类型检查
        if (expr1->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr1->getOperand() != nullptr);
        }
        if (expr2->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr2->getOperand() != nullptr);
        }

        // 通过 getOperand 函数得到子表达式的目的操作数
        Operand *src1 = expr1->getOperand();
        Operand *src2 = expr2->getOperand();

        int opcode = -1;
        switch (op)
        {
        case LESS:
            opcode = CmpInstruction::L;
            break;
        case MORE:
            opcode = CmpInstruction::G;
            break;
        case LEQ:
            opcode = CmpInstruction::LE;
            break;
        case MEQ:
            opcode = CmpInstruction::GE;
            break;
        case EQ:
            opcode = CmpInstruction::E;
            break;
        case NE:
            opcode = CmpInstruction::NE;
            break;
        }

        Operand *n1 = src1, *n2 = src2;
        // bool -> int 隐式类型转换
        if (src1->getType() == TypeSystem::boolType)
        {
            SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            n1 = new Operand(s);
            new ZextInstruction(n1, src1, bb);
        }
        if (src2->getType() == TypeSystem::boolType)
        {
            SymbolEntry *s2 = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            n2 = new Operand(s2);
            new ZextInstruction(n2, src2, bb);
        }

        // 目的寄存器
        SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
        dst = new Operand(tse);

        // 生成比较指令
        new CmpInstruction(opcode, dst, n1, n2, bb);
    }
    else if (op >= ADD && op <= MOD)
    {
        // 生成两个表达式的中间代码
        expr1->genCode();
        expr2->genCode();

        // 如果第一个表达式的结果为空，报错
        if (expr1->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr1->getOperand() != nullptr);
        }
        if (expr2->getOperand() == nullptr)
        {
            fprintf(stderr, "BinaryExpr can't be void type\n");
            assert(expr2->getOperand() != nullptr);
        }
         // 获取左右操作数的中间代码生成结果
        Operand *src1 = expr1->getOperand();
        Operand *src2 = expr2->getOperand();
    
        // 根据运算符类型确定相应的中间代码操作
        int opcode = 0;
        switch (op)
        {
            case ADD:
                opcode = BinaryInstruction::ADD;
                break;
            case SUB:
                opcode = BinaryInstruction::SUB;
                break;
            case MUL:
                opcode = BinaryInstruction::MUL;
                break;
            case DIV:
                opcode = BinaryInstruction::DIV;
                break;
            case MOD:
                opcode = BinaryInstruction::MOD;
                break;
        }

        Operand *n1 = src1, *n2 = src2;
        // 如果操作数类型为 bool，进行隐式类型转换
        if (src1->getType() == TypeSystem::boolType)
        {
            SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            n1 = new Operand(s);
            new ZextInstruction(n1, src1, bb);
        }
        if (src2->getType() == TypeSystem::boolType)
        {
            SymbolEntry *s2 = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            n2 = new Operand(s2);
            new ZextInstruction(n2, src2, bb);
        }
        // 生成二元运算指令的中间代码
        new BinaryInstruction(opcode, dst, src1, src2, bb);
    }
}

// 一元运算表达式代码生成
void UnaryExpr::genCode()
{
    fprintf(stderr, "UnaryExpr::genCode\n");
    // 生成子表达式的中间代码
    expr->genCode();
    
    // 检查子表达式的结果是否为 void 类型
    if (expr->getOperand() == nullptr)
    {
        fprintf(stderr, "UnaryExpr can't be void type\n");
        assert(expr->getOperand() != nullptr);
    }
    
    BasicBlock *bb = builder->getInsertBB();
    Operand *src = expr->getOperand();
    int opcode;

    if (op == ADD || op == SUB)
    {
        // 处理一元加法和减法
        switch (op)
        {
        case ADD:
            opcode = UnaryInstruction::ADD;
            break;
        case SUB:
            opcode = UnaryInstruction::SUB;
            break;
        }

        dst = new Operand(symbolEntry);
        Operand *n = src;

        // bool -> int 隐式类型转换
        if (src->getType() == TypeSystem::boolType)
        {
            SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            n = new Operand(s);
            new ZextInstruction(n, src, bb);
        }
        
        // 生成一元运算指令的中间代码
        new UnaryInstruction(opcode, dst, n, bb);
    }
    else if (op == NOT)
    {
        // 处理逻辑非运算
        if (expr->getOperand()->getType() == TypeSystem::intType)
        {
            opcode = CmpInstruction::E;
            Operand *src = expr->getOperand();
            Operand *src0 = src0_const0;
            SymbolEntry *s = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            Operand *n = new Operand(s);

            // 隐式类型转换
            if (dst->getType() != src->getType())
                new ZextInstruction(n, dst, bb);
            // 生成比较指令的中间代码
            new CmpInstruction(opcode, this->dst, src, src0, bb);
        }
        // 处理逻辑非运算（等价于与 true 异或运算）
        else if (expr->getOperand()->getType() == TypeSystem::boolType)
        {
            // 生成逻辑非指令的中间代码
            new NotInstruction(this->dst, src, bb);
        }
        fprintf(stderr, "出去NOT\n");
    }
}

void Constant::genCode()
{
    // 表示常量节点，不需要生成中间代码
}

// ID中间代码生成（加载值）
void Id::genCode() //根据标识符的类型生成加载指令的中间代码
{
     fprintf(stderr, "Id::genCode\n");
    BasicBlock *bb = builder->getInsertBB();
    // 获取标识符的地址
    Operand *addr = dynamic_cast<IdentifierSymbolEntry *>(symbolEntry)->getAddr();
    fprintf(stderr, "%s\n", this->getSymPtr()->toStr().c_str());
    
    if (this->getSymPtr()->getType()->isInt())
    {
        // 生成加载指令的中间代码
        new LoadInstruction(dst, addr, bb);
    }
}

// if(cond)
//    then
// end
void IfStmt::genCode()
{
    fprintf(stderr, "IfStmt::genCode\n");
    Function *func;
    BasicBlock *then_bb, *end_bb;

    // 获取当前函数和新建基本块
    func = builder->getInsertBB()->getParent();
    then_bb = new BasicBlock(func);
    end_bb = new BasicBlock(func);

    // 生成条件表达式的中间代码
    cond->genCode();

    // 获取当前基本块
    BasicBlock *bb = builder->getInsertBB();
    Instruction *test = bb->rbegin();

    // 如果当前基本块的最后一条指令不是条件或无条件跳转指令
    if (!test->isCond() && !test->isUncond())
    {
        Operand *src1 = cond->getOperand();
        Operand *n = src1;

        // int 类型需要与 0 比较并保存为 bool 类型
        if (src1->getType() == TypeSystem::intType)
        {
            int opcode = CmpInstruction::NE;
            Operand *src2 = src0_const0;
            SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            Operand *dst = new Operand(tse);
            new CmpInstruction(opcode, dst, n, src2, bb);
            n = dst;
        }

        // 生成条件跳转指令的中间代码
        Instruction *temp = new CondBrInstruction(nullptr, nullptr, n, bb);
        cond->trueList().push_back(temp);
        cond->falseList().push_back(temp);
    }

    // 回填
    backPatch(cond->trueList(), then_bb, true);
    backPatch(cond->falseList(), end_bb, false);

    // 设置新基本块插入点并生成 then 语句的中间代码
    builder->setInsertBB(then_bb);
    if (thenStmt != nullptr)
        thenStmt->genCode();

    // 获取生成的 then 语句的基本块
    then_bb = builder->getInsertBB();
    // 生成无条件跳转指令的中间代码
    new UncondBrInstruction(end_bb, then_bb);

    // 设置插入点为 end_bb
    builder->setInsertBB(end_bb);
}

void IfElseStmt::genCode()
{
    fprintf(stderr, "IfElseStmt::genCode\n");
    Function *func;
    BasicBlock *then_bb, *else_bb, *end_bb;
    
    // 获取当前函数和新建基本块
    func = builder->getInsertBB()->getParent();
    then_bb = new BasicBlock(func);
    else_bb = new BasicBlock(func);
    end_bb = new BasicBlock(func);

    // 生成条件表达式的中间代码
    cond->genCode();

    // 获取当前基本块
    BasicBlock *bb = builder->getInsertBB();
    Instruction *test = bb->rbegin();

    // 如果当前基本块的最后一条指令不是条件或无条件跳转指令
    if (!test->isCond() && !test->isUncond())
    {
        Operand *src1 = cond->getOperand();
        Operand *n = src1;

        // int 类型需要与 0 比较并保存为 bool 类型
        if (src1->getType() == TypeSystem::intType)
        {
            int opcode = CmpInstruction::NE;
            Operand *src2 = src0_const0;
            SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            Operand *dst = new Operand(tse);
            new CmpInstruction(opcode, dst, src1, src2, bb);
            n = dst;
        }

        // 生成条件跳转指令的中间代码
        Instruction *temp = new CondBrInstruction(nullptr, nullptr, n, bb);
        cond->trueList().push_back(temp);
        cond->falseList().push_back(temp);
    }

    // 回填
    backPatch(cond->trueList(), then_bb, true);
    backPatch(cond->falseList(), else_bb, false);

    // 设置新基本块插入点并生成 then 语句的中间代码
    builder->setInsertBB(then_bb);
    if (thenStmt != nullptr)
        thenStmt->genCode();

    // 获取生成的 then 语句的基本块
    then_bb = builder->getInsertBB();
    // 生成无条件跳转指令的中间代码
    new UncondBrInstruction(end_bb, then_bb);

    // 设置新基本块插入点并生成 else 语句的中间代码
    builder->setInsertBB(else_bb);
    if (elseStmt != nullptr)
        elseStmt->genCode();

    // 获取生成的 else 语句的基本块
    else_bb = builder->getInsertBB();
    // 生成无条件跳转指令的中间代码
    new UncondBrInstruction(end_bb, else_bb);

    // 设置插入点为 end_bb
    builder->setInsertBB(end_bb);
}

// while(cond)
//     loop_bb
// end_bb
void WhileStmt::genCode()
{
    fprintf(stderr, "WhileStmt::genCode\n");
    Function *func;
    BasicBlock *cond_bb, *loop_bb, *end_bb, *bb;

    // 获取当前基本块所属的函数
    bb = builder->getInsertBB();
    func = bb->getParent();
    
    // 新建基本块
    cond_bb = new BasicBlock(func);
    loop_bb = new BasicBlock(func);
    end_bb = new BasicBlock(func);

    // 将当前基本块添加为 cond_bb 的前驱，cond_bb 添加为当前基本块的后继
    bb->addSucc(cond_bb);
    cond_bb->addPred(bb);

    // 设置基本块插入点并生成条件表达式的中间代码
    builder->setInsertBB(cond_bb);
    cond->genCode();
    // 生成无条件跳转指令的中间代码
    new UncondBrInstruction(cond_bb, bb);

    // 获取当前基本块
    bb = builder->getInsertBB();
    Instruction *test = bb->rbegin();

    // 如果当前基本块的最后一条指令不是条件或无条件跳转指令
    if (!test->isCond() && !test->isUncond())
    {
        Operand *src1 = cond->getOperand();
        Operand *n = src1;

        // int 类型需要与 0 比较并保存为 bool 类型
        if (src1->getType() == TypeSystem::intType)
        {
            int opcode = CmpInstruction::NE;
            Operand *src2 = src0_const0;
            SymbolEntry *tse = new TemporarySymbolEntry(TypeSystem::boolType, SymbolTable::getLabel());
            Operand *dst = new Operand(tse);
            new CmpInstruction(opcode, dst, src1, src2, bb);
            n = dst;
        }

        // 生成条件跳转指令的中间代码
        Instruction *temp = new CondBrInstruction(nullptr, nullptr, n, bb);
        cond->trueList().push_back(temp);
        cond->falseList().push_back(temp);
    }

    // 回填
    backPatch(cond->trueList(), loop_bb, true);
    backPatch(cond->falseList(), end_bb, false);
    bb = builder->getInsertBB();

    // 设置新基本块插入点并生成循环体的中间代码
    builder->setInsertBB(loop_bb);
    if (stmt != nullptr)
        stmt->genCode();
    
    // 获取生成的循环体的基本块
    loop_bb = builder->getInsertBB();
    // 生成无条件跳转指令的中间代码
    new UncondBrInstruction(cond_bb, loop_bb);

    // 设置插入点为 end_bb
    builder->setInsertBB(end_bb);
}

void CompoundStmt::genCode()
{
    fprintf(stderr, "CompoundStmt::genCode\n");
    stmt->genCode();
}

void SeqNode::genCode()
{
    fprintf(stderr, "SeqNode::genCode\n");
    stmt1->genCode();
    if (stmt2 != nullptr)
        stmt2->genCode();
}

// 函数参数/变量声明
void DeclStmt::genCode()
{
    fprintf(stderr, "DeclStmt::genCode\n");
    IdentifierSymbolEntry *se = dynamic_cast<IdentifierSymbolEntry *>(id->getSymPtr());
    // 全局变量
    if (se->isGlobal())
    {
        Operand *addr;
        SymbolEntry *addr_se;
        addr_se = new IdentifierSymbolEntry(*se); // 地址
        addr_se->setType(new PointerType(se->getType()));
        addr = new Operand(addr_se);
        se->setAddr(addr);
        Instruction *g;
        if (expr != nullptr)
        {
            expr->genCode();
            g = new GlobalInstruction(new Operand(id->getSymPtr()), expr->getOperand(), se);
        }
        else
        {
            g = new GlobalInstruction(new Operand(id->getSymPtr()), nullptr, se);
        }
        global.push_back(g);
    }
    else if (se->isLocal() || se->isParam())
    {
        Function *func = builder->getInsertBB()->getParent();
        BasicBlock *entry = func->getEntry();
        Instruction *alloca;
        Operand *addr;
        SymbolEntry *addr_se;
        Type *type;
        type = new PointerType(se->getType());
        addr_se = new TemporarySymbolEntry(type, SymbolTable::getLabel());
        addr = new Operand(addr_se);
        alloca = new AllocaInstruction(addr, se); // allocate space for local id in function stack.
        entry->insertFront(alloca);               // allocate instructions should be inserted into the begin of the entry block.
        se->setAddr(addr);                        // set the addr operand in symbol entry so that we can use it in subsequent code generation.

        if (se->isParam())
        {
            // fprintf(stderr, "sdsdsdsdsdsds\n");
            // store参数的值到刚刚分配的空间中
            type = se->getType();
            SymbolEntry *s = new TemporarySymbolEntry(type, SymbolTable::getLabel());
            Operand *src = new Operand(s);
            BasicBlock *bb = builder->getInsertBB();
            new StoreInstruction(addr, src, bb);
            func->pushParamsOperand(src);
        }

        if (expr != nullptr)
        {
            expr->genCode();
            BasicBlock *bb = builder->getInsertBB();
            Operand *src = expr->getOperand();
            new StoreInstruction(addr, src, bb);
        }
    }
    // 串接后续函数参数/变量声明
    if (this->getNext())
    {
        this->getNext()->genCode();
    }
}

void ReturnStmt::genCode()
{
    fprintf(stderr, "ReturnStmt::genCode\n");
    Operand *src = nullptr;
    if (retValue != nullptr)
    {
        retValue->genCode();
        src = retValue->getOperand();
    }
    new RetInstruction(src, builder->getInsertBB());
}

void AssignStmt::genCode()
{
    fprintf(stderr, "AssignStmt::genCode\n");
    BasicBlock *bb = builder->getInsertBB();
    expr->genCode();
    Operand *addr = dynamic_cast<IdentifierSymbolEntry *>(lval->getSymPtr())->getAddr();
    Operand *src = expr->getOperand();
    /***
     * We haven't implemented array yet, the lval can only be ID. So we just store the result of the `expr` to the addr of the id.
     * If you want to implement array, you have to caculate the address first and then store the result into it.
     */
    new StoreInstruction(addr, src, bb);
}

// 最顶层是根节点的类型检查
void Ast::typeCheck()
{
    if (root != nullptr)
        root->typeCheck();
}

/*---以下是语句节点类----*/
// 复合语句
void CompoundStmt::typeCheck()
{
    if (stmt)
        stmt->typeCheck();
}
// 序列语句
void SeqNode::typeCheck()
{
    if (stmt1)
        stmt1->typeCheck();
    if (stmt2)
        stmt2->typeCheck();
}
// 表达式语句
void ExprStmt::typeCheck()
{
    if (expr)
        expr->typeCheck();
}
// if语句
void IfStmt::typeCheck()
{
    cond->typeCheck();
    if (thenStmt)
        thenStmt->typeCheck();
}
// if-else语句
void IfElseStmt::typeCheck()
{
    cond->typeCheck();
    // if-else结构体中可能有的没有
    if (thenStmt)
        thenStmt->typeCheck();
    if (elseStmt)
        elseStmt->typeCheck();
}
// while语句
void WhileStmt::typeCheck()
{
    cond->typeCheck();
    if (stmt)
        stmt->typeCheck();
}
void EmptyStmt::typeCheck()
{
}
// Break
void BreakStmt::typeCheck()
{
}
// Continue
void ContinueStmt::typeCheck()
{
}
// 变量声明语句
void DeclStmt::typeCheck()
{
    id->typeCheck();
    if (expr)
        expr->typeCheck();
}
// 返回语句
void ReturnStmt::typeCheck()
{
    if (retValue)
        retValue->typeCheck();
}
// 赋值语句
void AssignStmt::typeCheck()
{
    lval->typeCheck();
    expr->typeCheck();
}
// 函数定义语句
void FunctionDef::typeCheck()
{
    // 获取返回值类型
    Type *retType = ((FunctionType *)(se->getType()))->getRetType();
    // 调用checkRet函数，归到ReturnStmt类主要实现
    if (!stmt->checkRet(retType))
    {
        fprintf(stderr, "function has no return statement function type doesn't match return type\n");
        assert(stmt->checkRet(retType));
    }
}
// 实现checkRet函数的主要的判断,判断return 语句操作数和函数声明的返回值类型是否匹配
bool ReturnStmt::checkRet(Type *retType)
{
    // 先判断没有返回值的情况
    if (!retValue)
    {
        // 返回值类型为void，则正确，否则均有类型错误
        if (retType != TypeSystem::voidType)
        {
            fprintf(stderr, "function has no return statement or function type doesn't match return type\n");
            assert(retType == TypeSystem::voidType);
            return false;
        }
        else
        {
            return true;
        }
    }
    else
    {
        // 获取返回值类型
        Type *valueType = retValue->getSymPtr()->getType();
        // fprintf(stderr, "aaaaaaaa%s,%s\n", valueType->toStr().c_str(), retType->toStr().c_str());
        //  考虑constINT和INT两种类型的兼融
        if ((retType == TypeSystem::constIntType || retType == TypeSystem::intType) &&
            (valueType == TypeSystem::constIntType || valueType == TypeSystem::intType))
        {
            return true;
        }
        else
        {
            if (valueType->isFunc() && ((FunctionType *)valueType)->getRetType() == TypeSystem::intType)
            {
                return true;
            }
            // fprintf(stderr, "aaaaaaaa%s,%s\n", valueType->toStr().c_str(), retType->toStr().c_str());
            fprintf(stderr, "function type doesn't match return type\n");
            return false;
        }
    }
}
/*---以下是表达式节点类----*/
// 常量
void Constant::typeCheck()
{
}
// 标识符
void Id::typeCheck()
{
}
// 二元表达式的类型检查
void BinaryExpr::typeCheck()
{
    expr1->typeCheck();
    expr2->typeCheck();
}
// 一元表达式的类型检查
void UnaryExpr::typeCheck()
{
    expr->typeCheck();
}
void FuncCallExpr::typeCheck()
{
}
// 函数调用表达式，判断函数调用时形参及实参类型或数目是否一致
// 涉及到非重载函数的重复声明的判断，因此把构造函数挪到这边，需要考虑重载函数，用next链接
FuncCallExpr::FuncCallExpr(SymbolEntry *se, ExprNode *param)
    : ExprNode(se), param(param)
{
    dst = nullptr;
    // 实参计数
    int actualParamCount = 0;
    ExprNode *temp1 = param;
    while (temp1)
    {
        actualParamCount++;
        temp1 = (ExprNode *)(temp1->getNext());
    }
    SymbolEntry *temp2 = se;
    // 遍历同名的函数列表（考虑同名重载函数）
    while (temp2)
    {
        // 获取声明的参数列表
        std::vector<Type *> params = ((FunctionType *)temp2->getType())->getParamsType();
        // 比较实参和形参的参数数目,尝试找到正确的函数对应的符号表项
        if ((long unsigned int)actualParamCount == params.size())
        {
            // 设置该函数名对应的符号表项
            this->symbolEntry = temp2;
            break;
        }
        // 这边给符号表项都加了一个next成员变量,专用于处理同名函数
        temp2 = temp2->getNext();
    }
    if (symbolEntry)
    {
        // 获取返回值的类型
        this->type = ((FunctionType *)symbolEntry->getType())->getRetType();
        // 构造目标寄存器的保存操作数
        if (this->type != TypeSystem::voidType)
        {
            SymbolEntry *se =
                new TemporarySymbolEntry(this->type, SymbolTable::getLabel());
            dst = new Operand(se);
        }
        // 获取参数的类型列表
        std::vector<Type *> params = ((FunctionType *)symbolEntry->getType())->getParamsType();
        // param是实参，temp初始化等于param
        ExprNode *temp = param;
        for (auto it = params.begin(); it != params.end(); it++)
        {
            if (temp == nullptr)
            {
                fprintf(stderr, "actual Param numbers %d not match in function %s\n", actualParamCount, symbolEntry->toStr().c_str());
                assert(temp != nullptr);
            }
            else if ((*it)->getKind() != Type::INT)
            {
                fprintf(stderr, "arguments type not match in function %s\n", symbolEntry->toStr().c_str());
                assert(temp != nullptr);
            }
            temp = (ExprNode *)(temp->getNext());
        }
        if (temp != nullptr)
        {
            fprintf(stderr, "actual param numbers %d not match in function %s\n", actualParamCount, symbolEntry->toStr().c_str());
            assert(temp != nullptr);
        }
    }
};

void BinaryExpr::output(int level)
{
    std::string op_str;
    switch (op)
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
    case LEQ:
        op_str = "lessequal";
        break;
    case MORE:
        op_str = "greater";
        break;
    case MEQ:
        op_str = "greaterequal";
        break;
    case EQ:
        op_str = "equal";
        break;
    case NE:
        op_str = "notequal";
        break;
    }
    fprintf(yyout, "%*cBinaryExpr\top: %s\n", level, ' ', op_str.c_str());
    expr1->output(level + 4);
    expr2->output(level + 4);
}

int BinaryExpr::getValue()
{
    int value = 0;
    switch (op)
    {
    case ADD:
        value = expr1->getValue() + expr2->getValue();
        break;
    case SUB:
        value = expr1->getValue() - expr2->getValue();
        break;
    case MUL:
        value = expr1->getValue() * expr2->getValue();
        break;
    case DIV:
        value = expr1->getValue() / expr2->getValue();
        break;
    case MOD:
        value = expr1->getValue() % expr2->getValue();
        break;
    case AND:
        value = expr1->getValue() && expr2->getValue();
        break;
    case OR:
        value = expr1->getValue() || expr2->getValue();
        break;
    case LESS:
        value = expr1->getValue() < expr2->getValue();
        break;
    case LEQ:
        value = expr1->getValue() <= expr2->getValue();
        break;
    case MORE:
        value = expr1->getValue() > expr2->getValue();
        break;
    case MEQ:
        value = expr1->getValue() >= expr2->getValue();
        break;
    case EQ:
        value = expr1->getValue() == expr2->getValue();
        break;
    case NE:
        value = expr1->getValue() != expr2->getValue();
        break;
    }
    return value;
}

int UnaryExpr::getValue()
{
    int value = 0;
    switch (op)
    {
    case NOT:
        value = !(expr->getValue());
        break;
    case SUB:
        value = -(expr->getValue());
        break;
    }
    return value;
}

int Constant::getValue()
{
    return ((ConstantSymbolEntry *)symbolEntry)->getValue();
}

void Ast::output()
{
    fprintf(yyout, "program\n");
    if (root != nullptr)
        root->output(4);
}

void Constant::output(int level)
{
    std::string type, value;
    type = symbolEntry->getType()->toStr();
    value = symbolEntry->toStr();
    fprintf(yyout, "%*cIntegerLiteral\tvalue: %s\ttype: %s\n", level, ' ',
            value.c_str(), type.c_str());
}

void Id::output(int level)
{
    std::string name, type;
    int scope;
    name = symbolEntry->toStr();
    type = symbolEntry->getType()->toStr();
    scope = dynamic_cast<IdentifierSymbolEntry *>(symbolEntry)->getScope();
    fprintf(yyout, "%*cId\tname: %s\tscope: %d\ttype: %s\n", level, ' ',
            name.c_str(), scope, type.c_str());
}

void FuncCallExpr::output(int level)
{
    std::string name, type;
    int scope;
    name = symbolEntry->toStr();            // 获取函数名
    type = symbolEntry->getType()->toStr(); // 获取函数返回值类型
    scope = dynamic_cast<IdentifierSymbolEntry *>(symbolEntry)->getScope();
    fprintf(yyout, "%*cFuncCallExpr\tfunction name: %s\tscope: %d\ttype: %s\n",
            level, ' ', name.c_str(), scope, type.c_str());
    Node *temp = param;
    while (temp)
    {
        temp->output(level + 4);
        temp = temp->getNext();
    }
}

void ExprStmt::output(int level)
{
    fprintf(yyout, "%*cmake\n", level, ' ');
    expr->output(level + 4);
}

void DeclStmt::output(int level)
{
    fprintf(yyout, "%*cDeclStmt\n", level, ' ');
    id->output(level + 4);
    if (expr)
        expr->output(level + 4);
    if (this->getNext())
    {
        this->getNext()->output(level);
    }
}

void CompoundStmt::output(int level)
{
    fprintf(yyout, "%*cCompoundStmt\n", level, ' ');
    if (stmt)
        stmt->output(level + 4);
}

void SeqNode::output(int level)
{
    // fprintf(yyout, "%*cSequence\n", level, ' ');
    stmt1->output(level);
    stmt2->output(level);
}

void EmptyStmt::output(int level)
{
    fprintf(yyout, "%*cEmptyStmt\n", level, ' ');
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
    cond->output(level + 4);
    stmt->output(level + 4);
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
    retValue->output(level + 4);
}

void AssignStmt::output(int level)
{
    fprintf(yyout, "%*cAssignStmt\n", level, ' ');
    lval->output(level + 4);
    expr->output(level + 4);
}

void FunctionDef::output(int level)
{
    std::string name, type;
    name = se->toStr();
    type = se->getType()->toStr();
    fprintf(yyout, "%*cFunctionDefine function name: %s type: %s\n", level, ' ',
            name.c_str(), type.c_str());
    if (FuncDefParams)
    {
        FuncDefParams->output(level + 4);
    }
    stmt->output(level + 4);
}

void UnaryExpr::output(int level)
{
    std::string op_str;
    switch (op)
    {
    case NOT:
        op_str = "not";
        break;
    case SUB:
        op_str = "minus";
        break;
    }
    fprintf(yyout, "%*cUnaryExpr\top: %s\ttype: %s\n", level, ' ',
            op_str.c_str(), type->toStr().c_str());
    expr->output(level + 4);
}