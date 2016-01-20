#!/bin/bash
# Assemble Complie Script
#
# Assemble Name is "MyAssemble.s",
# Target FileName is exec
#
# History
# 2014/01/20	wyy	Creat

PATH=/bin:/usr/lib/qt-3.3/bin:/usr/kerberos/bin:/usr/lib/ccache:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/misar/bin:~/bin
export PATH

#as --gstabs MyAssemble.s -o a.out
#ld a.out -o exec
#rm a.out
#./exec
#echo $?

as --gstabs write-records.s -o write-records.o
as --gstabs write-record.s -o write-record.o
ld write-record.o write-records.o -o write-records
rm *.o


as --gstabs read-record.s -o read-record.o
as --gstabs count-chars.s -o count-chars.o
as --gstabs write-newline.s -o write-newline.o
as --gstabs read-records.s -o read-records.o
ld read-record.o count-chars.o write-newline.o read-records.o \
	   -o read-records
rm *.o


as --gstabs read-record.s -o read-record.o
as --gstabs ret_max_age.s -o ret_max_age.o
ld read-record.o ret_max_age.o -o ret_max_age
rm *.o


as --gstabs read-record.s -o read-record.o
as --gstabs ret_min_age.s -o ret_min_age.o
ld read-record.o ret_min_age.o -o ret_min_age
rm *.o