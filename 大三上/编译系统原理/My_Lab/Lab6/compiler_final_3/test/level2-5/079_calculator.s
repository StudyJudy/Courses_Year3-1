	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	ints,40000,4
	.global intt
	.align 4
	.size intt, 4
intt:
	.word 0
	.comm	chas,40000,4
	.global chat
	.align 4
	.size chat, 4
chat:
	.word 0
	.global i
	.align 4
	.size i, 4
i:
	.word 0
	.global ii
	.align 4
	.size ii, 4
ii:
	.word 1
	.global c
	.align 4
	.size c, 4
c:
	.word 0
	.comm	get,40000,4
	.comm	get2,40000,4
	.text
	.global isdigit
	.type isdigit , %function
isdigit:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L148:
	str r0, [fp, #-4]
	ldr r10, [fp, #-4]
	ldr r9, =48
	cmp r10, r9
	movge r10, #1
	movlt r10, #0
	bge .L152
	b .L155
.L152:
	ldr r10, [fp, #-4]
	ldr r9, =57
	cmp r10, r9
	movle r10, #1
	movgt r10, #0
	ble .L150
	b .L159
.L155:
	b .L151
.L150:
	ldr r10, =1
	mov r0, r10
	b .Lisdigit_END
.L159:
	b .L151
.L151:
	ldr r10, =0
	mov r0, r10
	b .Lisdigit_END
.Lisdigit_END:
	add sp, sp, #4
	pop {r9, r10, fp, lr}
	bx lr

	.global power
	.type power , %function
power:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #12
.L161:
	str r0, [fp, #-12]
	str r1, [fp, #-8]
	ldr r10, =1
	str r10, [fp, #-4]
	b .L166
.L166:
	ldr r10, [fp, #-8]
	ldr r9, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L165
	b .L170
.L165:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-12]
	mul r8, r10, r9
	str r8, [fp, #-4]
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	str r9, [fp, #-8]
	b .L166
.L170:
	b .L167
.L167:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lpower_END
.Lpower_END:
	add sp, sp, #12
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global getstr
	.type getstr , %function
getstr:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #12
.L176:
	str r0, [fp, #-12]
	bl getch
	mov r10, r0
	str r10, [fp, #-8]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L181
.L181:
	ldr r10, [fp, #-8]
	ldr r9, =13
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L183
	b .L186
.L183:
	ldr r10, [fp, #-8]
	ldr r9, =10
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L180
	b .L190
.L186:
	b .L182
.L180:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	ldr r8, [fp, #-12]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	bl getch
	mov r10, r0
	str r10, [fp, #-8]
	b .L181
.L190:
	b .L182
.L182:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lgetstr_END
.Lgetstr_END:
	add sp, sp, #12
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global intpush
	.type intpush , %function
intpush:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L199:
	str r0, [fp, #-4]
	ldr r10, addr_intt_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_intt_0
	str r10, [r9]
	ldr r10, [fp, #-4]
	ldr r9, addr_intt_0
	ldr r8, [r9]
	ldr r9, =4
	mul r7, r8, r9
	ldr r9, addr_ints_0
	add r8, r7, r9
	str r10, [r8]
	b .Lintpush_END
.Lintpush_END:
	add sp, sp, #4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global chapush
	.type chapush , %function
chapush:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L207:
	str r0, [fp, #-4]
	ldr r10, addr_chat_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_chat_0
	str r10, [r9]
	ldr r10, [fp, #-4]
	ldr r9, addr_chat_0
	ldr r8, [r9]
	ldr r9, =4
	mul r7, r8, r9
	ldr r9, addr_chas_0
	add r8, r7, r9
	str r10, [r8]
	b .Lchapush_END
.Lchapush_END:
	add sp, sp, #4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global intpop
	.type intpop , %function
intpop:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
.L215:
	ldr r10, addr_intt_0
	ldr r9, [r10]
	sub r10, r9, #1
	ldr r9, addr_intt_0
	str r10, [r9]
	ldr r10, addr_intt_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_ints_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	b .Lintpop_END
.Lintpop_END:
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global chapop
	.type chapop , %function
chapop:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
.L222:
	ldr r10, addr_chat_0
	ldr r9, [r10]
	sub r10, r9, #1
	ldr r9, addr_chat_0
	str r10, [r9]
	ldr r10, addr_chat_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_chas_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	b .Lchapop_END
.Lchapop_END:
	pop {r8, r9, r10, fp, lr}
	bx lr

	.global intadd
	.type intadd , %function
intadd:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L229:
	str r0, [fp, #-4]
	ldr r10, addr_intt_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_ints_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =10
	mul r8, r10, r9
	ldr r10, addr_intt_0
	ldr r9, [r10]
	ldr r10, =4
	mul r7, r9, r10
	ldr r10, addr_ints_0
	add r9, r7, r10
	str r8, [r9]
	ldr r10, addr_intt_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_ints_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, [fp, #-4]
	add r8, r10, r9
	ldr r10, addr_intt_0
	ldr r9, [r10]
	ldr r10, =4
	mul r7, r9, r10
	ldr r10, addr_ints_0
	add r9, r7, r10
	str r8, [r9]
	b .Lintadd_END
.Lintadd_END:
	add sp, sp, #4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global find
	.type find , %function
find:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
.L250:
	bl chapop
	mov r10, r0
	ldr r9, addr_c_0
	str r10, [r9]
	ldr r10, addr_ii_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_0
	add r9, r8, r10
	ldr r10, =32
	str r10, [r9]
	ldr r10, addr_c_0
	ldr r9, [r10]
	ldr r10, addr_ii_0
	ldr r8, [r10]
	add r10, r8, #1
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, addr_get2_0
	add r8, r7, r10
	str r9, [r8]
	ldr r10, addr_ii_0
	ldr r9, [r10]
	add r10, r9, #2
	ldr r9, addr_ii_0
	str r10, [r9]
	ldr r10, addr_chat_0
	ldr r9, [r10]
	ldr r10, =0
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L261
	b .L265
.L261:
	ldr r10, =0
	mov r0, r10
	b .Lfind_END
.L265:
	b .L262
.L262:
	ldr r10, =1
	mov r0, r10
	b .Lfind_END
.Lfind_END:
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #20
.L267:
	ldr r10, =0
	ldr r9, addr_intt_0
	str r10, [r9]
	ldr r10, =0
	ldr r9, addr_chat_0
	str r10, [r9]
	ldr r10, addr_get_0
	ldr r9, =0
	add r8, r9, r10
	mov r0, r8
	bl getstr
	mov r10, r0
	str r10, [fp, #-20]
	b .L273
.L273:
	ldr r10, addr_i_0
	ldr r9, [r10]
	ldr r10, [fp, #-20]
	cmp r9, r10
	movlt r10, #1
	movge r10, #0
	blt .L272
	b .L278
.L272:
	ldr r10, addr_i_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_0
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	bl isdigit
	mov r10, r0
	ldr r9, =1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L280
	b .L289
.L278:
	b .L274
.L280:
	ldr r10, addr_i_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, addr_ii_0
	ldr r8, [r9]
	ldr r9, =4
	mul r7, r8, r9
	ldr r9, addr_get2_0
	add r8, r7, r9
	str r10, [r8]
	ldr r10, addr_ii_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_ii_0
	str r10, [r9]
	b .L282
.L289:
	b .L281
.L274:
	b .L661
.L282:
	ldr r10, addr_i_0
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_i_0
	str r10, [r9]
	b .L273
.L281:
	ldr r10, addr_i_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =40
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L301
	b .L309
.L661:
	ldr r10, addr_chat_0
	ldr r9, [r10]
	ldr r10, =0
	cmp r9, r10
	movgt r10, #1
	movle r10, #0
	bgt .L660
	b .L665
.L301:
	mov r0, #40
	bl chapush
	b .L302
.L309:
	b .L302
.L660:
	bl chapop
	mov r10, r0
	str r10, [fp, #-16]
	ldr r10, addr_ii_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_0
	add r9, r8, r10
	ldr r10, =32
	str r10, [r9]
	ldr r10, [fp, #-16]
	ldr r9, addr_ii_0
	ldr r8, [r9]
	add r9, r8, #1
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, addr_get2_0
	add r8, r7, r9
	str r10, [r8]
	ldr r10, addr_ii_0
	ldr r9, [r10]
	add r10, r9, #2
	ldr r9, addr_ii_0
	str r10, [r9]
	b .L661
.L665:
	b .L662
.L302:
	ldr r10, addr_i_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L311
	b .L319
.L662:
	ldr r10, addr_ii_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_0
	add r9, r8, r10
	ldr r10, =64
	str r10, [r9]
	ldr r10, =1
	ldr r9, addr_i_0
	str r10, [r9]
	b .L683
.L311:
	mov r0, #94
	bl chapush
	b .L312
.L319:
	b .L312
.L683:
	ldr r10, addr_i_0
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_0
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =64
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L682
	b .L691
	b .F0
.LTORG
addr_ints_0:
	.word ints
addr_intt_0:
	.word intt
addr_chas_0:
	.word chas
addr_chat_0:
	.word chat
addr_i_0:
	.word i
addr_ii_0:
	.word ii
addr_c_0:
	.word c
addr_get_0:
	.word get
addr_get2_0:
	.word get2
.F0:
.L312:
	ldr r10, addr_i_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =41
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L321
	b .L329
.L682:
	ldr r10, addr_i_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L693
	b .L707
.L691:
	b .L684
.L321:
	bl chapop
	mov r10, r0
	ldr r9, addr_c_1
	str r10, [r9]
	b .L332
.L329:
	b .L322
.L693:
	bl intpop
	mov r10, r0
	str r10, [fp, #-12]
	bl intpop
	mov r10, r0
	str r10, [fp, #-8]
	ldr r10, addr_i_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L752
	b .L760
.L707:
	b .L700
.L684:
	ldr r10, =1
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_ints_1
	add r9, r8, r10
	ldr r10, [r9]
	mov r0, r10
	bl putint
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.L332:
	ldr r10, addr_c_1
	ldr r9, [r10]
	ldr r10, =40
	cmp r9, r10
	movne r10, #1
	moveq r10, #0
	bne .L331
	b .L336
.L322:
	ldr r10, addr_i_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L348
	b .L356
.L752:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-8]
	add r8, r10, r9
	str r8, [fp, #-4]
	b .L753
.L760:
	b .L753
.L700:
	ldr r10, addr_i_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L693
	b .L715
.L331:
	ldr r10, addr_ii_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_1
	add r9, r8, r10
	ldr r10, =32
	str r10, [r9]
	ldr r10, addr_c_1
	ldr r9, [r10]
	ldr r10, addr_ii_1
	ldr r8, [r10]
	add r10, r8, #1
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, addr_get2_1
	add r8, r7, r10
	str r9, [r8]
	ldr r10, addr_ii_1
	ldr r9, [r10]
	add r10, r9, #2
	ldr r9, addr_ii_1
	str r10, [r9]
	bl chapop
	mov r10, r0
	ldr r9, addr_c_1
	str r10, [r9]
	b .L332
.L336:
	b .L333
.L348:
	b .L359
.L356:
	b .L349
.L753:
	ldr r10, addr_i_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L764
	b .L772
.L715:
	b .L699
.L333:
	b .L322
.L359:
	ldr r10, addr_chat_1
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_1
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L358
	b .L372
	b .F1
.LTORG
addr_ints_1:
	.word ints
addr_intt_1:
	.word intt
addr_chas_1:
	.word chas
addr_chat_1:
	.word chat
addr_i_1:
	.word i
addr_ii_1:
	.word ii
addr_c_1:
	.word c
addr_get_1:
	.word get
addr_get2_1:
	.word get2
.F1:
.L349:
	ldr r10, addr_i_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L420
	b .L428
.L764:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-12]
	sub r8, r10, r9
	str r8, [fp, #-4]
	b .L765
.L772:
	b .L765
.L699:
	ldr r10, addr_i_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L693
	b .L723
.L358:
	bl find
	mov r10, r0
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L414
	b .L417
.L372:
	b .L365
.L420:
	b .L431
.L428:
	b .L421
.L765:
	ldr r10, addr_i_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L776
	b .L784
.L723:
	b .L698
.L414:
	b .L360
.L417:
	b .L415
.L365:
	ldr r10, addr_chat_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L358
	b .L380
.L431:
	ldr r10, addr_chat_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =43
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L430
	b .L444
.L421:
	ldr r10, addr_i_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L492
	b .L500
.L776:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-8]
	mul r8, r10, r9
	str r8, [fp, #-4]
	b .L777
.L784:
	b .L777
.L698:
	ldr r10, addr_i_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L693
	b .L731
.L360:
	mov r0, #43
	bl chapush
	b .L349
.L415:
	b .L359
.L380:
	b .L364
.L430:
	bl find
	mov r10, r0
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L486
	b .L489
.L444:
	b .L437
.L492:
	b .L503
.L500:
	b .L493
.L777:
	ldr r10, addr_i_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L788
	b .L796
.L731:
	b .L697
.L364:
	ldr r10, addr_chat_2
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_2
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L358
	b .L388
.L486:
	b .L432
	b .F2
.LTORG
addr_ints_2:
	.word ints
addr_intt_2:
	.word intt
addr_chas_2:
	.word chas
addr_chat_2:
	.word chat
addr_i_2:
	.word i
addr_ii_2:
	.word ii
addr_c_2:
	.word c
addr_get_2:
	.word get
addr_get2_2:
	.word get2
.F2:
.L489:
	b .L487
.L437:
	ldr r10, addr_chat_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =45
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L430
	b .L452
.L503:
	ldr r10, addr_chat_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L502
	b .L514
.L493:
	ldr r10, addr_i_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L546
	b .L554
.L788:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-12]
	sdiv r8, r10, r9
	str r8, [fp, #-4]
	b .L789
.L796:
	b .L789
.L697:
	ldr r10, addr_i_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L693
	b .L739
.L388:
	b .L363
.L432:
	mov r0, #45
	bl chapush
	b .L421
.L487:
	b .L431
.L452:
	b .L436
.L502:
	bl find
	mov r10, r0
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L540
	b .L543
.L514:
	b .L507
.L546:
	b .L557
.L554:
	b .L547
.L789:
	ldr r10, addr_i_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L800
	b .L808
.L739:
	b .L696
.L363:
	ldr r10, addr_chat_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L358
	b .L396
.L436:
	ldr r10, addr_chat_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L430
	b .L460
.L540:
	b .L504
.L543:
	b .L541
.L507:
	ldr r10, addr_chat_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L502
	b .L522
.L557:
	ldr r10, addr_chat_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L556
	b .L568
.L547:
	ldr r10, addr_i_3
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get_3
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L600
	b .L608
.L800:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-12]
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	str r8, [fp, #-4]
	b .L801
	b .F3
.LTORG
addr_ints_3:
	.word ints
addr_intt_3:
	.word intt
addr_chas_3:
	.word chas
addr_chat_3:
	.word chat
addr_i_3:
	.word i
addr_ii_3:
	.word ii
addr_c_3:
	.word c
addr_get_3:
	.word get
addr_get2_3:
	.word get2
.F3:
.L808:
	b .L801
.L696:
	ldr r10, addr_i_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L693
	b .L747
.L396:
	b .L362
.L460:
	b .L435
.L504:
	mov r0, #42
	bl chapush
	b .L493
.L541:
	b .L503
.L522:
	b .L506
.L556:
	bl find
	mov r10, r0
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L594
	b .L597
.L568:
	b .L561
.L600:
	b .L611
.L608:
	b .L601
.L801:
	ldr r10, addr_i_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L812
	b .L820
.L747:
	b .L694
.L362:
	ldr r10, addr_chat_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L358
	b .L404
.L435:
	ldr r10, addr_chat_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L430
	b .L468
.L506:
	ldr r10, addr_chat_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L502
	b .L530
.L594:
	b .L558
.L597:
	b .L595
.L561:
	ldr r10, addr_chat_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L556
	b .L576
.L611:
	ldr r10, addr_chat_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =42
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L610
	b .L622
.L601:
	ldr r10, addr_ii_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_4
	add r9, r8, r10
	ldr r10, =32
	str r10, [r9]
	ldr r10, addr_ii_4
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_ii_4
	str r10, [r9]
	b .L282
.L812:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-12]
	mov r1, r9
	mov r0, r10
	bl power
	mov r10, r0
	str r10, [fp, #-4]
	b .L813
.L820:
	b .L813
.L694:
	ldr r10, addr_i_4
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_4
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =32
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L825
	b .L833
.L404:
	b .L361
.L468:
	b .L434
.L530:
	b .L505
.L558:
	mov r0, #47
	bl chapush
	b .L547
.L595:
	b .L557
.L576:
	b .L560
.L610:
	bl find
	mov r10, r0
	ldr r9, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L648
	b .L651
	b .F4
.LTORG
addr_ints_4:
	.word ints
addr_intt_4:
	.word intt
addr_chas_4:
	.word chas
addr_chat_4:
	.word chat
addr_i_4:
	.word i
addr_ii_4:
	.word ii
addr_c_4:
	.word c
addr_get_4:
	.word get
addr_get2_4:
	.word get2
.F4:
.L622:
	b .L615
.L813:
	ldr r10, [fp, #-4]
	mov r0, r10
	bl intpush
	b .L695
.L825:
	ldr r10, addr_i_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_get2_5
	add r9, r8, r10
	ldr r10, [r9]
	sub r9, r10, #48
	mov r0, r9
	bl intpush
	ldr r10, =1
	ldr r9, addr_ii_5
	str r10, [r9]
	b .L841
.L833:
	b .L826
.L361:
	ldr r10, addr_chat_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L358
	b .L412
.L434:
	ldr r10, addr_chat_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L430
	b .L476
.L505:
	ldr r10, addr_chat_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L502
	b .L538
.L560:
	ldr r10, addr_chat_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L556
	b .L584
.L648:
	b .L612
.L651:
	b .L649
.L615:
	ldr r10, addr_chat_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =47
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L610
	b .L630
.L695:
	ldr r10, addr_i_5
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_i_5
	str r10, [r9]
	b .L683
.L841:
	ldr r10, addr_i_5
	ldr r9, [r10]
	ldr r10, addr_ii_5
	ldr r8, [r10]
	add r10, r9, r8
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_get2_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =32
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L840
	b .L850
.L826:
	b .L695
.L412:
	b .L360
.L476:
	b .L433
.L538:
	b .L504
.L584:
	b .L559
.L612:
	mov r0, #37
	bl chapush
	b .L601
.L649:
	b .L611
.L630:
	b .L614
.L840:
	ldr r10, addr_i_5
	ldr r9, [r10]
	ldr r10, addr_ii_5
	ldr r8, [r10]
	add r10, r9, r8
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, addr_get2_5
	add r9, r8, r10
	ldr r10, [r9]
	sub r9, r10, #48
	mov r0, r9
	bl intadd
	ldr r10, addr_ii_5
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, addr_ii_5
	str r10, [r9]
	b .L841
.L850:
	b .L842
.L433:
	ldr r10, addr_chat_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L430
	b .L484
.L559:
	ldr r10, addr_chat_5
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_5
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L556
	b .L592
	b .F5
.LTORG
addr_ints_5:
	.word ints
addr_intt_5:
	.word intt
addr_chas_5:
	.word chas
addr_chat_5:
	.word chat
addr_i_5:
	.word i
addr_ii_5:
	.word ii
addr_c_5:
	.word c
addr_get_5:
	.word get
addr_get2_5:
	.word get2
.F5:
.L614:
	ldr r10, addr_chat_6
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_6
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =37
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L610
	b .L638
.L842:
	ldr r10, addr_i_6
	ldr r9, [r10]
	ldr r10, addr_ii_6
	ldr r8, [r10]
	add r10, r9, r8
	sub r9, r10, #1
	ldr r10, addr_i_6
	str r9, [r10]
	b .L826
.L484:
	b .L432
.L592:
	b .L558
.L638:
	b .L613
.L613:
	ldr r10, addr_chat_6
	ldr r9, [r10]
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, addr_chas_6
	add r9, r8, r10
	ldr r10, [r9]
	ldr r9, =94
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L610
	b .L646
.L646:
	b .L612
.Lmain_END:
	add sp, sp, #20
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

addr_ints_6:
	.word ints
addr_intt_6:
	.word intt
addr_chas_6:
	.word chas
addr_chat_6:
	.word chat
addr_i_6:
	.word i
addr_ii_6:
	.word ii
addr_c_6:
	.word c
addr_get_6:
	.word get
addr_get2_6:
	.word get2
