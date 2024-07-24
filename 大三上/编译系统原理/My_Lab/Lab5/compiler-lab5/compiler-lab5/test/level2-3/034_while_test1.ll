declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @doubleWhile() {
B19:
  %t21 = alloca i32, align 4
  %t20 = alloca i32, align 4
  store i32 5, i32* %t20, align 4
  store i32 7, i32* %t21, align 4
  br label %B22
B22:                               	; preds = %B19, %B19, %B28
  %t4 = load i32, i32* %t20, align 4
  %t25 = icmp slt i32 %t4, 100
  br i1 %t25, label %B23, label %B24
B23:                               	; preds = %B22
  %t7 = load i32, i32* %t20, align 4
  %t8 = add i32 %t7, 30
  store i32 %t8, i32* %t20, align 4
  br label %B26
B24:                               	; preds = %B22
  %t17 = load i32, i32* %t21, align 4
  ret i32 %t17
B26:                               	; preds = %B23, %B23, %B27
  %t9 = load i32, i32* %t21, align 4
  %t29 = icmp slt i32 %t9, 100
  br i1 %t29, label %B27, label %B28
B27:                               	; preds = %B26
  %t12 = load i32, i32* %t21, align 4
  %t13 = add i32 %t12, 6
  store i32 %t13, i32* %t21, align 4
  br label %B26
B28:                               	; preds = %B26
  %t15 = load i32, i32* %t21, align 4
  %t16 = sub i32 %t15, 100
  store i32 %t16, i32* %t21, align 4
  br label %B22
}
define i32 @main() {
B30:
  %t18 = call i32 @doubleWhile()
  ret i32 %t18
}
