	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L1:
	ldr r10, =10
	str r10, [fp, #-8]
	ldr r10, =5
	str r10, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-4]
	sdiv r8, r10, r9
	mov r0, r8
	b .Lmain_END
.Lmain_END:
	add sp, sp, #8
	pop {r8, r9, r10, fp, lr}
	bx lr

