declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a = constant i32 10, align 4 
@b = constant i32 5, align 4 
define i32 @main() {
B3:
  %t2 = load i32, i32* @b, align 4
  ret i32 %t2
}
