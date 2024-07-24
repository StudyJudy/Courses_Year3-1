declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a = constant i32 10, align 4 
define i32 @main() {
B2:
  %t1 = load i32, i32* @a, align 4
  ret i32 %t1
}
