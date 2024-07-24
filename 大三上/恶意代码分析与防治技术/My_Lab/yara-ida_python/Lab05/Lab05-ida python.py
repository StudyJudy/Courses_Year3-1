import idc
import idautils

# 目标注释
target_string = "robotwork"

# 获取函数的起始和结束地址
start_address = 0x1000FF58
end_address = 0x1001073F

# 初始化一个列表来存储包含特定注释的汇编语句
relevant_instructions = []

# 遍历指令，查找包含指定字符串的汇编语句
current_address = start_address

while current_address <= end_address:
    # 获取当前指令的反汇编文本
    disasm = idc.GetDisasm(current_address)

    # 检查是否包含指定字符串
    if target_string in disasm:
        relevant_instructions.append((current_address, disasm))

    # 移动到下一条指令
    current_address = idc.NextHead(current_address)

# 输出找到的相关汇编语句
for instruction in relevant_instructions:
    print("Found relevant instruction at 0x%X: %s" % (instruction[0], instruction[1]))
