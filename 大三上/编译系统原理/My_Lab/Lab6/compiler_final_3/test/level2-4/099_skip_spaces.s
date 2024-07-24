	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global main
	.type main , %function
main:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=408
	sub sp, sp, r4
.L8:
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L13
.L13:
	bl getint
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L12
	b .L16
.L12:
	bl getint
	mov r10, r0
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-408
	add r8, r7, r9
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L13
.L16:
	b .L14
.L14:
	b .L23
.L23:
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L22
	b .L27
.L22:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	str r9, [fp, #-8]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-408
	add r8, r7, r9
	add r8, fp, r8
	ldr r9, [r8]
	add r8, r10, r9
	str r8, [fp, #-4]
	b .L23
.L27:
	b .L24
.L24:
	ldr r10, [fp, #-4]
	ldr r9, =79
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	mov r0, r8
	b .Lmain_END
.Lmain_END:
	ldr r4,=408
	add sp, sp, r4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

