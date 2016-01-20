.include "linux.s"
.include "record-def.s"

.section .data
input_file_name:
	.ascii "test.dat\0"
output_file_name:
	.ascii "testout.dat\0"

.section .bss
	.lcomm record_buffer, RECORD_SIZE

.equ ST_INPUT_DESCRIPTOR, -4
.equ ST_OUTPUT_DESCRIPTOR, -8

.section .text
.globl _start
_start:
	movl %esp, %ebp
	subl $8, %esp

	movl $SYS_OPEN, %eax
	movl $input_file_name, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
	cmpl $0, %eax
	jle end_of_process
	movl %eax, ST_INPUT_DESCRIPTOR(%ebp)

	movl $SYS_OPEN, %eax
	movl $output_file_name, %ebx
	movl $0101, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
	cmpl $0, %eax
	jle end_of_process
	movl %eax, ST_OUTPUT_DESCRIPTOR(%ebp)

loop_begin:
	pushl ST_INPUT_DESCRIPTOR(%ebp)
	pushl $record_buffer
	call read_record
	addl $8, %esp

	cmpl $RECORD_SIZE, %eax
	jne loop_end

	incl RECORD_FIRSTNAME + record_buffer
	pushl ST_OUTPUT_DESCRIPTOR(%ebp)
	pushl $record_buffer
	call write_record
	addl $8, %esp

	jmp loop_begin

loop_end:
	movl $SYS_CLOSE, %eax
	movl ST_INPUT_DESCRIPTOR(%ebp), %ebx
	int $LINUX_SYSCALL

	movl $SYS_CLOSE, %eax
	movl ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
	int $LINUX_SYSCALL

end_of_process:
	movl $SYS_EXIT, %eax
	movl $2, %ebx
	int $LINUX_SYSCALL

