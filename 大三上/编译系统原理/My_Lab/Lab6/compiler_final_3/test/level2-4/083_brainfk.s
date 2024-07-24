	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	tape,262144,4
	.comm	program,131072,4
	.global ptr
	.align 4
	.size ptr, 4
ptr:
	.word 0
	.text
	.global read_program
	.type read_program , %function
read_program:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L29:
	ldr r10, =0
	str r10, [fp, #-8]
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	b .L33
.L33:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L32
	b .L38
.L32:
	bl getch
	mov r10, r0
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_program_0
	add r8, r7, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L33
.L38:
	b .L34
.L34:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_program_0
	add r9, r8, r10
	ldr r10, =0
	str r10, [r9]
	b .Lread_program_END
.Lread_program_END:
	add sp, sp, #8
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global interpret
	.type interpret , %function
interpret:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #16
.L49:
	str r0, [fp, #-16]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L55
.L55:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L54
	b .L63
.L54:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	str r9, [fp, #-12]
	ldr r10, [fp, #-12]
	ldr r9, =62
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L70
	b .L75
.L63:
	b .L56
.L70:
	ldr r10, addr_ptr_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_ptr_0
	str r10, [r9]
	b .L72
.L75:
	b .L71
.L56:
	b .Linterpret_END
.L72:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L55
.L71:
	ldr r10, [fp, #-12]
	ldr r9, =60
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L78
	b .L83
.L78:
	ldr r10, addr_ptr_0
	ldr r9, [r10]
	sub r10, r9, #1
	ldr r9, addr_ptr_0
	str r10, [r9]
	b .L80
.L83:
	b .L79
.L80:
	b .L72
.L79:
	ldr r10, [fp, #-12]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L86
	b .L91
.L86:
	ldr r10, addr_ptr_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_tape_0
	add r9, r8, r10
	ldr r10, [r9]
	add r9, r10, #1
	ldr r10, addr_ptr_0
	ldr r8, [r10]
	ldr r10, =4
	mul r7, r8, r10
	ldr r10, addr_tape_0
	add r8, r7, r10
	str r9, [r8]
	b .L88
.L91:
	b .L87
.L88:
	b .L80
.L87:
	ldr r10, [fp, #-12]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L102
	b .L107
.L102:
	ldr r10, addr_ptr_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_tape_0
	add r9, r8, r10
	ldr r10, [r9]
	sub r9, r10, #1
	ldr r10, addr_ptr_0
	ldr r8, [r10]
	ldr r10, =4
	mul r7, r8, r10
	ldr r10, addr_tape_0
	add r8, r7, r10
	str r9, [r8]
	b .L104
.L107:
	b .L103
.L104:
	b .L88
.L103:
	ldr r10, [fp, #-12]
	ldr r9, =46
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L118
	b .L123
.L118:
	ldr r10, addr_ptr_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_tape_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	bl putch
	b .L120
.L123:
	b .L119
.L120:
	b .L104
.L119:
	ldr r10, [fp, #-12]
	ldr r9, =44
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L130
	b .L135
.L130:
	bl getch
	mov r10, r0
	ldr r9, addr_ptr_0
	ldr r8, [r9]
	ldr r9, =4
	mul r7, r8, r9
	ldr r9, addr_tape_0
	add r8, r7, r9
	str r10, [r8]
	b .L132
.L135:
	b .L131
.L132:
	b .L120
.L131:
	ldr r10, [fp, #-12]
	ldr r9, =93
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L143
	b .L146
.L143:
	ldr r10, addr_ptr_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_tape_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L141
	b .L154
	b .F0
.LTORG
addr_tape_0:
	.word tape
addr_program_0:
	.word program
addr_ptr_0:
	.word ptr
.F0:
.L146:
	b .L142
.L141:
	ldr r10, =1
	str r10, [fp, #-8]
	b .L157
.L154:
	b .L142
.L142:
	b .L132
.L157:
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L156
	b .L161
.L156:
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	str r9, [fp, #-12]
	ldr r10, [fp, #-12]
	ldr r9, =91
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L169
	b .L174
.L161:
	b .L158
.L169:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	str r9, [fp, #-8]
	b .L171
.L174:
	b .L170
.L158:
	b .L142
.L171:
	b .L157
.L170:
	ldr r10, [fp, #-12]
	ldr r9, =93
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L177
	b .L181
.L177:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L178
.L181:
	b .L178
.L178:
	b .L171
.Linterpret_END:
	add sp, sp, #16
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
.L185:
	bl read_program
	ldr r10, addr_program_1
	ldr r9, =0
	add r8, r9, r10
	mov r0, r8
	bl interpret
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r8, r9, r10, fp, lr}
	bx lr

addr_tape_1:
	.word tape
addr_program_1:
	.word program
addr_ptr_1:
	.word ptr
