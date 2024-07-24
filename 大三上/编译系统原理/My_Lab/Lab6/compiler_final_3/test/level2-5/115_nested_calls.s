	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global func1
	.type func1 , %function
func1:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #12
.L58:
	str r0, [fp, #-12]
	str r1, [fp, #-8]
	str r2, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L62
	b .L67
.L62:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-8]
	mul r8, r10, r9
	mov r0, r8
	b .Lfunc1_END
.L67:
	b .L63
.L63:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-8]
	ldr r8, [fp, #-4]
	sub r7, r9, r8
	mov r2, #0
	mov r1, r7
	mov r0, r10
	bl func1
	mov r10, r0
	mov r0, r10
	b .Lfunc1_END
.Lfunc1_END:
	add sp, sp, #12
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global func2
	.type func2 , %function
func2:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L74:
	str r0, [fp, #-8]
	str r1, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L77
	b .L82
.L77:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	mov r1, #0
	mov r0, r8
	bl func2
	mov r10, r0
	mov r0, r10
	b .Lfunc2_END
.L82:
	b .L78
.L78:
	ldr r10, [fp, #-8]
	mov r0, r10
	b .Lfunc2_END
.Lfunc2_END:
	add sp, sp, #8
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global func3
	.type func3 , %function
func3:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L87:
	str r0, [fp, #-8]
	str r1, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L90
	b .L95
.L90:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	mov r0, r9
	b .Lfunc3_END
.L95:
	b .L91
.L91:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	add r8, r10, r9
	mov r1, #0
	mov r0, r8
	bl func3
	mov r10, r0
	mov r0, r10
	b .Lfunc3_END
.Lfunc3_END:
	add sp, sp, #8
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global func4
	.type func4 , %function
func4:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #12
.L100:
	str r0, [fp, #-12]
	str r1, [fp, #-8]
	str r2, [fp, #-4]
	ldr r10, [fp, #-12]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L104
	b .L109
.L104:
	ldr r10, [fp, #-8]
	mov r0, r10
	b .Lfunc4_END
.L109:
	b .L105
.L105:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lfunc4_END
.Lfunc4_END:
	add sp, sp, #12
	pop {r9, r10, fp, lr}
	bx lr

	.global func5
	.type func5 , %function
func5:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L113:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	sub r8, r9, r10
	mov r0, r8
	b .Lfunc5_END
.Lfunc5_END:
	add sp, sp, #4
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global func6
	.type func6 , %function
func6:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L116:
	str r0, [fp, #-8]
	str r1, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L122
	b .L125
.L122:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L119
	b .L129
.L125:
	b .L120
.L119:
	ldr r10, =1
	mov r0, r10
	b .Lfunc6_END
.L129:
	b .L120
.L120:
	ldr r10, =0
	mov r0, r10
	b .Lfunc6_END
.Lfunc6_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

	.global func7
	.type func7 , %function
func7:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L131:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L133
	b .L138
.L133:
	ldr r10, =1
	mov r0, r10
	b .Lfunc7_END
.L138:
	b .L134
.L134:
	ldr r10, =0
	mov r0, r10
	b .Lfunc7_END
.Lfunc7_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #68
.L140:
	bl getint
	mov r10, r0
	str r10, [fp, #-64]
	bl getint
	mov r10, r0
	str r10, [fp, #-60]
	bl getint
	mov r10, r0
	str r10, [fp, #-56]
	bl getint
	mov r10, r0
	str r10, [fp, #-52]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L148
.L148:
	ldr r10, [fp, #-8]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L147
	b .L152
.L147:
	bl getint
	mov r10, r0
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-48
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L148
.L152:
	b .L149
.L149:
	ldr r10, [fp, #-64]
	mov r0, r10
	bl func7
	mov r10, r0
	ldr r9, [fp, #-60]
	mov r0, r9
	bl func5
	mov r9, r0
	mov r1, r9
	mov r0, r10
	bl func6
	mov r10, r0
	ldr r9, [fp, #-56]
	mov r1, r9
	mov r0, r10
	bl func2
	mov r10, r0
	ldr r9, [fp, #-52]
	mov r1, r9
	mov r0, r10
	bl func3
	mov r10, r0
	mov r0, r10
	bl func5
	mov r10, r0
	str r10, [fp, #-68]
	ldr r10, =0
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-48
	add r10, fp, r10
	ldr r9, [r10]
	ldr r10, =1
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, #-48
	add r10, fp, r10
	ldr r8, [r10]
	mov r0, r8
	bl func5
	mov r10, r0
	ldr r8, =2
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, #-48
	add r8, fp, r8
	ldr r7, [r8]
	ldr r8, =3
	ldr r6, =4
	mul r5, r8, r6
	add r8, r5, #-48
	add r8, fp, r8
	ldr r6, [r8]
	mov r0, r6
	bl func7
	mov r8, r0
	mov r1, r8
	mov r0, r7
	bl func6
	mov r8, r0
	ldr r7, =4
	ldr r6, =4
	mul r5, r7, r6
	add r7, r5, #-48
	add r7, fp, r7
	ldr r6, [r7]
	ldr r7, =5
	ldr r5, =4
	mul r4, r7, r5
	add r7, r4, #-48
	add r7, fp, r7
	ldr r5, [r7]
	mov r0, r5
	bl func7
	mov r7, r0
	mov r1, r7
	mov r0, r6
	bl func2
	mov r7, r0
	mov r2, r7
	mov r1, r8
	mov r0, r10
	bl func4
	mov r10, r0
	ldr r8, =6
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, #-48
	add r8, fp, r8
	ldr r7, [r8]
	mov r1, r7
	mov r0, r10
	bl func3
	mov r10, r0
	ldr r8, =7
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, #-48
	add r8, fp, r8
	ldr r7, [r8]
	mov r1, r7
	mov r0, r10
	bl func2
	mov r10, r0
	ldr r8, =8
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, #-48
	add r8, fp, r8
	ldr r7, [r8]
	ldr r8, =9
	ldr r6, =4
	mul r5, r8, r6
	add r8, r5, #-48
	add r8, fp, r8
	ldr r6, [r8]
	mov r0, r6
	bl func7
	mov r8, r0
	mov r1, r8
	mov r0, r7
	bl func3
	mov r8, r0
	ldr r7, [fp, #-64]
	mov r2, r7
	mov r1, r8
	mov r0, r10
	bl func1
	mov r10, r0
	mov r2, r10
	mov r1, r9
	ldr r10, [fp, #-68]
	mov r0, r10
	bl func4
	mov r10, r0
	ldr r9, [fp, #-60]
	ldr r8, [fp, #-56]
	mov r0, r8
	bl func7
	mov r8, r0
	ldr r7, [fp, #-52]
	mov r1, r7
	mov r0, r8
	bl func3
	mov r8, r0
	mov r1, r8
	mov r0, r9
	bl func2
	mov r9, r0
	mov r1, r9
	mov r0, r10
	bl func3
	mov r10, r0
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-48
	add r9, fp, r9
	ldr r8, [r9]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, #-48
	add r9, fp, r9
	ldr r7, [r9]
	mov r2, r7
	mov r1, r8
	mov r0, r10
	bl func1
	mov r10, r0
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-48
	add r9, fp, r9
	ldr r8, [r9]
	mov r1, r8
	mov r0, r10
	bl func2
	mov r10, r0
	ldr r9, =3
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-48
	add r9, fp, r9
	ldr r8, [r9]
	ldr r9, =4
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, #-48
	add r9, fp, r9
	ldr r7, [r9]
	ldr r9, =5
	ldr r6, =4
	mul r5, r9, r6
	add r9, r5, #-48
	add r9, fp, r9
	ldr r6, [r9]
	mov r0, r6
	bl func5
	mov r9, r0
	mov r1, r9
	mov r0, r7
	bl func3
	mov r9, r0
	ldr r7, =6
	ldr r6, =4
	mul r5, r7, r6
	add r7, r5, #-48
	add r7, fp, r7
	ldr r6, [r7]
	mov r0, r6
	bl func5
	mov r7, r0
	mov r1, r7
	mov r0, r9
	bl func2
	mov r9, r0
	ldr r7, =7
	ldr r6, =4
	mul r5, r7, r6
	add r7, r5, #-48
	add r6, fp, r7
	ldr r7, [r6]
	ldr r6, =8
	ldr r5, =4
	mul r4, r6, r5
	add r6, r4, #-48
	add r6, fp, r6
	ldr r5, [r6]
	mov r0, r5
	bl func7
	mov r6, r0
	mov r2, r6
	mov r1, r7
	mov r0, r9
	bl func1
	mov r9, r0
	ldr r7, =9
	ldr r6, =4
	mul r5, r7, r6
	add r7, r5, #-48
	add r7, fp, r7
	ldr r6, [r7]
	mov r0, r6
	bl func5
	mov r7, r0
	mov r1, r7
	mov r0, r9
	bl func2
	mov r9, r0
	ldr r7, [fp, #-64]
	mov r1, r7
	mov r0, r9
	bl func3
	mov r9, r0
	mov r2, r9
	mov r1, r8
	mov r0, r10
	bl func1
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lmain_END
	b .F0
.LTORG
.F0:
.Lmain_END:
	add sp, sp, #68
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

