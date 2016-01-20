.section .data

.section .text

.globl _start

_start:
	pushl $3
	pushl $2
	call power
	addl $8, %esp
	pushl %eax

	pushl $2
	pushl $5
	call power
	addl $8, %esp
	popl %ebx

	addl %eax, %ebx

	movl $1, %eax
	int $0x80

.type power, @function
power:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx
	movl %ebx, %eax
	movl 12(%ebp), %ecx

power_loop_start:
	cmpl $1, %ecx
	je end_power
	imull %ebx, %eax
	
	decl %ecx
	jmp power_loop_start

end_power:
	movl %ebp, %esp
	pop %ebp
	ret

