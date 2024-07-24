declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @enc( i32 %t34) {
B32:
  %t33 = alloca i32, align 4
  store i32 %t34, i32* %t33, align 4
  %t1 = load i32, i32* %t33, align 4
  %t38 = icmp sgt i32 %t1, 25
  br i1 %t38, label %B35, label %B36
B35:                               	; preds = %B32
  %t4 = load i32, i32* %t33, align 4
  %t5 = add i32 %t4, 60
  store i32 %t5, i32* %t33, align 4
  br label %B37
B36:                               	; preds = %B32
  %t7 = load i32, i32* %t33, align 4
  %t8 = sub i32 %t7, 15
  store i32 %t8, i32* %t33, align 4
  br label %B37
B37:                               	; preds = %B35, %B36
  %t9 = load i32, i32* %t33, align 4
  ret i32 %t9
}
define i32 @dec( i32 %t41) {
B39:
  %t40 = alloca i32, align 4
  store i32 %t41, i32* %t40, align 4
  %t11 = load i32, i32* %t40, align 4
  %t45 = icmp sgt i32 %t11, 85
  br i1 %t45, label %B42, label %B43
B42:                               	; preds = %B39
  %t14 = load i32, i32* %t40, align 4
  %t15 = sub i32 %t14, 59
  store i32 %t15, i32* %t40, align 4
  br label %B44
B43:                               	; preds = %B39
  %t17 = load i32, i32* %t40, align 4
  %t18 = add i32 %t17, 14
  store i32 %t18, i32* %t40, align 4
  br label %B44
B44:                               	; preds = %B42, %B43
  %t19 = load i32, i32* %t40, align 4
  ret i32 %t19
}
define i32 @main() {
B46:
  %t48 = alloca i32, align 4
  %t47 = alloca i32, align 4
  store i32 400, i32* %t47, align 4
  %t24 = load i32, i32* %t47, align 4
  %t25 = call i32 @enc(i32 %t24)
  store i32 %t25, i32* %t48, align 4
  %t27 = load i32, i32* %t48, align 4
  %t28 = call i32 @dec(i32 %t27)
  store i32 %t28, i32* %t48, align 4
  %t29 = load i32, i32* %t48, align 4
  call void @putint(i32 %t29)
  store i32 10, i32* %t48, align 4
  %t31 = load i32, i32* %t48, align 4
  call void @putch(i32 %t31)
  ret i32 0
}
