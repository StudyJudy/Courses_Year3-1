declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @main() {
B5:
  %t7 = alloca i32, align 4
  %t6 = alloca i32, align 4
  store i32 10, i32* %t6, align 4
  store i32 2, i32* %t7, align 4
  %t4 = load i32, i32* %t7, align 4
  ret i32 %t4
}
