	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global a0
	.align 4
	.size a0, 4
a0:
	.word 0
	.global a1
	.align 4
	.size a1, 4
a1:
	.word 0
	.global a2
	.align 4
	.size a2, 4
a2:
	.word 0
	.global a3
	.align 4
	.size a3, 4
a3:
	.word 0
	.global a4
	.align 4
	.size a4, 4
a4:
	.word 0
	.global a5
	.align 4
	.size a5, 4
a5:
	.word 0
	.global a6
	.align 4
	.size a6, 4
a6:
	.word 0
	.global a7
	.align 4
	.size a7, 4
a7:
	.word 0
	.global a8
	.align 4
	.size a8, 4
a8:
	.word 0
	.global a17
	.align 4
	.size a17, 4
a17:
	.word 0
	.global a9
	.align 4
	.size a9, 4
a9:
	.word 0
	.global a10
	.align 4
	.size a10, 4
a10:
	.word 0
	.global a11
	.align 4
	.size a11, 4
a11:
	.word 0
	.global a12
	.align 4
	.size a12, 4
a12:
	.word 0
	.global a13
	.align 4
	.size a13, 4
a13:
	.word 0
	.global a14
	.align 4
	.size a14, 4
a14:
	.word 0
	.global a15
	.align 4
	.size a15, 4
a15:
	.word 0
	.global a16
	.align 4
	.size a16, 4
a16:
	.word 0
	.global a18
	.align 4
	.size a18, 4
a18:
	.word 0
	.global a19
	.align 4
	.size a19, 4
a19:
	.word 0
	.global a20
	.align 4
	.size a20, 4
a20:
	.word 0
	.global a21
	.align 4
	.size a21, 4
a21:
	.word 0
	.global a22
	.align 4
	.size a22, 4
a22:
	.word 0
	.global a23
	.align 4
	.size a23, 4
a23:
	.word 0
	.global a24
	.align 4
	.size a24, 4
a24:
	.word 0
	.global a25
	.align 4
	.size a25, 4
a25:
	.word 0
	.global a26
	.align 4
	.size a26, 4
a26:
	.word 0
	.global a27
	.align 4
	.size a27, 4
a27:
	.word 0
	.global a28
	.align 4
	.size a28, 4
a28:
	.word 0
	.global a29
	.align 4
	.size a29, 4
a29:
	.word 0
	.global a30
	.align 4
	.size a30, 4
a30:
	.word 0
	.global a31
	.align 4
	.size a31, 4
a31:
	.word 0
	.global a32
	.align 4
	.size a32, 4
a32:
	.word 0
	.global a33
	.align 4
	.size a33, 4
a33:
	.word 0
	.global a34
	.align 4
	.size a34, 4
a34:
	.word 0
	.global a35
	.align 4
	.size a35, 4
a35:
	.word 0
	.global a36
	.align 4
	.size a36, 4
a36:
	.word 0
	.global a37
	.align 4
	.size a37, 4
a37:
	.word 0
	.global a38
	.align 4
	.size a38, 4
a38:
	.word 0
	.global a39
	.align 4
	.size a39, 4
a39:
	.word 0
	.text
	.global testParam8
	.type testParam8 , %function
testParam8:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #32
.L59:
	str r0, [fp, #-32]
	str r1, [fp, #-28]
	str r2, [fp, #-24]
	str r3, [fp, #-20]
	ldr r10, [fp, #-32]
	ldr r9, [fp, #-28]
	add r8, r10, r9
	ldr r10, [fp, #-24]
	add r9, r8, r10
	ldr r10, [fp, #-20]
	add r8, r9, r10
	ldr r10, [fp, #20]
	add r9, r8, r10
	ldr r10, [fp, #24]
	add r8, r9, r10
	ldr r10, [fp, #28]
	add r9, r8, r10
	ldr r10, [fp, #32]
	add r8, r9, r10
	mov r0, r8
	b .LtestParam8_END
.LtestParam8_END:
	add sp, sp, #32
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global testParam16
	.type testParam16 , %function
testParam16:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #64
.L76:
	str r0, [fp, #-64]
	str r1, [fp, #-60]
	str r2, [fp, #-56]
	str r3, [fp, #-52]
	ldr r10, [fp, #-64]
	ldr r9, [fp, #-60]
	add r8, r10, r9
	ldr r10, [fp, #-56]
	add r9, r8, r10
	ldr r10, [fp, #-52]
	sub r8, r9, r10
	ldr r10, [fp, #20]
	sub r9, r8, r10
	ldr r10, [fp, #24]
	sub r8, r9, r10
	ldr r10, [fp, #28]
	sub r9, r8, r10
	ldr r10, [fp, #32]
	sub r8, r9, r10
	ldr r10, [fp, #36]
	add r9, r8, r10
	ldr r10, [fp, #40]
	add r8, r9, r10
	ldr r10, [fp, #44]
	add r9, r8, r10
	ldr r10, [fp, #48]
	add r8, r9, r10
	ldr r10, [fp, #52]
	add r9, r8, r10
	ldr r10, [fp, #56]
	add r8, r9, r10
	ldr r10, [fp, #60]
	add r9, r8, r10
	ldr r10, [fp, #64]
	add r8, r9, r10
	mov r0, r8
	b .LtestParam16_END
.LtestParam16_END:
	add sp, sp, #64
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global testParam32
	.type testParam32 , %function
testParam32:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #128
.L109:
	str r0, [fp, #-128]
	str r1, [fp, #-124]
	str r2, [fp, #-120]
	str r3, [fp, #-116]
	ldr r10, [fp, #-128]
	ldr r9, [fp, #-124]
	add r8, r10, r9
	ldr r10, [fp, #-120]
	add r9, r8, r10
	ldr r10, [fp, #-116]
	add r8, r9, r10
	ldr r10, [fp, #20]
	add r9, r8, r10
	ldr r10, [fp, #24]
	add r8, r9, r10
	ldr r10, [fp, #28]
	add r9, r8, r10
	ldr r10, [fp, #32]
	add r8, r9, r10
	ldr r10, [fp, #36]
	add r9, r8, r10
	ldr r10, [fp, #40]
	add r8, r9, r10
	ldr r10, [fp, #44]
	add r9, r8, r10
	ldr r10, [fp, #48]
	add r8, r9, r10
	ldr r10, [fp, #52]
	add r9, r8, r10
	ldr r10, [fp, #56]
	add r8, r9, r10
	ldr r10, [fp, #60]
	add r9, r8, r10
	ldr r10, [fp, #64]
	add r8, r9, r10
	ldr r10, [fp, #68]
	add r9, r8, r10
	ldr r10, [fp, #72]
	add r8, r9, r10
	ldr r10, [fp, #76]
	sub r9, r8, r10
	ldr r10, [fp, #80]
	sub r8, r9, r10
	ldr r10, [fp, #84]
	sub r9, r8, r10
	ldr r10, [fp, #88]
	sub r8, r9, r10
	ldr r10, [fp, #92]
	sub r9, r8, r10
	ldr r10, [fp, #96]
	add r8, r9, r10
	ldr r10, [fp, #100]
	add r9, r8, r10
	ldr r10, [fp, #104]
	add r8, r9, r10
	ldr r10, [fp, #108]
	add r9, r8, r10
	ldr r10, [fp, #112]
	add r8, r9, r10
	ldr r10, [fp, #116]
	add r9, r8, r10
	ldr r10, [fp, #120]
	add r8, r9, r10
	ldr r10, [fp, #124]
	add r9, r8, r10
	ldr r10, [fp, #128]
	add r8, r9, r10
	mov r0, r8
	b .LtestParam32_END
.LtestParam32_END:
	add sp, sp, #128
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #152
.L174:
	ldr r10, =0
	ldr r9, addr_a0_0
	str r10, [r9]
	ldr r10, =1
	ldr r9, addr_a1_0
	str r10, [r9]
	ldr r10, =2
	ldr r9, addr_a2_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_a3_0
	str r10, [r9]
	ldr r10, =4
	ldr r9, addr_a4_0
	str r10, [r9]
	ldr r10, =5
	ldr r9, addr_a5_0
	str r10, [r9]
	ldr r10, =6
	ldr r9, addr_a6_0
	str r10, [r9]
	ldr r10, =7
	ldr r9, addr_a7_0
	str r10, [r9]
	ldr r10, =8
	ldr r9, addr_a8_0
	str r10, [r9]
	ldr r10, =9
	ldr r9, addr_a9_0
	str r10, [r9]
	ldr r10, =0
	ldr r9, addr_a10_0
	str r10, [r9]
	ldr r10, =1
	ldr r9, addr_a11_0
	str r10, [r9]
	ldr r10, =2
	ldr r9, addr_a12_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_a13_0
	str r10, [r9]
	ldr r10, =4
	ldr r9, addr_a14_0
	str r10, [r9]
	ldr r10, =5
	ldr r9, addr_a15_0
	str r10, [r9]
	ldr r10, =6
	ldr r9, addr_a16_0
	str r10, [r9]
	ldr r10, =7
	ldr r9, addr_a17_0
	str r10, [r9]
	ldr r10, =8
	ldr r9, addr_a18_0
	str r10, [r9]
	ldr r10, =9
	ldr r9, addr_a19_0
	str r10, [r9]
	ldr r10, =0
	ldr r9, addr_a20_0
	str r10, [r9]
	ldr r10, =1
	ldr r9, addr_a21_0
	str r10, [r9]
	ldr r10, =2
	ldr r9, addr_a22_0
	str r10, [r9]
	ldr r10, =3
	ldr r9, addr_a23_0
	str r10, [r9]
	ldr r10, =4
	ldr r9, addr_a24_0
	str r10, [r9]
	ldr r10, =5
	ldr r9, addr_a25_0
	str r10, [r9]
	ldr r10, =6
	ldr r9, addr_a26_0
	str r10, [r9]
	ldr r10, =7
	ldr r9, addr_a27_0
	str r10, [r9]
	ldr r10, =8
	ldr r9, addr_a28_0
	str r10, [r9]
	ldr r10, =9
	ldr r9, addr_a29_0
	str r10, [r9]
	ldr r10, =0
	ldr r9, addr_a30_0
	str r10, [r9]
	ldr r10, =1
	ldr r9, addr_a31_0
	str r10, [r9]
	ldr r10, =4
	ldr r9, addr_a32_0
	str r10, [r9]
	ldr r10, =5
	ldr r9, addr_a33_0
	str r10, [r9]
	ldr r10, =6
	ldr r9, addr_a34_0
	str r10, [r9]
	ldr r10, =7
	ldr r9, addr_a35_0
	str r10, [r9]
	ldr r10, =8
	ldr r9, addr_a36_0
	str r10, [r9]
	ldr r10, =9
	ldr r9, addr_a37_0
	str r10, [r9]
	ldr r10, =0
	ldr r9, addr_a38_0
	str r10, [r9]
	ldr r10, =1
	ldr r9, addr_a39_0
	str r10, [r9]
	ldr r10, addr_a0_0
	ldr r9, [r10]
	str r9, [fp, #-4]
	ldr r10, addr_a1_0
	ldr r9, [r10]
	str r9, [fp, #-16]
	ldr r10, addr_a2_0
	ldr r9, [r10]
	ldr r10, addr_a3_0
	ldr r8, [r10]
	ldr r10, addr_a4_0
	ldr r7, [r10]
	ldr r10, addr_a5_0
	ldr r6, [r10]
	ldr r10, addr_a6_0
	ldr r5, [r10]
	ldr r10, addr_a7_0
	ldr r4, [r10]
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r3, r8
	mov r2, r9
	ldr r10, [fp, #-16]
	mov r1, r10
	ldr r10, [fp, #-4]
	mov r0, r10
	bl testParam8
	mov r10, r0
	add sp, sp, #16
	ldr r9, addr_a0_0
	str r10, [r9]
	ldr r10, addr_a0_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	ldr r10, addr_a32_0
	ldr r9, [r10]
	str r9, [fp, #-8]
	ldr r10, addr_a33_0
	ldr r9, [r10]
	str r9, [fp, #-20]
	ldr r10, addr_a34_0
	ldr r9, [r10]
	str r9, [fp, #-28]
	ldr r10, addr_a35_0
	ldr r9, [r10]
	str r9, [fp, #-36]
	ldr r10, addr_a36_0
	ldr r9, [r10]
	str r9, [fp, #-44]
	ldr r10, addr_a37_0
	ldr r9, [r10]
	str r9, [fp, #-52]
	ldr r10, addr_a38_0
	ldr r9, [r10]
	str r9, [fp, #-60]
	ldr r10, addr_a39_0
	ldr r9, [r10]
	str r9, [fp, #-68]
	ldr r10, addr_a8_0
	ldr r9, [r10]
	str r9, [fp, #-76]
	ldr r10, addr_a9_0
	ldr r9, [r10]
	str r9, [fp, #-84]
	ldr r10, addr_a10_0
	ldr r9, [r10]
	ldr r10, addr_a11_0
	ldr r8, [r10]
	ldr r10, addr_a12_0
	ldr r7, [r10]
	ldr r10, addr_a13_0
	ldr r6, [r10]
	ldr r10, addr_a14_0
	ldr r5, [r10]
	ldr r10, addr_a15_0
	ldr r4, [r10]
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
	ldr r10, [fp, #-84]
	push {r10}
	ldr r10, [fp, #-76]
	push {r10}
	ldr r10, [fp, #-68]
	push {r10}
	ldr r10, [fp, #-60]
	push {r10}
	ldr r10, [fp, #-52]
	push {r10}
	ldr r10, [fp, #-44]
	push {r10}
	ldr r10, [fp, #-36]
	mov r3, r10
	ldr r10, [fp, #-28]
	mov r2, r10
	ldr r10, [fp, #-20]
	mov r1, r10
	ldr r10, [fp, #-8]
	mov r0, r10
	bl testParam16
	mov r10, r0
	add sp, sp, #48
	ldr r9, addr_a0_0
	str r10, [r9]
	ldr r10, addr_a0_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	ldr r10, addr_a0_0
	ldr r9, [r10]
	str r9, [fp, #-12]
	ldr r10, addr_a1_0
	ldr r9, [r10]
	str r9, [fp, #-24]
	ldr r10, addr_a2_0
	ldr r9, [r10]
	str r9, [fp, #-32]
	ldr r10, addr_a3_0
	ldr r9, [r10]
	str r9, [fp, #-40]
	ldr r10, addr_a4_0
	ldr r9, [r10]
	str r9, [fp, #-48]
	ldr r10, addr_a5_0
	ldr r9, [r10]
	str r9, [fp, #-56]
	ldr r10, addr_a6_0
	ldr r9, [r10]
	str r9, [fp, #-64]
	ldr r10, addr_a7_0
	ldr r9, [r10]
	str r9, [fp, #-72]
	ldr r10, addr_a8_0
	ldr r9, [r10]
	str r9, [fp, #-80]
	ldr r10, addr_a9_0
	ldr r9, [r10]
	str r9, [fp, #-88]
	ldr r10, addr_a10_0
	ldr r9, [r10]
	str r9, [fp, #-92]
	ldr r10, addr_a11_0
	ldr r9, [r10]
	str r9, [fp, #-96]
	ldr r10, addr_a12_0
	ldr r9, [r10]
	str r9, [fp, #-100]
	ldr r10, addr_a13_0
	ldr r9, [r10]
	str r9, [fp, #-104]
	ldr r10, addr_a14_0
	ldr r9, [r10]
	str r9, [fp, #-108]
	ldr r10, addr_a15_0
	ldr r9, [r10]
	str r9, [fp, #-112]
	ldr r10, addr_a16_0
	ldr r9, [r10]
	str r9, [fp, #-116]
	ldr r10, addr_a17_0
	ldr r9, [r10]
	str r9, [fp, #-120]
	ldr r10, addr_a18_0
	ldr r9, [r10]
	str r9, [fp, #-124]
	ldr r10, addr_a19_0
	ldr r9, [r10]
	str r9, [fp, #-128]
	ldr r10, addr_a20_0
	ldr r9, [r10]
	str r9, [fp, #-132]
	ldr r10, addr_a21_0
	ldr r9, [r10]
	str r9, [fp, #-136]
	ldr r10, addr_a22_0
	ldr r9, [r10]
	str r9, [fp, #-140]
	ldr r10, addr_a23_0
	ldr r9, [r10]
	str r9, [fp, #-144]
	ldr r10, addr_a24_0
	ldr r9, [r10]
	str r9, [fp, #-148]
	ldr r10, addr_a25_0
	ldr r9, [r10]
	str r9, [fp, #-152]
	ldr r10, addr_a26_0
	ldr r9, [r10]
	ldr r10, addr_a27_0
	ldr r8, [r10]
	ldr r10, addr_a28_0
	ldr r7, [r10]
	ldr r10, addr_a29_0
	ldr r6, [r10]
	ldr r10, addr_a30_0
	ldr r5, [r10]
	ldr r10, addr_a31_0
	ldr r4, [r10]
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
	ldr r10, [fp, #-152]
	push {r10}
	ldr r10, [fp, #-148]
	push {r10}
	ldr r10, [fp, #-144]
	push {r10}
	ldr r10, [fp, #-140]
	push {r10}
	ldr r10, [fp, #-136]
	push {r10}
	ldr r10, [fp, #-132]
	push {r10}
	ldr r10, [fp, #-128]
	push {r10}
	ldr r10, [fp, #-124]
	push {r10}
	ldr r10, [fp, #-120]
	push {r10}
	ldr r10, [fp, #-116]
	push {r10}
	ldr r10, [fp, #-112]
	push {r10}
	ldr r10, [fp, #-108]
	push {r10}
	ldr r10, [fp, #-104]
	push {r10}
	ldr r10, [fp, #-100]
	push {r10}
	ldr r10, [fp, #-96]
	push {r10}
	ldr r10, [fp, #-92]
	push {r10}
	ldr r10, [fp, #-88]
	push {r10}
	ldr r10, [fp, #-80]
	push {r10}
	ldr r10, [fp, #-72]
	push {r10}
	ldr r10, [fp, #-64]
	push {r10}
	ldr r10, [fp, #-56]
	push {r10}
	ldr r10, [fp, #-48]
	push {r10}
	ldr r10, [fp, #-40]
	mov r3, r10
	ldr r10, [fp, #-32]
	mov r2, r10
	ldr r10, [fp, #-24]
	mov r1, r10
	ldr r10, [fp, #-12]
	mov r0, r10
	bl testParam32
	mov r10, r0
	add sp, sp, #112
	ldr r9, addr_a0_0
	str r10, [r9]
	ldr r10, addr_a0_0
	ldr r9, [r10]
	mov r0, r9
	bl putint
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
	b .F0
.LTORG
addr_a0_0:
	.word a0
addr_a1_0:
	.word a1
addr_a2_0:
	.word a2
addr_a3_0:
	.word a3
addr_a4_0:
	.word a4
addr_a5_0:
	.word a5
addr_a6_0:
	.word a6
addr_a7_0:
	.word a7
addr_a8_0:
	.word a8
addr_a17_0:
	.word a17
addr_a9_0:
	.word a9
addr_a10_0:
	.word a10
addr_a11_0:
	.word a11
addr_a12_0:
	.word a12
addr_a13_0:
	.word a13
addr_a14_0:
	.word a14
addr_a15_0:
	.word a15
addr_a16_0:
	.word a16
addr_a18_0:
	.word a18
addr_a19_0:
	.word a19
addr_a20_0:
	.word a20
addr_a21_0:
	.word a21
addr_a22_0:
	.word a22
addr_a23_0:
	.word a23
addr_a24_0:
	.word a24
addr_a25_0:
	.word a25
addr_a26_0:
	.word a26
addr_a27_0:
	.word a27
addr_a28_0:
	.word a28
addr_a29_0:
	.word a29
addr_a30_0:
	.word a30
addr_a31_0:
	.word a31
addr_a32_0:
	.word a32
addr_a33_0:
	.word a33
addr_a34_0:
	.word a34
addr_a35_0:
	.word a35
addr_a36_0:
	.word a36
addr_a37_0:
	.word a37
addr_a38_0:
	.word a38
addr_a39_0:
	.word a39
.F0:
.Lmain_END:
	add sp, sp, #152
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

addr_a0_1:
	.word a0
addr_a1_1:
	.word a1
addr_a2_1:
	.word a2
addr_a3_1:
	.word a3
addr_a4_1:
	.word a4
addr_a5_1:
	.word a5
addr_a6_1:
	.word a6
addr_a7_1:
	.word a7
addr_a8_1:
	.word a8
addr_a17_1:
	.word a17
addr_a9_1:
	.word a9
addr_a10_1:
	.word a10
addr_a11_1:
	.word a11
addr_a12_1:
	.word a12
addr_a13_1:
	.word a13
addr_a14_1:
	.word a14
addr_a15_1:
	.word a15
addr_a16_1:
	.word a16
addr_a18_1:
	.word a18
addr_a19_1:
	.word a19
addr_a20_1:
	.word a20
addr_a21_1:
	.word a21
addr_a22_1:
	.word a22
addr_a23_1:
	.word a23
addr_a24_1:
	.word a24
addr_a25_1:
	.word a25
addr_a26_1:
	.word a26
addr_a27_1:
	.word a27
addr_a28_1:
	.word a28
addr_a29_1:
	.word a29
addr_a30_1:
	.word a30
addr_a31_1:
	.word a31
addr_a32_1:
	.word a32
addr_a33_1:
	.word a33
addr_a34_1:
	.word a34
addr_a35_1:
	.word a35
addr_a36_1:
	.word a36
addr_a37_1:
	.word a37
addr_a38_1:
	.word a38
addr_a39_1:
	.word a39
