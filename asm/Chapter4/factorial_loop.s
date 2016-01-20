.section .data
.section .text
.globl _start
.globl factorial

_start:
	movl $5, %eax
	movl $1, %ebx
factorial_loop:
	cmpl $1, %eax
	je end_factorial
	imull %eax, %ebx
	decl %eax
	jmp factorial_loop

end_factorial:
	movl $1, %eax
	int $0x80
