	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global g
	.align 4
	.size g, 4
g:
	.word 0
	.text
	.global func
	.type func , %function
func:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L27:
	str r0, [fp, #-4]
	ldr r10, addr_g_0
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	add r8, r9, r10
	ldr r10, addr_g_0
	str r8, [r10]
	ldr r10, addr_g_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	ldr r10, addr_g_0
	ldr r9, [r10]
	mov r0, r9
	b .Lfunc_END
.Lfunc_END:
	add sp, sp, #4
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L33:
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =10
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L38
	b .L41
.L38:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl func
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L35
	b .L45
.L41:
	b .L36
.L35:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L37
.L45:
	b .L36
.L36:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L37
.L37:
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =11
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L50
	b .L53
.L50:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl func
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L47
	b .L57
.L53:
	b .L48
.L47:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L49
.L57:
	b .L48
.L48:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L49
.L49:
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =99
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L59
	b .L65
.L59:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L61
.L65:
	b .L62
.L61:
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =100
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L71
	b .L77
.L62:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl func
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L59
	b .L69
.L71:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L73
.L77:
	b .L74
.L69:
	b .L60
.L73:
	mov r0, #99
	bl func
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L86
	b .L88
.L74:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl func
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L71
	b .L81
.L60:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L61
.L86:
	mov r0, #100
	bl func
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L83
	b .L91
.L88:
	b .L84
.L81:
	b .L72
.L83:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L85
.L91:
	b .L84
.L84:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L85
.L72:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L73
.L85:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

addr_g_0:
	.word g
