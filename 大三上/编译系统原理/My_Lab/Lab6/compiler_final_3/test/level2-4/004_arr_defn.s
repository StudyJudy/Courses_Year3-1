	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.comm	a,40,4
	.text
	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
.L0:
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	pop {r10, fp, lr}
	bx lr

addr_a_0:
	.word a
