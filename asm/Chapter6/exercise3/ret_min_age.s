.include "linux.s"
.include "record-def.s"

.section .data
file_name:
	.ascii "test.dat\0"

.section .bss
	.lcomm record_buffer, RECORD_SIZE

.section .text
.globl _start
_start:
.equ ST_INPUT_DESCRIPTOR, -4

	movl %esp, %ebp
	subl $8, %esp
	movl $SYS_OPEN, %eax
	movl $file_name, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL

	cmpl $0, %eax
	jle end_of_process

	movl %eax, ST_INPUT_DESCRIPTOR(%ebp)
	
	movl $999, %edx

record_read_loop:
	pushl %edx
	pushl ST_INPUT_DESCRIPTOR(%ebp)
	pushl $record_buffer
	call read_record
	addl $8, %esp
	popl %edx

	cmpl $RECORD_SIZE, %eax
	jne finished_reading

	movl $RECORD_AGE + record_buffer, %edi
	movl (%edi), %eax
	cmpl %eax, %edx
	jle record_read_loop
	movl %eax, %edx
	jmp record_read_loop

finished_reading:

	movl $SYS_CLOSE, %eax
	movl ST_INPUT_DESCRIPTOR(%ebp), %ebx
	int $LINUX_SYSCALL
	movl %edx, %ebx

end_of_process:
	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL

