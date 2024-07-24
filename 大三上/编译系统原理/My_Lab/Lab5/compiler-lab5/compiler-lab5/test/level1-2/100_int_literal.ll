declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@s = global i32 0, align 4 
define i32 @get_ans_se( i32 %t186, i32 %t188, i32 %t190) {
B184:
  %t191 = alloca i32, align 4
  %t189 = alloca i32, align 4
  %t187 = alloca i32, align 4
  %t185 = alloca i32, align 4
  store i32 %t186, i32* %t185, align 4
  store i32 %t188, i32* %t187, align 4
  store i32 %t190, i32* %t189, align 4
  store i32 0, i32* %t191, align 4
  %t5 = load i32, i32* %t187, align 4
  %t6 = load i32, i32* %t189, align 4
  %t194 = icmp eq i32 %t5, %t6
  br i1 %t194, label %B192, label %B193
B192:                               	; preds = %B184
  store i32 1, i32* %t191, align 4
  br label %B193
B193:                               	; preds = %B184, %B192
  %t10 = load i32, i32* %t185, align 4
  %t11 = mul i32 %t10, 2
  store i32 %t11, i32* %t185, align 4
  %t13 = load i32, i32* %t185, align 4
  %t14 = load i32, i32* %t191, align 4
  %t15 = add i32 %t13, %t14
  store i32 %t15, i32* %t185, align 4
  %t17 = load i32, i32* @s, align 4
  %t18 = load i32, i32* %t185, align 4
  %t19 = add i32 %t17, %t18
  store i32 %t19, i32* @s, align 4
  %t20 = load i32, i32* %t185, align 4
  ret i32 %t20
}
define i32 @get_ans( i32 %t197, i32 %t199, i32 %t201) {
B195:
  %t202 = alloca i32, align 4
  %t200 = alloca i32, align 4
  %t198 = alloca i32, align 4
  %t196 = alloca i32, align 4
  store i32 %t197, i32* %t196, align 4
  store i32 %t199, i32* %t198, align 4
  store i32 %t201, i32* %t200, align 4
  store i32 0, i32* %t202, align 4
  %t25 = load i32, i32* %t198, align 4
  %t26 = load i32, i32* %t200, align 4
  %t205 = icmp eq i32 %t25, %t26
  br i1 %t205, label %B203, label %B204
B203:                               	; preds = %B195
  store i32 1, i32* %t202, align 4
  br label %B204
B204:                               	; preds = %B195, %B203
  %t30 = load i32, i32* %t196, align 4
  %t31 = mul i32 %t30, 2
  store i32 %t31, i32* %t196, align 4
  %t33 = load i32, i32* %t196, align 4
  %t34 = load i32, i32* %t202, align 4
  %t35 = add i32 %t33, %t34
  store i32 %t35, i32* %t196, align 4
  %t36 = load i32, i32* %t196, align 4
  ret i32 %t36
}
define i32 @main() {
B206:
  %t215 = alloca i32, align 4
  %t214 = alloca i32, align 4
  %t213 = alloca i32, align 4
  %t212 = alloca i32, align 4
  %t211 = alloca i32, align 4
  %t210 = alloca i32, align 4
  %t209 = alloca i32, align 4
  %t208 = alloca i32, align 4
  %t207 = alloca i32, align 4
  %t37 = sub i32 0, -2147483648
  store i32 %t37, i32* %t207, align 4
  store i32 -2147483648, i32* %t208, align 4
  %t40 = add i32 -2147483648, 1
  store i32 %t40, i32* %t209, align 4
  store i32 2147483647, i32* %t210, align 4
  %t43 = sub i32 2147483647, 1
  store i32 %t43, i32* %t211, align 4
  %t50 = load i32, i32* %t207, align 4
  %t51 = load i32, i32* %t208, align 4
  %t52 = call i32 @get_ans(i32 0, i32 %t50, i32 %t51)
  store i32 %t52, i32* %t212, align 4
  %t54 = load i32, i32* %t212, align 4
  %t55 = load i32, i32* %t207, align 4
  %t56 = add i32 %t55, 1
  %t57 = load i32, i32* %t209, align 4
  %t58 = call i32 @get_ans(i32 %t54, i32 %t56, i32 %t57)
  store i32 %t58, i32* %t212, align 4
  %t60 = load i32, i32* %t212, align 4
  %t61 = load i32, i32* %t207, align 4
  %t62 = load i32, i32* %t210, align 4
  %t63 = sub i32 0, %t62
  %t64 = sub i32 %t63, 1
  %t65 = call i32 @get_ans(i32 %t60, i32 %t61, i32 %t64)
  store i32 %t65, i32* %t212, align 4
  %t67 = load i32, i32* %t212, align 4
  %t68 = load i32, i32* %t207, align 4
  %t69 = load i32, i32* %t211, align 4
  %t70 = add i32 %t69, 1
  %t71 = call i32 @get_ans(i32 %t67, i32 %t68, i32 %t70)
  store i32 %t71, i32* %t212, align 4
  %t73 = load i32, i32* %t212, align 4
  %t74 = load i32, i32* %t208, align 4
  %t75 = sdiv i32 %t74, 2
  %t76 = load i32, i32* %t209, align 4
  %t77 = sdiv i32 %t76, 2
  %t78 = call i32 @get_ans(i32 %t73, i32 %t75, i32 %t77)
  store i32 %t78, i32* %t212, align 4
  %t80 = load i32, i32* %t212, align 4
  %t81 = load i32, i32* %t208, align 4
  %t82 = load i32, i32* %t210, align 4
  %t83 = sub i32 0, %t82
  %t84 = sub i32 %t83, 1
  %t85 = call i32 @get_ans(i32 %t80, i32 %t81, i32 %t84)
  store i32 %t85, i32* %t212, align 4
  %t87 = load i32, i32* %t212, align 4
  %t88 = load i32, i32* %t208, align 4
  %t89 = load i32, i32* %t211, align 4
  %t90 = add i32 %t89, 1
  %t91 = call i32 @get_ans(i32 %t87, i32 %t88, i32 %t90)
  store i32 %t91, i32* %t212, align 4
  %t93 = load i32, i32* %t209, align 4
  %t94 = load i32, i32* %t210, align 4
  %t95 = call i32 @get_ans(i32 0, i32 %t93, i32 %t94)
  store i32 %t95, i32* %t213, align 4
  %t97 = load i32, i32* %t213, align 4
  %t98 = load i32, i32* %t209, align 4
  %t99 = load i32, i32* %t211, align 4
  %t100 = call i32 @get_ans(i32 %t97, i32 %t98, i32 %t99)
  store i32 %t100, i32* %t213, align 4
  %t102 = load i32, i32* %t213, align 4
  %t103 = load i32, i32* %t210, align 4
  %t104 = load i32, i32* %t211, align 4
  %t105 = call i32 @get_ans(i32 %t102, i32 %t103, i32 %t104)
  store i32 %t105, i32* %t213, align 4
  %t107 = load i32, i32* %t213, align 4
  %t108 = load i32, i32* %t207, align 4
  %t109 = sdiv i32 %t108, 2
  %t110 = load i32, i32* %t208, align 4
  %t111 = sdiv i32 %t110, 2
  %t112 = call i32 @get_ans(i32 %t107, i32 %t109, i32 %t111)
  store i32 %t112, i32* %t213, align 4
  %t114 = load i32, i32* %t207, align 4
  %t115 = load i32, i32* %t208, align 4
  %t116 = call i32 @get_ans_se(i32 0, i32 %t114, i32 %t115)
  store i32 %t116, i32* %t214, align 4
  %t118 = load i32, i32* %t214, align 4
  %t119 = load i32, i32* %t207, align 4
  %t120 = add i32 %t119, 1
  %t121 = load i32, i32* %t209, align 4
  %t122 = call i32 @get_ans_se(i32 %t118, i32 %t120, i32 %t121)
  store i32 %t122, i32* %t214, align 4
  %t124 = load i32, i32* %t214, align 4
  %t125 = load i32, i32* %t207, align 4
  %t126 = load i32, i32* %t210, align 4
  %t127 = sub i32 0, %t126
  %t128 = sub i32 %t127, 1
  %t129 = call i32 @get_ans_se(i32 %t124, i32 %t125, i32 %t128)
  store i32 %t129, i32* %t214, align 4
  %t131 = load i32, i32* %t214, align 4
  %t132 = load i32, i32* %t207, align 4
  %t133 = load i32, i32* %t211, align 4
  %t134 = add i32 %t133, 1
  %t135 = call i32 @get_ans_se(i32 %t131, i32 %t132, i32 %t134)
  store i32 %t135, i32* %t214, align 4
  %t137 = load i32, i32* %t214, align 4
  %t138 = load i32, i32* %t208, align 4
  %t139 = sdiv i32 %t138, 2
  %t140 = load i32, i32* %t209, align 4
  %t141 = sdiv i32 %t140, 2
  %t142 = call i32 @get_ans_se(i32 %t137, i32 %t139, i32 %t141)
  store i32 %t142, i32* %t214, align 4
  %t144 = load i32, i32* %t214, align 4
  %t145 = load i32, i32* %t208, align 4
  %t146 = load i32, i32* %t210, align 4
  %t147 = sub i32 0, %t146
  %t148 = sub i32 %t147, 1
  %t149 = call i32 @get_ans_se(i32 %t144, i32 %t145, i32 %t148)
  store i32 %t149, i32* %t214, align 4
  %t151 = load i32, i32* %t214, align 4
  %t152 = load i32, i32* %t208, align 4
  %t153 = load i32, i32* %t211, align 4
  %t154 = add i32 %t153, 1
  %t155 = call i32 @get_ans_se(i32 %t151, i32 %t152, i32 %t154)
  store i32 %t155, i32* %t214, align 4
  %t157 = load i32, i32* %t209, align 4
  %t158 = load i32, i32* %t210, align 4
  %t159 = call i32 @get_ans_se(i32 0, i32 %t157, i32 %t158)
  store i32 %t159, i32* %t215, align 4
  %t161 = load i32, i32* %t215, align 4
  %t162 = load i32, i32* %t209, align 4
  %t163 = load i32, i32* %t211, align 4
  %t164 = call i32 @get_ans_se(i32 %t161, i32 %t162, i32 %t163)
  store i32 %t164, i32* %t215, align 4
  %t166 = load i32, i32* %t215, align 4
  %t167 = load i32, i32* %t210, align 4
  %t168 = load i32, i32* %t211, align 4
  %t169 = call i32 @get_ans_se(i32 %t166, i32 %t167, i32 %t168)
  store i32 %t169, i32* %t215, align 4
  %t171 = load i32, i32* %t215, align 4
  %t172 = load i32, i32* %t207, align 4
  %t173 = sdiv i32 %t172, 2
  %t174 = load i32, i32* %t208, align 4
  %t175 = sdiv i32 %t174, 2
  %t176 = call i32 @get_ans_se(i32 %t171, i32 %t173, i32 %t175)
  store i32 %t176, i32* %t215, align 4
  %t177 = load i32, i32* %t212, align 4
  %t178 = load i32, i32* %t213, align 4
  %t179 = add i32 %t177, %t178
  %t180 = load i32, i32* %t214, align 4
  %t181 = add i32 %t179, %t180
  %t182 = load i32, i32* %t215, align 4
  %t183 = add i32 %t181, %t182
  ret i32 %t183
}
