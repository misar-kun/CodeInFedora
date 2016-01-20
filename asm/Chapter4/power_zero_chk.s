.section .data

.section .text

.globl _start

_start:
	pushl $0
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
	subl $4, %esp

	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx
	movl %ebx, -4(%ebp)

power_loop_start:
	cmpl $0, %ecx
	je end_power_and_ret_1
	cmpl $1, %ecx
	je end_power
	movl -4(%ebp), %eax
	imull %ebx, %eax
	movl %eax, -4(%ebp)
	
	decl %ecx
	jmp power_loop_start

end_power:
	movl -4(%ebp), %eax
	jmp ret_power
end_power_and_ret_1:
	movl $1, %eax
	jmp ret_power

ret_power:
	movl %ebp, %esp
	pop %ebp
	ret

