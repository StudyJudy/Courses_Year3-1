	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global FourWhile
	.type FourWhile , %function
FourWhile:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #16
.L15:
	ldr r10, =5
	str r10, [fp, #-16]
	ldr r10, =6
	str r10, [fp, #-12]
	ldr r10, =7
	str r10, [fp, #-8]
	ldr r10, =10
	str r10, [fp, #-4]
	b .L21
.L21:
	ldr r10, [fp, #-16]
	ldr r9, =20
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L20
	b .L25
.L20:
	ldr r10, [fp, #-16]
	add r9, r10, #3
	str r9, [fp, #-16]
	b .L29
.L25:
	b .L22
.L29:
	ldr r10, [fp, #-12]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L28
	b .L33
.L22:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, [fp, #-4]
	add r7, r9, r8
	add r9, r10, r7
	ldr r10, [fp, #-8]
	add r8, r9, r10
	mov r0, r8
	b .LFourWhile_END
.L28:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L37
.L33:
	b .L30
.L37:
	ldr r10, [fp, #-8]
	ldr r9, =7
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L36
	b .L41
.L30:
	ldr r10, [fp, #-12]
	sub r9, r10, #2
	str r9, [fp, #-12]
	b .L21
.L36:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	str r9, [fp, #-8]
	b .L45
.L41:
	b .L38
.L45:
	ldr r10, [fp, #-4]
	ldr r9, =20
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L44
	b .L49
.L38:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L29
.L44:
	ldr r10, [fp, #-4]
	add r9, r10, #3
	str r9, [fp, #-4]
	b .L45
.L49:
	b .L46
.L46:
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	b .L37
.LFourWhile_END:
	add sp, sp, #16
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L59:
	bl FourWhile
	mov r10, r0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

