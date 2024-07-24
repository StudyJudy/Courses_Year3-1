	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global whileIf
	.type whileIf , %function
whileIf:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L6:
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L10
.L10:
	ldr r10, [fp, #-8]
	ldr r9, =100
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L9
	b .L14
.L9:
	ldr r10, [fp, #-8]
	ldr r9, =5
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L16
	b .L21
.L14:
	b .L11
.L16:
	ldr r10, =25
	str r10, [fp, #-4]
	b .L18
.L21:
	b .L17
.L11:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .LwhileIf_END
.L18:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L10
.L17:
	ldr r10, [fp, #-8]
	ldr r9, =10
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L23
	b .L28
.L23:
	ldr r10, =42
	str r10, [fp, #-4]
	b .L25
.L28:
	b .L24
.L25:
	b .L18
.L24:
	ldr r10, [fp, #-8]
	ldr r9, =2
	mul r8, r10, r9
	str r8, [fp, #-4]
	b .L25
.LwhileIf_END:
	add sp, sp, #8
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L33:
	bl whileIf
	mov r10, r0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

