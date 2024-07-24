declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a = global i32 1, align 4 
@b = global i32 0, align 4 
@c = global i32 1, align 4 
@d = global i32 2, align 4 
@e = global i32 4, align 4 
define i32 @main() {
B42:
  %t43 = alloca i32, align 4
  store i32 0, i32* %t43, align 4
  %t6 = load i32, i32* @a, align 4
  %t7 = load i32, i32* @b, align 4
  %t8 = mul i32 %t6, %t7
  %t9 = load i32, i32* @c, align 4
  %t10 = sdiv i32 %t8, %t9
  %t11 = load i32, i32* @e, align 4
  %t12 = load i32, i32* @d, align 4
  %t13 = add i32 %t11, %t12
  %t46 = icmp eq i32 %t10, %t13
  %t48 = zext i1 %t46 to i32
  %t47 = icmp ne i32 %t48, 0
  br i1 %t47, label %B49, label %B53
B49:                               	; preds = %B42, %B42
  %t15 = load i32, i32* @a, align 4
  %t16 = load i32, i32* @a, align 4
  %t17 = load i32, i32* @b, align 4
  %t18 = add i32 %t16, %t17
  %t19 = mul i32 %t15, %t18
  %t20 = load i32, i32* @c, align 4
  %t21 = add i32 %t19, %t20
  %t22 = load i32, i32* @d, align 4
  %t23 = load i32, i32* @e, align 4
  %t24 = add i32 %t22, %t23
  %t50 = icmp sle i32 %t21, %t24
  %t52 = zext i1 %t50 to i32
  %t51 = icmp ne i32 %t52, 0
  br i1 %t51, label %B44, label %B53
B53:                               	; preds = %B42, %B42, %B49
  %t27 = load i32, i32* @a, align 4
  %t28 = load i32, i32* @b, align 4
  %t29 = load i32, i32* @c, align 4
  %t30 = mul i32 %t28, %t29
  %t31 = sub i32 %t27, %t30
  %t32 = load i32, i32* @d, align 4
  %t33 = load i32, i32* @a, align 4
  %t34 = load i32, i32* @c, align 4
  %t35 = sdiv i32 %t33, %t34
  %t36 = sub i32 %t32, %t35
  %t54 = icmp eq i32 %t31, %t36
  %t56 = zext i1 %t54 to i32
  %t55 = icmp ne i32 %t56, 0
  br i1 %t55, label %B44, label %B45
B44:                               	; preds = %B49, %B53
  store i32 1, i32* %t43, align 4
  br label %B45
B45:                               	; preds = %B44, %B53
  %t40 = load i32, i32* %t43, align 4
  call void @putint(i32 %t40)
  %t41 = load i32, i32* %t43, align 4
  ret i32 %t41
}
