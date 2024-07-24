declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @FourWhile() {
B45:
  %t49 = alloca i32, align 4
  %t48 = alloca i32, align 4
  %t47 = alloca i32, align 4
  %t46 = alloca i32, align 4
  store i32 5, i32* %t46, align 4
  store i32 6, i32* %t47, align 4
  store i32 7, i32* %t48, align 4
  store i32 10, i32* %t49, align 4
  br label %B50
B50:                               	; preds = %B45, %B45, %B56
  %t8 = load i32, i32* %t46, align 4
  %t53 = icmp slt i32 %t8, 20
  br i1 %t53, label %B51, label %B52
B51:                               	; preds = %B50
  %t11 = load i32, i32* %t46, align 4
  %t12 = add i32 %t11, 3
  store i32 %t12, i32* %t46, align 4
  br label %B54
B52:                               	; preds = %B50
  %t37 = load i32, i32* %t46, align 4
  %t38 = load i32, i32* %t47, align 4
  %t39 = load i32, i32* %t49, align 4
  %t40 = add i32 %t38, %t39
  %t41 = add i32 %t37, %t40
  %t42 = load i32, i32* %t48, align 4
  %t43 = add i32 %t41, %t42
  ret i32 %t43
B54:                               	; preds = %B51, %B51, %B60
  %t13 = load i32, i32* %t47, align 4
  %t57 = icmp slt i32 %t13, 10
  br i1 %t57, label %B55, label %B56
B55:                               	; preds = %B54
  %t16 = load i32, i32* %t47, align 4
  %t17 = add i32 %t16, 1
  store i32 %t17, i32* %t47, align 4
  br label %B58
B56:                               	; preds = %B54
  %t35 = load i32, i32* %t47, align 4
  %t36 = sub i32 %t35, 2
  store i32 %t36, i32* %t47, align 4
  br label %B50
B58:                               	; preds = %B55, %B55, %B64
  %t18 = load i32, i32* %t48, align 4
  %t61 = icmp eq i32 %t18, 7
  br i1 %t61, label %B59, label %B60
B59:                               	; preds = %B58
  %t21 = load i32, i32* %t48, align 4
  %t22 = sub i32 %t21, 1
  store i32 %t22, i32* %t48, align 4
  br label %B62
B60:                               	; preds = %B58
  %t32 = load i32, i32* %t48, align 4
  %t33 = add i32 %t32, 1
  store i32 %t33, i32* %t48, align 4
  br label %B54
B62:                               	; preds = %B59, %B59, %B63
  %t23 = load i32, i32* %t49, align 4
  %t65 = icmp slt i32 %t23, 20
  br i1 %t65, label %B63, label %B64
B63:                               	; preds = %B62
  %t26 = load i32, i32* %t49, align 4
  %t27 = add i32 %t26, 3
  store i32 %t27, i32* %t49, align 4
  br label %B62
B64:                               	; preds = %B62
  %t29 = load i32, i32* %t49, align 4
  %t30 = sub i32 %t29, 1
  store i32 %t30, i32* %t49, align 4
  br label %B58
}
define i32 @main() {
B66:
  %t44 = call i32 @FourWhile()
  ret i32 %t44
}
