declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@a = global i32 0, align 4 
define i32 @main() {
B4:
  store i32 10, i32* @a, align 4
  %t2 = load i32, i32* @a, align 4
  %t8 = icmp sgt i32 %t2, 0
  br i1 %t8, label %B5, label %B6
B5:                               	; preds = %B4
  ret i32 1
  br label %B7
B6:                               	; preds = %B4
  ret i32 0
  br label %B7
B7:                               	; preds = %B5, %B6
  ret i32 0
}
