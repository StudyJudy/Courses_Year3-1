	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global MAX
	.type MAX , %function
MAX:
	push {r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L29:
	str r0, [fp, #-8]
	str r1, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L32
	b .L38
.L32:
	ldr r10, [fp, #-8]
	mov r0, r10
	b .LMAX_END
.L38:
	b .L33
.L33:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L41
	b .L47
.L41:
	ldr r10, [fp, #-8]
	mov r0, r10
	b .LMAX_END
.L47:
	b .L42
.L42:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .LMAX_END
.LMAX_END:
	add sp, sp, #8
	pop {r9, r10, fp, lr}
	bx lr

	.global max_sum_nonadjacent
	.type max_sum_nonadjacent , %function
max_sum_nonadjacent:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #76
.L51:
	str r0, [fp, #-76]
	str r1, [fp, #-72]
	ldr r10, =0
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =4
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =8
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =12
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =16
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =20
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =24
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =28
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =32
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =36
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =40
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =44
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =48
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =52
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =56
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =60
	add r9, r10, #-68
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-76]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-68
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-76]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, [r9]
	ldr r9, [fp, #-76]
	ldr r8, =1
	ldr r7, =4
	mul r6, r8, r7
	add r8, r6, r9
	ldr r9, [r8]
	mov r1, r9
	mov r0, r10
	bl MAX
	mov r10, r0
	ldr r9, =1
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-68
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =2
	str r10, [fp, #-4]
	b .L89
.L89:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-72]
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L88
	b .L94
.L88:
	ldr r10, [fp, #-4]
	sub r9, r10, #2
	ldr r10, =4
	mul r8, r9, r10
	add r10, r8, #-68
	add r10, fp, r10
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	ldr r8, [fp, #-76]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r8
	ldr r8, [r10]
	add r10, r9, r8
	ldr r9, [fp, #-4]
	sub r8, r9, #1
	ldr r9, =4
	mul r7, r8, r9
	add r9, r7, #-68
	add r9, fp, r9
	ldr r8, [r9]
	mov r1, r8
	mov r0, r10
	bl MAX
	mov r10, r0
	ldr r9, [fp, #-4]
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, #-68
	add r8, fp, r9
	str r10, [r8]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L89
	b .F0
.LTORG
.F0:
.L94:
	b .L90
.L90:
	ldr r10, [fp, #-72]
	sub r9, r10, #1
	ldr r10, =4
	mul r8, r9, r10
	add r10, r8, #-68
	add r10, fp, r10
	ldr r9, [r10]
	mov r0, r9
	b .Lmax_sum_nonadjacent_END
.Lmax_sum_nonadjacent_END:
	add sp, sp, #76
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global longest_common_subseq
	.type longest_common_subseq , %function
longest_common_subseq:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=1048
	sub sp, sp, r4
.L117:
	ldr r10, =-1048
	str r0, [fp, r10]
	ldr r10, =-1044
	str r1, [fp, r10]
	ldr r10, =-1040
	str r2, [fp, r10]
	ldr r10, =-1036
	str r3, [fp, r10]
	ldr r10, =0
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =4
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =8
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =12
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =16
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =20
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =24
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =28
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =32
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =36
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =40
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =44
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =48
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =52
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =56
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =60
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =64
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =68
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =72
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =76
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =80
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =84
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =88
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =92
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =96
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =100
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =104
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =108
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =112
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =116
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =120
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =124
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =128
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =132
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =136
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =140
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =144
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =148
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =152
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =156
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =160
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =164
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =168
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =172
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =176
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =180
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =184
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =188
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =192
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =196
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =200
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =204
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =208
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =212
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =216
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =220
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =224
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =228
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =232
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =236
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =240
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =244
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =248
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =252
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =256
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =260
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =264
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =268
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =272
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =276
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =280
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =284
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =288
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =292
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =296
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =300
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =304
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =308
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =312
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =316
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =320
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =324
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	b .B0
.LTORG
.B0:
	ldr r10, =328
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =332
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =336
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =340
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =344
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =348
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =352
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =356
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =360
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =364
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =368
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =372
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =376
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =380
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =384
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =388
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =392
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =396
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =400
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =404
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =408
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =412
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =416
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =420
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =424
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =428
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =432
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =436
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =440
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =444
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =448
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =452
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =456
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =460
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =464
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =468
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =472
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =476
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =480
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =484
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =488
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =492
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =496
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =500
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =504
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =508
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =512
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =516
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =520
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =524
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =528
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =532
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =536
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =540
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =544
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =548
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =552
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =556
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =560
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =564
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =568
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =572
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =576
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =580
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =584
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =588
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =592
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =596
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =600
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =604
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =608
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =612
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =616
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =620
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =624
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =628
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =632
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =636
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =640
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =644
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =648
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =652
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =656
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =660
	ldr r9, =-1032
	b .B1
.LTORG
.B1:
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =664
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =668
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =672
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =676
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =680
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =684
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =688
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =692
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =696
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =700
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =704
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =708
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =712
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =716
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =720
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =724
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =728
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =732
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =736
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =740
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =744
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =748
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =752
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =756
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =760
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =764
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =768
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =772
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =776
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =780
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =784
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =788
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =792
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =796
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =800
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =804
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =808
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =812
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =816
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =820
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =824
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =828
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =832
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =836
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =840
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =844
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =848
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =852
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =856
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =860
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =864
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =868
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =872
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =876
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =880
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =884
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =888
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =892
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =896
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =900
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =904
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =908
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =912
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =916
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =920
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =924
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =928
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =932
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =936
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =940
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =944
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =948
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =952
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =956
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =960
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =964
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =968
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =972
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =976
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =980
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =984
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =988
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =992
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	b .B2
.LTORG
.B2:
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =996
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1000
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1004
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1008
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1012
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1016
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1020
	ldr r9, =-1032
	add r8, r10, r9
	ldr r10, =0
	add r9, fp, r8
	str r10, [r9]
	ldr r10, =1
	str r10, [fp, #-8]
	b .L382
	b .F4
.LTORG
.F4:
.L382:
	ldr r10, [fp, #-8]
	ldr r9, =-1044
	ldr r8, [fp, r9]
	cmp r10, r8
	movle r10, #1
	movgt r10, #0
	ble .L381
	b .L387
.L381:
	ldr r10, =1
	str r10, [fp, #-4]
	b .L390
.L387:
	b .L383
.L390:
	ldr r10, [fp, #-4]
	ldr r9, =-1036
	ldr r8, [fp, r9]
	cmp r10, r8
	movle r10, #1
	movgt r10, #0
	ble .L389
	b .L395
.L383:
	ldr r10, =-1044
	ldr r9, [fp, r10]
	ldr r10, =-1036
	ldr r8, [fp, r10]
	ldr r10, =16
	mul r7, r9, r10
	add r10, r7, r8
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, =-1032
	add r9, r8, r10
	add r9, fp, r9
	ldr r10, [r9]
	mov r0, r10
	b .Llongest_common_subseq_END
.L389:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	ldr r10, =-1048
	ldr r8, [fp, r10]
	ldr r10, =4
	mul r7, r9, r10
	add r10, r7, r8
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	sub r8, r10, #1
	ldr r10, =-1040
	ldr r7, [fp, r10]
	ldr r10, =4
	mul r6, r8, r10
	add r10, r6, r7
	ldr r8, [r10]
	cmp r9, r8
	moveq r10, #1
	movne r10, #0
	beq .L397
	b .L411
.L395:
	b .L391
.L397:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	ldr r10, [fp, #-4]
	sub r8, r10, #1
	ldr r10, =16
	mul r7, r9, r10
	add r10, r7, r8
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, =-1032
	add r9, r8, r10
	add r10, fp, r9
	ldr r9, [r10]
	add r10, r9, #1
	ldr r9, [fp, #-8]
	ldr r8, [fp, #-4]
	ldr r7, =16
	mul r6, r9, r7
	add r9, r6, r8
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-1032
	add r8, r7, r9
	add r9, fp, r8
	str r10, [r9]
	b .L399
.L411:
	b .L398
.L391:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L382
.L399:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L390
.L398:
	ldr r10, [fp, #-8]
	sub r9, r10, #1
	ldr r10, [fp, #-4]
	ldr r8, =16
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, =4
	mul r8, r9, r10
	ldr r10, =-1032
	add r9, r8, r10
	add r10, fp, r9
	ldr r9, [r10]
	ldr r10, [fp, #-8]
	ldr r8, [fp, #-4]
	sub r7, r8, #1
	ldr r8, =16
	mul r6, r10, r8
	add r10, r6, r7
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-1032
	add r8, r7, r10
	add r10, fp, r8
	ldr r8, [r10]
	mov r1, r8
	mov r0, r9
	bl MAX
	mov r10, r0
	ldr r9, [fp, #-8]
	ldr r8, [fp, #-4]
	ldr r7, =16
	mul r6, r9, r7
	add r9, r6, r8
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-1032
	add r8, r7, r9
	add r9, fp, r8
	str r10, [r9]
	b .L399
.Llongest_common_subseq_END:
	ldr r4,=1048
	add sp, sp, r4
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #120
.L455:
	ldr r10, =0
	add r9, r10, #-120
	ldr r10, =8
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =4
	add r9, r10, #-120
	ldr r10, =7
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =8
	add r9, r10, #-120
	ldr r10, =4
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =12
	add r9, r10, #-120
	ldr r10, =1
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =16
	add r9, r10, #-120
	ldr r10, =2
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =20
	add r9, r10, #-120
	ldr r10, =7
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =24
	add r9, r10, #-120
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =28
	add r9, r10, #-120
	ldr r10, =1
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =32
	add r9, r10, #-120
	ldr r10, =9
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =36
	add r9, r10, #-120
	ldr r10, =3
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =40
	add r9, r10, #-120
	ldr r10, =4
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =44
	add r9, r10, #-120
	ldr r10, =8
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =48
	add r9, r10, #-120
	ldr r10, =3
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =52
	add r9, r10, #-120
	ldr r10, =7
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =56
	add r9, r10, #-120
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =0
	add r9, r10, #-60
	ldr r10, =3
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =4
	add r9, r10, #-60
	ldr r10, =9
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =8
	add r9, r10, #-60
	ldr r10, =7
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =12
	add r9, r10, #-60
	ldr r10, =1
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =16
	add r9, r10, #-60
	ldr r10, =4
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =20
	add r9, r10, #-60
	ldr r10, =2
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =24
	add r9, r10, #-60
	ldr r10, =4
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =28
	add r9, r10, #-60
	ldr r10, =3
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =32
	add r9, r10, #-60
	ldr r10, =6
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =36
	add r9, r10, #-60
	ldr r10, =8
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =40
	add r9, r10, #-60
	ldr r10, =0
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =44
	add r9, r10, #-60
	ldr r10, =1
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =48
	add r9, r10, #-60
	ldr r10, =5
	add r8, fp, r9
	str r10, [r8]
	ldr r10, =0
	add r9, r10, #-120
	mov r1, #15
	add r10, fp, r9
	mov r0, r10
	bl max_sum_nonadjacent
	mov r10, r0
	mov r0, r10
	bl putint
	mov r0, #10
	bl putch
	ldr r10, =0
	add r9, r10, #-120
	ldr r10, =0
	add r8, r10, #-60
	mov r3, #13
	add r10, fp, r8
	mov r2, r10
	mov r1, #15
	add r10, fp, r9
	mov r0, r10
	bl longest_common_subseq
	mov r10, r0
	mov r0, r10
	bl putint
	mov r0, #10
	bl putch
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
	b .F5
.LTORG
.F5:
.Lmain_END:
	add sp, sp, #120
	pop {r8, r9, r10, fp, lr}
	bx lr

