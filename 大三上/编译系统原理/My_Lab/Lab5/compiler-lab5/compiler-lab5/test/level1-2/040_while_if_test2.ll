declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @ifWhile() {
B24:
  %t26 = alloca i32, align 4
  %t25 = alloca i32, align 4
  store i32 0, i32* %t25, align 4
  store i32 3, i32* %t26, align 4
  %t4 = load i32, i32* %t25, align 4
  %t30 = icmp eq i32 %t4, 5
  br i1 %t30, label %B27, label %B28
B27:                               	; preds = %B24
  br label %B31
B28:                               	; preds = %B24
  br label %B35
B31:                               	; preds = %B27, %B27, %B32
  %t6 = load i32, i32* %t26, align 4
  %t34 = icmp eq i32 %t6, 2
  br i1 %t34, label %B32, label %B33
B35:                               	; preds = %B28, %B28, %B36
  %t14 = load i32, i32* %t25, align 4
  %t38 = icmp slt i32 %t14, 5
  br i1 %t38, label %B36, label %B37
B32:                               	; preds = %B31
  %t9 = load i32, i32* %t26, align 4
  %t10 = add i32 %t9, 2
  store i32 %t10, i32* %t26, align 4
  br label %B31
B33:                               	; preds = %B31
  %t12 = load i32, i32* %t26, align 4
  %t13 = add i32 %t12, 25
  store i32 %t13, i32* %t26, align 4
  br label %B29
B36:                               	; preds = %B35
  %t17 = load i32, i32* %t26, align 4
  %t18 = mul i32 %t17, 2
  store i32 %t18, i32* %t26, align 4
  %t20 = load i32, i32* %t25, align 4
  %t21 = add i32 %t20, 1
  store i32 %t21, i32* %t25, align 4
  br label %B35
B37:                               	; preds = %B35
  br label %B29
B29:                               	; preds = %B33, %B37
  %t22 = load i32, i32* %t26, align 4
  ret i32 %t22
}
define i32 @main() {
B39:
  %t23 = call i32 @ifWhile()
  ret i32 %t23
}
