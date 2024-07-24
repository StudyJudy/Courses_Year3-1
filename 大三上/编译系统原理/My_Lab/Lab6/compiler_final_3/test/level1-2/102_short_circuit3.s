	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global a
	.align 4
	.size a, 4
a:
	.word 0
	.global b
	.align 4
	.size b, 4
b:
	.word 0
	.global d
	.align 4
	.size d, 4
d:
	.word 0
	.text
	.global set_a
	.type set_a , %function
set_a:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L94:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, addr_a_0
	str r10, [r9]
	ldr r10, addr_a_0
	ldr r9, [r10]
	mov r0, r9
	b .Lset_a_END
.Lset_a_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global set_b
	.type set_b , %function
set_b:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L98:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, addr_b_0
	str r10, [r9]
	ldr r10, addr_b_0
	ldr r9, [r10]
	mov r0, r9
	b .Lset_b_END
.Lset_b_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global set_d
	.type set_d , %function
set_d:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L102:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, addr_d_0
	str r10, [r9]
	ldr r10, addr_d_0
	ldr r9, [r10]
	mov r0, r9
	b .Lset_d_END
.Lset_d_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #24
.L106:
	ldr r10, =2
	ldr r9, addr_a_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_b_0
	str r10, [r9]
	mov r0, #0
	bl set_a
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L109
	b .L111
.L109:
	mov r0, #1
	bl set_b
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L107
	b .L114
.L111:
	b .L108
.L107:
	b .L108
.L114:
	b .L108
.L108:
	ldr r10, addr_a_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	mov r0, #32
	bl putch
	ldr r10, addr_b_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	mov r0, #32
	bl putch
	ldr r10, =2
	ldr r9, addr_a_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_b_0
	str r10, [r9]
	mov r0, #0
	bl set_a
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L120
	b .L122
.L120:
	mov r0, #1
	bl set_b
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L118
	b .L125
.L122:
	b .L119
.L118:
	b .L119
.L125:
	b .L119
.L119:
	ldr r10, addr_a_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	mov r0, #32
	bl putch
	ldr r10, addr_b_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	mov r0, #10
	bl putch
	ldr r10, =1
	str r10, [fp, #-24]
	ldr r10, =2
	ldr r9, addr_d_0
	str r10, [r9]
	ldr r10, =1
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L132
	b .L135
.L132:
	mov r0, #3
	bl set_d
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L130
	b .L138
.L135:
	b .L131
.L130:
	b .L131
.L138:
	b .L131
.L131:
	ldr r10, addr_d_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	mov r0, #32
	bl putch
	ldr r10, =1
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L141
	b .L146
.L141:
	b .L142
.L146:
	b .L143
.L142:
	ldr r10, addr_d_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	mov r0, #10
	bl putch
	ldr r10, =1
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L152
	b .L156
.L143:
	mov r0, #4
	bl set_d
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L141
	b .L149
.L152:
	mov r0, #65
	bl putch
	b .L153
.L156:
	b .L153
.L149:
	b .L142
.L153:
	ldr r10, =0
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L158
	b .L162
.L158:
	mov r0, #66
	bl putch
	b .L159
.L162:
	b .L159
.L159:
	ldr r10, =0
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L164
	b .L168
	b .F0
.LTORG
addr_a_0:
	.word a
addr_b_0:
	.word b
addr_d_0:
	.word d
.F0:
.L164:
	mov r0, #67
	bl putch
	b .L165
.L168:
	b .L165
.L165:
	ldr r10, =1
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L170
	b .L174
.L170:
	mov r0, #68
	bl putch
	b .L171
.L174:
	b .L171
.L171:
	ldr r10, =0
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L176
	b .L180
.L176:
	mov r0, #69
	bl putch
	b .L177
.L180:
	b .L177
.L177:
	ldr r10, =1
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L182
	b .L186
.L182:
	mov r0, #70
	bl putch
	b .L183
.L186:
	b .L183
.L183:
	mov r0, #10
	bl putch
	ldr r10, =0
	str r10, [fp, #-20]
	ldr r10, =1
	str r10, [fp, #-16]
	ldr r10, =2
	str r10, [fp, #-12]
	ldr r10, =3
	str r10, [fp, #-8]
	ldr r10, =4
	str r10, [fp, #-4]
	b .L194
.L194:
	ldr r10, [fp, #-20]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L196
	b .L199
.L196:
	ldr r10, [fp, #-16]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L193
	b .L203
.L199:
	b .L195
.L193:
	mov r0, #32
	bl putch
	b .L194
.L203:
	b .L195
.L195:
	ldr r10, [fp, #-20]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L205
	b .L210
.L205:
	mov r0, #67
	bl putch
	b .L206
.L210:
	b .L207
.L206:
	ldr r10, [fp, #-20]
	ldr r9, [fp, #-16]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L216
	b .L222
.L207:
	ldr r10, [fp, #-16]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L205
	b .L214
.L216:
	mov r0, #72
	bl putch
	b .L217
.L222:
	b .L218
.L214:
	b .L206
.L217:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-16]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L231
	b .L235
.L218:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-20]
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L216
	b .L227
.L231:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L229
	b .L240
.L235:
	b .L230
.L227:
	b .L217
.L229:
	mov r0, #73
	bl putch
	b .L230
.L240:
	b .L230
.L230:
	ldr r10, [fp, #-20]
	ldr r9, [fp, #-16]
	ldr r8, =0
	cmp r8, r9
	moveq r9, #1
	movne r9, #0
	uxtb r8, r9
	cmp r10, r8
	moveq r10, #1
	movne r10, #0
	beq .L245
	b .L250
.L245:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L242
	b .L255
.L250:
	b .L244
.L242:
	mov r0, #74
	bl putch
	b .L243
.L255:
	b .L244
.L244:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-4]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L242
	b .L260
.L243:
	ldr r10, [fp, #-20]
	ldr r9, [fp, #-16]
	ldr r8, =0
	cmp r8, r9
	moveq r9, #1
	movne r9, #0
	uxtb r8, r9
	cmp r10, r8
	moveq r10, #1
	movne r10, #0
	beq .L262
	b .L269
	b .F1
.LTORG
addr_a_1:
	.word a
addr_b_1:
	.word b
addr_d_1:
	.word d
.F1:
.L260:
	b .L243
.L262:
	mov r0, #75
	bl putch
	b .L263
.L269:
	b .L264
.L263:
	mov r0, #10
	bl putch
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L264:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-8]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L271
	b .L275
.L271:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-4]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L262
	b .L280
.L275:
	b .L263
.L280:
	b .L263
.Lmain_END:
	add sp, sp, #24
	pop {r8, r9, r10, fp, lr}
	bx lr

addr_a_2:
	.word a
addr_b_2:
	.word b
addr_d_2:
	.word d
