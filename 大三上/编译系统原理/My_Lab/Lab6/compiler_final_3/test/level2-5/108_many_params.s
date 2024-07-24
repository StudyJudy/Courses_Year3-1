	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global sort
	.type sort , %function
sort:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #20
.L103:
	str r0, [fp, #-20]
	str r1, [fp, #-16]
	ldr r10, =0
	str r10, [fp, #-12]
	b .L108
.L108:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-16]
	sub r8, r9, #1
	cmp r10, r8
	movlt r10, #1
	movge r10, #0
	blt .L107
	b .L113
.L107:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L118
.L113:
	b .L109
.L118:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-16]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L117
	b .L123
.L109:
	b .Lsort_END
.L117:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-20]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, [fp, #-8]
	ldr r8, [fp, #-20]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r8
	ldr r8, [r10]
	cmp r9, r8
	movlt r10, #1
	movge r10, #0
	blt .L125
	b .L138
.L123:
	b .L119
.L125:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-20]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	str r9, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-20]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, [fp, #-12]
	ldr r8, [fp, #-20]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r8
	str r9, [r10]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, [fp, #-20]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	b .L126
.L138:
	b .L126
.L119:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L108
.L126:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L118
.Lsort_END:
	add sp, sp, #20
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global param32_rec
	.type param32_rec , %function
param32_rec:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #228
.L162:
	str r0, [fp, #-128]
	str r1, [fp, #-124]
	str r2, [fp, #-120]
	str r3, [fp, #-116]
	ldr r10, [fp, #-128]
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L195
	b .L200
.L195:
	ldr r10, [fp, #-124]
	mov r0, r10
	b .Lparam32_rec_END
.L200:
	b .L196
.L196:
	ldr r10, [fp, #-128]
	sub r9, r10, #1
	str r9, [fp, #-132]
	ldr r10, [fp, #-124]
	ldr r9, [fp, #-120]
	add r8, r10, r9
	ldr r10, =998244353
	sdiv r9, r8, r10
	mul r10, r9, r10
	sub r9, r8, r10
	str r9, [fp, #-136]
	ldr r10, [fp, #-116]
	str r10, [fp, #-140]
	ldr r10, [fp, #36]
	str r10, [fp, #-144]
	ldr r10, [fp, #40]
	str r10, [fp, #-148]
	ldr r10, [fp, #44]
	str r10, [fp, #-152]
	ldr r10, [fp, #48]
	str r10, [fp, #-156]
	ldr r10, [fp, #52]
	str r10, [fp, #-160]
	ldr r10, [fp, #56]
	str r10, [fp, #-164]
	ldr r10, [fp, #60]
	str r10, [fp, #-168]
	ldr r10, [fp, #64]
	str r10, [fp, #-172]
	ldr r10, [fp, #68]
	str r10, [fp, #-176]
	ldr r10, [fp, #72]
	str r10, [fp, #-180]
	ldr r10, [fp, #76]
	str r10, [fp, #-184]
	ldr r10, [fp, #80]
	str r10, [fp, #-188]
	ldr r10, [fp, #84]
	str r10, [fp, #-192]
	ldr r10, [fp, #88]
	str r10, [fp, #-196]
	ldr r10, [fp, #92]
	str r10, [fp, #-200]
	ldr r10, [fp, #96]
	str r10, [fp, #-204]
	ldr r10, [fp, #100]
	str r10, [fp, #-208]
	ldr r10, [fp, #104]
	str r10, [fp, #-212]
	ldr r10, [fp, #108]
	str r10, [fp, #-216]
	ldr r10, [fp, #112]
	str r10, [fp, #-220]
	ldr r10, [fp, #116]
	str r10, [fp, #-224]
	ldr r10, [fp, #120]
	str r10, [fp, #-228]
	ldr r10, [fp, #124]
	ldr r9, [fp, #128]
	ldr r8, [fp, #132]
	ldr r7, [fp, #136]
	ldr r6, [fp, #140]
	ldr r5, [fp, #144]
	ldr r4, =0
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
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
	ldr r10, [fp, #-200]
	push {r10}
	ldr r10, [fp, #-196]
	push {r10}
	ldr r10, [fp, #-192]
	push {r10}
	ldr r10, [fp, #-188]
	push {r10}
	ldr r10, [fp, #-184]
	push {r10}
	ldr r10, [fp, #-180]
	push {r10}
	ldr r10, [fp, #-176]
	push {r10}
	ldr r10, [fp, #-172]
	push {r10}
	ldr r10, [fp, #-168]
	push {r10}
	ldr r10, [fp, #-164]
	push {r10}
	ldr r10, [fp, #-160]
	push {r10}
	ldr r10, [fp, #-156]
	push {r10}
	ldr r10, [fp, #-152]
	push {r10}
	ldr r10, [fp, #-148]
	push {r10}
	ldr r10, [fp, #-144]
	mov r3, r10
	ldr r10, [fp, #-140]
	mov r2, r10
	ldr r10, [fp, #-136]
	mov r1, r10
	ldr r10, [fp, #-132]
	mov r0, r10
	bl param32_rec
	mov r10, r0
	add sp, sp, #112
	mov r0, r10
	b .Lparam32_rec_END
.Lparam32_rec_END:
	add sp, sp, #228
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global param32_arr
	.type param32_arr , %function
param32_arr:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #132
.L235:
	str r0, [fp, #-132]
	str r1, [fp, #-128]
	str r2, [fp, #-124]
	str r3, [fp, #-120]
	ldr r10, [fp, #-132]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	ldr r9, [fp, #-132]
	ldr r8, =1
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	str r8, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-128]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #-128]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-124]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #-124]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-120]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #-120]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #28]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #28]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #32]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #32]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #36]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #36]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #40]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #40]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #44]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #44]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #48]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #48]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #52]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #52]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #56]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #56]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #60]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #60]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #64]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #64]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #68]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #68]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #72]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #72]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #76]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #76]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #80]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #80]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #84]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #84]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #88]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #88]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #92]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #92]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #96]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #96]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #100]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #100]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #104]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #104]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #108]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #108]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #112]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #112]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #116]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #116]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #120]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #120]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #124]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #124]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #128]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #128]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #132]
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #132]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #136]
	b .B0
.LTORG
.B0:
	ldr r8, =0
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	add r8, r10, r9
	ldr r10, [fp, #136]
	ldr r9, =1
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r10
	ldr r10, [r9]
	add r9, r8, r10
	str r9, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lparam32_arr_END
	b .F1
.LTORG
.F1:
.Lparam32_arr_END:
	add sp, sp, #132
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global param16
	.type param16 , %function
param16:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #228
.L557:
	str r0, [fp, #-128]
	str r1, [fp, #-124]
	str r2, [fp, #-120]
	str r3, [fp, #-116]
	ldr r10, [fp, #-128]
	ldr r9, =0
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #-124]
	ldr r9, =4
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #-120]
	ldr r9, =8
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #-116]
	ldr r9, =12
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #36]
	ldr r9, =16
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #40]
	ldr r9, =20
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #44]
	ldr r9, =24
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #48]
	ldr r9, =28
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #52]
	ldr r9, =32
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #56]
	ldr r9, =36
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #60]
	ldr r9, =40
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #64]
	ldr r9, =44
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #68]
	ldr r9, =48
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #72]
	ldr r9, =52
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #76]
	ldr r9, =56
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #80]
	ldr r9, =60
	add r8, r9, #-64
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =0
	add r9, r10, #-64
	mov r1, #16
	add r10, fp, r9
	mov r0, r10
	bl sort
	ldr r10, =0
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-132]
	ldr r10, =1
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r9, fp, r10
	ldr r10, [r9]
	str r10, [fp, #-136]
	ldr r10, =2
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-140]
	ldr r10, =3
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r9, fp, r10
	ldr r10, [r9]
	str r10, [fp, #-144]
	ldr r10, =4
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-148]
	ldr r10, =5
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r9, fp, r10
	ldr r10, [r9]
	str r10, [fp, #-152]
	ldr r10, =6
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-156]
	ldr r10, =7
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-160]
	ldr r10, =8
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-164]
	ldr r10, =9
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-168]
	ldr r10, =10
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-172]
	ldr r10, =11
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-176]
	ldr r10, =12
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-180]
	ldr r10, =13
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-184]
	ldr r10, =14
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-188]
	ldr r10, =15
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-64
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-192]
	ldr r10, [fp, #-128]
	str r10, [fp, #-196]
	ldr r10, [fp, #-124]
	str r10, [fp, #-200]
	ldr r10, [fp, #-120]
	str r10, [fp, #-204]
	ldr r10, [fp, #-116]
	str r10, [fp, #-208]
	ldr r10, [fp, #36]
	str r10, [fp, #-212]
	ldr r10, [fp, #40]
	str r10, [fp, #-216]
	ldr r10, [fp, #44]
	str r10, [fp, #-220]
	ldr r10, [fp, #48]
	str r10, [fp, #-224]
	ldr r10, [fp, #52]
	str r10, [fp, #-228]
	ldr r10, [fp, #56]
	ldr r9, [fp, #60]
	ldr r8, [fp, #64]
	ldr r7, [fp, #68]
	ldr r6, [fp, #72]
	ldr r5, [fp, #76]
	ldr r4, [fp, #80]
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
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
	ldr r10, [fp, #-200]
	push {r10}
	ldr r10, [fp, #-196]
	push {r10}
	ldr r10, [fp, #-192]
	push {r10}
	ldr r10, [fp, #-188]
	push {r10}
	ldr r10, [fp, #-184]
	push {r10}
	ldr r10, [fp, #-180]
	push {r10}
	ldr r10, [fp, #-176]
	push {r10}
	ldr r10, [fp, #-172]
	push {r10}
	ldr r10, [fp, #-168]
	push {r10}
	ldr r10, [fp, #-164]
	push {r10}
	ldr r10, [fp, #-160]
	push {r10}
	ldr r10, [fp, #-156]
	push {r10}
	ldr r10, [fp, #-152]
	push {r10}
	ldr r10, [fp, #-148]
	push {r10}
	ldr r10, [fp, #-144]
	mov r3, r10
	ldr r10, [fp, #-140]
	mov r2, r10
	ldr r10, [fp, #-136]
	mov r1, r10
	ldr r10, [fp, #-132]
	mov r0, r10
	bl param32_rec
	mov r10, r0
	add sp, sp, #112
	mov r0, r10
	b .Lparam16_END
	b .F2
.LTORG
.F2:
.Lparam16_END:
	add sp, sp, #228
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=404
	sub sp, sp, r4
.L673:
	bl getint
	mov r10, r0
	str r10, [fp, #-264]
	bl getint
	mov r10, r0
	str r10, [fp, #-272]
	bl getint
	mov r10, r0
	str r10, [fp, #-280]
	bl getint
	mov r10, r0
	str r10, [fp, #-288]
	bl getint
	mov r10, r0
	str r10, [fp, #-296]
	bl getint
	mov r10, r0
	str r10, [fp, #-304]
	bl getint
	mov r10, r0
	str r10, [fp, #-312]
	bl getint
	mov r10, r0
	str r10, [fp, #-320]
	bl getint
	mov r10, r0
	str r10, [fp, #-328]
	bl getint
	mov r10, r0
	bl getint
	mov r9, r0
	bl getint
	mov r8, r0
	bl getint
	mov r7, r0
	bl getint
	mov r6, r0
	bl getint
	mov r5, r0
	bl getint
	mov r4, r0
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	push {r8}
	push {r9}
	push {r10}
	ldr r10, [fp, #-328]
	push {r10}
	ldr r10, [fp, #-320]
	push {r10}
	ldr r10, [fp, #-312]
	push {r10}
	ldr r10, [fp, #-304]
	push {r10}
	ldr r10, [fp, #-296]
	push {r10}
	ldr r10, [fp, #-288]
	mov r3, r10
	ldr r10, [fp, #-280]
	mov r2, r10
	ldr r10, [fp, #-272]
	mov r1, r10
	ldr r10, [fp, #-264]
	mov r0, r10
	bl param16
	mov r10, r0
	add sp, sp, #48
	ldr r9, =0
	ldr r8, =-260
	add r7, r9, r8
	add r9, fp, r7
	str r10, [r9]
	ldr r10, =4
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =8848
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =8
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =12
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =16
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =20
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =24
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =28
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =32
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =36
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =40
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =44
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =48
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =52
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =56
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =60
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =64
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =68
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =72
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =76
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =80
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =84
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =88
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =92
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =96
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =100
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =104
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =108
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =112
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =116
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =120
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =124
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =128
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =132
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =136
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =140
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =144
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =148
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =152
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =156
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =160
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =164
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =168
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =172
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =176
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =180
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =184
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =188
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =192
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =196
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =200
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =204
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =208
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =212
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =216
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =220
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =224
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =228
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =232
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =236
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =240
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =244
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =248
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =252
	ldr r9, =-260
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1
	str r10, [fp, #-4]
	b .L741
	b .F3
.LTORG
.F3:
.L741:
	ldr r10, [fp, #-4]
	ldr r9, =32
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L740
	b .L745
.L740:
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	ldr r10, =2
	mul r8, r9, r10
	add r10, r8, #1
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, =-260
	add r9, r8, r10
	add r9, fp, r9
	ldr r10, [r9]
	sub r9, r10, #1
	ldr r10, [fp, #-4]
	ldr r8, =2
	mul r7, r10, r8
	add r10, r7, #0
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-260
	add r8, r7, r10
	add r10, fp, r8
	str r9, [r10]
	ldr r10, [fp, #-4]
	sub r9, r10, #1
	ldr r10, =2
	mul r8, r9, r10
	add r10, r8, #0
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, =-260
	add r9, r8, r10
	add r9, fp, r9
	ldr r10, [r9]
	sub r9, r10, #2
	ldr r10, [fp, #-4]
	ldr r8, =2
	mul r7, r10, r8
	add r10, r7, #1
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-260
	add r8, r7, r10
	add r10, fp, r8
	str r9, [r10]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L741
.L745:
	b .L742
.L742:
	ldr r10, =0
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-268]
	ldr r10, =1
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-276]
	ldr r10, =2
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-284]
	ldr r10, =3
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-292]
	ldr r10, =4
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-300]
	ldr r10, =5
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-308]
	ldr r10, =6
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-316]
	ldr r10, =7
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-324]
	ldr r10, =8
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-332]
	ldr r10, =9
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-336]
	ldr r10, =10
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-340]
	ldr r10, =11
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-344]
	ldr r10, =12
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-348]
	ldr r10, =13
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-352]
	ldr r10, =14
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-356]
	ldr r10, =15
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-360]
	ldr r10, =16
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-364]
	ldr r10, =17
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-368]
	ldr r10, =18
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-372]
	ldr r10, =19
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-376]
	ldr r10, =20
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-380]
	ldr r10, =21
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-384]
	ldr r10, =22
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-388]
	ldr r10, =23
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-392]
	ldr r10, =24
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-396]
	ldr r10, =25
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-400]
	ldr r10, =26
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	str r8, [fp, #-404]
	ldr r10, =27
	ldr r9, =2
	mul r8, r10, r9
	ldr r10, =4
	mul r9, r8, r10
	ldr r10, =-260
	add r8, r9, r10
	ldr r10, =28
	ldr r9, =2
	mul r7, r10, r9
	ldr r10, =4
	mul r9, r7, r10
	ldr r10, =-260
	add r7, r9, r10
	ldr r10, =29
	ldr r9, =2
	mul r6, r10, r9
	ldr r10, =4
	mul r9, r6, r10
	ldr r10, =-260
	add r6, r9, r10
	ldr r10, =30
	ldr r9, =2
	mul r5, r10, r9
	ldr r10, =4
	mul r9, r5, r10
	ldr r10, =-260
	add r5, r9, r10
	ldr r10, =31
	ldr r9, =2
	mul r4, r10, r9
	ldr r10, =4
	mul r9, r4, r10
	ldr r10, =-260
	add r4, r9, r10
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
	ldr r10, [fp, #-404]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-400]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-396]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-392]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-388]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-384]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-380]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-376]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-372]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-368]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-364]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-360]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-356]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-352]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-348]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-344]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-340]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-336]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-332]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-324]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-316]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-308]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-300]
	add r10, fp, r10
	push {r10}
	ldr r10, [fp, #-292]
	add r10, fp, r10
	mov r3, r10
	ldr r10, [fp, #-284]
	add r10, fp, r10
	mov r2, r10
	ldr r10, [fp, #-276]
	add r10, fp, r10
	mov r1, r10
	ldr r10, [fp, #-268]
	add r10, fp, r10
	mov r0, r10
	bl param32_arr
	mov r10, r0
	add sp, sp, #112
	mov r0, r10
	bl putint
	mov r0, #10
	bl putch
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
	b .F4
.LTORG
.F4:
.Lmain_END:
	ldr r4,=404
	add sp, sp, r4
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

