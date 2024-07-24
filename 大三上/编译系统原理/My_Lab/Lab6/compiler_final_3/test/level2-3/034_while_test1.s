	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global doubleWhile
	.type doubleWhile , %function
doubleWhile:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L6:
	ldr r10, =5
	str r10, [fp, #-8]
	ldr r10, =7
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
	add r9, r10, #30
	str r9, [fp, #-8]
	b .L18
.L14:
	b .L11
.L18:
	ldr r10, [fp, #-4]
	ldr r9, =100
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L17
	b .L22
.L11:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .LdoubleWhile_END
.L17:
	ldr r10, [fp, #-4]
	add r9, r10, #6
	str r9, [fp, #-4]
	b .L18
.L22:
	b .L19
.L19:
	ldr r10, [fp, #-4]
	sub r9, r10, #100
	str r9, [fp, #-4]
	b .L10
.LdoubleWhile_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L27:
	bl doubleWhile
	mov r10, r0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

