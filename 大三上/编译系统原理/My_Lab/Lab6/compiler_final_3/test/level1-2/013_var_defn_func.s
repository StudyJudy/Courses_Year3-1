	.arch armv8-a
	.arch_extension crc
	.arm
	.text
	.global defn
	.type defn , %function
defn:
	push {r10, fp, lr}
	mov fp, sp
.L1:
	ldr r10, =4
	mov r0, r10
	b .Ldefn_END
.Ldefn_END:
	pop {r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r10, fp, lr}
	mov fp, sp
	sub sp, sp, #4
.L2:
	bl defn
	mov r10, r0
	str r10, [fp, #-4]
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	add sp, sp, #4
	pop {r10, fp, lr}
	bx lr

