declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @main() {
B17:
  %t20 = alloca i32, align 4
  %t19 = alloca i32, align 4
  %t18 = alloca i32, align 4
  %t4 = add i32 1, 2
  %t5 = add i32 %t4, 3
  store i32 %t5, i32* %t18, align 4
  %t7 = add i32 2, 3
  %t8 = add i32 %t7, 4
  store i32 %t8, i32* %t19, align 4
  %t9 = load i32, i32* %t18, align 4
  %t10 = load i32, i32* %t19, align 4
  %t24 = icmp slt i32 %t9, %t10
  br i1 %t24, label %B21, label %B22
B21:                               	; preds = %B17
  %t13 = load i32, i32* %t18, align 4
  store i32 %t13, i32* %t20, align 4
  br label %B23
B22:                               	; preds = %B17
  %t15 = load i32, i32* %t19, align 4
  store i32 %t15, i32* %t20, align 4
  br label %B23
B23:                               	; preds = %B21, %B22
  %t16 = load i32, i32* %t20, align 4
  ret i32 %t16
}
