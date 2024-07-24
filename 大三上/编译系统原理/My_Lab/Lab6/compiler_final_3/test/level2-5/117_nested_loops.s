	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	arr1,57600,4
	.comm	arr2,107520,4
	.text
	.global loop1
	.type loop1 , %function
loop1:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #48
.L77:
	str r0, [fp, #-36]
	str r1, [fp, #-32]
	ldr r10, =0
	str r10, [fp, #-28]
	b .L88
.L88:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-36]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L90
	b .L94
.L90:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-32]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L87
	b .L99
.L94:
	b .L89
.L87:
	ldr r10, =0
	str r10, [fp, #-24]
	b .L102
.L99:
	b .L89
.L89:
	b .Lloop1_END
.L102:
	ldr r10, [fp, #-24]
	ldr r9, =2
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L101
	b .L106
.L101:
	ldr r10, =0
	str r10, [fp, #-20]
	b .L109
.L106:
	b .L103
.L109:
	ldr r10, [fp, #-20]
	ldr r9, =3
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L108
	b .L113
.L103:
	ldr r10, [fp, #-28]
	add r9, r10, #1
	str r9, [fp, #-28]
	b .L88
.L108:
	ldr r10, =0
	str r10, [fp, #-16]
	b .L116
.L113:
	b .L110
.L116:
	ldr r10, [fp, #-16]
	ldr r9, =4
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L115
	b .L120
.L110:
	ldr r10, [fp, #-24]
	add r9, r10, #1
	str r9, [fp, #-24]
	b .L102
.L115:
	ldr r10, =0
	str r10, [fp, #-12]
	b .L123
.L120:
	b .L117
.L123:
	ldr r10, [fp, #-12]
	ldr r9, =5
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L122
	b .L127
.L117:
	ldr r10, [fp, #-20]
	add r9, r10, #1
	str r9, [fp, #-20]
	b .L109
.L122:
	ldr r10, =0
	str r10, [fp, #-8]
	b .L130
.L127:
	b .L124
.L130:
	ldr r10, [fp, #-8]
	ldr r9, =6
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L129
	b .L134
.L124:
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L116
.L129:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L137
.L134:
	b .L131
.L137:
	ldr r10, [fp, #-4]
	ldr r9, =2
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L136
	b .L141
.L131:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L123
.L136:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	add r8, r10, r9
	ldr r10, [fp, #-20]
	add r9, r8, r10
	ldr r10, [fp, #-16]
	add r8, r9, r10
	ldr r10, [fp, #-12]
	add r9, r8, r10
	ldr r10, [fp, #-8]
	add r8, r9, r10
	ldr r10, [fp, #-4]
	add r9, r8, r10
	ldr r10, [fp, #-36]
	add r8, r9, r10
	ldr r10, [fp, #-32]
	add r9, r8, r10
	str r9, [fp, #-40]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #-12]
	ldr r5, [fp, #-8]
	str r5, [fp, #-48]
	ldr r5, [fp, #-4]
	str r5, [fp, #-44]
	ldr r5, =2
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =3
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =5
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =6
	mul r8, r10, r9
	ldr r10, [fp, #-48]
	add r9, r8, r10
	ldr r10, =2
	mul r8, r9, r10
	ldr r10, [fp, #-44]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_arr1_0
	add r9, r8, r10
	ldr r10, [fp, #-40]
	str r10, [r9]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L137
	b .F0
.LTORG
addr_arr1_0:
	.word arr1
addr_arr2_0:
	.word arr2
.F0:
.L141:
	b .L138
.L138:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L130
.Lloop1_END:
	add sp, sp, #48
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global loop2
	.type loop2 , %function
loop2:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #40
.L181:
	ldr r10, =0
	str r10, [fp, #-28]
	b .L190
.L190:
	ldr r10, [fp, #-28]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L189
	b .L194
.L189:
	ldr r10, =0
	str r10, [fp, #-24]
	b .L197
.L194:
	b .L191
.L197:
	ldr r10, [fp, #-24]
	ldr r9, =2
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L196
	b .L201
.L191:
	b .Lloop2_END
.L196:
	ldr r10, =0
	str r10, [fp, #-20]
	b .L204
.L201:
	b .L198
.L204:
	ldr r10, [fp, #-20]
	ldr r9, =3
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L203
	b .L208
.L198:
	ldr r10, [fp, #-28]
	add r9, r10, #1
	str r9, [fp, #-28]
	b .L190
.L203:
	ldr r10, =0
	str r10, [fp, #-16]
	b .L211
.L208:
	b .L205
.L211:
	ldr r10, [fp, #-16]
	ldr r9, =2
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L210
	b .L215
.L205:
	ldr r10, [fp, #-24]
	add r9, r10, #1
	str r9, [fp, #-24]
	b .L197
.L210:
	ldr r10, =0
	str r10, [fp, #-12]
	b .L218
.L215:
	b .L212
.L218:
	ldr r10, [fp, #-12]
	ldr r9, =4
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L217
	b .L222
.L212:
	ldr r10, [fp, #-20]
	add r9, r10, #1
	str r9, [fp, #-20]
	b .L204
.L217:
	ldr r10, =0
	str r10, [fp, #-8]
	b .L225
.L222:
	b .L219
.L225:
	ldr r10, [fp, #-8]
	ldr r9, =8
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L224
	b .L229
.L219:
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L211
.L224:
	ldr r10, =0
	str r10, [fp, #-4]
	b .L232
.L229:
	b .L226
.L232:
	ldr r10, [fp, #-4]
	ldr r9, =7
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L231
	b .L236
.L226:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	b .L218
.L231:
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	add r8, r10, r9
	ldr r10, [fp, #-16]
	add r9, r8, r10
	ldr r10, [fp, #-4]
	add r8, r9, r10
	str r8, [fp, #-32]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-24]
	ldr r8, [fp, #-20]
	ldr r7, [fp, #-16]
	ldr r6, [fp, #-12]
	ldr r5, [fp, #-8]
	str r5, [fp, #-40]
	ldr r5, [fp, #-4]
	str r5, [fp, #-36]
	ldr r5, =2
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =3
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =2
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =8
	mul r8, r10, r9
	ldr r10, [fp, #-40]
	add r9, r8, r10
	ldr r10, =7
	mul r8, r9, r10
	ldr r10, [fp, #-36]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_arr2_1
	add r9, r8, r10
	ldr r10, [fp, #-32]
	str r10, [r9]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L232
.L236:
	b .L233
.L233:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L225
.Lloop2_END:
	add sp, sp, #40
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global loop3
	.type loop3 , %function
loop3:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #84
.L271:
	str r0, [fp, #-60]
	str r1, [fp, #-56]
	str r2, [fp, #-52]
	str r3, [fp, #-48]
	ldr r10, =0
	str r10, [fp, #-4]
	ldr r10, =0
	str r10, [fp, #-32]
	b .L288
.L288:
	ldr r10, [fp, #-32]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L287
	b .L292
.L287:
	ldr r10, =0
	str r10, [fp, #-28]
	b .L295
.L292:
	b .L289
.L295:
	ldr r10, [fp, #-28]
	ldr r9, =100
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L294
	b .L299
.L289:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lloop3_END
.L294:
	ldr r10, =0
	str r10, [fp, #-24]
	b .L302
.L299:
	b .L296
.L302:
	ldr r10, [fp, #-24]
	ldr r9, =1000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L301
	b .L306
.L296:
	ldr r10, [fp, #-32]
	add r9, r10, #1
	str r9, [fp, #-32]
	ldr r10, [fp, #-32]
	ldr r9, [fp, #-60]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L438
	b .L443
.L301:
	ldr r10, =0
	str r10, [fp, #-20]
	b .L309
.L306:
	b .L303
.L438:
	b .L289
.L443:
	b .L439
.L309:
	ldr r10, [fp, #-20]
	ldr r9, =10000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L308
	b .L313
.L303:
	ldr r10, [fp, #-28]
	add r9, r10, #1
	str r9, [fp, #-28]
	ldr r10, [fp, #-28]
	ldr r9, [fp, #-56]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L429
	b .L434
.L439:
	b .L288
.L308:
	ldr r10, =0
	str r10, [fp, #-16]
	b .L316
.L313:
	b .L310
.L429:
	b .L296
.L434:
	b .L430
.L316:
	ldr r10, [fp, #-16]
	ldr r9, =100000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L315
	b .L320
.L310:
	ldr r10, [fp, #-24]
	add r9, r10, #1
	str r9, [fp, #-24]
	ldr r10, [fp, #-24]
	ldr r9, [fp, #-52]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L420
	b .L425
.L430:
	b .L295
.L315:
	ldr r10, =0
	str r10, [fp, #-12]
	b .L323
.L320:
	b .L317
.L420:
	b .L303
.L425:
	b .L421
.L323:
	ldr r10, [fp, #-12]
	ldr r9, =1000000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L322
	b .L327
.L317:
	ldr r10, [fp, #-20]
	add r9, r10, #1
	str r9, [fp, #-20]
	ldr r10, [fp, #-20]
	ldr r9, [fp, #-48]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L411
	b .L416
.L421:
	b .L302
.L322:
	ldr r10, =0
	str r10, [fp, #-8]
	b .L330
.L327:
	b .L324
.L411:
	b .L310
.L416:
	b .L412
.L330:
	ldr r10, [fp, #-8]
	ldr r9, =10000000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L329
	b .L334
.L324:
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	ldr r10, [fp, #-16]
	ldr r9, [fp, #36]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L402
	b .L407
.L412:
	b .L309
.L329:
	ldr r10, [fp, #-4]
	ldr r9, =817
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	str r8, [fp, #-64]
	ldr r10, [fp, #-32]
	ldr r9, [fp, #-28]
	ldr r8, [fp, #-24]
	ldr r7, [fp, #-20]
	ldr r6, [fp, #-16]
	ldr r5, [fp, #-12]
	str r5, [fp, #-76]
	ldr r5, [fp, #-8]
	str r5, [fp, #-68]
	ldr r5, =2
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =3
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =5
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =6
	mul r8, r10, r9
	ldr r10, [fp, #-76]
	add r9, r8, r10
	ldr r10, =2
	mul r8, r9, r10
	ldr r10, [fp, #-68]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_arr1_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, [fp, #-64]
	add r8, r9, r10
	str r8, [fp, #-72]
	ldr r10, [fp, #-32]
	ldr r9, [fp, #-28]
	ldr r8, [fp, #-24]
	ldr r7, [fp, #-20]
	ldr r6, [fp, #-16]
	ldr r5, [fp, #-12]
	str r5, [fp, #-84]
	ldr r5, [fp, #-8]
	str r5, [fp, #-80]
	ldr r5, =2
	mul r4, r10, r5
	add r10, r4, r9
	ldr r9, =3
	mul r5, r10, r9
	add r10, r5, r8
	ldr r9, =2
	mul r8, r10, r9
	add r10, r8, r7
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, r6
	ldr r9, =8
	mul r8, r10, r9
	ldr r10, [fp, #-84]
	add r9, r8, r10
	ldr r10, =7
	mul r8, r9, r10
	ldr r10, [fp, #-80]
	add r9, r8, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_arr2_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, [fp, #-72]
	add r8, r9, r10
	str r8, [fp, #-4]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #44]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L384
	b .L389
	b .F1
.LTORG
addr_arr1_1:
	.word arr1
addr_arr2_1:
	.word arr2
.F1:
.L334:
	b .L331
.L402:
	b .L317
.L407:
	b .L403
.L384:
	b .L331
.L389:
	b .L385
.L331:
	ldr r10, [fp, #-12]
	add r9, r10, #1
	str r9, [fp, #-12]
	ldr r10, [fp, #-12]
	ldr r9, [fp, #40]
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L393
	b .L398
.L403:
	b .L316
.L385:
	b .L330
.L393:
	b .L324
.L398:
	b .L394
.L394:
	b .L323
.Lloop3_END:
	add sp, sp, #84
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #36
.L447:
	bl getint
	mov r10, r0
	str r10, [fp, #-36]
	bl getint
	mov r10, r0
	str r10, [fp, #-32]
	bl getint
	mov r10, r0
	str r10, [fp, #-28]
	bl getint
	mov r10, r0
	str r10, [fp, #-24]
	bl getint
	mov r10, r0
	str r10, [fp, #-20]
	bl getint
	mov r10, r0
	str r10, [fp, #-16]
	bl getint
	mov r10, r0
	str r10, [fp, #-12]
	bl getint
	mov r10, r0
	str r10, [fp, #-8]
	bl getint
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-36]
	ldr r9, [fp, #-32]
	mov r1, r9
	mov r0, r10
	bl loop1
	bl loop2
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
	mov r3, r7
	mov r2, r8
	mov r1, r9
	mov r0, r10
	bl loop3
	mov r10, r0
	add sp, sp, #12
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #36
	pop {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx lr

addr_arr1_2:
	.word arr1
addr_arr2_2:
	.word arr2
