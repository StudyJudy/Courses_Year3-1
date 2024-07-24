import idautils
import idc
for seg in idautils.Segments():
    print idc.SegName(seg),hex(idc.SegStart(seg)),hex(idc.SegEnd(seg))
