	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global func
	.type func , %function
func:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L19:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =50
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L21
	b .L26
.L21:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, =1
	mov r0, r10
	b .Lfunc_END
.L26:
	b .L22
.L22:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, =0
	mov r0, r10
	b .Lfunc_END
.Lfunc_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L30:
	mov r0, #0
	bl func
	mov r10, r0
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L32
	b .L37
.L32:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L34
.L37:
	b .L35
.L34:
	mov r0, #50
	bl func
	mov r10, r0
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L50
	b .L52
.L35:
	mov r0, #50
	bl func
	mov r10, r0
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L39
	b .L41
.L50:
	mov r0, #40
	bl func
	mov r10, r0
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L46
	b .L55
.L52:
	b .L49
.L39:
	mov r0, #100
	bl func
	mov r10, r0
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L32
	b .L44
.L41:
	b .L33
.L46:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L48
.L55:
	b .L49
.L49:
	mov r0, #1
	bl func
	mov r10, r0
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L46
	b .L58
.L44:
	b .L33
.L33:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L34
.L48:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L58:
	b .L47
.L47:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L48
.Lmain_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

