declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a = global i32 0, align 4 
define i32 @func( i32 %t14) {
B12:
  %t13 = alloca i32, align 4
  store i32 %t14, i32* %t13, align 4
  %t3 = load i32, i32* %t13, align 4
  %t4 = sub i32 %t3, 1
  store i32 %t4, i32* %t13, align 4
  %t5 = load i32, i32* %t13, align 4
  ret i32 %t5
}
define i32 @main() {
B15:
  %t16 = alloca i32, align 4
  store i32 10, i32* @a, align 4
  %t9 = load i32, i32* @a, align 4
  %t10 = call i32 @func(i32 %t9)
  store i32 %t10, i32* %t16, align 4
  %t11 = load i32, i32* %t16, align 4
  ret i32 %t11
}
