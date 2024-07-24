	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global M
	.align 4
	.size M, 4
M:
	.word 0
	.global L
	.align 4
	.size L, 4
L:
	.word 0
	.global N
	.align 4
	.size N, 4
N:
	.word 0
	.text
	.global mul
	.type mul , %function
mul:
	push {r7, r8, r9, r10, fp, lr}
	vpush {s28, s29, s30, s31}
	mov fp, sp
	sub sp, sp, #40
.L60:
	str r0, [fp, #-40]
	str r1, [fp, #-36]
	str r2, [fp, #-32]
	str r3, [fp, #-28]
	ldr r10, =0
	str r10, [fp, #-4]
	ldr r10, [fp, #-40]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-40]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-40]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #48]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-40]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-40]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-40]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #48]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-40]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-40]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-40]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #48]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-36]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-36]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-36]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #52]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-36]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-36]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-36]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #52]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-36]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-36]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-36]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #52]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-32]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-32]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-32]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #56]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-32]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-32]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-32]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #56]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-32]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #-28]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s29, s31, s30
	ldr r10, [fp, #-32]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #40]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	vmul.f32 s28, s31, s30
	vadd.f32 s31, s29, s28
	ldr r10, [fp, #-32]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s30, [r9]
	ldr r10, [fp, #44]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s29, [r9]
	vmul.f32 s28, s30, s29
	vadd.f32 s30, s31, s28
	ldr r10, [fp, #56]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s30, [r9]
	ldr r10, =0
	mov r0, r10
	b .Lmul_END
	b .F0
.LTORG
addr_M_0:
	.word M
addr_L_0:
	.word L
addr_N_0:
	.word N
.F0:
.Lmul_END:
	add sp, sp, #40
	vpop {s28, s29, s30, s31}
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	vpush {s30, s31}
	mov fp, sp
	sub sp, sp, #140
.L314:
	ldr r10, =3
	ldr r9, addr_N_1
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_M_1
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_L_1
	str r10, [r9]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L326
.L326:
	ldr r10, [fp, #-8]
	ldr r9, addr_M_1
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L325
	b .L331
.L325:
	ldr r10, [fp, #-8]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-128
	add r9, fp, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-8]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-116
	add r9, fp, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-8]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-104
	add r9, fp, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-8]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-92
	add r9, fp, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-8]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-80
	add r9, fp, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-8]
	vmov s31, r10
	vcvt.f32.s32  s30, s31
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-68
	add r9, fp, r10
	vstr.32 s30, [r9]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L326
.L331:
	b .L327
.L327:
	ldr r10, =0
	add r9, r10, #-128
	str r9, [fp, #-132]
	ldr r10, =0
	add r9, r10, #-116
	str r9, [fp, #-136]
	ldr r10, =0
	add r9, r10, #-104
	str r9, [fp, #-140]
	ldr r10, =0
	add r9, r10, #-92
	ldr r10, =0
	add r8, r10, #-80
	ldr r10, =0
	add r7, r10, #-68
	ldr r10, =0
	add r6, r10, #-56
	ldr r10, =0
	add r5, r10, #-32
	ldr r10, =0
	add r4, r10, #-20
	add r10, fp, r4
	push {r10}
	add r10, fp, r5
	push {r10}
	add r10, fp, r6
	push {r10}
	add r10, fp, r7
	push {r10}
	add r10, fp, r8
	push {r10}
	add r10, fp, r9
	mov r3, r10
	ldr r10, [fp, #-140]
	add r10, fp, r10
	mov r2, r10
	ldr r10, [fp, #-136]
	add r10, fp, r10
	mov r1, r10
	ldr r10, [fp, #-132]
	add r10, fp, r10
	mov r0, r10
	bl mul
	mov r10, r0
	add sp, sp, #20
	str r10, [fp, #-8]
	b .L384
.L384:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_1
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L383
	b .L389
.L383:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-56
	add r10, fp, r10
	vldr.32 s31, [r10]
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L384
.L389:
	b .L385
.L385:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	b .L400
.L400:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_1
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L399
	b .L405
	b .F1
.LTORG
addr_M_1:
	.word M
addr_L_1:
	.word L
addr_N_1:
	.word N
.F1:
.L399:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-32
	add r10, fp, r10
	vldr.32 s31, [r10]
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L400
.L405:
	b .L401
.L401:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	b .L416
.L416:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_2
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L415
	b .L421
.L415:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-20
	add r10, fp, r10
	vldr.32 s31, [r10]
	vcvt.s32.f32  s30, s31
	vmov r10, s30
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L416
.L421:
	b .L417
.L417:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #140
	vpop {s30, s31}
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

addr_M_2:
	.word M
addr_L_2:
	.word L
addr_N_2:
	.word N
