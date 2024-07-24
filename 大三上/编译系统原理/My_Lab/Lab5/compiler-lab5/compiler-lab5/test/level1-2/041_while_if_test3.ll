declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @deepWhileBr( i32 %t35, i32 %t37) {
B33:
  %t50 = alloca i32, align 4
  %t43 = alloca i32, align 4
  %t38 = alloca i32, align 4
  %t36 = alloca i32, align 4
  %t34 = alloca i32, align 4
  store i32 %t35, i32* %t34, align 4
  store i32 %t37, i32* %t36, align 4
  %t4 = load i32, i32* %t34, align 4
  %t5 = load i32, i32* %t36, align 4
  %t6 = add i32 %t4, %t5
  store i32 %t6, i32* %t38, align 4
  br label %B39
B39:                               	; preds = %B33, %B33, %B45
  %t7 = load i32, i32* %t38, align 4
  %t42 = icmp slt i32 %t7, 75
  br i1 %t42, label %B40, label %B41
B40:                               	; preds = %B39
  store i32 42, i32* %t43, align 4
  %t11 = load i32, i32* %t38, align 4
  %t46 = icmp slt i32 %t11, 100
  br i1 %t46, label %B44, label %B45
B41:                               	; preds = %B39
  %t27 = load i32, i32* %t38, align 4
  ret i32 %t27
B44:                               	; preds = %B40
  %t14 = load i32, i32* %t38, align 4
  %t15 = load i32, i32* %t43, align 4
  %t16 = add i32 %t14, %t15
  store i32 %t16, i32* %t38, align 4
  %t17 = load i32, i32* %t38, align 4
  %t49 = icmp sgt i32 %t17, 99
  br i1 %t49, label %B47, label %B48
B45:                               	; preds = %B40, %B48
  br label %B39
B47:                               	; preds = %B44
  %t21 = load i32, i32* %t43, align 4
  %t22 = mul i32 %t21, 2
  store i32 %t22, i32* %t50, align 4
  %t53 = icmp eq i32 1, 1
  br i1 %t53, label %B51, label %B52
B48:                               	; preds = %B44, %B52
  br label %B45
B51:                               	; preds = %B47
  %t25 = load i32, i32* %t50, align 4
  %t26 = mul i32 %t25, 2
  store i32 %t26, i32* %t38, align 4
  br label %B52
B52:                               	; preds = %B47, %B51
  br label %B48
}
define i32 @main() {
B54:
  %t55 = alloca i32, align 4
  store i32 2, i32* %t55, align 4
  %t30 = load i32, i32* %t55, align 4
  %t31 = load i32, i32* %t55, align 4
  %t32 = call i32 @deepWhileBr(i32 %t30, i32 %t31)
  ret i32 %t32
}
