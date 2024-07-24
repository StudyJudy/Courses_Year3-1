	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	dp,52907904,4
	.comm	list,800,4
	.comm	cns,80,4
	.text
	.global equal
	.type equal , %function
equal:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L71:
	str r0, [fp, #-8]
	str r1, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L74
	b .L79
.L74:
	ldr r10, =1
	mov r0, r10
	b .Lequal_END
.L79:
	b .L75
.L75:
	ldr r10, =0
	mov r0, r10
	b .Lequal_END
.Lequal_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

	.global dfs
	.type dfs , %function
dfs:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #68
.L81:
	str r0, [fp, #-28]
	str r1, [fp, #-24]
	str r2, [fp, #-20]
	str r3, [fp, #-16]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #36]
	ldr r5, [fp, #40]
	str r5, [fp, #-32]
	ldr r5, =18
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =18
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =7
	mul r8, r10, r9
	ldr r10, [fp, #-32]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_dp_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =-1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L88
	b .L111
.L88:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #36]
	ldr r5, [fp, #40]
	str r5, [fp, #-40]
	ldr r5, =18
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =18
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =7
	mul r8, r10, r9
	ldr r10, [fp, #-40]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_dp_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	b .Ldfs_END
.L111:
	b .L89
.L89:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	add r8, r10, r9
	ldr r10, [fp, #-20]
	add r9, r8, r10
	ldr r10, [fp, #-16]
	add r8, r9, r10
	ldr r10, [fp, #36]
	add r9, r8, r10
	ldr r10, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L133
	b .L141
.L133:
	ldr r10, =1
	mov r0, r10
	b .Ldfs_END
.L141:
	b .L134
.L134:
	ldr r10, =0
	str r10, [fp, #-4]
	ldr r10, [fp, #-28]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L144
	b .L148
.L144:
	ldr r10, [fp, #-4]
	str r10, [fp, #-44]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #40]
	mov r1, #2
	mov r0, r9
	bl equal
	mov r9, r0
	sub r8, r10, r9
	ldr r10, [fp, #-28]
	sub r9, r10, #1
	ldr r10, [fp, #-24]
	ldr r7, [fp, #-20]
	ldr r6, [fp, #-16]
	ldr r5, [fp, #36]
	ldr r4, =1
	push {r4}
	push {r5}
	mov r3, r6
	mov r2, r7
	mov r1, r10
	mov r0, r9
	bl dfs
	mov r10, r0
	add sp, sp, #8
	mul r9, r8, r10
	ldr r10, [fp, #-44]
	add r8, r10, r9
	ldr r10, =1000000007
	sdiv r9, r8, r10
	mul r9, r9, r10
	sub r10, r8, r9
	str r10, [fp, #-4]
	b .L145
.L148:
	b .L145
.L145:
	ldr r10, [fp, #-24]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L158
	b .L162
.L158:
	ldr r10, [fp, #-4]
	str r10, [fp, #-48]
	ldr r10, [fp, #-24]
	ldr r9, [fp, #40]
	mov r1, #3
	mov r0, r9
	bl equal
	mov r9, r0
	sub r8, r10, r9
	ldr r10, [fp, #-28]
	add r9, r10, #1
	ldr r10, [fp, #-24]
	sub r7, r10, #1
	ldr r10, [fp, #-20]
	ldr r6, [fp, #-16]
	ldr r5, [fp, #36]
	ldr r4, =2
	push {r4}
	push {r5}
	mov r3, r6
	mov r2, r10
	mov r1, r7
	mov r0, r9
	bl dfs
	mov r10, r0
	add sp, sp, #8
	mul r9, r8, r10
	ldr r10, [fp, #-48]
	add r8, r10, r9
	ldr r10, =1000000007
	sdiv r9, r8, r10
	mul r9, r9, r10
	sub r10, r8, r9
	str r10, [fp, #-4]
	b .L159
	b .F0
.LTORG
addr_dp_0:
	.word dp
addr_list_0:
	.word list
addr_cns_0:
	.word cns
.F0:
.L162:
	b .L159
.L159:
	ldr r10, [fp, #-20]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L172
	b .L176
.L172:
	ldr r10, [fp, #-4]
	str r10, [fp, #-52]
	ldr r10, [fp, #-20]
	ldr r9, [fp, #40]
	mov r1, #4
	mov r0, r9
	bl equal
	mov r9, r0
	sub r8, r10, r9
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	add r7, r9, #1
	ldr r9, [fp, #-20]
	sub r6, r9, #1
	ldr r9, [fp, #-16]
	ldr r5, [fp, #36]
	ldr r4, =3
	push {r4}
	push {r5}
	mov r3, r9
	mov r2, r6
	mov r1, r7
	mov r0, r10
	bl dfs
	mov r10, r0
	add sp, sp, #8
	mul r9, r8, r10
	ldr r10, [fp, #-52]
	add r8, r10, r9
	ldr r10, =1000000007
	sdiv r9, r8, r10
	mul r9, r9, r10
	sub r10, r8, r9
	str r10, [fp, #-4]
	b .L173
.L176:
	b .L173
.L173:
	ldr r10, [fp, #-16]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L186
	b .L190
.L186:
	ldr r10, [fp, #-4]
	str r10, [fp, #-56]
	ldr r10, [fp, #-16]
	ldr r9, [fp, #40]
	mov r1, #5
	mov r0, r9
	bl equal
	mov r9, r0
	sub r8, r10, r9
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r7, [fp, #-20]
	add r6, r7, #1
	ldr r7, [fp, #-16]
	sub r5, r7, #1
	ldr r7, [fp, #36]
	ldr r4, =4
	push {r4}
	push {r7}
	mov r3, r5
	mov r2, r6
	mov r1, r9
	mov r0, r10
	bl dfs
	mov r10, r0
	add sp, sp, #8
	mul r9, r8, r10
	ldr r10, [fp, #-56]
	add r8, r10, r9
	ldr r10, =1000000007
	sdiv r9, r8, r10
	mul r9, r9, r10
	sub r10, r8, r9
	str r10, [fp, #-4]
	b .L187
.L190:
	b .L187
.L187:
	ldr r10, [fp, #36]
	ldr r9, =0
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L200
	b .L204
.L200:
	ldr r10, [fp, #-4]
	str r10, [fp, #-60]
	ldr r10, [fp, #36]
	ldr r9, [fp, #-28]
	ldr r8, [fp, #-24]
	ldr r7, [fp, #-20]
	ldr r6, [fp, #-16]
	add r5, r6, #1
	ldr r6, [fp, #36]
	sub r4, r6, #1
	ldr r6, =5
	push {r6}
	push {r4}
	mov r3, r5
	mov r2, r7
	mov r1, r8
	mov r0, r9
	bl dfs
	mov r9, r0
	add sp, sp, #8
	mul r8, r10, r9
	ldr r10, [fp, #-60]
	add r9, r10, r8
	ldr r10, =1000000007
	sdiv r8, r9, r10
	mul r8, r8, r10
	sub r10, r9, r8
	str r10, [fp, #-4]
	b .L201
.L204:
	b .L201
.L201:
	ldr r10, [fp, #-4]
	ldr r9, =1000000007
	sdiv r8, r10, r9
	mul r8, r8, r9
	sub r9, r10, r8
	str r9, [fp, #-36]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #36]
	ldr r5, [fp, #40]
	str r5, [fp, #-64]
	ldr r5, =18
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =18
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =7
	mul r8, r10, r9
	ldr r10, [fp, #-64]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_dp_1
	add r9, r8, r10
	ldr r10, [fp, #-36]
	str r10, [r9]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #36]
	ldr r5, [fp, #40]
	str r5, [fp, #-68]
	ldr r5, =18
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =18
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =7
	mul r8, r10, r9
	ldr r10, [fp, #-68]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_dp_1
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	b .Ldfs_END
	b .F1
.LTORG
addr_dp_1:
	.word dp
addr_list_1:
	.word list
addr_cns_1:
	.word cns
.F1:
.Ldfs_END:
	add sp, sp, #68
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #36
.L253:
	bl getint
	mov r10, r0
	str r10, [fp, #-32]
	ldr r10, =0
	str r10, [fp, #-28]
	b .L257
.L257:
	ldr r10, [fp, #-28]
	ldr r9, =18
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L256
	b .L261
.L256:
	ldr r10, =0
	str r10, [fp, #-24]
	b .L265
.L261:
	b .L258
.L265:
	ldr r10, [fp, #-24]
	ldr r9, =18
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L264
	b .L269
.L258:
	ldr r10, =0
	str r10, [fp, #-28]
	b .L329
.L264:
	ldr r10, =0
	str r10, [fp, #-20]
	b .L273
.L269:
	b .L266
.L329:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-32]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L328
	b .L334
.L273:
	ldr r10, [fp, #-20]
	ldr r9, =18
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L272
	b .L277
.L266:
	ldr r10, [fp, #-28]
	add r9, r10, #1
	str r9, [fp, #-28]
	b .L257
.L328:
	bl getint
	mov r10, r0
	ldr r9, [fp, #-28]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_list_2
	add r8, r7, r9
	str r10, [r8]
	ldr r10, [fp, #-28]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_list_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_cns_2
	add r9, r8, r10
	ldr r10, [r9]
	add r9, r10, #1
	ldr r10, [fp, #-28]
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, addr_list_2
	add r8, r7, r10
	ldr r10, [r8]
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, addr_cns_2
	add r8, r7, r10
	str r9, [r8]
	ldr r10, [fp, #-28]
	add r9, r10, #1
	str r9, [fp, #-28]
	b .L329
.L334:
	b .L330
.L272:
	ldr r10, =0
	str r10, [fp, #-16]
	b .L281
.L277:
	b .L274
.L330:
	ldr r10, =1
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_cns_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =2
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_cns_2
	add r8, r7, r9
	ldr r9, [r8]
	ldr r8, =3
	ldr r7, =4
	mul r6, r8, r7
	ldr r8, addr_cns_2
	add r7, r6, r8
	ldr r8, [r7]
	ldr r7, =4
	ldr r6, =4
	mul r5, r7, r6
	ldr r7, addr_cns_2
	add r6, r5, r7
	ldr r7, [r6]
	ldr r6, =5
	ldr r5, =4
	mul r4, r6, r5
	ldr r6, addr_cns_2
	add r5, r4, r6
	ldr r6, [r5]
	ldr r5, =0
	push {r5}
	push {r6}
	mov r3, r7
	mov r2, r8
	mov r1, r9
	mov r0, r10
	bl dfs
	mov r10, r0
	add sp, sp, #8
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	bl putint
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lmain_END
.L281:
	ldr r10, [fp, #-16]
	ldr r9, =18
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L280
	b .L285
.L274:
	ldr r10, [fp, #-24]
	add r9, r10, #1
	str r9, [fp, #-24]
	b .L265
.L280:
	ldr r10, =0
	str r10, [fp, #-12]
	b .L289
.L285:
	b .L282
.L289:
	ldr r10, [fp, #-12]
	ldr r9, =18
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L288
	b .L293
.L282:
	ldr r10, [fp, #-20]
	add r9, r10, #1
	str r9, [fp, #-20]
	b .L273
	b .F2
.LTORG
addr_dp_2:
	.word dp
addr_list_2:
	.word list
addr_cns_2:
	.word cns
.F2:
.L288:
	ldr r10, =0
	str r10, [fp, #-8]
	b .L297
.L293:
	b .L290
.L297:
	ldr r10, [fp, #-8]
	ldr r9, =7
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L296
	b .L301
.L290:
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L281
.L296:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #-12]
	ldr r5, [fp, #-8]
	str r5, [fp, #-36]
	ldr r5, =18
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =18
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =18
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =7
	mul r8, r10, r9
	ldr r10, [fp, #-36]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_dp_3
	add r9, r8, r10
	ldr r10, =-1
	str r10, [r9]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L297
.L301:
	b .L298
.L298:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L289
.Lmain_END:
	add sp, sp, #36
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

addr_dp_3:
	.word dp
addr_list_3:
	.word list
addr_cns_3:
	.word cns
