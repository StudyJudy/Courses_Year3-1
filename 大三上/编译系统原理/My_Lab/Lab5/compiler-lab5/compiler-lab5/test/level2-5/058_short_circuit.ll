declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

@g = global i32 0, align 4 
define i32 @func( i32 %t53) {
B51:
  %t52 = alloca i32, align 4
  store i32 %t53, i32* %t52, align 4
  %t3 = load i32, i32* @g, align 4
  %t4 = load i32, i32* %t52, align 4
  %t5 = add i32 %t3, %t4
  store i32 %t5, i32* @g, align 4
  %t6 = load i32, i32* @g, align 4
  call void @putint(i32 %t6)
  %t7 = load i32, i32* @g, align 4
  ret i32 %t7
}
define i32 @main() {
B54:
  %t55 = alloca i32, align 4
  %t10 = call i32 @getint()
  store i32 %t10, i32* %t55, align 4
  %t11 = load i32, i32* %t55, align 4
  %t59 = icmp sgt i32 %t11, 10
  %t61 = zext i1 %t59 to i32
  %t60 = icmp ne i32 %t61, 0
  br i1 %t60, label %B62, label %B57
B62:                               	; preds = %B54, %B54
  %t13 = load i32, i32* %t55, align 4
  %t14 = call i32 @func(i32 %t13)
  %t63 = icmp ne i32 %t14, 0
  br i1 %t63, label %B56, label %B57
B57:                               	; preds = %B54, %B62
  store i32 0, i32* %t55, align 4
  br label %B58
B56:                               	; preds = %B62
  store i32 1, i32* %t55, align 4
  br label %B58
B58:                               	; preds = %B56, %B57
  %t19 = call i32 @getint()
  store i32 %t19, i32* %t55, align 4
  %t20 = load i32, i32* %t55, align 4
  %t67 = icmp sgt i32 %t20, 11
  %t69 = zext i1 %t67 to i32
  %t68 = icmp ne i32 %t69, 0
  br i1 %t68, label %B70, label %B65
B70:                               	; preds = %B58, %B58
  %t22 = load i32, i32* %t55, align 4
  %t23 = call i32 @func(i32 %t22)
  %t71 = icmp ne i32 %t23, 0
  br i1 %t71, label %B64, label %B65
B65:                               	; preds = %B58, %B70
  store i32 0, i32* %t55, align 4
  br label %B66
B64:                               	; preds = %B70
  store i32 1, i32* %t55, align 4
  br label %B66
B66:                               	; preds = %B64, %B65
  %t28 = call i32 @getint()
  store i32 %t28, i32* %t55, align 4
  %t29 = load i32, i32* %t55, align 4
  %t75 = icmp sle i32 %t29, 99
  %t77 = zext i1 %t75 to i32
  %t76 = icmp ne i32 %t77, 0
  br i1 %t76, label %B72, label %B78
B78:                               	; preds = %B66, %B66
  %t31 = load i32, i32* %t55, align 4
  %t32 = call i32 @func(i32 %t31)
  %t79 = icmp ne i32 %t32, 0
  br i1 %t79, label %B72, label %B73
B72:                               	; preds = %B66, %B78
  store i32 1, i32* %t55, align 4
  br label %B74
B73:                               	; preds = %B78
  store i32 0, i32* %t55, align 4
  br label %B74
B74:                               	; preds = %B72, %B73
  %t37 = call i32 @getint()
  store i32 %t37, i32* %t55, align 4
  %t38 = load i32, i32* %t55, align 4
  %t83 = icmp sle i32 %t38, 100
  %t85 = zext i1 %t83 to i32
  %t84 = icmp ne i32 %t85, 0
  br i1 %t84, label %B80, label %B86
B86:                               	; preds = %B74, %B74
  %t40 = load i32, i32* %t55, align 4
  %t41 = call i32 @func(i32 %t40)
  %t87 = icmp ne i32 %t41, 0
  br i1 %t87, label %B80, label %B81
B80:                               	; preds = %B74, %B86
  store i32 1, i32* %t55, align 4
  br label %B82
B81:                               	; preds = %B86
  store i32 0, i32* %t55, align 4
  br label %B82
B82:                               	; preds = %B80, %B81
  %t45 = call i32 @func(i32 99)
  %t46 = icmp eq i32 %t45, 0
  %t93 = zext i1 %t46 to i32
  %t92 = icmp ne i32 %t93, 0
  br i1 %t92, label %B94, label %B89
B94:                               	; preds = %B82, %B82
  %t47 = call i32 @func(i32 100)
  %t95 = icmp ne i32 %t47, 0
  br i1 %t95, label %B88, label %B89
B89:                               	; preds = %B82, %B94
  store i32 0, i32* %t55, align 4
  br label %B90
B88:                               	; preds = %B94
  store i32 1, i32* %t55, align 4
  br label %B90
B90:                               	; preds = %B88, %B89
  ret i32 0
}
