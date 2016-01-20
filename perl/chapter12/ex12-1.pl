#!/usr/bin/perl

use warnings;
use strict;
use 5.010;

my $filename = shift @ARGV;

#die "Oops! A file called '$filename' already exists.\n"
#if -e $filename;

say $filename;

print "  Is a TxtFile\n\n" if -T $filename;
my $size_in_K = (-s $filename) / 1000;
print "size_in_K is $size_in_K\n";

if (-r $filename and -w $filename) {
	print "File is read and write \n";
}

if (-r $filename and -w _) {
	print "File is read and write \n";
}

if (-r -w $filename) {
	print "File is read and write \n";
}

my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev,
			$size, $atime, $mtime, $ctime, 
			$blksize, $blocks) = stat($filename);

print "$dev, $ino, $mode, $nlink, $uid, $gid, $rdev,
			$size, $atime, $mtime, $ctime, 
			$blksize, $blocks \n";

my $timestamp = $atime;
my $date = localtime $timestamp;
say $date;

printf "----------\n";
my $time = gmtime;
say $time;

