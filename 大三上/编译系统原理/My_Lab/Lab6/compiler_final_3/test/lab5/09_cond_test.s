	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #12
.L9:
	ldr r10, =0
	str r10, [fp, #-12]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L13
.L13:
	ldr r10, [fp, #-8]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L12
	b .L17
.L12:
	ldr r10, =10
	str r10, [fp, #-4]
	b .L21
.L17:
	b .L14
.L21:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L20
	b .L25
.L14:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L20:
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L29
	b .L32
.L25:
	b .L22
.L29:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L27
	b .L36
.L32:
	b .L28
.L22:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	add r8, r10, r9
	str r8, [fp, #-8]
	b .L13
.L27:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-8]
	add r8, r10, r9
	ldr r10, [fp, #-4]
	add r9, r8, r10
	str r9, [fp, #-12]
	b .L28
.L36:
	b .L28
.L28:
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	b .L21
.Lmain_END:
	add sp, sp, #12
	pop {r8, r9, r10, fp, lr}
	bx lr

