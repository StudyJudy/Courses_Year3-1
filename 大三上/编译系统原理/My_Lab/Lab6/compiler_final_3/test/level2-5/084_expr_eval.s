	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global last_char
	.align 4
	.size last_char, 4
last_char:
	.word 32
	.global num
	.align 4
	.size num, 4
num:
	.word 0
	.global other
	.align 4
	.size other, 4
other:
	.word 0
	.global cur_token
	.align 4
	.size cur_token, 4
cur_token:
	.word 0
	.text
	.global next_char
	.type next_char , %function
next_char:
	push {r9, r10, fp, lr}
	mov fp, sp
.L90:
	bl getch
	mov r10, r0
	ldr r9, addr_last_char_0
	str r10, [r9]
	ldr r10, addr_last_char_0
	ldr r9, [r10]
	mov r0, r9
	b .Lnext_char_END
.Lnext_char_END:
	pop {r9, r10, fp, lr}
	bx lr

	.global is_space
	.type is_space , %function
is_space:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L92:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =32
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L94
	b .L100
.L94:
	ldr r10, =1
	mov r0, r10
	b .Lis_space_END
.L100:
	b .L97
.L97:
	ldr r10, [fp, #-4]
	ldr r9, =10
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L94
	b .L104
.L104:
	b .L95
.L95:
	ldr r10, =0
	mov r0, r10
	b .Lis_space_END
.Lis_space_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global is_num
	.type is_num , %function
is_num:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L106:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =48
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L111
	b .L114
.L111:
	ldr r10, [fp, #-4]
	ldr r9, =57
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L108
	b .L118
.L114:
	b .L109
.L108:
	ldr r10, =1
	mov r0, r10
	b .Lis_num_END
.L118:
	b .L109
.L109:
	ldr r10, =0
	mov r0, r10
	b .Lis_num_END
.Lis_num_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global next_token
	.type next_token , %function
next_token:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
.L120:
	b .L122
.L122:
	ldr r10, addr_last_char_0
	ldr r9, [r10]
	mov r0, r9
	bl is_space
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L121
	b .L126
.L121:
	bl next_char
	mov r10, r0
	b .L122
.L126:
	b .L123
.L123:
	ldr r10, addr_last_char_0
	ldr r9, [r10]
	mov r0, r9
	bl is_num
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L128
	b .L133
.L128:
	ldr r10, addr_last_char_0
	ldr r9, [r10]
	sub r10, r9, #48
	ldr r9, addr_num_0
	str r10, [r9]
	b .L137
.L133:
	b .L129
.L137:
	bl next_char
	mov r10, r0
	mov r0, r10
	bl is_num
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L136
	b .L140
.L129:
	ldr r10, addr_last_char_0
	ldr r9, [r10]
	ldr r10, addr_other_0
	str r9, [r10]
	bl next_char
	mov r10, r0
	ldr r10, =1
	ldr r9, addr_cur_token_0
	str r10, [r9]
	b .L130
.L136:
	ldr r10, addr_num_0
	ldr r9, [r10]
	ldr r10, =10
	mul r8, r9, r10
	ldr r10, addr_last_char_0
	ldr r9, [r10]
	add r10, r8, r9
	sub r9, r10, #48
	ldr r10, addr_num_0
	str r9, [r10]
	b .L137
.L140:
	b .L138
.L130:
	ldr r10, addr_cur_token_0
	ldr r9, [r10]
	mov r0, r9
	b .Lnext_token_END
.L138:
	ldr r10, =0
	ldr r9, addr_cur_token_0
	str r10, [r9]
	b .L130
.Lnext_token_END:
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global panic
	.type panic , %function
panic:
	push {r10, fp, lr}
	mov fp, sp
.L146:
	mov r0, #112
	bl putch
	mov r0, #97
	bl putch
	mov r0, #110
	bl putch
	mov r0, #105
	bl putch
	mov r0, #99
	bl putch
	mov r0, #33
	bl putch
	mov r0, #10
	bl putch
	ldr r10, =-1
	mov r0, r10
	b .Lpanic_END
.Lpanic_END:
	pop {r10, fp, lr}
	bx lr

	.global get_op_prec
	.type get_op_prec , %function
get_op_prec:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L147:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L149
	b .L154
.L149:
	ldr r10, =10
	mov r0, r10
	b .Lget_op_prec_END
.L154:
	b .L151
.L151:
	ldr r10, [fp, #-4]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L149
	b .L158
.L158:
	b .L150
.L150:
	ldr r10, [fp, #-4]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L160
	b .L166
.L160:
	ldr r10, =20
	mov r0, r10
	b .Lget_op_prec_END
.L166:
	b .L163
.L163:
	ldr r10, [fp, #-4]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L160
	b .L170
.L170:
	b .L162
.L162:
	ldr r10, [fp, #-4]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L160
	b .L174
.L174:
	b .L161
.L161:
	ldr r10, =0
	mov r0, r10
	b .Lget_op_prec_END
.Lget_op_prec_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global stack_push
	.type stack_push , %function
stack_push:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L176:
	str r0, [fp, #-8]
	str r1, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	add r9, r10, #1
	ldr r10, [fp, #-8]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r10
	str r9, [r8]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	ldr r8, [fp, #-8]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	b .Lstack_push_END
.Lstack_push_END:
	add sp, sp, #8
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global stack_pop
	.type stack_pop , %function
stack_pop:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L194:
	str r0, [fp, #-8]
	ldr r10, [fp, #-8]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	str r9, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	sub r9, r10, #1
	ldr r10, [fp, #-8]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r10
	str r9, [r8]
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lstack_pop_END
.Lstack_pop_END:
	add sp, sp, #8
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global stack_peek
	.type stack_peek , %function
stack_peek:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L213:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	ldr r9, [fp, #-4]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	mov r0, r9
	b .Lstack_peek_END
.Lstack_peek_END:
	add sp, sp, #4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global stack_size
	.type stack_size , %function
stack_size:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L223:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	mov r0, r10
	b .Lstack_size_END
.Lstack_size_END:
	add sp, sp, #4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global eval_op
	.type eval_op , %function
eval_op:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #12
.L229:
	str r0, [fp, #-12]
	str r1, [fp, #-8]
	str r2, [fp, #-4]
	ldr r10, [fp, #-12]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L233
	b .L237
.L233:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	add r8, r10, r9
	mov r0, r8
	b .Leval_op_END
.L237:
	b .L234
.L234:
	ldr r10, [fp, #-12]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L241
	b .L245
.L241:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	sub r8, r10, r9
	mov r0, r8
	b .Leval_op_END
.L245:
	b .L242
.L242:
	ldr r10, [fp, #-12]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L249
	b .L253
.L249:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	mul r8, r10, r9
	mov r0, r8
	b .Leval_op_END
.L253:
	b .L250
.L250:
	ldr r10, [fp, #-12]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L257
	b .L261
.L257:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	sdiv r8, r10, r9
	mov r0, r8
	b .Leval_op_END
.L261:
	b .L258
.L258:
	ldr r10, [fp, #-12]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L265
	b .L269
.L265:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	mov r0, r8
	b .Leval_op_END
.L269:
	b .L266
.L266:
	ldr r10, =0
	mov r0, r10
	b .Leval_op_END
.Leval_op_END:
	add sp, sp, #12
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global eval
	.type eval , %function
eval:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=2076
	sub sp, sp, r4
.L273:
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =4
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =8
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =12
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =16
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =20
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =24
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =28
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =32
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =36
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =40
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =44
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =48
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =52
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =56
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =60
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =64
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =68
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =72
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =76
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =80
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =84
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =88
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =92
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =96
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =100
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =104
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =108
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =112
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =116
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =120
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =124
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =128
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =132
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =136
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =140
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =144
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =148
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =152
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =156
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =160
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =164
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =168
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =172
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =176
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =180
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =184
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =188
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =192
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =196
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =200
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =204
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =208
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =212
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =216
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =220
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =224
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =228
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =232
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =236
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =240
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =244
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =248
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =252
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =256
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =260
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =264
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =268
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =272
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =276
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =280
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =284
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =288
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =292
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =296
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =300
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =304
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =308
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =312
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =316
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =320
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =324
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =328
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =332
	ldr r9, =-2076
	b .B0
.LTORG
addr_last_char_0:
	.word last_char
addr_num_0:
	.word num
addr_other_0:
	.word other
addr_cur_token_0:
	.word cur_token
.B0:
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =336
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =340
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =344
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =348
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =352
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =356
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =360
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =364
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =368
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =372
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =376
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =380
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =384
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =388
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =392
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =396
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =400
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =404
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =408
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =412
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =416
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =420
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =424
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =428
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =432
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =436
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =440
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =444
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =448
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =452
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =456
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =460
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =464
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =468
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =472
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =476
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =480
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =484
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =488
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =492
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =496
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =500
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =504
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =508
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =512
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =516
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =520
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =524
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =528
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =532
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =536
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =540
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =544
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =548
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =552
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =556
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =560
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =564
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =568
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =572
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =576
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =580
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =584
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =588
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =592
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =596
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =600
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =604
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =608
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =612
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =616
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =620
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =624
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =628
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =632
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =636
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =640
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =644
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =648
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =652
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =656
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =660
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =664
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	b .B1
.LTORG
addr_last_char_1:
	.word last_char
addr_num_1:
	.word num
addr_other_1:
	.word other
addr_cur_token_1:
	.word cur_token
.B1:
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =668
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =672
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =676
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =680
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =684
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =688
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =692
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =696
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =700
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =704
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =708
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =712
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =716
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =720
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =724
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =728
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =732
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =736
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =740
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =744
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =748
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =752
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =756
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =760
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =764
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =768
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =772
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =776
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =780
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =784
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =788
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =792
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =796
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =800
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =804
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =808
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =812
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =816
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =820
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =824
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =828
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =832
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =836
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =840
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =844
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =848
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =852
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =856
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =860
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =864
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =868
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =872
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =876
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =880
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =884
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =888
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =892
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =896
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =900
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =904
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =908
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =912
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =916
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =920
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =924
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =928
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =932
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =936
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =940
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =944
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =948
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =952
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =956
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =960
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =964
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =968
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =972
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =976
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =980
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =984
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =988
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =992
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =996
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	b .B2
.LTORG
addr_last_char_2:
	.word last_char
addr_num_2:
	.word num
addr_other_2:
	.word other
addr_cur_token_2:
	.word cur_token
.B2:
	ldr r10, =1000
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1004
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1008
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1012
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1016
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1020
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =0
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =4
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =8
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =12
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =16
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =20
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =24
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =28
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =32
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =36
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =40
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =44
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =48
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =52
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =56
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =60
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =64
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =68
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =72
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =76
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =80
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =84
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =88
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =92
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =96
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =100
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =104
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =108
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =112
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =116
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =120
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =124
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =128
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =132
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =136
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =140
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =144
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =148
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =152
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =156
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =160
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =164
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =168
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =172
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =176
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =180
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =184
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =188
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =192
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =196
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =200
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =204
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =208
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =212
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =216
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =220
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =224
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =228
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =232
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =236
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =240
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =244
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =248
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =252
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =256
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =260
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =264
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =268
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =272
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =276
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =280
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =284
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =288
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =292
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =296
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =300
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =304
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =308
	ldr r9, =-1052
	b .B3
.LTORG
addr_last_char_3:
	.word last_char
addr_num_3:
	.word num
addr_other_3:
	.word other
addr_cur_token_3:
	.word cur_token
.B3:
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =312
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =316
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =320
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =324
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =328
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =332
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =336
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =340
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =344
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =348
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =352
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =356
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =360
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =364
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =368
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =372
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =376
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =380
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =384
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =388
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =392
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =396
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =400
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =404
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =408
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =412
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =416
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =420
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =424
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =428
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =432
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =436
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =440
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =444
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =448
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =452
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =456
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =460
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =464
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =468
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =472
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =476
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =480
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =484
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =488
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =492
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =496
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =500
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =504
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =508
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =512
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =516
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =520
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =524
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =528
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =532
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =536
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =540
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =544
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =548
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =552
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =556
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =560
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =564
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =568
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =572
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =576
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =580
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =584
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =588
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =592
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =596
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =600
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =604
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =608
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =612
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =616
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =620
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =624
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =628
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =632
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =636
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =640
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	b .B4
.LTORG
addr_last_char_4:
	.word last_char
addr_num_4:
	.word num
addr_other_4:
	.word other
addr_cur_token_4:
	.word cur_token
.B4:
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =644
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =648
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =652
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =656
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =660
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =664
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =668
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =672
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =676
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =680
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =684
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =688
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =692
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =696
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =700
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =704
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =708
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =712
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =716
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =720
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =724
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =728
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =732
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =736
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =740
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =744
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =748
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =752
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =756
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =760
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =764
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =768
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =772
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =776
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =780
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =784
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =788
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =792
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =796
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =800
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =804
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =808
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =812
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =816
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =820
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =824
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =828
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =832
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =836
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =840
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =844
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =848
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =852
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =856
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =860
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =864
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =868
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =872
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =876
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =880
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =884
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =888
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =892
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =896
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =900
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =904
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =908
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =912
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =916
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =920
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =924
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =928
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =932
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =936
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =940
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =944
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =948
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =952
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =956
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =960
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =964
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =968
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =972
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	b .B5
.LTORG
addr_last_char_5:
	.word last_char
addr_num_5:
	.word num
addr_other_5:
	.word other
addr_cur_token_5:
	.word cur_token
.B5:
	ldr r10, =976
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =980
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =984
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =988
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =992
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =996
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1000
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1004
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1008
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1012
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1016
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1020
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, addr_cur_token_6
	ldr r9, [r10]
	ldr r10, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L788
	b .L792
	b .F6
.LTORG
addr_last_char_6:
	.word last_char
addr_num_6:
	.word num
addr_other_6:
	.word other
addr_cur_token_6:
	.word cur_token
.F6:
.L788:
	bl panic
	mov r10, r0
	mov r0, r10
	b .Leval_END
.L792:
	b .L789
.L789:
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, addr_num_7
	ldr r9, [r10]
	mov r1, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_push
	bl next_token
	mov r10, r0
	b .L798
.L798:
	ldr r10, addr_cur_token_7
	ldr r9, [r10]
	ldr r10, =1
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L797
	b .L802
.L797:
	ldr r10, addr_other_7
	ldr r9, [r10]
	str r9, [fp, #-28]
	ldr r10, [fp, #-28]
	mov r0, r10
	bl get_op_prec
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L806
	b .L810
.L802:
	b .L799
.L806:
	b .L799
.L810:
	b .L807
.L799:
	bl next_token
	mov r10, r0
	b .L855
.L807:
	bl next_token
	mov r10, r0
	b .L814
.L855:
	ldr r10, =0
	ldr r9, =-1052
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_size
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L854
	b .L860
.L814:
	ldr r10, =0
	ldr r9, =-1052
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_size
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L816
	b .L820
.L854:
	ldr r10, =0
	ldr r9, =-1052
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_pop
	mov r10, r0
	str r10, [fp, #-12]
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_pop
	mov r10, r0
	str r10, [fp, #-8]
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_pop
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-4]
	ldr r7, [fp, #-8]
	mov r2, r7
	mov r1, r9
	mov r0, r10
	bl eval_op
	mov r10, r0
	mov r1, r10
	add r10, fp, r8
	mov r0, r10
	bl stack_push
	b .L855
.L860:
	b .L856
.L816:
	ldr r10, =0
	ldr r9, =-1052
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_peek
	mov r10, r0
	mov r0, r10
	bl get_op_prec
	mov r10, r0
	ldr r9, [fp, #-28]
	mov r0, r9
	bl get_op_prec
	mov r9, r0
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L813
	b .L826
.L820:
	b .L815
.L856:
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_peek
	mov r10, r0
	mov r0, r10
	b .Leval_END
.L813:
	ldr r10, =0
	ldr r9, =-1052
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_pop
	mov r10, r0
	str r10, [fp, #-24]
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_pop
	mov r10, r0
	str r10, [fp, #-20]
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_pop
	mov r10, r0
	str r10, [fp, #-16]
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, [fp, #-24]
	ldr r9, [fp, #-16]
	ldr r7, [fp, #-20]
	mov r2, r7
	mov r1, r9
	mov r0, r10
	bl eval_op
	mov r10, r0
	mov r1, r10
	add r10, fp, r8
	mov r0, r10
	bl stack_push
	b .L814
	b .F7
.LTORG
addr_last_char_7:
	.word last_char
addr_num_7:
	.word num
addr_other_7:
	.word other
addr_cur_token_7:
	.word cur_token
.F7:
.L826:
	b .L815
.L815:
	ldr r10, =0
	ldr r9, =-1052
	add r8, r10, r9
	ldr r10, [fp, #-28]
	mov r1, r10
	add r10, fp, r8
	mov r0, r10
	bl stack_push
	ldr r10, addr_cur_token_8
	ldr r9, [r10]
	ldr r10, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L845
	b .L849
.L845:
	bl panic
	mov r10, r0
	mov r0, r10
	b .Leval_END
.L849:
	b .L846
.L846:
	ldr r10, =0
	ldr r9, =-2076
	add r8, r10, r9
	ldr r10, addr_num_8
	ldr r9, [r10]
	mov r1, r9
	add r10, fp, r8
	mov r0, r10
	bl stack_push
	bl next_token
	mov r10, r0
	b .L798
.Leval_END:
	ldr r4,=2076
	add sp, sp, r4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L878:
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	bl getch
	mov r10, r0
	bl next_token
	mov r10, r0
	b .L881
.L881:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L880
	b .L885
.L880:
	bl eval
	mov r10, r0
	mov r0, r10
	bl putint
	mov r0, #10
	bl putch
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	b .L881
.L885:
	b .L882
.L882:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

addr_last_char_8:
	.word last_char
addr_num_8:
	.word num
addr_other_8:
	.word other
addr_cur_token_8:
	.word cur_token
