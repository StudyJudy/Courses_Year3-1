	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global seed
	.align 4
	.size seed, 4
seed:
	.word 0
	.text
	.global rand
	.type rand , %function
rand:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
.L100:
	ldr r10, addr_seed_0
	ldr r9, [r10]
	ldr r10, =19980130
	mul r8, r9, r10
	ldr r10, =23333
	add r9, r8, r10
	ldr r10, =100000007
	sdiv r8, r9, r10
	mul r8, r8, r10
	sub r10, r9, r8
	ldr r9, addr_seed_0
	str r10, [r9]
	ldr r10, addr_seed_0
	ldr r9, [r10]
	ldr r10, =0
	cmp r9, r10
	movlt r10, #1
	movge r10, #0
	blt .L102
	b .L106
.L102:
	ldr r10, addr_seed_0
	ldr r9, [r10]
	ldr r10, =100000007
	add r8, r9, r10
	ldr r10, addr_seed_0
	str r8, [r10]
	b .L103
.L106:
	b .L103
.L103:
	ldr r10, addr_seed_0
	ldr r9, [r10]
	mov r0, r9
	b .Lrand_END
.Lrand_END:
	pop {r8, r9, r10, fp, lr}
	bx lr

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

	.global my_sqrt
	.type my_sqrt , %function
my_sqrt:
	push {r9, r10, fp, lr}
	vpush {s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #12
.L121:
	vstr.32 s0, [fp, #-12]
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
	b .L132
.L132:
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L131
	b .L136
.L131:
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
	b .L132
.L136:
	b .L133
.L133:
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	b .Lmy_sqrt_END
.Lmy_sqrt_END:
	add sp, sp, #12
	vpop {s27, s28, s29, s30, s31}
	pop {r9, r10, fp, lr}
	bx lr

	.global p
	.type p , %function
p:
	push {r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L144:
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
.L152:
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
	ble .L154
	b .L158
.L154:
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	b .Lmy_sin_impl_END
.L158:
	b .L155
.L155:
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
.L162:
	vstr.32 s0, [fp, #-8]
	vldr.32 s31, [fp, #-8]
	ldr r10, =1086918619
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L164
	b .L169
.L164:
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
	b .L165
.L169:
	b .L166
.L165:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1078530011
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movgt r10, #1
	movle r10, #0
	bgt .L181
	b .L185
.L166:
	vldr.32 s31, [fp, #-8]
	ldr r10, =3233808384
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L164
	b .L173
.L181:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1086918619
	vmov s30, r10
	vsub.f32 s29, s31, s30
	vstr.32 s29, [fp, #-8]
	b .L182
.L185:
	b .L182
.L173:
	b .L165
.L182:
	vldr.32 s31, [fp, #-8]
	ldr r10, =3225419776
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L188
	b .L192
.L188:
	vldr.32 s31, [fp, #-8]
	ldr r10, =1086918619
	vmov s30, r10
	vadd.f32 s29, s31, s30
	vstr.32 s29, [fp, #-8]
	b .L189
.L192:
	b .L189
.L189:
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
.L196:
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

	.global circle_sdf
	.type circle_sdf , %function
circle_sdf:
	push {fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #28
.L199:
	vstr.32 s0, [fp, #-28]
	vstr.32 s1, [fp, #-24]
	vstr.32 s2, [fp, #-20]
	vstr.32 s3, [fp, #-16]
	vldr.32 s31, [fp, #-28]
	vldr.32 s30, [fp, #-20]
	vsub.f32 s29, s31, s30
	vstr.32 s29, [fp, #-8]
	vldr.32 s31, [fp, #-24]
	vldr.32 s30, [fp, #-16]
	vsub.f32 s29, s31, s30
	vstr.32 s29, [fp, #-4]
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-8]
	vmul.f32 s29, s31, s30
	vldr.32 s31, [fp, #-4]
	vldr.32 s30, [fp, #-4]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	vmov s0, s31
	bl my_sqrt
	vmov s31, s0
	vldr.32 s30, [fp, #24]
	vsub.f32 s29, s31, s30
	vmov s0, s29
	b .Lcircle_sdf_END
.Lcircle_sdf_END:
	add sp, sp, #28
	vpop {s28, s29, s30, s31}
	pop {fp, lr}
	bx lr

	.global scene
	.type scene , %function
scene:
	push {r7, r8, r9, r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #20
.L216:
	vstr.32 s0, [fp, #-20]
	vstr.32 s1, [fp, #-16]
	str r0, [fp, #-12]
	vldr.32 s31, [fp, #-20]
	vldr.32 s30, [fp, #-16]
	ldr r10, =1036831949
	vmov s29, r10
	vpush {s29}
	ldr r10, =1053609165
	vmov s3, r10
	ldr r10, =1053609165
	vmov s2, r10
	vmov s1, s30
	vmov s0, s31
	bl circle_sdf
	vmov s31, s0
	add sp, sp, #4
	vstr.32 s31, [fp, #-8]
	vldr.32 s31, [fp, #-20]
	vldr.32 s30, [fp, #-16]
	ldr r10, =1028443341
	vmov s29, r10
	vpush {s29}
	ldr r10, =1058642330
	vmov s3, r10
	ldr r10, =1058642330
	vmov s2, r10
	vmov s1, s30
	vmov s0, s31
	bl circle_sdf
	vmov s31, s0
	add sp, sp, #4
	vstr.32 s31, [fp, #-4]
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L226
	b .L232
.L226:
	vldr.32 s31, [fp, #-8]
	ldr r10, [fp, #-12]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
	ldr r10, [fp, #-12]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, =1077936128
	vmov s31, r10
	vstr.32 s31, [r9]
	b .L228
.L232:
	b .L227
.L228:
	b .Lscene_END
.L227:
	vldr.32 s31, [fp, #-4]
	ldr r10, [fp, #-12]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
	ldr r10, [fp, #-12]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, =0
	vmov s31, r10
	vstr.32 s31, [r9]
	b .L228
.Lscene_END:
	add sp, sp, #20
	vpop {s29, s30, s31}
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global trace
	.type trace , %function
trace:
	push {r8, r9, r10, fp, lr}
	vpush {s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #32
.L248:
	vstr.32 s0, [fp, #-32]
	vstr.32 s1, [fp, #-28]
	vstr.32 s2, [fp, #-24]
	vstr.32 s3, [fp, #-20]
	ldr r10, =0
	vmov s31, r10
	vstr.32 s31, [fp, #-16]
	ldr r10, =0
	str r10, [fp, #-12]
	b .L256
.L256:
	ldr r10, [fp, #-12]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L258
	b .L261
.L258:
	vldr.32 s31, [fp, #-16]
	ldr r10, =1073741824
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L255
	b .L265
.L261:
	b .L257
.L255:
	vldr.32 s31, [fp, #-32]
	vldr.32 s30, [fp, #-24]
	vldr.32 s29, [fp, #-16]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	vldr.32 s31, [fp, #-28]
	vldr.32 s29, [fp, #-20]
	vldr.32 s28, [fp, #-16]
	vmul.f32 s27, s29, s28
	vadd.f32 s29, s31, s27
	ldr r10, =0
	add r9, r10, #-8
	add r10, fp, r9
	mov r0, r10
	vmov s1, s29
	vmov s0, s30
	bl scene
	ldr r10, =0
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-8
	add r10, fp, r10
	vldr.32 s31, [r10]
	ldr r10, =897988541
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L276
	b .L282
.L265:
	b .L257
.L257:
	ldr r10, =0
	vmov s0, r10
	b .Ltrace_END
.L276:
	ldr r10, =1
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-8
	add r10, fp, r10
	vldr.32 s31, [r10]
	vmov s0, s31
	b .Ltrace_END
.L282:
	b .L277
.L277:
	vldr.32 s31, [fp, #-16]
	ldr r10, =0
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-8
	add r10, fp, r10
	vldr.32 s30, [r10]
	vadd.f32 s29, s31, s30
	vstr.32 s29, [fp, #-16]
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L256
.Ltrace_END:
	add sp, sp, #32
	vpop {s27, s28, s29, s30, s31}
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global sample
	.type sample , %function
sample:
	push {r9, r10, fp, lr}
	vpush {s27, s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #24
.L292:
	vstr.32 s0, [fp, #-24]
	vstr.32 s1, [fp, #-20]
	ldr r10, =0
	vmov s31, r10
	vstr.32 s31, [fp, #-16]
	ldr r10, =0
	str r10, [fp, #-12]
	b .L298
.L298:
	ldr r10, [fp, #-12]
	ldr r9, =24
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L297
	b .L302
.L297:
	bl rand
	mov r10, r0
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vstr.32 s30, [fp, #-8]
	ldr r10, [fp, #-12]
	vldr.32 s31, [fp, #-8]
	ldr r9, =100000006
	vmov s30, r9
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	vmov s31, r10
	vcvt.f32.s32  s29, s31
	vadd.f32 s31, s29, s30
	ldr r10, =1086918619
	vmov s30, r10
	vmul.f32 s29, s30, s31
	ldr r10, =24
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vdiv.f32 s31, s29, s30
	vstr.32 s31, [fp, #-4]
	vldr.32 s31, [fp, #-16]
	vldr.32 s30, [fp, #-24]
	vldr.32 s29, [fp, #-20]
	vldr.32 s28, [fp, #-4]
	vmov s0, s28
	bl my_cos
	vmov s28, s0
	vldr.32 s27, [fp, #-4]
	vmov s0, s27
	bl my_sin
	vmov s27, s0
	vmov s3, s27
	vmov s2, s28
	vmov s1, s29
	vmov s0, s30
	bl trace
	vmov s30, s0
	vadd.f32 s29, s31, s30
	vstr.32 s29, [fp, #-16]
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L298
.L302:
	b .L299
.L299:
	vldr.32 s31, [fp, #-16]
	ldr r10, =24
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	vmov s0, s30
	b .Lsample_END
.Lsample_END:
	add sp, sp, #24
	vpop {s27, s28, s29, s30, s31}
	pop {r9, r10, fp, lr}
	bx lr

	.global write_pgm
	.type write_pgm , %function
write_pgm:
	push {r9, r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #20
.L320:
	mov r0, #80
	bl putch
	mov r0, #50
	bl putch
	mov r0, #10
	bl putch
	mov r0, #192
	bl putint
	mov r0, #32
	bl putch
	mov r0, #192
	bl putint
	mov r0, #32
	bl putch
	mov r0, #255
	bl putint
	mov r0, #10
	bl putch
	ldr r10, =0
	str r10, [fp, #-20]
	b .L323
.L323:
	ldr r10, [fp, #-20]
	ldr r9, =192
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L322
	b .L327
.L322:
	ldr r10, =0
	str r10, [fp, #-16]
	b .L331
.L327:
	b .L324
.L331:
	ldr r10, [fp, #-16]
	ldr r9, =192
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L330
	b .L335
.L324:
	b .Lwrite_pgm_END
.L330:
	ldr r10, [fp, #-16]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vstr.32 s30, [fp, #-12]
	ldr r10, [fp, #-20]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vstr.32 s30, [fp, #-8]
	vldr.32 s31, [fp, #-12]
	ldr r10, =192
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vdiv.f32 s30, s31, s29
	vldr.32 s31, [fp, #-8]
	ldr r10, =192
	vmov s29, r10
	vcvt.f32.s32  s28, s29
	vdiv.f32 s29, s31, s28
	vmov s1, s29
	vmov s0, s30
	bl sample
	vmov s31, s0
	ldr r10, =1132396544
	vmov s30, r10
	vmul.f32 s29, s31, s30
	vcvt.s32.f32  s31, s29
	vmov r10, s31
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =255
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L349
	b .L353
.L335:
	b .L332
.L349:
	ldr r10, =255
	str r10, [fp, #-4]
	b .L350
.L353:
	b .L350
.L332:
	mov r0, #10
	bl putch
	ldr r10, [fp, #-20]
	add r9, r10, #1
	str r9, [fp, #-20]
	b .L323
.L350:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	mov r0, #32
	bl putch
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L331
.Lwrite_pgm_END:
	add sp, sp, #20
	vpop {s28, s29, s30, s31}
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L358:
	bl write_pgm
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

addr_seed_0:
	.word seed
