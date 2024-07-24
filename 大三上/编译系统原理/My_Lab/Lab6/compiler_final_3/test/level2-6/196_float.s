	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global float_abs
	.type float_abs , %function
float_abs:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L85:
	vstr.32 s0, [fp, #-4]
	vldr.32 s31, [fp, #-4]
	ldr r10, =0
	vmov s30, r10
	vcvt.f32.s32  s29, s30
	vcmp.f32 s31, s29
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L87
	b .L92
.L87:
	vldr.32 s31, [fp, #-4]
	ldr r10, =0
	vmov s30, r10
	vsub.f32 s29, s30, s31
	vmov s0, s29
	b .Lfloat_abs_END
.L92:
	b .L88
.L88:
	vldr.32 s31, [fp, #-4]
	vmov s0, s31
	b .Lfloat_abs_END
.Lfloat_abs_END:
	add sp, sp, #4
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global circle_area
	.type circle_area , %function
circle_area:
	push {r8, r9, r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #4
.L96:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, =1078530011
	vmov s31, r10
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-4]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	vmul.f32 s31, s29, s30
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-4]
	mul r8, r10, r9
	vmov s30, r8
	vcvt.f32.s32  s29, s30
	ldr r10, =1078530011
	vmov s30, r10
	vmul.f32 s28, s29, s30
	vadd.f32 s30, s31, s28
	ldr r10, =2
	vmov s31, r10
	vcvt.f32.s32  s29, s31
	vdiv.f32 s31, s30, s29
	vmov s0, s31
	b .Lcircle_area_END
.Lcircle_area_END:
	add sp, sp, #4
	vpop {s28, s29, s30, s31}
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global float_eq
	.type float_eq , %function
float_eq:
	push {r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #8
.L106:
	vstr.32 s0, [fp, #-8]
	vstr.32 s1, [fp, #-4]
	vldr.32 s31, [fp, #-8]
	vldr.32 s30, [fp, #-4]
	vsub.f32 s29, s31, s30
	vmov s0, s29
	bl float_abs
	vmov s31, s0
	ldr r10, =897988541
	vmov s30, r10
	vcmp.f32 s31, s30
	vmrs APSR_nzcv, FPSCR
	movlt r10, #1
	movge r10, #0
	blt .L109
	b .L115
.L109:
	ldr r10, =1065353216
	vmov s31, r10
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	mov r0, r10
	b .Lfloat_eq_END
.L115:
	b .L110
.L110:
	ldr r10, =0
	mov r0, r10
	b .Lfloat_eq_END
.Lfloat_eq_END:
	add sp, sp, #8
	vpop {s29, s30, s31}
	pop {r10, fp, lr}
	bx lr

	.global error
	.type error , %function
error:
	push {fp, lr}
	mov fp, sp
.L118:
	mov r0, #101
	bl putch
	mov r0, #114
	bl putch
	mov r0, #114
	bl putch
	mov r0, #111
	bl putch
	mov r0, #114
	bl putch
	mov r0, #10
	bl putch
	b .Lerror_END
.Lerror_END:
	pop {fp, lr}
	bx lr

	.global ok
	.type ok , %function
ok:
	push {fp, lr}
	mov fp, sp
.L119:
	mov r0, #111
	bl putch
	mov r0, #107
	bl putch
	mov r0, #10
	bl putch
	b .Lok_END
.Lok_END:
	pop {fp, lr}
	bx lr

	.global assert
	.type assert , %function
assert:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L120:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L122
	b .L127
.L122:
	bl error
	b .L124
.L127:
	b .L123
.L124:
	b .Lassert_END
.L123:
	bl ok
	b .L124
.Lassert_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	vpush {s29, s30, s31}
	mov fp, sp
	sub sp, sp, #64
.L129:
	ldr r10, =3338725376
	vmov s1, r10
	ldr r10, =1033895936
	vmov s0, r10
	bl float_eq
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	uxtb r9, r10
	mov r0, r9
	bl assert
	ldr r10, =1107966695
	vmov s1, r10
	ldr r10, =1119752446
	vmov s0, r10
	bl float_eq
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	uxtb r9, r10
	mov r0, r9
	bl assert
	ldr r10, =1107966695
	vmov s1, r10
	ldr r10, =1107966695
	vmov s0, r10
	bl float_eq
	mov r10, r0
	mov r0, r10
	bl assert
	ldr r10, =1085276160
	vmov s31, r10
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	mov r0, r10
	bl circle_area
	vmov s31, s0
	mov r0, #5
	bl circle_area
	vmov s30, s0
	vmov s1, s30
	vmov s0, s31
	bl float_eq
	mov r10, r0
	mov r0, r10
	bl assert
	ldr r10, =1166012416
	vmov s1, r10
	ldr r10, =1130954752
	vmov s0, r10
	bl float_eq
	mov r10, r0
	ldr r9, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	uxtb r9, r10
	mov r0, r9
	bl assert
	ldr r10, =0
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, =1069547520
	vmov s31, r10
	vcmp.f32 s30, s31
	vmrs APSR_nzcv, FPSCR
	movne r10, #1
	moveq r10, #0
	bne .L134
	b .L138
.L134:
	bl ok
	b .L135
.L138:
	b .L135
.L135:
	ldr r10, =0
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, =1065353216
	vmov s31, r10
	vcmp.f32 s30, s31
	vmrs APSR_nzcv, FPSCR
	movne r10, #1
	moveq r10, #0
	bne .L140
	b .L144
.L140:
	bl ok
	b .L141
.L144:
	b .L141
.L141:
	ldr r10, =0
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L146
	b .L150
.L146:
	bl error
	b .L147
.L150:
	b .L147
.L147:
	ldr r10, =1
	uxtb r9, r10
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L152
	b .L156
.L152:
	bl ok
	b .L153
.L156:
	b .L153
.L153:
	ldr r10, =1
	str r10, [fp, #-64]
	ldr r10, =0
	str r10, [fp, #-60]
	ldr r10, =0
	add r9, r10, #-56
	ldr r10, =1065353216
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =4
	add r9, r10, #-56
	ldr r10, =2
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =8
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =12
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =16
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =20
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =24
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =28
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =32
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =36
	add r9, r10, #-56
	ldr r10, =0
	vmov s31, r10
	add r10, fp, r9
	vstr.32 s31, [r10]
	ldr r10, =0
	add r9, r10, #-56
	add r10, fp, r9
	mov r0, r10
	bl getfarray
	mov r10, r0
	str r10, [fp, #-16]
	b .L175
	b .F0
.LTORG
.F0:
.L175:
	ldr r10, [fp, #-64]
	ldr r9, =1000000000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L174
	b .L179
.L174:
	bl getfloat
	vmov s31, s0
	vstr.32 s31, [fp, #-12]
	vldr.32 s31, [fp, #-12]
	ldr r10, =1078530011
	vmov s30, r10
	vmul.f32 s29, s30, s31
	vldr.32 s31, [fp, #-12]
	vmul.f32 s30, s29, s31
	vstr.32 s30, [fp, #-8]
	vldr.32 s31, [fp, #-12]
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	mov r0, r10
	bl circle_area
	vmov s31, s0
	vstr.32 s31, [fp, #-4]
	ldr r10, [fp, #-60]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-56
	add r10, fp, r10
	vldr.32 s31, [r10]
	vldr.32 s30, [fp, #-12]
	vadd.f32 s29, s31, s30
	ldr r10, [fp, #-60]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-56
	add r9, fp, r10
	vstr.32 s29, [r9]
	vldr.32 s31, [fp, #-8]
	vmov s0, s31
	bl putfloat
	mov r0, #32
	bl putch
	vldr.32 s31, [fp, #-4]
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	mov r0, r10
	bl putint
	mov r0, #10
	bl putch
	ldr r10, [fp, #-64]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, =1092616192
	vmov s31, r10
	vmul.f32 s29, s30, s31
	vcvt.s32.f32  s31, s29
	vmov r10, s31
	str r10, [fp, #-64]
	ldr r10, [fp, #-60]
	add r9, r10, #1
	str r9, [fp, #-60]
	b .L175
.L179:
	b .L176
.L176:
	ldr r10, [fp, #-16]
	ldr r9, =0
	add r8, r9, #-56
	add r9, fp, r8
	mov r1, r9
	mov r0, r10
	bl putfarray
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #64
	vpop {s29, s30, s31}
	pop {r8, r9, r10, fp, lr}
	bx lr

