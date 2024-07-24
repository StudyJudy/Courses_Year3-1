	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global testParam8
	.type testParam8 , %function
testParam8:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #32
.L57:
	str r0, [fp, #-32]
	str r1, [fp, #-28]
	str r2, [fp, #-24]
	str r3, [fp, #-20]
	ldr r10, [fp, #-32]
	ldr r9, [fp, #-28]
	sub r8, r10, r9
	ldr r10, [fp, #-24]
	add r9, r8, r10
	ldr r10, [fp, #-20]
	sub r8, r9, r10
	ldr r10, [fp, #20]
	sub r9, r8, r10
	ldr r10, [fp, #24]
	sub r8, r9, r10
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
.L74:
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
	add r8, r9, r10
	ldr r10, [fp, #20]
	sub r9, r8, r10
	ldr r10, [fp, #24]
	add r8, r9, r10
	ldr r10, [fp, #28]
	add r9, r8, r10
	ldr r10, [fp, #32]
	add r8, r9, r10
	ldr r10, [fp, #36]
	sub r9, r8, r10
	ldr r10, [fp, #40]
	add r8, r9, r10
	ldr r10, [fp, #44]
	sub r9, r8, r10
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
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #128
.L107:
	str r0, [fp, #-128]
	str r1, [fp, #-124]
	str r2, [fp, #-120]
	str r3, [fp, #-116]
	ldr r10, [fp, #-128]
	ldr r9, [fp, #-124]
	ldr r8, [fp, #-120]
	mul r7, r9, r8
	add r9, r10, r7
	ldr r10, [fp, #-116]
	add r8, r9, r10
	ldr r10, [fp, #24]
	add r9, r8, r10
	ldr r10, [fp, #28]
	add r8, r9, r10
	ldr r10, [fp, #32]
	add r9, r8, r10
	ldr r10, [fp, #36]
	add r8, r9, r10
	ldr r10, [fp, #40]
	add r9, r8, r10
	ldr r10, [fp, #44]
	add r8, r9, r10
	ldr r10, [fp, #48]
	add r9, r8, r10
	ldr r10, [fp, #52]
	add r8, r9, r10
	ldr r10, [fp, #56]
	sub r9, r8, r10
	ldr r10, [fp, #60]
	sub r8, r9, r10
	ldr r10, [fp, #64]
	sub r9, r8, r10
	ldr r10, [fp, #68]
	sub r8, r9, r10
	ldr r10, [fp, #72]
	sub r9, r8, r10
	ldr r10, [fp, #76]
	sub r8, r9, r10
	ldr r10, [fp, #80]
	sub r9, r8, r10
	ldr r10, [fp, #84]
	sub r8, r9, r10
	ldr r10, [fp, #88]
	sub r9, r8, r10
	ldr r10, [fp, #92]
	sub r8, r9, r10
	ldr r10, [fp, #96]
	add r9, r8, r10
	ldr r10, [fp, #100]
	add r8, r9, r10
	ldr r10, [fp, #104]
	add r9, r8, r10
	ldr r10, [fp, #108]
	add r8, r9, r10
	ldr r10, [fp, #112]
	add r9, r8, r10
	ldr r10, [fp, #116]
	add r8, r9, r10
	ldr r10, [fp, #120]
	add r9, r8, r10
	ldr r10, [fp, #124]
	add r8, r9, r10
	ldr r10, [fp, #128]
	add r9, r8, r10
	ldr r10, [fp, #132]
	add r8, r9, r10
	mov r0, r8
	b .LtestParam32_END
.LtestParam32_END:
	add sp, sp, #128
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=268
	sub sp, sp, r4
.L172:
	ldr r10, =0
	str r10, [fp, #-128]
	ldr r10, =1
	str r10, [fp, #-124]
	ldr r10, =2
	str r10, [fp, #-120]
	ldr r10, =3
	str r10, [fp, #-116]
	ldr r10, =4
	str r10, [fp, #-112]
	ldr r10, =5
	str r10, [fp, #-108]
	ldr r10, =6
	str r10, [fp, #-104]
	ldr r10, =7
	str r10, [fp, #-100]
	ldr r10, =8
	str r10, [fp, #-96]
	ldr r10, =9
	str r10, [fp, #-92]
	ldr r10, =0
	str r10, [fp, #-88]
	ldr r10, =1
	str r10, [fp, #-84]
	ldr r10, =2
	str r10, [fp, #-80]
	ldr r10, =3
	str r10, [fp, #-76]
	ldr r10, =4
	str r10, [fp, #-72]
	ldr r10, =5
	str r10, [fp, #-68]
	ldr r10, =6
	str r10, [fp, #-64]
	ldr r10, =7
	str r10, [fp, #-60]
	ldr r10, =8
	str r10, [fp, #-56]
	ldr r10, =9
	str r10, [fp, #-52]
	ldr r10, =0
	str r10, [fp, #-48]
	ldr r10, =1
	str r10, [fp, #-44]
	ldr r10, =2
	str r10, [fp, #-40]
	ldr r10, =3
	str r10, [fp, #-36]
	ldr r10, =4
	str r10, [fp, #-32]
	ldr r10, =5
	str r10, [fp, #-28]
	ldr r10, =6
	str r10, [fp, #-24]
	ldr r10, =7
	str r10, [fp, #-20]
	ldr r10, =8
	str r10, [fp, #-16]
	ldr r10, =9
	str r10, [fp, #-12]
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, =1
	str r10, [fp, #-4]
	ldr r10, [fp, #-128]
	str r10, [fp, #-132]
	ldr r10, [fp, #-124]
	ldr r9, [fp, #-120]
	ldr r8, [fp, #-116]
	ldr r7, [fp, #-112]
	ldr r6, [fp, #-108]
	ldr r5, [fp, #-104]
	ldr r4, [fp, #-100]
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r3, r8
	mov r2, r9
	mov r1, r10
	ldr r10, [fp, #-132]
	mov r0, r10
	bl testParam8
	mov r10, r0
	str r10, [fp, #-136]
	add sp, sp, #16
	ldr r10, [fp, #-124]
	str r10, [fp, #-144]
	ldr r10, [fp, #-120]
	str r10, [fp, #-152]
	ldr r10, [fp, #-116]
	str r10, [fp, #-160]
	ldr r10, [fp, #-112]
	str r10, [fp, #-168]
	ldr r10, [fp, #-108]
	str r10, [fp, #-176]
	ldr r10, [fp, #-104]
	str r10, [fp, #-184]
	ldr r10, [fp, #-100]
	str r10, [fp, #-192]
	ldr r10, [fp, #-96]
	str r10, [fp, #-200]
	ldr r10, [fp, #-92]
	ldr r9, [fp, #-88]
	ldr r8, [fp, #-84]
	ldr r7, [fp, #-80]
	ldr r6, [fp, #-76]
	ldr r5, [fp, #-72]
	ldr r4, [fp, #-68]
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
	push {r10}
	ldr r10, [fp, #-200]
	push {r10}
	ldr r10, [fp, #-192]
	push {r10}
	ldr r10, [fp, #-184]
	push {r10}
	ldr r10, [fp, #-176]
	push {r10}
	ldr r10, [fp, #-168]
	push {r10}
	ldr r10, [fp, #-160]
	mov r3, r10
	ldr r10, [fp, #-152]
	mov r2, r10
	ldr r10, [fp, #-144]
	mov r1, r10
	ldr r10, [fp, #-136]
	mov r0, r10
	bl testParam16
	mov r10, r0
	str r10, [fp, #-140]
	add sp, sp, #48
	ldr r10, [fp, #-124]
	str r10, [fp, #-148]
	ldr r10, [fp, #-120]
	str r10, [fp, #-156]
	ldr r10, [fp, #-116]
	str r10, [fp, #-164]
	ldr r10, [fp, #-112]
	str r10, [fp, #-172]
	ldr r10, [fp, #-108]
	str r10, [fp, #-180]
	ldr r10, [fp, #-104]
	str r10, [fp, #-188]
	ldr r10, [fp, #-100]
	str r10, [fp, #-196]
	ldr r10, [fp, #-96]
	str r10, [fp, #-204]
	ldr r10, [fp, #-92]
	str r10, [fp, #-208]
	ldr r10, [fp, #-88]
	str r10, [fp, #-212]
	ldr r10, [fp, #-84]
	str r10, [fp, #-216]
	ldr r10, [fp, #-80]
	str r10, [fp, #-220]
	ldr r10, [fp, #-76]
	str r10, [fp, #-224]
	ldr r10, [fp, #-72]
	str r10, [fp, #-228]
	ldr r10, [fp, #-68]
	str r10, [fp, #-232]
	ldr r10, [fp, #-64]
	str r10, [fp, #-236]
	ldr r10, [fp, #-60]
	str r10, [fp, #-240]
	ldr r10, [fp, #-56]
	str r10, [fp, #-244]
	ldr r10, [fp, #-52]
	str r10, [fp, #-248]
	ldr r10, [fp, #-48]
	str r10, [fp, #-252]
	ldr r10, [fp, #-44]
	str r10, [fp, #-256]
	ldr r10, [fp, #-40]
	str r10, [fp, #-260]
	ldr r10, [fp, #-36]
	str r10, [fp, #-264]
	ldr r10, [fp, #-32]
	str r10, [fp, #-268]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #-12]
	ldr r5, [fp, #-8]
	ldr r4, [fp, #-4]
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
	push {r10}
	ldr r10, [fp, #-268]
	push {r10}
	ldr r10, [fp, #-264]
	push {r10}
	ldr r10, [fp, #-260]
	push {r10}
	ldr r10, [fp, #-256]
	push {r10}
	ldr r10, [fp, #-252]
	push {r10}
	ldr r10, [fp, #-248]
	push {r10}
	ldr r10, [fp, #-244]
	push {r10}
	ldr r10, [fp, #-240]
	push {r10}
	ldr r10, [fp, #-236]
	push {r10}
	ldr r10, [fp, #-232]
	push {r10}
	ldr r10, [fp, #-228]
	push {r10}
	ldr r10, [fp, #-224]
	push {r10}
	ldr r10, [fp, #-220]
	push {r10}
	ldr r10, [fp, #-216]
	push {r10}
	ldr r10, [fp, #-212]
	push {r10}
	ldr r10, [fp, #-208]
	push {r10}
	ldr r10, [fp, #-204]
	push {r10}
	ldr r10, [fp, #-196]
	push {r10}
	ldr r10, [fp, #-188]
	push {r10}
	ldr r10, [fp, #-180]
	push {r10}
	ldr r10, [fp, #-172]
	push {r10}
	ldr r10, [fp, #-164]
	mov r3, r10
	ldr r10, [fp, #-156]
	mov r2, r10
	ldr r10, [fp, #-148]
	mov r1, r10
	ldr r10, [fp, #-140]
	mov r0, r10
	bl testParam32
	mov r10, r0
	add sp, sp, #112
	str r10, [fp, #-128]
	ldr r10, [fp, #-128]
	mov r0, r10
	bl putint
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
	b .F0
.LTORG
.F0:
.Lmain_END:
	ldr r4,=268
	add sp, sp, r4
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

