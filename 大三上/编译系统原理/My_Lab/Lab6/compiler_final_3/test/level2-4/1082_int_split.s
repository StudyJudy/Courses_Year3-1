	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global N
	.align 4
	.size N, 4
N:
	.word 0
	.global newline
	.align 4
	.size newline, 4
newline:
	.word 0
	.text
	.global split
	.type split , %function
split:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #12
.L11:
	str r0, [fp, #-12]
	str r1, [fp, #-8]
	ldr r10, addr_N_0
	ldr r9, [r10]
	sub r10, r9, #1
	str r10, [fp, #-4]
	b .L17
.L17:
	ldr r10, [fp, #-4]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L16
	b .L21
.L16:
	ldr r10, [fp, #-12]
	ldr r9, =10
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r9
	str r8, [r10]
	ldr r10, [fp, #-12]
	ldr r9, =10
	sdiv r8, r10, r9
	str r8, [fp, #-12]
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	b .L17
.L21:
	b .L18
.L18:
	ldr r10, =0
	mov r0, r10
	b .Lsplit_END
.Lsplit_END:
	add sp, sp, #12
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #28
.L30:
	ldr r10, =4
	ldr r9, addr_N_0
	str r10, [r9]
	ldr r10, =10
	ldr r9, addr_newline_0
	str r10, [r9]
	ldr r10, =1478
	str r10, [fp, #-24]
	ldr r10, [fp, #-24]
	ldr r9, =0
	add r8, r9, #-20
	add r9, fp, r8
	mov r1, r9
	mov r0, r10
	bl split
	mov r10, r0
	str r10, [fp, #-24]
	ldr r10, =0
	str r10, [fp, #-28]
	b .L39
.L39:
	ldr r10, [fp, #-28]
	ldr r9, =4
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L38
	b .L43
.L38:
	ldr r10, [fp, #-28]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-20
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, addr_newline_0
	ldr r9, [r10]
	mov r0, r9
	bl putch
	ldr r10, [fp, #-28]
	add r9, r10, #1
	str r9, [fp, #-28]
	b .L39
.L43:
	b .L40
.L40:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #28
	pop {r8, r9, r10, fp, lr}
	bx lr

addr_N_0:
	.word N
addr_newline_0:
	.word newline
