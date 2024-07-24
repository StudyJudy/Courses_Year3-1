declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @ififElse() {
B14:
  %t16 = alloca i32, align 4
  %t15 = alloca i32, align 4
  store i32 5, i32* %t15, align 4
  store i32 10, i32* %t16, align 4
  %t4 = load i32, i32* %t15, align 4
  %t19 = icmp eq i32 %t4, 5
  br i1 %t19, label %B17, label %B18
B17:                               	; preds = %B14
  %t6 = load i32, i32* %t16, align 4
  %t23 = icmp eq i32 %t6, 10
  br i1 %t23, label %B20, label %B21
B18:                               	; preds = %B14, %B22
  %t12 = load i32, i32* %t15, align 4
  ret i32 %t12
B20:                               	; preds = %B17
  store i32 25, i32* %t15, align 4
  br label %B22
B21:                               	; preds = %B17
  %t10 = load i32, i32* %t15, align 4
  %t11 = add i32 %t10, 15
  store i32 %t11, i32* %t15, align 4
  br label %B22
B22:                               	; preds = %B20, %B21
  br label %B18
}
define i32 @main() {
B24:
  %t13 = call i32 @ififElse()
  ret i32 %t13
}
