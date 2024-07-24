# -*- coding: utf-8 -*-

import idaapi

# 获取指定地址的函数的参数数量
def get_function_args_count(ea):
    func = idaapi.get_func(ea)
    if func:
        cfunc = idaapi.decompile(func.startEA)
        if cfunc:
            # 获取函数的参数列表
            args = cfunc.get_lvars()
            return len(args)
    return None

# 获取指定地址的函数的局部变量数量
def get_function_locals_count(ea):
    func = idaapi.get_func(ea)
    if func:
        return func.frsize // 4  # 假设是32位架构
    else:
        return None

# 获取指定地址的函数的起始地址
def get_function_start_address(ea):
    func = idaapi.get_func(ea)
    if func:
        return func.startEA
    else:
        return None

# 获取当前光标所在地址
current_address = ScreenEA()

# 获取当前地址的函数信息
args_count = get_function_args_count(current_address)
locals_count = get_function_locals_count(current_address)
start_address = get_function_start_address(current_address)

# 打印函数信息
print("Current selected address:", hex(current_address))
print("Function start address:", hex(start_address))
print("Number of arguments:", args_count)
print("Number of local variables:", locals_count)
