declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @get_one( i32 %t39) {
B37:
  %t38 = alloca i32, align 4
  store i32 %t39, i32* %t38, align 4
  ret i32 1
}
define i32 @deepWhileBr( i32 %t42, i32 %t44) {
B40:
  %t57 = alloca i32, align 4
  %t50 = alloca i32, align 4
  %t45 = alloca i32, align 4
  %t43 = alloca i32, align 4
  %t41 = alloca i32, align 4
  store i32 %t42, i32* %t41, align 4
  store i32 %t44, i32* %t43, align 4
  %t5 = load i32, i32* %t41, align 4
  %t6 = load i32, i32* %t43, align 4
  %t7 = add i32 %t5, %t6
  store i32 %t7, i32* %t45, align 4
  br label %B46
B46:                               	; preds = %B40, %B40, %B52
  %t8 = load i32, i32* %t45, align 4
  %t49 = icmp slt i32 %t8, 75
  br i1 %t49, label %B47, label %B48
B47:                               	; preds = %B46
  store i32 42, i32* %t50, align 4
  %t12 = load i32, i32* %t45, align 4
  %t53 = icmp slt i32 %t12, 100
  br i1 %t53, label %B51, label %B52
B48:                               	; preds = %B46
  %t29 = load i32, i32* %t45, align 4
  ret i32 %t29
B51:                               	; preds = %B47
  %t15 = load i32, i32* %t45, align 4
  %t16 = load i32, i32* %t50, align 4
  %t17 = add i32 %t15, %t16
  store i32 %t17, i32* %t45, align 4
  %t18 = load i32, i32* %t45, align 4
  %t56 = icmp sgt i32 %t18, 99
  br i1 %t56, label %B54, label %B55
B52:                               	; preds = %B47, %B55
  br label %B46
B54:                               	; preds = %B51
  %t22 = load i32, i32* %t50, align 4
  %t23 = mul i32 %t22, 2
  store i32 %t23, i32* %t57, align 4
  %t24 = call i32 @get_one(i32 0)
  %t60 = icmp eq i32 %t24, 1
  br i1 %t60, label %B58, label %B59
B55:                               	; preds = %B51, %B59
  br label %B52
B58:                               	; preds = %B54
  %t27 = load i32, i32* %t57, align 4
  %t28 = mul i32 %t27, 2
  store i32 %t28, i32* %t45, align 4
  br label %B59
B59:                               	; preds = %B54, %B58
  br label %B55
}
define i32 @main() {
B61:
  %t62 = alloca i32, align 4
  store i32 2, i32* %t62, align 4
  %t33 = load i32, i32* %t62, align 4
  %t34 = load i32, i32* %t62, align 4
  %t35 = call i32 @deepWhileBr(i32 %t33, i32 %t34)
  store i32 %t35, i32* %t62, align 4
  %t36 = load i32, i32* %t62, align 4
  call void @putint(i32 %t36)
  ret i32 0
}
