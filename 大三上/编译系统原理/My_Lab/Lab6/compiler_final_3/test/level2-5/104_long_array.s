	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global long_array
	.type long_array , %function
long_array:
	push {r7, r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=120020
	sub sp, sp, r4
.L42:
	ldr r10, =-120020
	str r0, [fp, r10]
	ldr r10, =0
	str r10, [fp, #-16]
	b .L49
.L49:
	ldr r10, [fp, #-16]
	ldr r9, =10000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L48
	b .L53
.L48:
	ldr r10, [fp, #-16]
	ldr r9, [fp, #-16]
	mul r8, r10, r9
	ldr r10, =10
	sdiv r9, r8, r10
	mul r10, r9, r10
	sub r9, r8, r10
	ldr r10, [fp, #-16]
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-120016
	add r8, r7, r10
	add r10, fp, r8
	str r9, [r10]
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L49
.L53:
	b .L50
.L50:
	ldr r10, =0
	str r10, [fp, #-16]
	b .L62
.L62:
	ldr r10, [fp, #-16]
	ldr r9, =10000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L61
	b .L66
.L61:
	ldr r10, [fp, #-16]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, =-120016
	add r9, r8, r10
	add r10, fp, r9
	ldr r9, [r10]
	ldr r10, [fp, #-16]
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-120016
	add r8, r7, r10
	add r10, fp, r8
	ldr r8, [r10]
	mul r10, r9, r8
	ldr r9, =10
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	ldr r10, [fp, #-16]
	ldr r9, =4
	mul r7, r10, r9
	ldr r10, =-80016
	add r9, r7, r10
	add r10, fp, r9
	str r8, [r10]
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L62
.L66:
	b .L63
.L63:
	ldr r10, =0
	str r10, [fp, #-16]
	b .L81
.L81:
	ldr r10, [fp, #-16]
	ldr r9, =10000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L80
	b .L85
.L80:
	ldr r10, [fp, #-16]
	ldr r9, =4
	mul r8, r10, r9
	ldr r10, =-80016
	add r9, r8, r10
	add r9, fp, r9
	ldr r10, [r9]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-80016
	add r8, r7, r9
	add r9, fp, r8
	ldr r8, [r9]
	mul r9, r10, r8
	ldr r10, =100
	sdiv r8, r9, r10
	mul r10, r8, r10
	sub r8, r9, r10
	ldr r10, [fp, #-16]
	ldr r9, =4
	mul r7, r10, r9
	ldr r10, =-120016
	add r9, r7, r10
	add r10, fp, r9
	ldr r9, [r10]
	add r10, r8, r9
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-40016
	add r8, r7, r9
	add r9, fp, r8
	str r10, [r9]
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L81
.L85:
	b .L82
.L82:
	ldr r10, =0
	str r10, [fp, #-12]
	ldr r10, =0
	str r10, [fp, #-16]
	b .L105
.L105:
	ldr r10, [fp, #-16]
	ldr r9, =10000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L104
	b .L109
.L104:
	ldr r10, [fp, #-16]
	ldr r9, =10
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L111
	b .L116
.L109:
	b .L106
.L111:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-40016
	add r8, r7, r9
	add r9, fp, r8
	ldr r8, [r9]
	add r9, r10, r8
	ldr r10, =1333
	sdiv r8, r9, r10
	mul r8, r8, r10
	sub r10, r9, r8
	str r10, [fp, #-12]
	ldr r10, [fp, #-12]
	mov r0, r10
	bl putint
	b .L113
.L116:
	b .L112
.L106:
	ldr r10, [fp, #-12]
	mov r0, r10
	b .Llong_array_END
	b .F0
.LTORG
.F0:
.L113:
	ldr r10, [fp, #-16]
	add r9, r10, #1
	str r9, [fp, #-16]
	b .L105
.L112:
	ldr r10, [fp, #-16]
	ldr r9, =20
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L124
	b .L129
.L124:
	ldr r10, =5000
	str r10, [fp, #-8]
	b .L133
.L129:
	b .L125
.L133:
	ldr r10, [fp, #-8]
	ldr r9, =10000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L132
	b .L137
.L125:
	ldr r10, [fp, #-16]
	ldr r9, =30
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L150
	b .L155
.L132:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-40016
	add r8, r7, r9
	add r9, fp, r8
	ldr r8, [r9]
	add r9, r10, r8
	ldr r10, [fp, #-8]
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-120016
	add r8, r7, r10
	add r10, fp, r8
	ldr r8, [r10]
	sub r10, r9, r8
	str r10, [fp, #-12]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	b .L133
.L137:
	b .L134
.L150:
	ldr r10, =5000
	str r10, [fp, #-4]
	b .L159
.L155:
	b .L151
.L134:
	ldr r10, [fp, #-12]
	mov r0, r10
	bl putint
	b .L126
.L159:
	ldr r10, [fp, #-4]
	ldr r9, =10000
	cmp r10, r9
	movlt r10, #1
	movge r10, #0
	blt .L158
	b .L163
.L151:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-40016
	add r8, r7, r9
	add r9, fp, r8
	ldr r8, [r9]
	ldr r9, =-120020
	ldr r7, [fp, r9]
	mul r9, r8, r7
	add r8, r10, r9
	ldr r10, =99988
	sdiv r9, r8, r10
	mul r10, r9, r10
	sub r9, r8, r10
	str r9, [fp, #-12]
	b .L152
.L126:
	b .L113
.L158:
	ldr r10, [fp, #-4]
	ldr r9, =2233
	cmp r10, r9
	movgt r10, #1
	movle r10, #0
	bgt .L165
	b .L170
.L163:
	b .L160
.L152:
	b .L126
.L165:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-80016
	add r8, r7, r9
	add r9, fp, r8
	ldr r8, [r9]
	add r9, r10, r8
	ldr r10, [fp, #-4]
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-120016
	add r8, r7, r10
	add r10, fp, r8
	ldr r8, [r10]
	sub r10, r9, r8
	str r10, [fp, #-12]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L167
.L170:
	b .L166
.L160:
	ldr r10, [fp, #-12]
	mov r0, r10
	bl putint
	b .L152
.L167:
	b .L159
.L166:
	ldr r10, [fp, #-12]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r9, r8
	ldr r9, =-120016
	add r8, r7, r9
	add r9, fp, r8
	ldr r8, [r9]
	add r9, r10, r8
	ldr r10, [fp, #-4]
	ldr r8, =4
	mul r7, r10, r8
	ldr r10, =-40016
	add r8, r7, r10
	add r10, fp, r8
	ldr r8, [r10]
	add r10, r9, r8
	ldr r9, =13333
	sdiv r8, r10, r9
	mul r9, r8, r9
	sub r8, r10, r9
	str r8, [fp, #-12]
	ldr r10, [fp, #-4]
	add r9, r10, #2
	str r9, [fp, #-4]
	b .L167
.Llong_array_END:
	ldr r4,=120020
	add sp, sp, r4
	pop {r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L201:
	mov r0, #9
	bl long_array
	mov r10, r0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

