	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global a
	.align 4
	.size a, 4
a:
	.word 7
	.text
	.global func
	.type func , %function
func:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L10:
	ldr r10, addr_a_0
	ldr r9, [r10]
	str r9, [fp, #-8]
	ldr r10, =1
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L14
	b .L20
.L14:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	ldr r10, =1
	mov r0, r10
	b .Lfunc_END
.L20:
	b .L15
.L15:
	ldr r10, =0
	mov r0, r10
	b .Lfunc_END
.Lfunc_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L23:
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L27
.L27:
	ldr r10, [fp, #-4]
	ldr r9, =100
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L26
	b .L31
.L26:
	bl func
	mov r10, r0
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L33
	b .L36
.L31:
	b .L28
.L33:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L34
.L36:
	b .L34
.L28:
	ldr r10, [fp, #-8]
	ldr r9, =100
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L40
	b .L45
.L34:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L27
.L40:
	mov r0, #1
	bl putint
	b .L42
.L45:
	b .L41
.L42:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L41:
	mov r0, #0
	bl putint
	b .L42
.Lmain_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

addr_a_0:
	.word a
