declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @main() {
B22:
  %t29 = alloca i32, align 4
  %t24 = alloca i32, align 4
  %t23 = alloca i32, align 4
  store i32 0, i32* %t23, align 4
  store i32 0, i32* %t24, align 4
  br label %B25
B25:                               	; preds = %B22, %B22, %B32
  %t2 = load i32, i32* %t24, align 4
  %t28 = icmp slt i32 %t2, 10
  br i1 %t28, label %B26, label %B27
B26:                               	; preds = %B25
  store i32 10, i32* %t29, align 4
  br label %B30
B27:                               	; preds = %B25
  ret i32 0
B30:                               	; preds = %B26, %B26, %B35
  %t5 = load i32, i32* %t29, align 4
  %t33 = icmp ne i32 %t5, 0
  br i1 %t33, label %B31, label %B32
B31:                               	; preds = %B30
  %t6 = load i32, i32* %t24, align 4
  %t36 = icmp ne i32 %t6, 0
  br i1 %t36, label %B37, label %B35
B32:                               	; preds = %B30
  %t19 = load i32, i32* %t24, align 4
  %t20 = load i32, i32* %t24, align 4
  %t21 = add i32 %t19, %t20
  store i32 %t21, i32* %t24, align 4
  br label %B25
B37:                               	; preds = %B31, %B31
  %t7 = load i32, i32* %t29, align 4
  %t38 = icmp ne i32 %t7, 0
  br i1 %t38, label %B34, label %B35
B35:                               	; preds = %B31, %B34, %B37
  %t16 = load i32, i32* %t29, align 4
  %t17 = sub i32 %t16, 1
  store i32 %t17, i32* %t29, align 4
  br label %B30
B34:                               	; preds = %B37
  %t10 = load i32, i32* %t23, align 4
  %t11 = load i32, i32* %t24, align 4
  %t12 = add i32 %t10, %t11
  %t13 = load i32, i32* %t29, align 4
  %t14 = add i32 %t12, %t13
  store i32 %t14, i32* %t23, align 4
  br label %B35
}
