#include "BasicBlock.h"
#include "Function.h"
#include <algorithm>

extern FILE *yyout;

// insert the instruction to the front of the basicblock.
void BasicBlock::insertFront(Instruction *inst)
{
    insertBefore(inst, head->getNext());//将指令inst插入到基本块开头
}

// insert the instruction to the back of the basicblock.
void BasicBlock::insertBack(Instruction *inst)
{
    insertBefore(inst, head);// 将指令inst插入到基本块的末尾。
}

// insert the instruction dst before src.
void BasicBlock::insertBefore(Instruction *dst, Instruction *src)
{
    // 在指令的链表中，在指令src之前插入指令dst。
    src->getPrev()->setNext(dst);  // 将src的前一个指令的next指针指向dst
    dst->setPrev(src->getPrev());  // 将dst的prev指针指向src的前一个指令

    dst->setNext(src);  // 将dst的next指针指向src
    src->setPrev(dst);  // 将src的prev指针指向dst

    dst->setParent(this);  // 设置dst的父亲为当前基本块
}

// remove the instruction from intruction list.
void BasicBlock::remove(Instruction *inst)
{
    // 从链表中移除指定的指令inst。
    inst->getPrev()->setNext(inst->getNext());  // 将inst的前一个指令的next指针指向inst的下一个指令
    inst->getNext()->setPrev(inst->getPrev());  // 将inst的下一个指令的prev指针指向inst的前一个指令
}

void BasicBlock::output() const
{
    // 输出有关基本块的信息，包括编号、前驱以及它包含的指令。
    fprintf(yyout, "B%d:", no);  // 输出基本块的编号

    // 如果前驱基本块不为空，通过循环输出前继的若干个基本块的编号
    if (!pred.empty())
    {
        fprintf(yyout, "%*c; preds = %%B%d", 32, '\t', pred[0]->getNo());
        for (auto i = pred.begin() + 1; i != pred.end(); i++)
            fprintf(yyout, ", %%B%d", (*i)->getNo());
    }
    fprintf(yyout, "\n");

    // head为这个基本块的第一条指令，调用每一条指令的output
    // 循环遍历基本块内的指令链表
    for (auto i = head->getNext(); i != head; i = i->getNext())
        i->output();  // 输出当前基本块内每个指令的信息
}

void BasicBlock::addSucc(BasicBlock *bb)
{
    succ.push_back(bb);//向基本块的后继添加后继
}

// remove the successor basicclock bb.
void BasicBlock::removeSucc(BasicBlock *bb)
{
    //向基本块的后继移除后继
    succ.erase(std::find(succ.begin(), succ.end(), bb));
}

void BasicBlock::addPred(BasicBlock *bb)
{
    // 向基本块的前驱添加前驱
    pred.push_back(bb);
}

// remove the predecessor basicblock bb.
void BasicBlock::removePred(BasicBlock *bb)
{
    // 向基本块的前驱移除前驱
    pred.erase(std::find(pred.begin(), pred.end(), bb));
}

BasicBlock::BasicBlock(Function *f)
{
    // 初始化一个 BasicBlock 对象，分配一个唯一标签，并将块插入到指定的函数中
    this->no = SymbolTable::getLabel(); // 为当前基本块分配一个唯一标签
    f->insertBlock(this); // 将当前基本块插入到指定的函数中
    parent = f; // 将当前基本块的父亲指定为指定的函数
    head = new DummyInstruction(); // 创建一个虚拟指令头
    head->setParent(this); // 设置虚拟指令头的父亲为当前基本块
}

BasicBlock::~BasicBlock()
{
    // 释放基本块内指令占用的内存，更新后继和前驱的邻居块，并将块从其父函数中移除
    Instruction *inst;
    inst = head->getNext();
    while (inst != head)
    {
        Instruction *t;
        t = inst;
        inst = inst->getNext();
        delete t; // 释放当前指令节点占用的内存
    }
    for (auto &bb : pred)
        bb->removeSucc(this); // 从前驱基本块的后继列表中移除当前基本块
    for (auto &bb : succ)
        bb->removePred(this); // 从后继基本块的前驱列表中移除当前基本块
    parent->remove(this); // 从父函数中移除当前基本块
}