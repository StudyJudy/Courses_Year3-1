declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @main() {
B38:
  %t42 = alloca i32, align 4
  %t41 = alloca i32, align 4
  %t40 = alloca i32, align 4
  %t39 = alloca i32, align 4
  store i32 0, i32* %t39, align 4
  store i32 0, i32* %t40, align 4
  store i32 0, i32* %t41, align 4
  br label %B43
B43:                               	; preds = %B38, %B38, %B49
  %t7 = load i32, i32* %t39, align 4
  %t46 = icmp slt i32 %t7, 21
  br i1 %t46, label %B44, label %B45
B44:                               	; preds = %B43
  br label %B47
B45:                               	; preds = %B43
  ret i32 0
B47:                               	; preds = %B44, %B44, %B52
  %t9 = load i32, i32* %t40, align 4
  %t10 = load i32, i32* %t39, align 4
  %t11 = sub i32 101, %t10
  %t50 = icmp slt i32 %t9, %t11
  br i1 %t50, label %B48, label %B49
B48:                               	; preds = %B47
  %t14 = load i32, i32* %t39, align 4
  %t15 = sub i32 100, %t14
  %t16 = load i32, i32* %t40, align 4
  %t17 = sub i32 %t15, %t16
  store i32 %t17, i32* %t41, align 4
  %t18 = load i32, i32* %t39, align 4
  %t19 = mul i32 5, %t18
  %t20 = load i32, i32* %t40, align 4
  %t21 = mul i32 1, %t20
  %t22 = add i32 %t19, %t21
  %t23 = load i32, i32* %t41, align 4
  %t24 = sdiv i32 %t23, 2
  %t25 = add i32 %t22, %t24
  %t53 = icmp eq i32 %t25, 100
  br i1 %t53, label %B51, label %B52
B49:                               	; preds = %B47
  %t36 = load i32, i32* %t39, align 4
  %t37 = add i32 %t36, 1
  store i32 %t37, i32* %t39, align 4
  br label %B43
B51:                               	; preds = %B48
  %t27 = load i32, i32* %t39, align 4
  call void @putint(i32 %t27)
  %t28 = load i32, i32* %t40, align 4
  call void @putint(i32 %t28)
  %t29 = load i32, i32* %t41, align 4
  call void @putint(i32 %t29)
  store i32 10, i32* %t42, align 4
  %t31 = load i32, i32* %t42, align 4
  call void @putch(i32 %t31)
  br label %B52
B52:                               	; preds = %B48, %B51
  %t33 = load i32, i32* %t40, align 4
  %t34 = add i32 %t33, 1
  store i32 %t34, i32* %t40, align 4
  br label %B47
}
