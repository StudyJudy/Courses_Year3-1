declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@N = global i32 0, align 4 
@newline = global i32 0, align 4 
define i32 @factor( i32 %t33) {
B31:
  %t35 = alloca i32, align 4
  %t34 = alloca i32, align 4
  %t32 = alloca i32, align 4
  store i32 %t33, i32* %t32, align 4
  store i32 0, i32* %t35, align 4
  store i32 1, i32* %t34, align 4
  br label %B36
B36:                               	; preds = %B31, %B31, %B41
  %t7 = load i32, i32* %t34, align 4
  %t8 = load i32, i32* %t32, align 4
  %t9 = add i32 %t8, 1
  %t39 = icmp slt i32 %t7, %t9
  br i1 %t39, label %B37, label %B38
B37:                               	; preds = %B36
  %t11 = load i32, i32* %t32, align 4
  %t12 = load i32, i32* %t34, align 4
  %t13 = srem i32 %t11, %t12
  %t42 = icmp eq i32 %t13, 0
  br i1 %t42, label %B40, label %B41
B38:                               	; preds = %B36
  %t22 = load i32, i32* %t35, align 4
  ret i32 %t22
B40:                               	; preds = %B37
  %t16 = load i32, i32* %t35, align 4
  %t17 = load i32, i32* %t34, align 4
  %t18 = add i32 %t16, %t17
  store i32 %t18, i32* %t35, align 4
  br label %B41
B41:                               	; preds = %B37, %B40
  %t20 = load i32, i32* %t34, align 4
  %t21 = add i32 %t20, 1
  store i32 %t21, i32* %t34, align 4
  br label %B36
}
define i32 @main() {
B43:
  %t46 = alloca i32, align 4
  %t45 = alloca i32, align 4
  %t44 = alloca i32, align 4
  store i32 4, i32* @N, align 4
  store i32 10, i32* @newline, align 4
  store i32 1478, i32* %t45, align 4
  %t29 = load i32, i32* %t45, align 4
  %t30 = call i32 @factor(i32 %t29)
  ret i32 %t30
}
