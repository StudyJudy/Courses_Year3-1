#ifndef MYSYMBOLTABLE_H
#define MYSYMBOLTABLE_H

#include <string>
#include <unordered_map>

class MySymbolTable {
    std::unordered_map<std::string, double*> mysymbolTable;
public:
    bool lookup(std::string identifier);// 查找标识符是否存在于符号表中
    void insert(std::string identifier, double value);// 插入或更新标识符及其对应的值到符号表中
    double* getAddress(std::string identifier, double value);
};
#endif //SYMBOLTABLE_H