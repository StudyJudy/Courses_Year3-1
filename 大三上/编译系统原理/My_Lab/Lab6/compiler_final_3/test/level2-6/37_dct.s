	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	test_block,256,4
	.comm	test_dct,256,4
	.comm	test_idct,256,4
	.text
	.global my_fabs
	.type my_fabs , %function
my_fabs:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L110:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L112
	b .L117
.L112:
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	b .Lmy_fabs_END
.L117:
	b .L113
.L113:
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

	.global p
	.type p , %function
p:
	push {r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L121:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	ldr r10, =3
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vmul.f32 s30, s29, s31
	vldr.32 s31, [fp, #-4]
	ldr r10, =4
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	vmul.f32 s29, s28, s31
	vldr.32 s31, [fp, #-4]
	vmul.f32 s28, s29, s31
	vldr.32 s31, [fp, #-4]
	vmul.f32 s29, s28, s31
	vsub.f32 s31, s30, s29
	vmov s0, s31
	b .Lp_END
.Lp_END:
	add sp, sp, #4
	vpop {s28, s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global my_sin_impl
	.type my_sin_impl , %function
my_sin_impl:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L129:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	bl my_fabs
	vmov s31, s0
	ldr r10, =897988541
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movle r10, #1
	movgt r10, #0
	ble .L131
	b .L135
.L131:
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	b .Lmy_sin_impl_END
.L135:
	b .L132
.L132:
	vldr.32 s31, [fp, #-4]
	ldr r10, =1077936128
	vmov s30, r10
	vdiv.f32 s29, s31, s30
	vmov s0, s29
	bl my_sin_impl
	vmov s31, s0
	vmov s0, s31
	bl p
	vmov s31, s0
	vmov s0, s31
	b .Lmy_sin_impl_END
.Lmy_sin_impl_END:
	add sp, sp, #4
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global my_sin
	.type my_sin , %function
my_sin:
	push {r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #8
.L139:
	vstr.32 s0, [fp, #-8]
	vldr.32 s31, [fp, #-8]
	ldr r10, =1086918619
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L141
	b .L146
.L141:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1086918619
	vmov s30, r10
	vdiv.f32 s29, s31, s30
	vcvt.s32.f32  s31, s29
	vmov r10, s31
	str r10, [fp, #-4]
	vldr.32 s31, [fp, #-8]
	ldr r10, [fp, #-4]
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	ldr r10, =1086918619
	vmov s30, r10
	vmul.f32 s28, s29, s30
	vsub.f32 s30, s31, s28
	vstr.32 s30, [fp, #-8]
	b .L142
.L146:
	b .L143
.L142:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1078530011
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L158
	b .L162
.L143:
	vldr.32 s31, [fp, #-8]
	ldr r10, =3233808384
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L141
	b .L150
.L158:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1086918619
	vmov s30, r10
	vsub.f32 s29, s31, s30
	vstr.32 s29, [fp, #-8]
	b .L159
.L162:
	b .L159
.L150:
	b .L142
.L159:
	vldr.32 s31, [fp, #-8]
	ldr r10, =3225419776
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L165
	b .L169
.L165:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1086918619
	vmov s30, r10
	vadd.f32 s29, s31, s30
	vstr.32 s29, [fp, #-8]
	b .L166
.L169:
	b .L166
.L166:
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	bl my_sin_impl
	vmov s31, s0
	vmov s0, s31
	b .Lmy_sin_END
.Lmy_sin_END:
	add sp, sp, #8
	vpop {s28, s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global my_cos
	.type my_cos , %function
my_cos:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L173:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	ldr r10, =1070141403
	vmov s30, r10
	vadd.f32 s29, s31, s30
	vmov s0, s29
	bl my_sin
	vmov s31, s0
	vmov s0, s31
	b .Lmy_cos_END
.Lmy_cos_END:
	add sp, sp, #4
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global write_mat
	.type write_mat , %function
write_mat:
	push {r6, r7, r8, r9, r10, fp, lr}
	vpush {s31}
	mov fp, sp
	sub sp, sp, #48
.L176:
	str r0, [fp, #-48]
	str r1, [fp, #-16]
	str r2, [fp, #-12]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L182
.L182:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-16]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L181
	b .L187
.L181:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-48]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, #0
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	vldr.32 s31, [r10]
	vmov s0, s31
	bl putfloat
	ldr r10, =1
	str r10, [fp, #-4]
	b .L198
.L187:
	b .L183
.L198:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-12]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L197
	b .L203
.L183:
	mov r0, #10
	bl putch
	b .Lwrite_mat_END
.L197:
	mov r0, #32
	bl putch
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	ldr r8, [fp, #-48]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s31, [r10]
	vmov s0, s31
	bl putfloat
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L198
.L203:
	b .L199
.L199:
	mov r0, #10
	bl putch
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L182
.Lwrite_mat_END:
	add sp, sp, #48
	vpop {s31}
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global dct
	.type dct , %function
dct:
	push {r6, r7, r8, r9, r10, fp, lr}
	vpush {s26, s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #88
.L215:
	str r0, [fp, #-88]
	str r1, [fp, #-56]
	str r2, [fp, #-24]
	str r3, [fp, #-20]
	ldr r10, =0
	str r10, [fp, #-16]
	b .L222
.L222:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-24]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L221
	b .L227
.L221:
	ldr r10, =0
	str r10, [fp, #-12]
	b .L231
.L227:
	b .L223
.L231:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-20]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L230
	b .L236
.L223:
	b .Ldct_END
.L230:
	ldr r10, =0
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-88
	vstr.32 s30, [r10]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L247
.L236:
	b .L232
.L247:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-24]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L246
	b .L252
.L232:
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L222
.L246:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L256
.L252:
	b .L248
.L256:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-20]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L255
	b .L261
.L248:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L231
.L255:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, [fp, #-88]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s31, [r10]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	ldr r8, [fp, #-56]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s30, [r10]
	ldr r10, [fp, #-24]
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	ldr r10, =1078530011
	vmov s29, r10
	vdiv.f32 s27, s29, s28
	ldr r10, [fp, #-8]
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	ldr r10, =1056964608
	vmov s29, r10
	vadd.f32 s26, s28, s29
	vmul.f32 s29, s27, s26
	ldr r10, [fp, #-16]
	vmov s28, r10
	vcvt.f32.s32  s27, s28
	vmul.f32 s28, s29, s27
	vmov s0, s28
	bl my_cos
	vmov s29, s0
	vmul.f32 s28, s30, s29
	ldr r10, [fp, #-20]
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	ldr r10, =1078530011
	vmov s30, r10
	vdiv.f32 s27, s30, s29
	ldr r10, [fp, #-4]
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	ldr r10, =1056964608
	vmov s30, r10
	vadd.f32 s26, s29, s30
	vmul.f32 s30, s27, s26
	ldr r10, [fp, #-12]
	vmov s29, r10
	vcvt.f32.s32  s27, s29
	vmul.f32 s29, s30, s27
	vmov s0, s29
	bl my_cos
	vmov s30, s0
	vmul.f32 s29, s28, s30
	vadd.f32 s30, s31, s29
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-88
	vstr.32 s30, [r10]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L256
.L261:
	b .L257
.L257:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L247
.Ldct_END:
	add sp, sp, #88
	vpop {s26, s27, s28, s29, s30, s31}
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global idct
	.type idct , %function
idct:
	push {r6, r7, r8, r9, r10, fp, lr}
	vpush {s26, s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #88
.L301:
	str r0, [fp, #-88]
	str r1, [fp, #-56]
	str r2, [fp, #-24]
	str r3, [fp, #-20]
	ldr r10, =0
	str r10, [fp, #-16]
	b .L308
.L308:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-24]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L307
	b .L313
.L307:
	ldr r10, =0
	str r10, [fp, #-12]
	b .L317
.L313:
	b .L309
.L317:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-20]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L316
	b .L322
.L309:
	b .Lidct_END
.L316:
	ldr r10, [fp, #-56]
	ldr r9, =0
	ldr r8, =8
	mul r7, r9, r8
	add r9, r7, #0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, =1048576000
	vmov s30, r10
	vmul.f32 s29, s30, s31
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-88
	vstr.32 s29, [r10]
	ldr r10, =1
	str r10, [fp, #-8]
	b .L339
.L322:
	b .L318
.L339:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-24]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L338
	b .L344
.L318:
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L308
.L338:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, [fp, #-88]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s31, [r10]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-56]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, #0
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	vldr.32 s30, [r10]
	ldr r10, =1056964608
	vmov s29, r10
	vmul.f32 s28, s29, s30
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-88
	vstr.32 s30, [r10]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L339
.L344:
	b .L340
.L340:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L369
.L369:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-20]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L368
	b .L374
.L368:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, [fp, #-88]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s31, [r10]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-56]
	ldr r8, =0
	ldr r7, =8
	mul r6, r8, r7
	add r8, r6, r10
	ldr r10, =4
	mul r7, r8, r10
	add r10, r7, r9
	vldr.32 s30, [r10]
	ldr r10, =1056964608
	vmov s29, r10
	vmul.f32 s28, s29, s30
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-88
	vstr.32 s30, [r10]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L369
.L374:
	b .L370
.L370:
	ldr r10, =1
	str r10, [fp, #-8]
	b .L399
.L399:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-24]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L398
	b .L404
.L398:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L407
.L404:
	b .L400
	b .F0
.LTORG
addr_test_block_0:
	.word test_block
addr_test_dct_0:
	.word test_dct
addr_test_idct_0:
	.word test_idct
.F0:
.L407:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-20]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L406
	b .L412
.L400:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, [fp, #-88]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s31, [r10]
	ldr r10, =1073741824
	vmov s30, r10
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-24]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vdiv.f32 s31, s29, s30
	ldr r10, =1073741824
	vmov s30, r10
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-20]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vdiv.f32 s31, s29, s30
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-88
	vstr.32 s31, [r10]
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L317
.L406:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, [fp, #-88]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s31, [r10]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	ldr r8, [fp, #-56]
	ldr r7, =8
	mul r6, r10, r7
	add r10, r6, r9
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	vldr.32 s30, [r10]
	ldr r10, [fp, #-24]
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	ldr r10, =1078530011
	vmov s29, r10
	vdiv.f32 s27, s29, s28
	ldr r10, [fp, #-16]
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	ldr r10, =1056964608
	vmov s29, r10
	vadd.f32 s26, s28, s29
	vmul.f32 s29, s27, s26
	ldr r10, [fp, #-8]
	vmov s28, r10
	vcvt.f32.s32  s27, s28
	vmul.f32 s28, s29, s27
	vmov s0, s28
	bl my_cos
	vmov s29, s0
	vmul.f32 s28, s30, s29
	ldr r10, [fp, #-20]
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	ldr r10, =1078530011
	vmov s30, r10
	vdiv.f32 s27, s30, s29
	ldr r10, [fp, #-12]
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	ldr r10, =1056964608
	vmov s30, r10
	vadd.f32 s26, s29, s30
	vmul.f32 s30, s27, s26
	ldr r10, [fp, #-4]
	vmov s29, r10
	vcvt.f32.s32  s27, s29
	vmul.f32 s29, s30, s27
	vmov s0, s29
	bl my_cos
	vmov s30, s0
	vmul.f32 s29, s28, s30
	vadd.f32 s30, s31, s29
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-88
	vstr.32 s30, [r10]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L407
.L412:
	b .L408
.L408:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L399
.Lidct_END:
	add sp, sp, #88
	vpop {s26, s27, s28, s29, s30, s31}
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r7, r8, r9, r10, fp, lr}
	vpush {s31}
	mov fp, sp
	sub sp, sp, #16
.L470:
	bl getint
	mov r10, r0
	str r10, [fp, #-16]
	bl getint
	mov r10, r0
	str r10, [fp, #-12]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L475
.L475:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-16]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L474
	b .L480
.L474:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L484
.L480:
	b .L476
.L484:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-12]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L483
	b .L489
.L476:
	ldr r10, addr_test_dct_1
	ldr r9, =0
	add r8, r9, r10
	ldr r10, addr_test_block_1
	ldr r9, =0
	add r7, r9, r10
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	mov r3, r9
	mov r2, r10
	mov r1, r7
	mov r0, r8
	bl dct
	ldr r10, addr_test_dct_1
	ldr r9, =0
	add r8, r9, r10
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	mov r2, r9
	mov r1, r10
	mov r0, r8
	bl write_mat
	ldr r10, addr_test_idct_1
	ldr r9, =0
	add r8, r9, r10
	ldr r10, addr_test_dct_1
	ldr r9, =0
	add r7, r9, r10
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	mov r3, r9
	mov r2, r10
	mov r1, r7
	mov r0, r8
	bl idct
	ldr r10, addr_test_idct_1
	ldr r9, =0
	add r8, r9, r10
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-12]
	mov r2, r9
	mov r1, r10
	mov r0, r8
	bl write_mat
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L483:
	bl getfloat
	vmov s31, s0
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	ldr r8, =8
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_test_block_1
	add r9, r8, r10
	vstr.32 s31, [r9]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L484
.L489:
	b .L485
.L485:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L475
.Lmain_END:
	add sp, sp, #16
	vpop {s31}
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

addr_test_block_1:
	.word test_block
addr_test_dct_1:
	.word test_dct
addr_test_idct_1:
	.word test_idct
