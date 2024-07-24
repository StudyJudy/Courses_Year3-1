declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a = global i32 0, align 4 
@b = global i32 0, align 4 
@d = global i32 0, align 4 
define i32 @set_a( i32 %t110) {
B108:
  %t109 = alloca i32, align 4
  store i32 %t110, i32* %t109, align 4
  %t5 = load i32, i32* %t109, align 4
  store i32 %t5, i32* @a, align 4
  %t6 = load i32, i32* @a, align 4
  ret i32 %t6
}
define i32 @set_b( i32 %t113) {
B111:
  %t112 = alloca i32, align 4
  store i32 %t113, i32* %t112, align 4
  %t9 = load i32, i32* %t112, align 4
  store i32 %t9, i32* @b, align 4
  %t10 = load i32, i32* @b, align 4
  ret i32 %t10
}
define i32 @set_d( i32 %t116) {
B114:
  %t115 = alloca i32, align 4
  store i32 %t116, i32* %t115, align 4
  %t13 = load i32, i32* %t115, align 4
  store i32 %t13, i32* @d, align 4
  %t14 = load i32, i32* @d, align 4
  ret i32 %t14
}
define i32 @main() {
B117:
  %t173 = alloca i32, align 4
  %t172 = alloca i32, align 4
  %t171 = alloca i32, align 4
  %t170 = alloca i32, align 4
  %t169 = alloca i32, align 4
  %t128 = alloca i32, align 4
  store i32 2, i32* @a, align 4
  store i32 3, i32* @b, align 4
  %t17 = call i32 @set_a(i32 0)
  %t120 = icmp ne i32 %t17, 0
  br i1 %t120, label %B121, label %B119
B121:                               	; preds = %B117, %B117
  %t18 = call i32 @set_b(i32 1)
  %t122 = icmp ne i32 %t18, 0
  br i1 %t122, label %B118, label %B119
B119:                               	; preds = %B117, %B118, %B121
  %t20 = load i32, i32* @a, align 4
  call void @putint(i32 %t20)
  call void @putch(i32 32)
  %t21 = load i32, i32* @b, align 4
  call void @putint(i32 %t21)
  call void @putch(i32 32)
  store i32 2, i32* @a, align 4
  store i32 3, i32* @b, align 4
  %t24 = call i32 @set_a(i32 0)
  %t125 = icmp ne i32 %t24, 0
  br i1 %t125, label %B126, label %B124
B118:                               	; preds = %B121
  br label %B119
B126:                               	; preds = %B119, %B119
  %t25 = call i32 @set_b(i32 1)
  %t127 = icmp ne i32 %t25, 0
  br i1 %t127, label %B123, label %B124
B124:                               	; preds = %B119, %B123, %B126
  %t27 = load i32, i32* @a, align 4
  call void @putint(i32 %t27)
  call void @putch(i32 32)
  %t28 = load i32, i32* @b, align 4
  call void @putint(i32 %t28)
  call void @putch(i32 10)
  store i32 1, i32* %t128, align 4
  store i32 2, i32* @d, align 4
  %t31 = load i32, i32* %t128, align 4
  %t131 = icmp sge i32 %t31, 1
  %t133 = zext i1 %t131 to i32
  %t132 = icmp ne i32 %t133, 0
  br i1 %t132, label %B134, label %B130
B123:                               	; preds = %B126
  br label %B124
B134:                               	; preds = %B124, %B124
  %t33 = call i32 @set_d(i32 3)
  %t135 = icmp ne i32 %t33, 0
  br i1 %t135, label %B129, label %B130
B130:                               	; preds = %B124, %B129, %B134
  %t35 = load i32, i32* @d, align 4
  call void @putint(i32 %t35)
  call void @putch(i32 32)
  %t36 = load i32, i32* %t128, align 4
  %t138 = icmp sle i32 %t36, 1
  %t140 = zext i1 %t138 to i32
  %t139 = icmp ne i32 %t140, 0
  br i1 %t139, label %B136, label %B141
B129:                               	; preds = %B134
  br label %B130
B141:                               	; preds = %B130, %B130
  %t38 = call i32 @set_d(i32 4)
  %t142 = icmp ne i32 %t38, 0
  br i1 %t142, label %B136, label %B137
B136:                               	; preds = %B130, %B141
  br label %B137
B137:                               	; preds = %B136, %B141
  %t40 = load i32, i32* @d, align 4
  call void @putint(i32 %t40)
  call void @putch(i32 10)
  %t41 = add i32 2, 1
  %t42 = sub i32 3, %t41
  %t145 = icmp sge i32 16, %t42
  br i1 %t145, label %B143, label %B144
B143:                               	; preds = %B137
  call void @putch(i32 65)
  br label %B144
B144:                               	; preds = %B137, %B143
  %t44 = sub i32 25, 7
  %t45 = mul i32 6, 3
  %t46 = sub i32 36, %t45
  %t148 = icmp ne i32 %t44, %t46
  br i1 %t148, label %B146, label %B147
B146:                               	; preds = %B144
  call void @putch(i32 66)
  br label %B147
B147:                               	; preds = %B144, %B146
  %t151 = icmp slt i32 1, 8
  %t49 = srem i32 7, 2
  %t152 = zext i1 %t151 to i32
  %t153 = icmp ne i32 %t152, %t49
  br i1 %t153, label %B149, label %B150
B149:                               	; preds = %B147
  call void @putch(i32 67)
  br label %B150
B150:                               	; preds = %B147, %B149
  %t156 = icmp sgt i32 3, 4
  %t157 = zext i1 %t156 to i32
  %t158 = icmp eq i32 %t157, 0
  br i1 %t158, label %B154, label %B155
B154:                               	; preds = %B150
  call void @putch(i32 68)
  br label %B155
B155:                               	; preds = %B150, %B154
  %t161 = icmp sle i32 102, 63
  %t162 = zext i1 %t161 to i32
  %t163 = icmp eq i32 1, %t162
  br i1 %t163, label %B159, label %B160
B159:                               	; preds = %B155
  call void @putch(i32 69)
  br label %B160
B160:                               	; preds = %B155, %B159
  %t55 = sub i32 5, 6
  %t56 = icmp eq i32 0, 0
  %t167 = zext i1 %t56 to i32
  %t57 = sub i32 0, %t167
  %t168 = icmp eq i32 %t55, %t57
  br i1 %t168, label %B164, label %B165
B164:                               	; preds = %B160
  call void @putch(i32 70)
  br label %B165
B165:                               	; preds = %B160, %B164
  call void @putch(i32 10)
  store i32 0, i32* %t169, align 4
  store i32 1, i32* %t170, align 4
  store i32 2, i32* %t171, align 4
  store i32 3, i32* %t172, align 4
  store i32 4, i32* %t173, align 4
  br label %B174
B174:                               	; preds = %B165, %B165, %B175
  %t64 = load i32, i32* %t169, align 4
  %t177 = icmp ne i32 %t64, 0
  br i1 %t177, label %B178, label %B176
B178:                               	; preds = %B174, %B174
  %t65 = load i32, i32* %t170, align 4
  %t179 = icmp ne i32 %t65, 0
  br i1 %t179, label %B175, label %B176
B176:                               	; preds = %B174, %B178
  %t67 = load i32, i32* %t169, align 4
  %t182 = icmp ne i32 %t67, 0
  br i1 %t182, label %B180, label %B183
B175:                               	; preds = %B178
  call void @putch(i32 32)
  br label %B174
B183:                               	; preds = %B176, %B176
  %t68 = load i32, i32* %t170, align 4
  %t184 = icmp ne i32 %t68, 0
  br i1 %t184, label %B180, label %B181
B180:                               	; preds = %B176, %B183
  call void @putch(i32 67)
  br label %B181
B181:                               	; preds = %B180, %B183
  %t70 = load i32, i32* %t169, align 4
  %t71 = load i32, i32* %t170, align 4
  %t187 = icmp sge i32 %t70, %t71
  %t189 = zext i1 %t187 to i32
  %t188 = icmp ne i32 %t189, 0
  br i1 %t188, label %B185, label %B190
B190:                               	; preds = %B181, %B181
  %t73 = load i32, i32* %t170, align 4
  %t74 = load i32, i32* %t169, align 4
  %t191 = icmp sle i32 %t73, %t74
  %t193 = zext i1 %t191 to i32
  %t192 = icmp ne i32 %t193, 0
  br i1 %t192, label %B185, label %B186
B185:                               	; preds = %B181, %B190
  call void @putch(i32 72)
  br label %B186
B186:                               	; preds = %B185, %B190
  %t77 = load i32, i32* %t171, align 4
  %t78 = load i32, i32* %t170, align 4
  %t196 = icmp sge i32 %t77, %t78
  %t198 = zext i1 %t196 to i32
  %t197 = icmp ne i32 %t198, 0
  br i1 %t197, label %B199, label %B195
B199:                               	; preds = %B186, %B186
  %t80 = load i32, i32* %t173, align 4
  %t81 = load i32, i32* %t172, align 4
  %t200 = icmp ne i32 %t80, %t81
  %t202 = zext i1 %t200 to i32
  %t201 = icmp ne i32 %t202, 0
  br i1 %t201, label %B194, label %B195
B195:                               	; preds = %B186, %B194, %B199
  %t84 = load i32, i32* %t169, align 4
  %t85 = load i32, i32* %t170, align 4
  %t86 = icmp eq i32 %t85, 0
  %t206 = zext i1 %t86 to i32
  %t207 = icmp eq i32 %t84, %t206
  %t209 = zext i1 %t207 to i32
  %t208 = icmp ne i32 %t209, 0
  br i1 %t208, label %B210, label %B214
B194:                               	; preds = %B199
  call void @putch(i32 73)
  br label %B195
B210:                               	; preds = %B195, %B195
  %t88 = load i32, i32* %t172, align 4
  %t89 = load i32, i32* %t172, align 4
  %t211 = icmp slt i32 %t88, %t89
  %t213 = zext i1 %t211 to i32
  %t212 = icmp ne i32 %t213, 0
  br i1 %t212, label %B203, label %B214
B214:                               	; preds = %B195, %B195, %B210
  %t92 = load i32, i32* %t173, align 4
  %t93 = load i32, i32* %t173, align 4
  %t215 = icmp sge i32 %t92, %t93
  %t217 = zext i1 %t215 to i32
  %t216 = icmp ne i32 %t217, 0
  br i1 %t216, label %B203, label %B204
B203:                               	; preds = %B210, %B214
  call void @putch(i32 74)
  br label %B204
B204:                               	; preds = %B203, %B214
  %t96 = load i32, i32* %t169, align 4
  %t97 = load i32, i32* %t170, align 4
  %t98 = icmp eq i32 %t97, 0
  %t221 = zext i1 %t98 to i32
  %t222 = icmp eq i32 %t96, %t221
  %t224 = zext i1 %t222 to i32
  %t223 = icmp ne i32 %t224, 0
  br i1 %t223, label %B218, label %B225
B225:                               	; preds = %B204, %B204
  %t100 = load i32, i32* %t172, align 4
  %t101 = load i32, i32* %t172, align 4
  %t226 = icmp slt i32 %t100, %t101
  %t228 = zext i1 %t226 to i32
  %t227 = icmp ne i32 %t228, 0
  br i1 %t227, label %B229, label %B219
B218:                               	; preds = %B204, %B229
  call void @putch(i32 75)
  br label %B219
B229:                               	; preds = %B225, %B225
  %t103 = load i32, i32* %t173, align 4
  %t104 = load i32, i32* %t173, align 4
  %t230 = icmp sge i32 %t103, %t104
  %t232 = zext i1 %t230 to i32
  %t231 = icmp ne i32 %t232, 0
  br i1 %t231, label %B218, label %B219
B219:                               	; preds = %B218, %B225, %B229
  call void @putch(i32 10)
  ret i32 0
}
