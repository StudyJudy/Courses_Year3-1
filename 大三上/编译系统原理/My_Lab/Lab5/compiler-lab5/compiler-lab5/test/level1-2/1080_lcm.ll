declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@n = global i32 0, align 4 
define i32 @gcd( i32 %t50, i32 %t52) {
B48:
  %t56 = alloca i32, align 4
  %t55 = alloca i32, align 4
  %t54 = alloca i32, align 4
  %t53 = alloca i32, align 4
  %t51 = alloca i32, align 4
  %t49 = alloca i32, align 4
  store i32 %t50, i32* %t49, align 4
  store i32 %t52, i32* %t51, align 4
  %t6 = load i32, i32* %t49, align 4
  store i32 %t6, i32* %t53, align 4
  %t8 = load i32, i32* %t51, align 4
  store i32 %t8, i32* %t54, align 4
  %t11 = load i32, i32* %t49, align 4
  %t12 = load i32, i32* %t51, align 4
  %t59 = icmp slt i32 %t11, %t12
  br i1 %t59, label %B57, label %B58
B57:                               	; preds = %B48
  %t15 = load i32, i32* %t49, align 4
  store i32 %t15, i32* %t55, align 4
  %t17 = load i32, i32* %t51, align 4
  store i32 %t17, i32* %t49, align 4
  %t19 = load i32, i32* %t55, align 4
  store i32 %t19, i32* %t51, align 4
  br label %B58
B58:                               	; preds = %B48, %B57
  %t21 = load i32, i32* %t49, align 4
  %t22 = load i32, i32* %t51, align 4
  %t23 = srem i32 %t21, %t22
  store i32 %t23, i32* %t56, align 4
  br label %B60
B60:                               	; preds = %B58, %B58, %B61
  %t24 = load i32, i32* %t56, align 4
  %t63 = icmp ne i32 %t24, 0
  br i1 %t63, label %B61, label %B62
B61:                               	; preds = %B60
  %t27 = load i32, i32* %t51, align 4
  store i32 %t27, i32* %t49, align 4
  %t29 = load i32, i32* %t56, align 4
  store i32 %t29, i32* %t51, align 4
  %t31 = load i32, i32* %t49, align 4
  %t32 = load i32, i32* %t51, align 4
  %t33 = srem i32 %t31, %t32
  store i32 %t33, i32* %t56, align 4
  br label %B60
B62:                               	; preds = %B60
  %t34 = load i32, i32* %t53, align 4
  %t35 = load i32, i32* %t54, align 4
  %t36 = mul i32 %t34, %t35
  %t37 = load i32, i32* %t51, align 4
  %t38 = sdiv i32 %t36, %t37
  ret i32 %t38
}
define i32 @main() {
B64:
  %t66 = alloca i32, align 4
  %t65 = alloca i32, align 4
  %t42 = call i32 @getint()
  store i32 %t42, i32* %t65, align 4
  %t44 = call i32 @getint()
  store i32 %t44, i32* %t66, align 4
  %t45 = load i32, i32* %t65, align 4
  %t46 = load i32, i32* %t66, align 4
  %t47 = call i32 @gcd(i32 %t45, i32 %t46)
  ret i32 %t47
}
