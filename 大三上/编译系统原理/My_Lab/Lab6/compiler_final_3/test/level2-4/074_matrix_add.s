	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global M
	.align 4
	.size M, 4
M:
	.word 0
	.global L
	.align 4
	.size L, 4
L:
	.word 0
	.global N
	.align 4
	.size N, 4
N:
	.word 0
	.text
	.global add
	.type add , %function
add:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #40
.L20:
	str r0, [fp, #-40]
	str r1, [fp, #-36]
	str r2, [fp, #-32]
	str r3, [fp, #-28]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L32
.L32:
	ldr r10, [fp, #-4]
	ldr r9, addr_M_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L31
	b .L37
.L31:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-40]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	ldr r8, [fp, #-28]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r8
	ldr r8, [r10]
	add r10, r9, r8
	ldr r9, [fp, #-4]
	ldr r8, [fp, #36]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-36]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	ldr r8, [fp, #28]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r8
	ldr r8, [r10]
	add r10, r9, r8
	ldr r9, [fp, #-4]
	ldr r8, [fp, #40]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-32]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	ldr r8, [fp, #32]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r8
	ldr r8, [r10]
	add r10, r9, r8
	ldr r9, [fp, #-4]
	ldr r8, [fp, #44]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L32
.L37:
	b .L33
.L33:
	ldr r10, =0
	mov r0, r10
	b .Ladd_END
.Ladd_END:
	add sp, sp, #40
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #140
.L82:
	ldr r10, =3
	ldr r9, addr_N_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_M_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_L_0
	str r10, [r9]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L94
.L94:
	ldr r10, [fp, #-8]
	ldr r9, addr_M_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L93
	b .L99
.L93:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-128
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-116
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-104
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-92
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-80
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-68
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L94
.L99:
	b .L95
.L95:
	ldr r10, =0
	add r9, r10, #-128
	str r9, [fp, #-132]
	ldr r10, =0
	add r9, r10, #-116
	str r9, [fp, #-136]
	ldr r10, =0
	add r9, r10, #-104
	str r9, [fp, #-140]
	ldr r10, =0
	add r9, r10, #-92
	ldr r10, =0
	add r8, r10, #-80
	ldr r10, =0
	add r7, r10, #-68
	ldr r10, =0
	add r6, r10, #-56
	ldr r10, =0
	add r5, r10, #-32
	ldr r10, =0
	add r4, r10, #-20
	add r10, fp, r4
	push {r10}
	add r10, fp, r5
	push {r10}
	add r10, fp, r6
	push {r10}
	add r10, fp, r7
	push {r10}
	add r10, fp, r8
	push {r10}
	add r10, fp, r9
	mov r3, r10
	ldr r10, [fp, #-140]
	add r10, fp, r10
	mov r2, r10
	ldr r10, [fp, #-136]
	add r10, fp, r10
	mov r1, r10
	ldr r10, [fp, #-132]
	add r10, fp, r10
	mov r0, r10
	bl add
	mov r10, r0
	add sp, sp, #20
	str r10, [fp, #-8]
	b .L146
.L146:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L145
	b .L151
.L145:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-56
	add r9, fp, r10
	ldr r10, [r9]
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L146
.L151:
	b .L147
.L147:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	ldr r10, =0
	str r10, [fp, #-8]
	b .L161
.L161:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L160
	b .L166
.L160:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-32
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L161
	b .F0
.LTORG
addr_M_0:
	.word M
addr_L_0:
	.word L
addr_N_0:
	.word N
.F0:
.L166:
	b .L162
.L162:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	ldr r10, =0
	str r10, [fp, #-8]
	b .L176
.L176:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_1
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L175
	b .L181
.L175:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-20
	add r9, fp, r10
	ldr r10, [r9]
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L176
.L181:
	b .L177
.L177:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #140
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

addr_M_1:
	.word M
addr_L_1:
	.word L
addr_N_1:
	.word N
