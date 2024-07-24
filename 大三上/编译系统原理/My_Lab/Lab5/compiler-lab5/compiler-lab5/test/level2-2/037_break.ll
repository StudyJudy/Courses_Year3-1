declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @main() {
B16:
  %t18 = alloca i32, align 4
  %t17 = alloca i32, align 4
  store i32 0, i32* %t17, align 4
  store i32 0, i32* %t18, align 4
  br label %B19
B19:                               	; preds = %B16, %B16, %B24
  %t4 = load i32, i32* %t17, align 4
  %t22 = icmp slt i32 %t4, 100
  br i1 %t22, label %B20, label %B21
B20:                               	; preds = %B19
  %t6 = load i32, i32* %t17, align 4
  %t25 = icmp eq i32 %t6, 50
  br i1 %t25, label %B23, label %B24
B21:                               	; preds = %B19
  %t15 = load i32, i32* %t18, align 4
  ret i32 %t15
B23:                               	; preds = %B20
  br label %B24
B24:                               	; preds = %B20, %B23
  %t9 = load i32, i32* %t18, align 4
  %t10 = load i32, i32* %t17, align 4
  %t11 = add i32 %t9, %t10
  store i32 %t11, i32* %t18, align 4
  %t13 = load i32, i32* %t17, align 4
  %t14 = add i32 %t13, 1
  store i32 %t14, i32* %t17, align 4
  br label %B19
}
