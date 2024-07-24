# -*- coding: utf-8 -*-

import idc
import idautils

def analyze_call_graph(start_address):
    # 创建函数调用图的字典
    call_graph = {}

    # 遍历所有函数
    for func_ea in idautils.Functions():
        func_name = idc.GetFunctionName(func_ea)
        call_graph[func_name] = []

        # 获取函数信息
        func_start = idc.GetFunctionAttr(func_ea, idc.FUNCATTR_START)
        func_end = idc.GetFunctionAttr(func_ea, idc.FUNCATTR_END)

        # 遍历函数内的指令
        for head in idautils.Heads(func_start, func_end):
            # 获取指令的助记符
            mnemonic = idc.GetMnem(head)

            # 检查指令是否为"call"
            if mnemonic == "call":
                target_address = idc.GetOperandValue(head, 0)
                target_func_name = idc.GetFunctionName(target_address)

                # 如果目标函数不为空，则将其添加到调用图中
                if target_func_name:
                    call_graph[func_name].append(target_func_name)

    # 显示调用图
    for func, calls in call_graph.items():
        print("Function: {}".format(func))
        if calls:
            print("Calls the following functions:")
            for called_func in calls:
                print("  {}".format(called_func))
        else:
            print("This function does not call other functions.")
        print("=" * 30)

# 在此处替换为要分析的起始地址
start_address_to_analyze = 0x401000  # 请替换为实际地址

# 运行分析程序
analyze_call_graph(start_address_to_analyze)
