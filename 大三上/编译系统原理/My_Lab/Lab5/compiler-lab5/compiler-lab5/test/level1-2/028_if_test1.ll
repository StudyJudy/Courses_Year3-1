declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @ifElse() {
B10:
  %t11 = alloca i32, align 4
  store i32 5, i32* %t11, align 4
  %t2 = load i32, i32* %t11, align 4
  %t15 = icmp eq i32 %t2, 5
  br i1 %t15, label %B12, label %B13
B12:                               	; preds = %B10
  store i32 25, i32* %t11, align 4
  br label %B14
B13:                               	; preds = %B10
  %t6 = load i32, i32* %t11, align 4
  %t7 = mul i32 %t6, 2
  store i32 %t7, i32* %t11, align 4
  br label %B14
B14:                               	; preds = %B12, %B13
  %t8 = load i32, i32* %t11, align 4
  ret i32 %t8
}
define i32 @main() {
B16:
  %t9 = call i32 @ifElse()
  ret i32 %t9
}
