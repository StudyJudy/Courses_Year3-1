declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@g = global i32 0, align 4 
@h = global i32 0, align 4 
@f = global i32 0, align 4 
@e = global i32 0, align 4 
define i32 @EightWhile() {
B93:
  %t97 = alloca i32, align 4
  %t96 = alloca i32, align 4
  %t95 = alloca i32, align 4
  %t94 = alloca i32, align 4
  store i32 5, i32* %t94, align 4
  store i32 6, i32* %t95, align 4
  store i32 7, i32* %t96, align 4
  store i32 10, i32* %t97, align 4
  br label %B98
B98:                               	; preds = %B93, %B93, %B104
  %t12 = load i32, i32* %t94, align 4
  %t101 = icmp slt i32 %t12, 20
  br i1 %t101, label %B99, label %B100
B99:                               	; preds = %B98
  %t15 = load i32, i32* %t94, align 4
  %t16 = add i32 %t15, 3
  store i32 %t16, i32* %t94, align 4
  br label %B102
B100:                               	; preds = %B98
  %t73 = load i32, i32* %t94, align 4
  %t74 = load i32, i32* %t95, align 4
  %t75 = load i32, i32* %t97, align 4
  %t76 = add i32 %t74, %t75
  %t77 = add i32 %t73, %t76
  %t78 = load i32, i32* %t96, align 4
  %t79 = add i32 %t77, %t78
  %t80 = load i32, i32* @e, align 4
  %t81 = load i32, i32* %t97, align 4
  %t82 = add i32 %t80, %t81
  %t83 = load i32, i32* @g, align 4
  %t84 = sub i32 %t82, %t83
  %t85 = load i32, i32* @h, align 4
  %t86 = add i32 %t84, %t85
  %t87 = sub i32 %t79, %t86
  ret i32 %t87
B102:                               	; preds = %B99, %B99, %B108
  %t17 = load i32, i32* %t95, align 4
  %t105 = icmp slt i32 %t17, 10
  br i1 %t105, label %B103, label %B104
B103:                               	; preds = %B102
  %t20 = load i32, i32* %t95, align 4
  %t21 = add i32 %t20, 1
  store i32 %t21, i32* %t95, align 4
  br label %B106
B104:                               	; preds = %B102
  %t71 = load i32, i32* %t95, align 4
  %t72 = sub i32 %t71, 2
  store i32 %t72, i32* %t95, align 4
  br label %B98
B106:                               	; preds = %B103, %B103, %B112
  %t22 = load i32, i32* %t96, align 4
  %t109 = icmp eq i32 %t22, 7
  br i1 %t109, label %B107, label %B108
B107:                               	; preds = %B106
  %t25 = load i32, i32* %t96, align 4
  %t26 = sub i32 %t25, 1
  store i32 %t26, i32* %t96, align 4
  br label %B110
B108:                               	; preds = %B106
  %t68 = load i32, i32* %t96, align 4
  %t69 = add i32 %t68, 1
  store i32 %t69, i32* %t96, align 4
  br label %B102
B110:                               	; preds = %B107, %B107, %B116
  %t27 = load i32, i32* %t97, align 4
  %t113 = icmp slt i32 %t27, 20
  br i1 %t113, label %B111, label %B112
B111:                               	; preds = %B110
  %t30 = load i32, i32* %t97, align 4
  %t31 = add i32 %t30, 3
  store i32 %t31, i32* %t97, align 4
  br label %B114
B112:                               	; preds = %B110
  %t65 = load i32, i32* %t97, align 4
  %t66 = sub i32 %t65, 1
  store i32 %t66, i32* %t97, align 4
  br label %B106
B114:                               	; preds = %B111, %B111, %B120
  %t32 = load i32, i32* @e, align 4
  %t117 = icmp sgt i32 %t32, 1
  br i1 %t117, label %B115, label %B116
B115:                               	; preds = %B114
  %t35 = load i32, i32* @e, align 4
  %t36 = sub i32 %t35, 1
  store i32 %t36, i32* @e, align 4
  br label %B118
B116:                               	; preds = %B114
  %t62 = load i32, i32* @e, align 4
  %t63 = add i32 %t62, 1
  store i32 %t63, i32* @e, align 4
  br label %B110
B118:                               	; preds = %B115, %B115, %B124
  %t37 = load i32, i32* @f, align 4
  %t121 = icmp sgt i32 %t37, 2
  br i1 %t121, label %B119, label %B120
B119:                               	; preds = %B118
  %t40 = load i32, i32* @f, align 4
  %t41 = sub i32 %t40, 2
  store i32 %t41, i32* @f, align 4
  br label %B122
B120:                               	; preds = %B118
  %t59 = load i32, i32* @f, align 4
  %t60 = add i32 %t59, 1
  store i32 %t60, i32* @f, align 4
  br label %B114
B122:                               	; preds = %B119, %B119, %B128
  %t42 = load i32, i32* @g, align 4
  %t125 = icmp slt i32 %t42, 3
  br i1 %t125, label %B123, label %B124
B123:                               	; preds = %B122
  %t45 = load i32, i32* @g, align 4
  %t46 = add i32 %t45, 10
  store i32 %t46, i32* @g, align 4
  br label %B126
B124:                               	; preds = %B122
  %t56 = load i32, i32* @g, align 4
  %t57 = sub i32 %t56, 8
  store i32 %t57, i32* @g, align 4
  br label %B118
B126:                               	; preds = %B123, %B123, %B127
  %t47 = load i32, i32* @h, align 4
  %t129 = icmp slt i32 %t47, 10
  br i1 %t129, label %B127, label %B128
B127:                               	; preds = %B126
  %t50 = load i32, i32* @h, align 4
  %t51 = add i32 %t50, 8
  store i32 %t51, i32* @h, align 4
  br label %B126
B128:                               	; preds = %B126
  %t53 = load i32, i32* @h, align 4
  %t54 = sub i32 %t53, 1
  store i32 %t54, i32* @h, align 4
  br label %B122
}
define i32 @main() {
B130:
  store i32 1, i32* @g, align 4
  store i32 2, i32* @h, align 4
  store i32 4, i32* @e, align 4
  store i32 6, i32* @f, align 4
  %t92 = call i32 @EightWhile()
  ret i32 %t92
}
