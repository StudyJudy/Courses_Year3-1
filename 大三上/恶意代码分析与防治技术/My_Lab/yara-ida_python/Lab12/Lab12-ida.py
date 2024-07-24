# -*- coding: utf-8 -*-
import idaapi
import idautils
import idc

for func in idautils.Functions():
    func_flags = idaapi.get_func(func).flags
    if func_flags & idaapi.FUNC_LIB or func_flags & idaapi.FUNC_THUNK:
        continue
    dism_addr = list(idautils.FuncItems(func))
    for line in dism_addr:
        m = idc.GetMnem(line)
        if m == "call" or m == "jmp":
            op = idc.GetOpType(line, 0)
            if op == idc.o_reg:
                print("0x%x %s" % (line, idc.GetDisasm(line)))
