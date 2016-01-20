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

as --gstabs MyAssemble.s -o a.out
ld a.out -o exec
rm a.out
./exec
echo $?

