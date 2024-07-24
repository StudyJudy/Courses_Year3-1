	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	array,440,4
	.global n
	.align 4
	.size n, 4
n:
	.word 0
	.text
	.global init
	.type init , %function
init:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L71:
	str r0, [fp, #-8]
	ldr r10, =1
	str r10, [fp, #-4]
	b .L75
.L75:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, [fp, #-8]
	mul r7, r9, r8
	add r9, r7, #1
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L74
	b .L81
.L74:
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_array_0
	add r9, r8, r10
	ldr r10, =-1
	str r10, [r9]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L75
.L81:
	b .L76
.L76:
	b .Linit_END
.Linit_END:
	add sp, sp, #8
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global findfa
	.type findfa , %function
findfa:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L88:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_array_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, [fp, #-4]
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L90
	b .L100
.L90:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lfindfa_END
.L100:
	b .L91
.L91:
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_array_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	bl findfa
	mov r10, r0
	ldr r9, [fp, #-4]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_array_0
	add r8, r7, r9
	str r10, [r8]
	ldr r10, [fp, #-4]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_array_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	b .Lfindfa_END
.Lfindfa_END:
	add sp, sp, #4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global mmerge
	.type mmerge , %function
mmerge:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #16
.L117:
	str r0, [fp, #-16]
	str r1, [fp, #-12]
	ldr r10, [fp, #-16]
	mov r0, r10
	bl findfa
	mov r10, r0
	str r10, [fp, #-8]
	ldr r10, [fp, #-12]
	mov r0, r10
	bl findfa
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L124
	b .L129
.L124:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_array_0
	add r8, r7, r9
	str r10, [r8]
	b .L125
.L129:
	b .L125
.L125:
	b .Lmmerge_END
.Lmmerge_END:
	add sp, sp, #16
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #36
.L136:
	ldr r10, =1
	str r10, [fp, #-36]
	b .L142
.L142:
	ldr r10, [fp, #-36]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L141
	b .L146
.L141:
	ldr r10, [fp, #-36]
	sub r9, r10, #1
	str r9, [fp, #-36]
	ldr r10, =4
	ldr r9, addr_n_0
	str r10, [r9]
	ldr r10, =10
	str r10, [fp, #-32]
	ldr r10, =0
	str r10, [fp, #-20]
	ldr r10, =0
	str r10, [fp, #-16]
	ldr r10, addr_n_0
	ldr r9, [r10]
	mov r0, r9
	bl init
	ldr r10, addr_n_0
	ldr r9, [r10]
	ldr r10, addr_n_0
	ldr r8, [r10]
	mul r10, r9, r8
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L156
.L146:
	b .L143
.L156:
	ldr r10, [fp, #-20]
	ldr r9, [fp, #-32]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L155
	b .L161
.L143:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L155:
	bl getint
	mov r10, r0
	str r10, [fp, #-28]
	bl getint
	mov r10, r0
	str r10, [fp, #-24]
	ldr r10, [fp, #-16]
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L163
	b .L167
.L161:
	b .L157
.L163:
	ldr r10, addr_n_0
	ldr r9, [r10]
	ldr r10, [fp, #-28]
	sub r8, r10, #1
	mul r10, r9, r8
	ldr r9, [fp, #-24]
	add r8, r10, r9
	str r8, [fp, #-8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_array_0
	add r8, r7, r9
	str r10, [r8]
	ldr r10, [fp, #-28]
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L178
	b .L182
.L167:
	b .L164
.L157:
	ldr r10, [fp, #-16]
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L303
	b .L307
.L178:
	ldr r10, =0
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_array_0
	add r9, r8, r10
	ldr r10, =0
	str r10, [r9]
	ldr r10, [fp, #-8]
	mov r1, #0
	mov r0, r10
	bl mmerge
	b .L179
.L182:
	b .L179
.L164:
	ldr r10, [fp, #-20]
	add r9, r10, #1
	str r9, [fp, #-20]
	b .L156
.L303:
	mov r0, #-1
	bl putint
	mov r0, #10
	bl putch
	b .L304
.L307:
	b .L304
.L179:
	ldr r10, [fp, #-28]
	ldr r9, addr_n_0
	ldr r8, [r9]
	cmp r10, r8
	moveq r10, #1
	movne r10, #0
	beq .L188
	b .L193
.L304:
	b .L142
.L188:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-12]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_array_0
	add r8, r7, r9
	str r10, [r8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-12]
	mov r1, r9
	mov r0, r10
	bl mmerge
	b .L189
.L193:
	b .L189
.L189:
	ldr r10, [fp, #-24]
	ldr r9, addr_n_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L204
	b .L208
.L204:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_array_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L202
	b .L216
.L208:
	b .L203
.L202:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	add r8, r9, #1
	mov r1, r8
	mov r0, r10
	bl mmerge
	b .L203
	b .F0
.LTORG
addr_array_0:
	.word array
addr_n_0:
	.word n
.F0:
.L216:
	b .L203
.L203:
	ldr r10, [fp, #-24]
	ldr r9, =1
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L222
	b .L225
.L222:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_array_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L220
	b .L233
.L225:
	b .L221
.L220:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	sub r8, r9, #1
	mov r1, r8
	mov r0, r10
	bl mmerge
	b .L221
.L233:
	b .L221
.L221:
	ldr r10, [fp, #-28]
	ldr r9, addr_n_1
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L239
	b .L243
.L239:
	ldr r10, [fp, #-8]
	ldr r9, addr_n_1
	ldr r8, [r9]
	add r9, r10, r8
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_array_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L237
	b .L252
.L243:
	b .L238
.L237:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, addr_n_1
	ldr r7, [r8]
	add r8, r9, r7
	mov r1, r8
	mov r0, r10
	bl mmerge
	b .L238
.L252:
	b .L238
.L238:
	ldr r10, [fp, #-28]
	ldr r9, =1
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L259
	b .L262
.L259:
	ldr r10, [fp, #-8]
	ldr r9, addr_n_1
	ldr r8, [r9]
	sub r9, r10, r8
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_array_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L257
	b .L271
.L262:
	b .L258
.L257:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	ldr r8, addr_n_1
	ldr r7, [r8]
	sub r8, r9, r7
	mov r1, r8
	mov r0, r10
	bl mmerge
	b .L258
.L271:
	b .L258
.L258:
	ldr r10, =0
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_array_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L279
	b .L285
.L279:
	ldr r10, [fp, #-12]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_array_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L278
	b .L293
.L285:
	b .L277
.L278:
	mov r0, #0
	bl findfa
	mov r10, r0
	ldr r9, [fp, #-12]
	mov r0, r9
	bl findfa
	mov r9, r0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L276
	b .L297
.L293:
	b .L277
.L277:
	b .L164
.L276:
	ldr r10, =1
	str r10, [fp, #-16]
	ldr r10, [fp, #-20]
	add r9, r10, #1
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	mov r0, #10
	bl putch
	b .L277
.L297:
	b .L277
.Lmain_END:
	add sp, sp, #36
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

addr_array_1:
	.word array
addr_n_1:
	.word n
