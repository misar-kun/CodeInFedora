.section .data

.equ SYS_OPEN, 5
.equ SYS_WRITE, 4
.equ SYS_READ, 3
.equ SYS_CLOSE, 6
.equ SYS_EXIT, 1

.equ O_RDONLY, 0
.equ O_CREAT_WRONLY_TRUNC, 03101

.equ STDIN, 0
.equ STDOUT, 1
.equ STDERR, 2

.equ LINUX_SYSCALL, 0x80
.equ END_OF_FILE, 0

.equ NUMBER_ARGUMENTS, 2

.section .bss
.equ BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE
.lcomm FILE_DICRIPT_IN, 4
.lcomm FILE_DICRIPT_OUT, 4

.section .text
.equ ST_ARGC, 0
.equ ST_ARGV_0, 4
.equ ST_ARGV_1, 8
.equ ST_ARGV_2, 12

.globl _start
_start:
	movl %esp, %ebp

open_files:
open_fd_out:
	movl $SYS_OPEN, %eax
	movl ST_ARGV_2(%ebp), %ebx
	movl $O_CREAT_WRONLY_TRUNC, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
store_fd_out:
	movl %eax, FILE_DICRIPT_OUT

	movl $0, %edi
	movl ST_ARGV_1(%ebp), %eax
count_loop:
	movb (%eax, %edi, 1), %cl
	cmpb $0, %cl
	je count_end
	incl %edi
	jmp count_loop
count_end:

	movl %eax, %ecx
	movl $SYS_WRITE, %eax
	movl FILE_DICRIPT_OUT, %ebx
	movl %edi, %edx
	int $LINUX_SYSCALL

end_loop:
	movl $SYS_CLOSE, %eax
	movl FILE_DICRIPT_OUT, %ebx
	int $LINUX_SYSCALL

	movl $SYS_EXIT, %eax
	movl %edi, %ebx
	int $LINUX_SYSCALL

