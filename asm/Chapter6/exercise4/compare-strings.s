.include "linux.s"
.include "record-def.s"

.section .bss
.lcomm RECORD_BUFFER, RECORD_SIZE
.lcomm SCAN_STRING, 10

.EQU PARE_FILE_NAME, 12
.EQU OPEN_READ_FID, -4

.section .text
.globl _start
_start:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp

#Open Read File
	movl $SYS_OPEN, %eax
	movl PARE_FILE_NAME(%ebp), %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
	cmpl $0, %eax
	jle end_start
	movl %eax, OPEN_READ_FID(%ebp)

#SCanf User String
	movl $SYS_READ, %eax
	movl $STDIN, %ebx
	movl $SCAN_STRING, %ecx
	movl $6, %edx
	int $LINUX_SYSCALL

	pushl $SCAN_STRING
	call count_chars
	addl $4, %esp

#Loop Search String
record_read_loop:
	pushl OPEN_READ_FID(%ebp)
	pushl $RECORD_BUFFER
	call read_record
	addl $8, %esp
	
	cmpl $RECORD_SIZE, %eax
	jne file_close

	pushl $SCAN_STRING
FirstNameCmp:
	pushl $RECORD_FIRSTNAME + RECORD_BUFFER
	call strcmpare
	addl $4, %esp
	cmpl $1, %eax
	jne LastNameCmp
	pushl $RECORD_FIRSTNAME + RECORD_BUFFER
	call printString
	addl $4, %esp

LastNameCmp:
	pushl $RECORD_LASTNAME + RECORD_BUFFER
	call strcmpare
	addl $4, %esp
	cmpl $1, %eax
	jne AddressCmp
	pushl $RECORD_LASTNAME + RECORD_BUFFER
	call printString
	addl $4, %esp
	
AddressCmp:
	pushl $RECORD_ADDRESS + RECORD_BUFFER
	call strcmpare
	addl $4, %esp
	cmpl $1, %eax
	jne one_name_finish
	pushl $RECORD_ADDRESS + RECORD_BUFFER
	call printString
	addl $4, %esp

one_name_finish:
	addl $4, %esp
	jmp record_read_loop

file_close:
	movl $SYS_CLOSE, %eax
	movl OPEN_READ_FID(%ebp), %ebx
	int $LINUX_SYSCALL
	end_start:
	movl %ebp, %esp
	popl %ebp
	movl $SYS_EXIT, %eax
	movl $0, %ebx
	int $LINUX_SYSCALL



.type printString, @function
.section .text
printString:
	pushl %ebp
	movl %esp, %ebp

	pushl 8(%ebp)
	call count_chars
	addl $4, %esp
	movl %eax, %edx
	movl $STDOUT, %ebx
	movl $SYS_WRITE, %eax
	movl 8(%ebp), %ecx
	int $LINUX_SYSCALL
	
	pushl $STDOUT
	call write_newline
	addl $4, %esp

	movl %ebp, %esp
	popl %ebp
	ret


.type strcmpare, @function
.section .data
newline_char:
	.ascii "\n"

.section .text
strcmpare:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %edx
	movl 12(%ebp), %esi
	movl $0, %eax
	movl $0, %ebx
	
compare_loop:
	movb (%esi, %eax, 1), %cl
	movb (%edx, %ebx, 1), %ch
	cmpb newline_char, %cl
	je compare_same
	cmpb $0, %cl
	je compare_same
	cmpb $0, %ch
	je compare_differ
	cmpb %cl, %ch
	jne next_char
	incl %eax
	incl %ebx
	jmp compare_loop
	
next_char:
	movl $0, %eax
	incl %ebx
	jmp compare_loop
	
compare_same:
	movl $1, %eax
	jmp compare_end
compare_differ:
	movl $0, %eax
	jmp compare_end
compare_end:
	movl %ebp, %esp
	popl %ebp
	ret
	

