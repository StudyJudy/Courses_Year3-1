	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global g
	.align 4
	.size g, 4
g:
	.word 0
	.global h
	.align 4
	.size h, 4
h:
	.word 0
	.global f
	.align 4
	.size f, 4
f:
	.word 0
	.global e
	.align 4
	.size e, 4
e:
	.word 0
	.text
	.global EightWhile
	.type EightWhile , %function
EightWhile:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #16
.L31:
	ldr r10, =5
	str r10, [fp, #-16]
	ldr r10, =6
	str r10, [fp, #-12]
	ldr r10, =7
	str r10, [fp, #-8]
	ldr r10, =10
	str r10, [fp, #-4]
	b .L37
.L37:
	ldr r10, [fp, #-16]
	ldr r9, =20
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L36
	b .L41
.L36:
	ldr r10, [fp, #-16]
	add r9, r10, #3
	str r9, [fp, #-16]
	b .L45
.L41:
	b .L38
.L45:
	ldr r10, [fp, #-12]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L44
	b .L49
.L38:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, [fp, #-4]
	add r7, r9, r8
	add r9, r10, r7
	ldr r10, [fp, #-8]
	add r8, r9, r10
	ldr r10, addr_e_0
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	add r7, r9, r10
	ldr r10, addr_g_0
	ldr r9, [r10]
	sub r10, r7, r9
	ldr r9, addr_h_0
	ldr r7, [r9]
	add r9, r10, r7
	sub r10, r8, r9
	mov r0, r10
	b .LEightWhile_END
.L44:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L53
.L49:
	b .L46
.L53:
	ldr r10, [fp, #-8]
	ldr r9, =7
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L52
	b .L57
.L46:
	ldr r10, [fp, #-12]
	sub r9, r10, #2
	str r9, [fp, #-12]
	b .L37
.L52:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	str r9, [fp, #-8]
	b .L61
.L57:
	b .L54
.L61:
	ldr r10, [fp, #-4]
	ldr r9, =20
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L60
	b .L65
.L54:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L45
.L60:
	ldr r10, [fp, #-4]
	add r9, r10, #3
	str r9, [fp, #-4]
	b .L69
.L65:
	b .L62
.L69:
	ldr r10, addr_e_0
	ldr r9, [r10]
	ldr r10, =1
	cmp r9, r10
	movgt r10, #1
	movle r10, #0
	bgt .L68
	b .L73
.L62:
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	b .L53
.L68:
	ldr r10, addr_e_0
	ldr r9, [r10]
	sub r10, r9, #1
	ldr r9, addr_e_0
	str r10, [r9]
	b .L77
.L73:
	b .L70
.L77:
	ldr r10, addr_f_0
	ldr r9, [r10]
	ldr r10, =2
	cmp r9, r10
	movgt r10, #1
	movle r10, #0
	bgt .L76
	b .L81
.L70:
	ldr r10, addr_e_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_e_0
	str r10, [r9]
	b .L61
.L76:
	ldr r10, addr_f_0
	ldr r9, [r10]
	sub r10, r9, #2
	ldr r9, addr_f_0
	str r10, [r9]
	b .L85
.L81:
	b .L78
.L85:
	ldr r10, addr_g_0
	ldr r9, [r10]
	ldr r10, =3
	cmp r9, r10
	movlt r10, #1
	movge r10, #0
	blt .L84
	b .L89
.L78:
	ldr r10, addr_f_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_f_0
	str r10, [r9]
	b .L69
.L84:
	ldr r10, addr_g_0
	ldr r9, [r10]
	add r10, r9, #10
	ldr r9, addr_g_0
	str r10, [r9]
	b .L93
.L89:
	b .L86
.L93:
	ldr r10, addr_h_0
	ldr r9, [r10]
	ldr r10, =10
	cmp r9, r10
	movlt r10, #1
	movge r10, #0
	blt .L92
	b .L97
.L86:
	ldr r10, addr_g_0
	ldr r9, [r10]
	sub r10, r9, #8
	ldr r9, addr_g_0
	str r10, [r9]
	b .L77
.L92:
	ldr r10, addr_h_0
	ldr r9, [r10]
	add r10, r9, #8
	ldr r9, addr_h_0
	str r10, [r9]
	b .L93
	b .F0
.LTORG
addr_g_0:
	.word g
addr_h_0:
	.word h
addr_f_0:
	.word f
addr_e_0:
	.word e
.F0:
.L97:
	b .L94
.L94:
	ldr r10, addr_h_1
	ldr r9, [r10]
	sub r10, r9, #1
	ldr r9, addr_h_1
	str r10, [r9]
	b .L85
.LEightWhile_END:
	add sp, sp, #16
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	mov fp, sp
.L115:
	ldr r10, =1
	ldr r9, addr_g_1
	str r10, [r9]
	ldr r10, =2
	ldr r9, addr_h_1
	str r10, [r9]
	ldr r10, =4
	ldr r9, addr_e_1
	str r10, [r9]
	ldr r10, =6
	ldr r9, addr_f_1
	str r10, [r9]
	bl EightWhile
	mov r10, r0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r9, r10, fp, lr}
	bx lr

addr_g_1:
	.word g
addr_h_1:
	.word h
addr_f_1:
	.word f
addr_e_1:
	.word e
