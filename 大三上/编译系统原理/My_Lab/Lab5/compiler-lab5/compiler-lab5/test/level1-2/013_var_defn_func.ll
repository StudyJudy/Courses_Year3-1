declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @defn() {
B3:
  ret i32 4
}
define i32 @main() {
B4:
  %t5 = alloca i32, align 4
  %t0 = call i32 @defn()
  store i32 %t0, i32* %t5, align 4
  %t2 = load i32, i32* %t5, align 4
  ret i32 %t2
}
