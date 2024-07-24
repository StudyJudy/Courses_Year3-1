declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @putf(i32)

define i32 @func( i32 %t28) {
B26:
  %t27 = alloca i32, align 4
  store i32 %t28, i32* %t27, align 4
  %t1 = load i32, i32* %t27, align 4
  %t32 = icmp sle i32 %t1, 50
  br i1 %t32, label %B29, label %B30
B29:                               	; preds = %B26
  %t3 = load i32, i32* %t27, align 4
  call void @putint(i32 %t3)
  ret i32 1
  br label %B31
B30:                               	; preds = %B26
  %t4 = load i32, i32* %t27, align 4
  call void @putint(i32 %t4)
  ret i32 0
  br label %B31
B31:                               	; preds = %B29, %B30
  ret i32 0
}
define i32 @main() {
B33:
  %t34 = alloca i32, align 4
  %t6 = call i32 @func(i32 0)
  %t38 = icmp eq i32 %t6, 1
  %t40 = zext i1 %t38 to i32
  %t39 = icmp ne i32 %t40, 0
  br i1 %t39, label %B35, label %B41
B41:                               	; preds = %B33, %B33
  %t8 = call i32 @func(i32 50)
  %t42 = icmp eq i32 %t8, 1
  %t44 = zext i1 %t42 to i32
  %t43 = icmp ne i32 %t44, 0
  br i1 %t43, label %B45, label %B36
B35:                               	; preds = %B33, %B45
  store i32 0, i32* %t34, align 4
  br label %B37
B45:                               	; preds = %B41, %B41
  %t10 = call i32 @func(i32 100)
  %t46 = icmp eq i32 %t10, 0
  %t48 = zext i1 %t46 to i32
  %t47 = icmp ne i32 %t48, 0
  br i1 %t47, label %B35, label %B36
B36:                               	; preds = %B41, %B45
  store i32 1, i32* %t34, align 4
  br label %B37
B37:                               	; preds = %B35, %B36
  %t16 = call i32 @func(i32 50)
  %t52 = icmp eq i32 %t16, 1
  %t54 = zext i1 %t52 to i32
  %t53 = icmp ne i32 %t54, 0
  br i1 %t53, label %B55, label %B59
B55:                               	; preds = %B37, %B37
  %t18 = call i32 @func(i32 40)
  %t56 = icmp eq i32 %t18, 1
  %t58 = zext i1 %t56 to i32
  %t57 = icmp ne i32 %t58, 0
  br i1 %t57, label %B49, label %B59
B59:                               	; preds = %B37, %B37, %B55
  %t21 = call i32 @func(i32 1)
  %t60 = icmp eq i32 %t21, 1
  %t62 = zext i1 %t60 to i32
  %t61 = icmp ne i32 %t62, 0
  br i1 %t61, label %B49, label %B50
B49:                               	; preds = %B55, %B59
  store i32 0, i32* %t34, align 4
  br label %B51
B50:                               	; preds = %B59
  store i32 1, i32* %t34, align 4
  br label %B51
B51:                               	; preds = %B49, %B50
  ret i32 0
}
