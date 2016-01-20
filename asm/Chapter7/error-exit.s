.include "linux.s"
.equ st_error_code, 8
.equ st_error_msg, 12
.globl error_exit
.type error_exit, @function
error_exit:
	pushl %ebp
	movl %esp, %ebp

	movl st_error_code(%ebp), %ecx
	pushl %ecx
	call count_chars
	popl %ecx
	movl %eax, %edx
	movl $STDERR, %ebx
	movl $SYS_WRITE, %eax
	int $LINUX_SYSCALL

	movl st_error_msg(%ebp), %ecx
	pushl %ecx
	call count_chars
	popl %ecx
	movl %eax, %edx
	movl $STDERR, %ebx
	movl $SYS_WRITE, %eax
	int $LINUX_SYSCALL

	pushl $STDERR
	call write_newline

	movl $SYS_EXIT, %eax
	movl $1, %ebx
	int $LINUX_SYSCALL
