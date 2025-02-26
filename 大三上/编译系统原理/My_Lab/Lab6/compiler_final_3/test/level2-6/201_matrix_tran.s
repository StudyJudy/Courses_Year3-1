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
	.global tran
	.type tran , %function
tran:
	push {r7, r8, r9, r10, fp, lr}
	vpush {s31}
	mov fp, sp
	sub sp, sp, #40
.L15:
	str r0, [fp, #-40]
	str r1, [fp, #-36]
	str r2, [fp, #-32]
	str r3, [fp, #-28]
	ldr r10, =0
	str r10, [fp, #-4]
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
	vstr.32 s31, [r9]
	ldr r10, [fp, #-36]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #44]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
	ldr r10, [fp, #-36]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #36]
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
	ldr r10, [fp, #-32]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #36]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
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
	vstr.32 s31, [r9]
	ldr r10, [fp, #-40]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #44]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
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
	vstr.32 s31, [r9]
	ldr r10, [fp, #-32]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #44]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
	ldr r10, [fp, #-40]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vldr.32 s31, [r9]
	ldr r10, [fp, #36]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	vstr.32 s31, [r9]
	ldr r10, =0
	mov r0, r10
	b .Ltran_END
.Ltran_END:
	add sp, sp, #40
	vpop {s31}
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	vpush {s30, s31}
	mov fp, sp
	sub sp, sp, #140
.L89:
	ldr r10, =3
	ldr r9, addr_N_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_M_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_L_0
	str r10, [r9]
	ldr r10, =0
	str r10, [fp, #-8]
	b .L101
.L101:
	ldr r10, [fp, #-8]
	ldr r9, addr_M_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L100
	b .L106
.L100:
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
	b .L101
.L106:
	b .L102
.L102:
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
	bl tran
	mov r10, r0
	add sp, sp, #20
	str r10, [fp, #-8]
	b .L159
.L159:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L158
	b .L164
.L158:
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
	b .L159
.L164:
	b .L160
.L160:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	ldr r10, =0
	str r10, [fp, #-8]
	b .L175
.L175:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_0
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L174
	b .L180
	b .F0
.LTORG
addr_M_0:
	.word M
addr_L_0:
	.word L
addr_N_0:
	.word N
.F0:
.L174:
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
	b .L175
.L180:
	b .L176
.L176:
	ldr r10, =10
	str r10, [fp, #-4]
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putch
	b .L191
.L191:
	ldr r10, [fp, #-8]
	ldr r9, addr_N_1
	ldr r8, [r9]
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L190
	b .L196
.L190:
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
	b .L191
.L196:
	b .L192
.L192:
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

addr_M_1:
	.word M
addr_L_1:
	.word L
addr_N_1:
	.word N
