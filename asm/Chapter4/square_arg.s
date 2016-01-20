.section .data
.section .text

.globl _start

_start:
	pushl %ebp
	movl %esp, %ebp
	
	movl 12(%ebp), %ebx
	pushl %ebx
	call atoi
	addl $4, %esp

	pushl %eax
	call square
	addl $4, %esp
	movl %eax, %ebx

	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	int $0x80

.type square,@function
square:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp

	movl 8(%ebp), %eax
	imull %eax, %eax

	movl %ebp, %esp
	popl %ebp
	ret

.type atoi,@function
atoi:
	pushl %ebp
	movl %esp, %ebp

	subl %eax, %eax
	subl %edi, %edi
loop_atoi:
	movl 8(%ebp), %ebx
	movb (%ebx, %edi, 1), %cl
	cmpb $0, %cl
	je end_atoi
	cmpb $0x30, %cl
	jl not_number
	cmpb $0x39, %cl
	jg not_number

	subb $0x30, %cl
	imull $10, %eax
	addl %ecx, %eax
	incl %edi
	jmp loop_atoi

not_number:
	movl $0, %eax
end_atoi:
	movl %ebp, %esp
	pop %ebp
	ret

