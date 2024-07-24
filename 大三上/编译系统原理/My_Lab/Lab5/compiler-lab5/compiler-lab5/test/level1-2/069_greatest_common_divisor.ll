declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @fun( i32 %t28, i32 %t30) {
B26:
  %t31 = alloca i32, align 4
  %t29 = alloca i32, align 4
  %t27 = alloca i32, align 4
  store i32 %t28, i32* %t27, align 4
  store i32 %t30, i32* %t29, align 4
  br label %B32
B32:                               	; preds = %B26, %B26, %B33
  %t3 = load i32, i32* %t29, align 4
  %t35 = icmp sgt i32 %t3, 0
  br i1 %t35, label %B33, label %B34
B33:                               	; preds = %B32
  %t6 = load i32, i32* %t27, align 4
  %t7 = load i32, i32* %t29, align 4
  %t8 = srem i32 %t6, %t7
  store i32 %t8, i32* %t31, align 4
  %t10 = load i32, i32* %t29, align 4
  store i32 %t10, i32* %t27, align 4
  %t12 = load i32, i32* %t31, align 4
  store i32 %t12, i32* %t29, align 4
  br label %B32
B34:                               	; preds = %B32
  %t13 = load i32, i32* %t27, align 4
  ret i32 %t13
}
define i32 @main() {
B36:
  %t39 = alloca i32, align 4
  %t38 = alloca i32, align 4
  %t37 = alloca i32, align 4
  %t18 = call i32 @getint()
  store i32 %t18, i32* %t38, align 4
  %t20 = call i32 @getint()
  store i32 %t20, i32* %t37, align 4
  %t22 = load i32, i32* %t38, align 4
  %t23 = load i32, i32* %t37, align 4
  %t24 = call i32 @fun(i32 %t22, i32 %t23)
  store i32 %t24, i32* %t39, align 4
  %t25 = load i32, i32* %t39, align 4
  call void @putint(i32 %t25)
  ret i32 0
}
