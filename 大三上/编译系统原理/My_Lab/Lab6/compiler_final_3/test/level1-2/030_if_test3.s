	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global ififElse
	.type ififElse , %function
ififElse:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L4:
	ldr r10, =5
	str r10, [fp, #-8]
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, =5
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L7
	b .L11
.L7:
	ldr r10, [fp, #-4]
	ldr r9, =10
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L13
	b .L18
.L11:
	b .L8
.L13:
	ldr r10, =25
	str r10, [fp, #-8]
	b .L15
.L18:
	b .L14
.L8:
	ldr r10, [fp, #-8]
	mov r0, r10
	b .LififElse_END
.L15:
	b .L8
.L14:
	ldr r10, [fp, #-8]
	add r9, r10, #15
	str r9, [fp, #-8]
	b .L15
.LififElse_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L22:
	bl ififElse
	mov r10, r0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

