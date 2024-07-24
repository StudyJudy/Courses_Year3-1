	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global my_fabs
	.type my_fabs , %function
my_fabs:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L143:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L145
	b .L150
.L145:
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	b .Lmy_fabs_END
.L150:
	b .L146
.L146:
	vldr.32 s31, [fp, #-4]
	ldr r10, =0
	vmov s30, r10
	vsub.f32 s29, s30, s31
	vmov s0, s29
	b .Lmy_fabs_END
.Lmy_fabs_END:
	add sp, sp, #4
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global my_pow
	.type my_pow , %function
my_pow:
	push {r8, r9, r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #12
.L154:
	vstr.32 s0, [fp, #-12]
	str r0, [fp, #-8]
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L157
	b .L161
.L157:
	vldr.32 s31, [fp, #-12]
	ldr r10, [fp, #-8]
	ldr r9, =0
	sub r8, r9, r10
	mov r0, r8
	vmov s0, s31
	bl my_pow
	vmov s31, s0
	ldr r10, =1
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s29, s31
	vmov s0, s30
	b .Lmy_pow_END
.L161:
	b .L158
.L158:
	ldr r10, =1065353216
	vmov s31, r10
	vstr.32 s31, [fp, #-4]
	b .L168
.L168:
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L167
	b .L172
.L167:
	ldr r10, [fp, #-8]
	ldr r9, =2
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	ldr r10, =0
	cmp r10, r8
	movne r10, #1
	moveq r10, #0
	bne .L174
	b .L178
.L172:
	b .L169
.L174:
	vldr.32 s31, [fp, #-4]
	vldr.32 s30, [fp, #-12]
	vmul.f32 s29, s31, s30
	vstr.32 s29, [fp, #-4]
	b .L175
.L178:
	b .L175
.L169:
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	b .Lmy_pow_END
.L175:
	vldr.32 s31, [fp, #-12]
	vldr.32 s30, [fp, #-12]
	vmul.f32 s29, s31, s30
	vstr.32 s29, [fp, #-12]
	ldr r10, [fp, #-8]
	ldr r9, =2
	sdiv r8, r10, r9
	str r8, [fp, #-8]
	b .L168
.Lmy_pow_END:
	add sp, sp, #12
	vpop {s29, s30, s31}
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global my_sqrt
	.type my_sqrt , %function
my_sqrt:
	push {r9, r10, fp, lr}
	vpush {s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #12
.L186:
	vstr.32 s0, [fp, #-12]
	vldr.32 s31, [fp, #-12]
	ldr r10, =100
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L188
	b .L193
.L188:
	vldr.32 s31, [fp, #-12]
	ldr r10, =100
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	vmov s0, s30
	bl my_sqrt
	vmov s31, s0
	ldr r10, =1092616192
	vmov s30, r10
	vmul.f32 s29, s30, s31
	vmov s0, s29
	b .Lmy_sqrt_END
.L193:
	b .L189
.L189:
	vldr.32 s31, [fp, #-12]
	ldr r10, =8
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	ldr r10, =1056964608
	vmov s31, r10
	vadd.f32 s29, s30, s31
	vldr.32 s31, [fp, #-12]
	ldr r10, =2
	vmov s30, r10
	vcvt.f32.s32  s28, s30
	vmul.f32 s30, s28, s31
	vldr.32 s31, [fp, #-12]
	ldr r10, =4
	vmov s28, r10
	vcvt.f32.s32  s27, s28
	vadd.f32 s28, s27, s31
	vdiv.f32 s31, s30, s28
	vadd.f32 s30, s29, s31
	vstr.32 s30, [fp, #-8]
	ldr r10, =10
	str r10, [fp, #-4]
	b .L206
.L206:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L205
	b .L210
.L205:
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-12]
	vldr.32 s29, [fp, #-8]
	vdiv.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, =2
	vmov s31, r10
	vcvt.f32.s32  s29, s31
	vdiv.f32 s31, s30, s29
	vstr.32 s31, [fp, #-8]
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	str r9, [fp, #-4]
	b .L206
.L210:
	b .L207
.L207:
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	b .Lmy_sqrt_END
.Lmy_sqrt_END:
	add sp, sp, #12
	vpop {s27, s28, s29, s30, s31}
	pop {r9, r10, fp, lr}
	bx lr

	.global F1
	.type F1 , %function
F1:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L218:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	ldr r10, =1
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s29, s31
	vmov s0, s30
	b .LF1_END
.LF1_END:
	add sp, sp, #4
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global F2
	.type F2 , %function
F2:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L222:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	vldr.32 s30, [fp, #-4]
	vmul.f32 s29, s31, s30
	ldr r10, =1
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vsub.f32 s31, s30, s29
	vmov s0, s31
	bl my_sqrt
	vmov s31, s0
	ldr r10, =1
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s29, s31
	vmov s0, s30
	b .LF2_END
.LF2_END:
	add sp, sp, #4
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global simpson
	.type simpson , %function
simpson:
	push {r9, r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #16
.L228:
	vstr.32 s0, [fp, #-16]
	vstr.32 s1, [fp, #-12]
	str r0, [fp, #-8]
	vldr.32 s31, [fp, #-16]
	vldr.32 s30, [fp, #-12]
	vldr.32 s29, [fp, #-16]
	vsub.f32 s28, s30, s29
	ldr r10, =2
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s28, s29
	vadd.f32 s29, s31, s30
	vstr.32 s29, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L237
	b .L241
.L237:
	vldr.32 s31, [fp, #-16]
	vmov s0, s31
	bl F1
	vmov s31, s0
	vldr.32 s30, [fp, #-4]
	vmov s0, s30
	bl F1
	vmov s30, s0
	ldr r10, =4
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	vmul.f32 s29, s28, s30
	vadd.f32 s30, s31, s29
	vldr.32 s31, [fp, #-12]
	vmov s0, s31
	bl F1
	vmov s31, s0
	vadd.f32 s29, s30, s31
	vldr.32 s31, [fp, #-12]
	vldr.32 s30, [fp, #-16]
	vsub.f32 s28, s31, s30
	vmul.f32 s31, s29, s28
	ldr r10, =6
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	vmov s0, s30
	b .Lsimpson_END
.L241:
	b .L238
.L238:
	ldr r10, [fp, #-8]
	ldr r9, =2
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L250
	b .L254
.L250:
	vldr.32 s31, [fp, #-16]
	vmov s0, s31
	bl F2
	vmov s31, s0
	vldr.32 s30, [fp, #-4]
	vmov s0, s30
	bl F2
	vmov s30, s0
	ldr r10, =4
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	vmul.f32 s29, s28, s30
	vadd.f32 s30, s31, s29
	vldr.32 s31, [fp, #-12]
	vmov s0, s31
	bl F2
	vmov s31, s0
	vadd.f32 s29, s30, s31
	vldr.32 s31, [fp, #-12]
	vldr.32 s30, [fp, #-16]
	vsub.f32 s28, s31, s30
	vmul.f32 s31, s29, s28
	ldr r10, =6
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	vmov s0, s30
	b .Lsimpson_END
.L254:
	b .L251
.L251:
	ldr r10, =0
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vmov s0, s30
	b .Lsimpson_END
.Lsimpson_END:
	add sp, sp, #16
	vpop {s28, s29, s30, s31}
	pop {r9, r10, fp, lr}
	bx lr

	.global asr5
	.type asr5 , %function
asr5:
	push {r10, fp, lr}
	vpush {s26, s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #32
.L264:
	vstr.32 s0, [fp, #-32]
	vstr.32 s1, [fp, #-28]
	vstr.32 s2, [fp, #-24]
	vstr.32 s3, [fp, #-20]
	str r0, [fp, #-16]
	vldr.32 s31, [fp, #-32]
	vldr.32 s30, [fp, #-28]
	vldr.32 s29, [fp, #-32]
	vsub.f32 s28, s30, s29
	ldr r10, =2
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s28, s29
	vadd.f32 s29, s31, s30
	vstr.32 s29, [fp, #-12]
	vldr.32 s31, [fp, #-32]
	vldr.32 s30, [fp, #-12]
	ldr r10, [fp, #-16]
	mov r0, r10
	vmov s1, s30
	vmov s0, s31
	bl simpson
	vmov s31, s0
	vstr.32 s31, [fp, #-8]
	vldr.32 s31, [fp, #-12]
	vldr.32 s30, [fp, #-28]
	ldr r10, [fp, #-16]
	mov r0, r10
	vmov s1, s30
	vmov s0, s31
	bl simpson
	vmov s31, s0
	vstr.32 s31, [fp, #-4]
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vadd.f32 s29, s31, s30
	vldr.32 s31, [fp, #-20]
	vsub.f32 s30, s29, s31
	vmov s0, s30
	bl my_fabs
	vmov s31, s0
	vldr.32 s30, [fp, #-24]
	ldr r10, =15
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	vmul.f32 s29, s28, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movle r10, #1
	movgt r10, #0
	ble .L283
	b .L291
.L283:
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vadd.f32 s29, s31, s30
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vadd.f32 s28, s31, s30
	vldr.32 s31, [fp, #-20]
	vsub.f32 s30, s28, s31
	ldr r10, =1097859072
	vmov s31, r10
	vdiv.f32 s28, s30, s31
	vadd.f32 s31, s29, s28
	vmov s0, s31
	b .Lasr5_END
.L291:
	b .L284
.L284:
	vldr.32 s31, [fp, #-32]
	vldr.32 s30, [fp, #-12]
	vldr.32 s29, [fp, #-24]
	ldr r10, =2
	vmov s28, r10
	vcvt.f32.s32  s27, s28
	vdiv.f32 s28, s29, s27
	vldr.32 s29, [fp, #-8]
	ldr r10, [fp, #-16]
	mov r0, r10
	vmov s3, s29
	vmov s2, s28
	vmov s1, s30
	vmov s0, s31
	bl asr5
	vmov s31, s0
	vldr.32 s30, [fp, #-12]
	vldr.32 s29, [fp, #-28]
	vldr.32 s28, [fp, #-24]
	ldr r10, =2
	vmov s27, r10
	vcvt.f32.s32  s26, s27
	vdiv.f32 s27, s28, s26
	vldr.32 s28, [fp, #-4]
	ldr r10, [fp, #-16]
	mov r0, r10
	vmov s3, s28
	vmov s2, s27
	vmov s1, s29
	vmov s0, s30
	bl asr5
	vmov s30, s0
	vadd.f32 s29, s31, s30
	vmov s0, s29
	b .Lasr5_END
.Lasr5_END:
	add sp, sp, #32
	vpop {s26, s27, s28, s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global asr4
	.type asr4 , %function
asr4:
	push {r10, fp, lr}
	vpush {s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #16
.L310:
	vstr.32 s0, [fp, #-16]
	vstr.32 s1, [fp, #-12]
	vstr.32 s2, [fp, #-8]
	str r0, [fp, #-4]
	vldr.32 s31, [fp, #-16]
	vldr.32 s30, [fp, #-12]
	vldr.32 s29, [fp, #-8]
	vldr.32 s28, [fp, #-16]
	vldr.32 s27, [fp, #-12]
	ldr r10, [fp, #-4]
	mov r0, r10
	vmov s1, s27
	vmov s0, s28
	bl simpson
	vmov s28, s0
	ldr r10, [fp, #-4]
	mov r0, r10
	vmov s3, s28
	vmov s2, s29
	vmov s1, s30
	vmov s0, s31
	bl asr5
	vmov s31, s0
	vmov s0, s31
	b .Lasr4_END
.Lasr4_END:
	add sp, sp, #16
	vpop {s27, s28, s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global eee
	.type eee , %function
eee:
	push {r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #8
.L322:
	vstr.32 s0, [fp, #-8]
	vldr.32 s31, [fp, #-8]
	ldr r10, =981668463
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L324
	b .L328
.L324:
	vldr.32 s31, [fp, #-8]
	ldr r10, =2
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	vmov s0, s30
	bl eee
	vmov s31, s0
	vstr.32 s31, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	vldr.32 s30, [fp, #-4]
	vmul.f32 s29, s31, s30
	vmov s0, s29
	b .Leee_END
.L328:
	b .L325
.L325:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vadd.f32 s30, s29, s31
	vldr.32 s31, [fp, #-8]
	vldr.32 s29, [fp, #-8]
	vmul.f32 s28, s31, s29
	ldr r10, =2
	vmov s31, r10
	vcvt.f32.s32  s29, s31
	vdiv.f32 s31, s28, s29
	vadd.f32 s29, s30, s31
	vldr.32 s31, [fp, #-8]
	mov r0, #3
	vmov s0, s31
	bl my_pow
	vmov s31, s0
	ldr r10, =6
	vmov s30, r10
	vcvt.f32.s32  s28, s30
	vdiv.f32 s30, s31, s28
	vadd.f32 s31, s29, s30
	vldr.32 s30, [fp, #-8]
	mov r0, #4
	vmov s0, s30
	bl my_pow
	vmov s30, s0
	ldr r10, =24
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	vdiv.f32 s29, s30, s28
	vadd.f32 s30, s31, s29
	vldr.32 s31, [fp, #-8]
	mov r0, #5
	vmov s0, s31
	bl my_pow
	vmov s31, s0
	ldr r10, =120
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	vdiv.f32 s29, s31, s28
	vadd.f32 s31, s30, s29
	vmov s0, s31
	b .Leee_END
.Leee_END:
	add sp, sp, #8
	vpop {s28, s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global my_exp
	.type my_exp , %function
my_exp:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #16
.L346:
	vstr.32 s0, [fp, #-16]
	vldr.32 s31, [fp, #-16]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L348
	b .L353
.L348:
	vldr.32 s31, [fp, #-16]
	ldr r10, =0
	vmov s30, r10
	vsub.f32 s29, s30, s31
	vmov s0, s29
	bl my_exp
	vmov s31, s0
	ldr r10, =1
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s29, s31
	vmov s0, s30
	b .Lmy_exp_END
.L353:
	b .L349
.L349:
	vldr.32 s31, [fp, #-16]
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	str r10, [fp, #-12]
	vldr.32 s31, [fp, #-16]
	ldr r10, [fp, #-12]
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vsub.f32 s30, s31, s29
	vstr.32 s30, [fp, #-16]
	ldr r10, [fp, #-12]
	mov r0, r10
	ldr r10, =1076754516
	vmov s0, r10
	bl my_pow
	vmov s31, s0
	vstr.32 s31, [fp, #-8]
	vldr.32 s31, [fp, #-16]
	vmov s0, s31
	bl eee
	vmov s31, s0
	vstr.32 s31, [fp, #-4]
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vmul.f32 s29, s31, s30
	vmov s0, s29
	b .Lmy_exp_END
.Lmy_exp_END:
	add sp, sp, #16
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global my_ln
	.type my_ln , %function
my_ln:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L369:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	ldr r10, =1
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	mov r0, #1
	ldr r10, =841731191
	vmov s2, r10
	vmov s1, s31
	vmov s0, s29
	bl asr4
	vmov s31, s0
	vmov s0, s31
	b .Lmy_ln_END
.Lmy_ln_END:
	add sp, sp, #4
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global my_log
	.type my_log , %function
my_log:
	push {fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #8
.L373:
	vstr.32 s0, [fp, #-8]
	vstr.32 s1, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	bl my_ln
	vmov s31, s0
	vldr.32 s30, [fp, #-8]
	vmov s0, s30
	bl my_ln
	vmov s30, s0
	vdiv.f32 s29, s31, s30
	vmov s0, s29
	b .Lmy_log_END
.Lmy_log_END:
	add sp, sp, #8
	vpop {s29, s30, s31}
	pop {fp, lr}
	bx lr

	.global my_powf
	.type my_powf , %function
my_powf:
	push {fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #8
.L378:
	vstr.32 s0, [fp, #-8]
	vstr.32 s1, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	vldr.32 s30, [fp, #-8]
	vmov s0, s30
	bl my_ln
	vmov s30, s0
	vmul.f32 s29, s31, s30
	vmov s0, s29
	bl my_exp
	vmov s31, s0
	vmov s0, s31
	b .Lmy_powf_END
.Lmy_powf_END:
	add sp, sp, #8
	vpop {s29, s30, s31}
	pop {fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r9, r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #12
.L383:
	bl getint
	mov r10, r0
	str r10, [fp, #-12]
	b .L386
.L386:
	ldr r10, [fp, #-12]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L385
	b .L390
.L385:
	bl getfloat
	vmov s31, s0
	vstr.32 s31, [fp, #-8]
	bl getfloat
	vmov s31, s0
	vstr.32 s31, [fp, #-4]
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	bl my_fabs
	vmov s31, s0
	vmov s0, s31
	bl putfloat
	mov r0, #32
	bl putch
	vldr.32 s31, [fp, #-8]
	mov r0, #2
	vmov s0, s31
	bl my_pow
	vmov s31, s0
	vmov s0, s31
	bl putfloat
	mov r0, #32
	bl putch
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	bl my_sqrt
	vmov s31, s0
	vmov s0, s31
	bl putfloat
	mov r0, #32
	bl putch
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	bl my_exp
	vmov s31, s0
	vmov s0, s31
	bl putfloat
	mov r0, #32
	bl putch
	vldr.32 s31, [fp, #-8]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L398
	b .L404
.L390:
	b .L387
.L398:
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	bl my_ln
	vmov s31, s0
	vmov s0, s31
	bl putfloat
	b .L400
.L404:
	b .L399
.L387:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L400:
	mov r0, #32
	bl putch
	vldr.32 s31, [fp, #-8]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L410
	b .L414
.L399:
	mov r0, #45
	bl putch
	b .L400
.L410:
	vldr.32 s31, [fp, #-4]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L407
	b .L419
.L414:
	b .L408
.L407:
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vmov s1, s30
	vmov s0, s31
	bl my_log
	vmov s31, s0
	vmov s0, s31
	bl putfloat
	b .L409
.L419:
	b .L408
.L408:
	mov r0, #45
	bl putch
	b .L409
.L409:
	mov r0, #32
	bl putch
	vldr.32 s31, [fp, #-8]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L423
	b .L429
.L423:
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vmov s1, s30
	vmov s0, s31
	bl my_powf
	vmov s31, s0
	vmov s0, s31
	bl putfloat
	b .L425
.L429:
	b .L424
.L425:
	mov r0, #10
	bl putch
	ldr r10, [fp, #-12]
	sub r9, r10, #1
	str r9, [fp, #-12]
	b .L386
.L424:
	mov r0, #45
	bl putch
	b .L425
.Lmain_END:
	add sp, sp, #12
	vpop {s29, s30, s31}
	pop {r9, r10, fp, lr}
	bx lr

