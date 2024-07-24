declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @f( i32 %t24, i32 %t26) {
B22:
  %t25 = alloca i32, align 4
  %t23 = alloca i32, align 4
  store i32 %t24, i32* %t23, align 4
  store i32 %t26, i32* %t25, align 4
  %t2 = load i32, i32* %t23, align 4
  %t3 = load i32, i32* %t25, align 4
  %t4 = mul i32 %t2, %t3
  ret i32 %t4
}
define i32 @g( i32 %t29, i32 %t31) {
B27:
  %t30 = alloca i32, align 4
  %t28 = alloca i32, align 4
  store i32 %t29, i32* %t28, align 4
  store i32 %t31, i32* %t30, align 4
  %t7 = load i32, i32* %t28, align 4
  %t8 = load i32, i32* %t30, align 4
  %t9 = srem i32 %t7, %t8
  ret i32 %t9
}
define i32 @h( i32 %t34, i32 %t36) {
B32:
  %t35 = alloca i32, align 4
  %t33 = alloca i32, align 4
  store i32 %t34, i32* %t33, align 4
  store i32 %t36, i32* %t35, align 4
  %t12 = load i32, i32* %t33, align 4
  %t13 = load i32, i32* %t35, align 4
  %t14 = call i32 @g(i32 %t12, i32 %t13)
  %t15 = call i32 @f(i32 2, i32 %t14)
  %t16 = load i32, i32* %t33, align 4
  %t17 = load i32, i32* %t35, align 4
  %t18 = call i32 @f(i32 %t16, i32 %t17)
  %t19 = call i32 @g(i32 %t18, i32 4)
  %t20 = call i32 @f(i32 %t15, i32 %t19)
  ret i32 %t20
}
define i32 @main() {
B37:
  %t21 = call i32 @h(i32 11, i32 3)
  call void @putint(i32 %t21)
  ret i32 0
}
