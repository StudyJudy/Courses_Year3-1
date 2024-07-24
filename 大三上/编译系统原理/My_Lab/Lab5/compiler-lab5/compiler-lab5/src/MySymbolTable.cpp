#include <iostream>
#include <cfloat>
#include "MySymbolTable.h"

bool MySymbolTable::lookup(std::string identifier)
{
    if(mysymbolTable.find(identifier) == mysymbolTable.end()){// 使用 find() 函数在符号表中查找标识符
        return false;//不存在返回false
    }
    return true;//存在返回true
}

void MySymbolTable::insert(std::string identifier, double value)
{
    double* addr = new double(value); // 创建一个新的 double 类型的变量，并将其地址存储在符号表中
    auto res = mysymbolTable.insert(std::pair<std::string, double*>(identifier, addr));
    if(res.second){}
}

double* MySymbolTable::getAddress(std::string identifier,double value) {
    if (mysymbolTable.find(identifier) == mysymbolTable.end()) {
        insert(identifier, value);
        getAddress(identifier, value);
    }
    return mysymbolTable[identifier]; // 返回标识符对应的地址
}