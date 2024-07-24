declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a = global i32 0, align 4 
@b = global i32 0, align 4 
define i32 @main() {
B16:
  %t17 = alloca i32, align 4
  %t3 = call i32 @getint()
  store i32 %t3, i32* @a, align 4
  %t5 = call i32 @getint()
  store i32 %t5, i32* @b, align 4
  %t7 = load i32, i32* @a, align 4
  %t8 = load i32, i32* @b, align 4
  %t21 = icmp eq i32 %t7, %t8
  %t23 = zext i1 %t21 to i32
  %t22 = icmp ne i32 %t23, 0
  br i1 %t22, label %B24, label %B19
B24:                               	; preds = %B16, %B16
  %t10 = load i32, i32* @a, align 4
  %t25 = icmp ne i32 %t10, 3
  %t27 = zext i1 %t25 to i32
  %t26 = icmp ne i32 %t27, 0
  br i1 %t26, label %B18, label %B19
B19:                               	; preds = %B16, %B24
  store i32 0, i32* %t17, align 4
  br label %B20
B18:                               	; preds = %B24
  store i32 1, i32* %t17, align 4
  br label %B20
B20:                               	; preds = %B18, %B19
  %t15 = load i32, i32* %t17, align 4
  ret i32 %t15
}
