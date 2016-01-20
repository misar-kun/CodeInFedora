.section .data
data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,246,0

.section .text
.globl _start

_start:
	pushl %ebp
	movl %esp, %ebp

	movl $data_items, %eax
	pushl %eax
	call max
	subl $4, %esp
	movl %eax, %ebx

	movl %ebp, %esp
	pop %ebp
	movl $1, %eax
	int $0x80

.type max, @function
max:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ebx
	movl (%ebx), %eax
	cmpl $0, %eax
	je max_end
	movl $0, %edi

max_loop:
	incl %edi
	movl (%ebx, %edi, 4), %ecx
	cmpl $0, %ecx
	je max_end
	cmpl %ecx, %eax
	jge max_loop
	movl %ecx, %eax
	jmp max_loop

max_end:
	movl %ebp, %esp
	popl %ebp
	ret

