declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @whileIf() {
B20:
  %t22 = alloca i32, align 4
  %t21 = alloca i32, align 4
  store i32 0, i32* %t21, align 4
  store i32 0, i32* %t22, align 4
  br label %B23
B23:                               	; preds = %B20, %B20, %B29
  %t4 = load i32, i32* %t21, align 4
  %t26 = icmp slt i32 %t4, 100
  br i1 %t26, label %B24, label %B25
B24:                               	; preds = %B23
  %t6 = load i32, i32* %t21, align 4
  %t30 = icmp eq i32 %t6, 5
  br i1 %t30, label %B27, label %B28
B25:                               	; preds = %B23
  %t18 = load i32, i32* %t22, align 4
  ret i32 %t18
B27:                               	; preds = %B24
  store i32 25, i32* %t22, align 4
  br label %B29
B28:                               	; preds = %B24
  %t9 = load i32, i32* %t21, align 4
  %t34 = icmp eq i32 %t9, 10
  br i1 %t34, label %B31, label %B32
B29:                               	; preds = %B27, %B33
  %t16 = load i32, i32* %t21, align 4
  %t17 = add i32 %t16, 1
  store i32 %t17, i32* %t21, align 4
  br label %B23
B31:                               	; preds = %B28
  store i32 42, i32* %t22, align 4
  br label %B33
B32:                               	; preds = %B28
  %t13 = load i32, i32* %t21, align 4
  %t14 = mul i32 %t13, 2
  store i32 %t14, i32* %t22, align 4
  br label %B33
B33:                               	; preds = %B31, %B32
  br label %B29
}
define i32 @main() {
B35:
  %t19 = call i32 @whileIf()
  ret i32 %t19
}
