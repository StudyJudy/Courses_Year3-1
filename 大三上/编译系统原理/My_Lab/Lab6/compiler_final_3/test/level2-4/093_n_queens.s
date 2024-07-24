	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	ans,200,4
	.global sum
	.align 4
	.size sum, 4
sum:
	.word 0
	.global n
	.align 4
	.size n, 4
n:
	.word 0
	.comm	row,200,4
	.comm	line1,200,4
	.comm	line2,400,4
	.text
	.global printans
	.type printans , %function
printans:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L32:
	ldr r10, addr_sum_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_sum_0
	str r10, [r9]
	ldr r10, =1
	str r10, [fp, #-4]
	b .L36
.L36:
	ldr r10, [fp, #-4]
	ldr r9, addr_n_0
	ldr r8, [r9]
	cmp r10, r8
	movle r10, #1
	movgt r10, #0
	ble .L35
	b .L41
.L35:
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_ans_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-4]
	ldr r9, addr_n_0
	ldr r8, [r9]
	cmp r10, r8
	moveq r10, #1
	movne r10, #0
	beq .L48
	b .L54
.L41:
	b .L37
.L48:
	mov r0, #10
	bl putch
	b .Lprintans_END
.L54:
	b .L49
.L37:
	b .Lprintans_END
.L49:
	mov r0, #32
	bl putch
	b .L50
.L50:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L36
.Lprintans_END:
	add sp, sp, #4
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global f
	.type f , %function
f:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L57:
	str r0, [fp, #-8]
	ldr r10, =1
	str r10, [fp, #-4]
	b .L61
.L61:
	ldr r10, [fp, #-4]
	ldr r9, addr_n_0
	ldr r8, [r9]
	cmp r10, r8
	movle r10, #1
	movgt r10, #0
	ble .L60
	b .L66
.L60:
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_row_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L71
	b .L78
.L66:
	b .L62
.L71:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	add r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, addr_line1_0
	add r8, r9, r10
	ldr r10, [r8]
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L70
	b .L87
.L78:
	b .L69
.L62:
	b .Lf_END
.L70:
	ldr r10, addr_n_0
	ldr r9, [r10]
	ldr r10, [fp, #-8]
	add r8, r9, r10
	ldr r10, [fp, #-4]
	sub r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_line2_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L68
	b .L97
.L87:
	b .L69
.L69:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L61
.L68:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_ans_0
	add r8, r7, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	ldr r9, addr_n_0
	ldr r8, [r9]
	cmp r10, r8
	moveq r10, #1
	movne r10, #0
	beq .L104
	b .L109
.L97:
	b .L69
.L104:
	bl printans
	b .L105
.L109:
	b .L105
.L105:
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_row_0
	add r9, r8, r10
	ldr r10, =1
	str r10, [r9]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	add r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, addr_line1_0
	add r8, r9, r10
	ldr r10, =1
	str r10, [r8]
	ldr r10, addr_n_0
	ldr r9, [r10]
	ldr r10, [fp, #-8]
	add r8, r9, r10
	ldr r10, [fp, #-4]
	sub r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_line2_0
	add r9, r8, r10
	ldr r10, =1
	str r10, [r9]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	mov r0, r9
	bl f
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_row_0
	add r9, r8, r10
	ldr r10, =0
	str r10, [r9]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	add r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, addr_line1_0
	add r8, r9, r10
	ldr r10, =0
	str r10, [r8]
	ldr r10, addr_n_0
	ldr r9, [r10]
	ldr r10, [fp, #-8]
	add r8, r9, r10
	ldr r10, [fp, #-4]
	sub r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_line2_0
	add r9, r8, r10
	ldr r10, =0
	str r10, [r9]
	b .L69
.Lf_END:
	add sp, sp, #8
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L143:
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	b .L146
.L146:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L145
	b .L150
.L145:
	bl getint
	mov r10, r0
	ldr r9, addr_n_0
	str r10, [r9]
	mov r0, #1
	bl f
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	b .L146
.L150:
	b .L147
.L147:
	ldr r10, addr_sum_0
	ldr r9, [r10]
	mov r0, r9
	b .Lmain_END
.Lmain_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

addr_ans_0:
	.word ans
addr_sum_0:
	.word sum
addr_n_0:
	.word n
addr_row_0:
	.word row
addr_line1_0:
	.word line1
addr_line2_0:
	.word line2
