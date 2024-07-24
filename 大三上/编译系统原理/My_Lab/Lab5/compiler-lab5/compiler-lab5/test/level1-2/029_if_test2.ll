declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @ifElseIf() {
B31:
  %t33 = alloca i32, align 4
  %t32 = alloca i32, align 4
  store i32 5, i32* %t32, align 4
  store i32 10, i32* %t33, align 4
  %t4 = load i32, i32* %t32, align 4
  %t37 = icmp eq i32 %t4, 6
  %t39 = zext i1 %t37 to i32
  %t38 = icmp ne i32 %t39, 0
  br i1 %t38, label %B34, label %B40
B40:                               	; preds = %B31, %B31
  %t6 = load i32, i32* %t33, align 4
  %t41 = icmp eq i32 %t6, 11
  %t43 = zext i1 %t41 to i32
  %t42 = icmp ne i32 %t43, 0
  br i1 %t42, label %B34, label %B35
B34:                               	; preds = %B31, %B40
  %t9 = load i32, i32* %t32, align 4
  ret i32 %t9
  br label %B36
B35:                               	; preds = %B40
  %t10 = load i32, i32* %t33, align 4
  %t47 = icmp eq i32 %t10, 10
  %t49 = zext i1 %t47 to i32
  %t48 = icmp ne i32 %t49, 0
  br i1 %t48, label %B50, label %B45
B36:                               	; preds = %B34, %B46
  %t29 = load i32, i32* %t32, align 4
  ret i32 %t29
B50:                               	; preds = %B35, %B35
  %t12 = load i32, i32* %t32, align 4
  %t51 = icmp eq i32 %t12, 1
  %t53 = zext i1 %t51 to i32
  %t52 = icmp ne i32 %t53, 0
  br i1 %t52, label %B44, label %B45
B45:                               	; preds = %B35, %B50
  %t16 = load i32, i32* %t33, align 4
  %t57 = icmp eq i32 %t16, 10
  %t59 = zext i1 %t57 to i32
  %t58 = icmp ne i32 %t59, 0
  br i1 %t58, label %B60, label %B55
B44:                               	; preds = %B50
  store i32 25, i32* %t32, align 4
  br label %B46
B60:                               	; preds = %B45, %B45
  %t18 = load i32, i32* %t32, align 4
  %t19 = sub i32 0, 5
  %t61 = icmp eq i32 %t18, %t19
  %t63 = zext i1 %t61 to i32
  %t62 = icmp ne i32 %t63, 0
  br i1 %t62, label %B54, label %B55
B55:                               	; preds = %B45, %B60
  %t26 = load i32, i32* %t32, align 4
  %t27 = add i32 0, %t26
  %t28 = sub i32 0, %t27
  store i32 %t28, i32* %t32, align 4
  br label %B56
B46:                               	; preds = %B44, %B56
  br label %B36
B54:                               	; preds = %B60
  %t23 = load i32, i32* %t32, align 4
  %t24 = add i32 %t23, 15
  store i32 %t24, i32* %t32, align 4
  br label %B56
B56:                               	; preds = %B54, %B55
  br label %B46
}
define i32 @main() {
B64:
  %t30 = call i32 @ifElseIf()
  call void @putint(i32 %t30)
  ret i32 0
}
