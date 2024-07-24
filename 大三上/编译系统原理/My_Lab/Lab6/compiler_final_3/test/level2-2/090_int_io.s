	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global my_getint
	.type my_getint , %function
my_getint:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L28:
	ldr r10, =0
	str r10, [fp, #-8]
	b .L32
.L32:
	ldr r10, =0
	ldr r9, =1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L31
	b .L35
.L31:
	bl getch
	mov r10, r0
	sub r9, r10, #48
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L37
	b .L43
.L35:
	b .L33
.L37:
	b .L32
.L43:
	b .L40
.L33:
	ldr r10, [fp, #-4]
	str r10, [fp, #-8]
	b .L53
.L40:
	ldr r10, [fp, #-4]
	ldr r9, =9
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L37
	b .L47
.L53:
	ldr r10, =0
	ldr r9, =1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L52
	b .L56
.L47:
	b .L38
.L52:
	bl getch
	mov r10, r0
	sub r9, r10, #48
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L61
	b .L64
.L56:
	b .L54
.L38:
	b .L33
.L61:
	ldr r10, [fp, #-4]
	ldr r9, =9
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L58
	b .L68
.L64:
	b .L59
.L54:
	ldr r10, [fp, #-8]
	mov r0, r10
	b .Lmy_getint_END
.L58:
	ldr r10, [fp, #-8]
	ldr r9, =10
	mul r8, r10, r9
	ldr r10, [fp, #-4]
	add r9, r8, r10
	str r9, [fp, #-8]
	b .L60
.L68:
	b .L59
.L59:
	b .L54
.L60:
	b .L53
.Lmy_getint_END:
	add sp, sp, #8
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global my_putint
	.type my_putint , %function
my_putint:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #72
.L74:
	str r0, [fp, #-72]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L79
.L79:
	ldr r10, [fp, #-72]
	ldr r9, =0
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L78
	b .L83
.L78:
	ldr r10, [fp, #-72]
	ldr r9, =10
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	add r10, r8, #48
	ldr r9, [fp, #-4]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-68
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-72]
	ldr r9, =10
	sdiv r8, r10, r9
	str r8, [fp, #-72]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L79
.L83:
	b .L80
.L80:
	b .L92
.L92:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L91
	b .L96
.L91:
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-68
	add r10, fp, r10
	ldr r9, [r10]
	mov r0, r9
	bl putch
	b .L92
.L96:
	b .L93
.L93:
	b .Lmy_putint_END
.Lmy_putint_END:
	add sp, sp, #72
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L103:
	bl my_getint
	mov r10, r0
	str r10, [fp, #-8]
	b .L106
.L106:
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L105
	b .L110
.L105:
	bl my_getint
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl my_putint
	mov r0, #10
	bl putch
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	str r9, [fp, #-8]
	b .L106
.L110:
	b .L107
.L107:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

