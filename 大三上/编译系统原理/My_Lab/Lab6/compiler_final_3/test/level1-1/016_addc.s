	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L1:
	ldr r10, =15
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

