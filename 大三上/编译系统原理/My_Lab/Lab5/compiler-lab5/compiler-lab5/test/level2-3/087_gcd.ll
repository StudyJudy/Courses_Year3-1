declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @gcd( i32 %t26, i32 %t28) {
B24:
  %t27 = alloca i32, align 4
  %t25 = alloca i32, align 4
  store i32 %t26, i32* %t25, align 4
  store i32 %t28, i32* %t27, align 4
  %t2 = load i32, i32* %t27, align 4
  %t31 = icmp eq i32 %t2, 0
  br i1 %t31, label %B29, label %B30
B29:                               	; preds = %B24
  %t4 = load i32, i32* %t25, align 4
  ret i32 %t4
  br label %B30
B30:                               	; preds = %B24, %B29
  %t5 = load i32, i32* %t27, align 4
  %t6 = load i32, i32* %t25, align 4
  %t7 = load i32, i32* %t27, align 4
  %t8 = srem i32 %t6, %t7
  %t9 = call i32 @gcd(i32 %t5, i32 %t8)
  ret i32 %t9
}
define i32 @main() {
B32:
  %t39 = alloca i32, align 4
  %t38 = alloca i32, align 4
  %t33 = alloca i32, align 4
  %t10 = call i32 @getint()
  store i32 %t10, i32* %t33, align 4
  br label %B34
B34:                               	; preds = %B32, %B32, %B35
  %t12 = load i32, i32* %t33, align 4
  %t37 = icmp sgt i32 %t12, 0
  br i1 %t37, label %B35, label %B36
B35:                               	; preds = %B34
  %t14 = call i32 @getint()
  store i32 %t14, i32* %t38, align 4
  %t16 = call i32 @getint()
  store i32 %t16, i32* %t39, align 4
  %t18 = load i32, i32* %t38, align 4
  %t19 = load i32, i32* %t39, align 4
  %t20 = call i32 @gcd(i32 %t18, i32 %t19)
  call void @putint(i32 %t20)
  call void @putch(i32 10)
  %t22 = load i32, i32* %t33, align 4
  %t23 = sub i32 %t22, 1
  store i32 %t23, i32* %t33, align 4
  br label %B34
B36:                               	; preds = %B34
  ret i32 0
}
