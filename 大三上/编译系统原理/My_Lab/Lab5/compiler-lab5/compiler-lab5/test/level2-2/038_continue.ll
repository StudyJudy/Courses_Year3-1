declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @main() {
B19:
  %t21 = alloca i32, align 4
  %t20 = alloca i32, align 4
  store i32 0, i32* %t20, align 4
  store i32 0, i32* %t21, align 4
  br label %B22
B22:                               	; preds = %B19, %B19, %B27
  %t4 = load i32, i32* %t20, align 4
  %t25 = icmp slt i32 %t4, 100
  br i1 %t25, label %B23, label %B24
B23:                               	; preds = %B22
  %t6 = load i32, i32* %t20, align 4
  %t28 = icmp eq i32 %t6, 50
  br i1 %t28, label %B26, label %B27
B24:                               	; preds = %B22
  %t18 = load i32, i32* %t21, align 4
  ret i32 %t18
B26:                               	; preds = %B23
  %t9 = load i32, i32* %t20, align 4
  %t10 = add i32 %t9, 1
  store i32 %t10, i32* %t20, align 4
  br label %B27
B27:                               	; preds = %B23, %B26
  %t12 = load i32, i32* %t21, align 4
  %t13 = load i32, i32* %t20, align 4
  %t14 = add i32 %t12, %t13
  store i32 %t14, i32* %t21, align 4
  %t16 = load i32, i32* %t20, align 4
  %t17 = add i32 %t16, 1
  store i32 %t17, i32* %t20, align 4
  br label %B22
}
