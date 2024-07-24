#include "Type.h"
#include <sstream>

IntType TypeSystem::commonInt = IntType(4);
FloatType TypeSystem::commonFloat = FloatType();
ConstIntType TypeSystem::commonConstInt = ConstIntType();
ConstFloatType TypeSystem::commonConstFloat = ConstFloatType();
BoolType TypeSystem::commonBool = BoolType();
VoidType TypeSystem::commonVoid = VoidType();

Type* TypeSystem::intType = &commonInt;
Type* TypeSystem::floatType = &commonFloat;
Type* TypeSystem::constIntType = &commonConstInt;
Type* TypeSystem::constFloatType = &commonConstFloat;
Type* TypeSystem::boolType = &commonBool;
Type* TypeSystem::voidType = &commonVoid;

std::string IntType::toStr()
{
    return "int";
}

std::string FloatType::toStr()
{
    return "float";
}

std::string ConstIntType::toStr()
{
    return "const int";
}

std::string ConstFloatType::toStr()
{
    return "const float";
}

std::string BoolType::toStr()
{
    return "bool";
}

std::string VoidType::toStr()
{
    return "void";
}

void FunctionType::setparamsType(std::vector<Type*> in)
{
    // 设置函数类型的参数列表
    paramsType = in;
}

std::string FunctionType::toStr()
{
    // 将函数类型转换为字符串表示
    std::ostringstream buffer;
    buffer << returnType->toStr() << "(";  // 将返回类型添加到字符串缓冲区中
    for(int i = 0; i < (int)paramsType.size(); i++){
        if(i != 0) 
            buffer << ", ";  // 添加逗号分隔符
        buffer << paramsType[i]->toStr();  // 将参数类型添加到字符串缓冲区中
    }
    buffer << ")";  // 添加右括号
    return buffer.str();  // 返回字符串表示
}

void IntArrayType::pushBackDimension(int dim)
{
    // 将维度信息添加到 int 数组类型的维度列表中
    dimensions.push_back(dim);
}

std::vector<int> IntArrayType::getDimensions()
{
    // 获取 int 数组类型的维度信息并返回
    return dimensions;
}

std::string IntArrayType::toStr()
{
    return "int array";
}

void FloatArrayType::pushBackDimension(int dim)
{
    dimensions.push_back(dim);
}

std::vector<int> FloatArrayType::getDimensions()
{
    return dimensions;
}

std::string FloatArrayType::toStr()
{
    return "float array";
}
void ConstIntArrayType::pushBackDimension(int dim)
{
    dimensions.push_back(dim);
}

std::vector<int> ConstIntArrayType::getDimensions()
{
    return dimensions;
}

std::string ConstIntArrayType::toStr()
{
    return "const int array";
}

void ConstFloatArrayType::pushBackDimension(int dim)
{
    dimensions.push_back(dim);
}

std::vector<int> ConstFloatArrayType::getDimensions()
{
    return dimensions;
}

std::string ConstFloatArrayType::toStr()
{
    return "const float array";
}