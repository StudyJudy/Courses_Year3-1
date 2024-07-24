declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @main() {
B42:
  %t47 = alloca i32, align 4
  %t46 = alloca i32, align 4
  %t45 = alloca i32, align 4
  %t44 = alloca i32, align 4
  %t43 = alloca i32, align 4
  store i32 5, i32* %t43, align 4
  store i32 5, i32* %t44, align 4
  store i32 1, i32* %t45, align 4
  %t9 = sub i32 0, 2
  store i32 %t9, i32* %t46, align 4
  store i32 2, i32* %t47, align 4
  %t11 = load i32, i32* %t46, align 4
  %t12 = mul i32 %t11, 1
  %t13 = sdiv i32 %t12, 2
  %t50 = icmp slt i32 %t13, 0
  %t52 = zext i1 %t50 to i32
  %t51 = icmp ne i32 %t52, 0
  br i1 %t51, label %B48, label %B53
B53:                               	; preds = %B42, %B42
  %t15 = load i32, i32* %t43, align 4
  %t16 = load i32, i32* %t44, align 4
  %t17 = sub i32 %t15, %t16
  %t54 = icmp ne i32 %t17, 0
  %t56 = zext i1 %t54 to i32
  %t55 = icmp ne i32 %t56, 0
  br i1 %t55, label %B57, label %B49
B48:                               	; preds = %B42, %B57
  %t25 = load i32, i32* %t47, align 4
  call void @putint(i32 %t25)
  br label %B49
B57:                               	; preds = %B53, %B53
  %t19 = load i32, i32* %t45, align 4
  %t20 = add i32 %t19, 3
  %t21 = srem i32 %t20, 2
  %t58 = icmp ne i32 %t21, 0
  %t60 = zext i1 %t58 to i32
  %t59 = icmp ne i32 %t60, 0
  br i1 %t59, label %B48, label %B49
B49:                               	; preds = %B48, %B53, %B57
  %t26 = load i32, i32* %t46, align 4
  %t27 = srem i32 %t26, 2
  %t28 = add i32 %t27, 67
  %t63 = icmp slt i32 %t28, 0
  %t65 = zext i1 %t63 to i32
  %t64 = icmp ne i32 %t65, 0
  br i1 %t64, label %B61, label %B66
B66:                               	; preds = %B49, %B49
  %t30 = load i32, i32* %t43, align 4
  %t31 = load i32, i32* %t44, align 4
  %t32 = sub i32 %t30, %t31
  %t67 = icmp ne i32 %t32, 0
  %t69 = zext i1 %t67 to i32
  %t68 = icmp ne i32 %t69, 0
  br i1 %t68, label %B70, label %B62
B61:                               	; preds = %B49, %B70
  store i32 4, i32* %t47, align 4
  %t41 = load i32, i32* %t47, align 4
  call void @putint(i32 %t41)
  br label %B62
B70:                               	; preds = %B66, %B66
  %t34 = load i32, i32* %t45, align 4
  %t35 = add i32 %t34, 2
  %t36 = srem i32 %t35, 2
  %t71 = icmp ne i32 %t36, 0
  %t73 = zext i1 %t71 to i32
  %t72 = icmp ne i32 %t73, 0
  br i1 %t72, label %B61, label %B62
B62:                               	; preds = %B61, %B66, %B70
  ret i32 0
}
