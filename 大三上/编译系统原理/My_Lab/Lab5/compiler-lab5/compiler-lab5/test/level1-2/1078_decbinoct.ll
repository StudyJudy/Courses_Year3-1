declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @dec2bin( i32 %t38) {
B36:
  %t42 = alloca i32, align 4
  %t41 = alloca i32, align 4
  %t40 = alloca i32, align 4
  %t39 = alloca i32, align 4
  %t37 = alloca i32, align 4
  store i32 %t38, i32* %t37, align 4
  store i32 0, i32* %t39, align 4
  store i32 1, i32* %t40, align 4
  %t8 = load i32, i32* %t37, align 4
  store i32 %t8, i32* %t42, align 4
  br label %B43
B43:                               	; preds = %B36, %B36, %B44
  %t9 = load i32, i32* %t42, align 4
  %t46 = icmp ne i32 %t9, 0
  br i1 %t46, label %B44, label %B45
B44:                               	; preds = %B43
  %t12 = load i32, i32* %t42, align 4
  %t13 = srem i32 %t12, 2
  store i32 %t13, i32* %t41, align 4
  %t15 = load i32, i32* %t40, align 4
  %t16 = load i32, i32* %t41, align 4
  %t17 = mul i32 %t15, %t16
  %t18 = load i32, i32* %t39, align 4
  %t19 = add i32 %t17, %t18
  store i32 %t19, i32* %t39, align 4
  %t21 = load i32, i32* %t40, align 4
  %t22 = mul i32 %t21, 10
  store i32 %t22, i32* %t40, align 4
  %t24 = load i32, i32* %t42, align 4
  %t25 = sdiv i32 %t24, 2
  store i32 %t25, i32* %t42, align 4
  br label %B43
B45:                               	; preds = %B43
  %t26 = load i32, i32* %t39, align 4
  ret i32 %t26
}
define i32 @main() {
B47:
  %t49 = alloca i32, align 4
  %t48 = alloca i32, align 4
  store i32 400, i32* %t48, align 4
  %t31 = load i32, i32* %t48, align 4
  %t32 = call i32 @dec2bin(i32 %t31)
  store i32 %t32, i32* %t49, align 4
  %t33 = load i32, i32* %t49, align 4
  call void @putint(i32 %t33)
  store i32 10, i32* %t49, align 4
  %t35 = load i32, i32* %t49, align 4
  call void @putch(i32 %t35)
  ret i32 0
}
