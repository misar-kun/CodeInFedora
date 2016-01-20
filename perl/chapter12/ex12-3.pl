#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

die "No Input Files!" unless @ARGV;

#$_ = shift @ARGV;
#my $OldTime = -C;
#my $OldName = $_;

#my $CurrentFileTime;
#foreach (@ARGV) {
#	$CurrentFileTime = -C $_;
#	if ($CurrentFileTime > $OldTime) {
#		$OldTime = $CurrentFileTime;
#		$OldName = $_;
#	}
#}
#
#say "The File Name is $OldName and Time is $OldTime";
my $OldName = shift @ARGV;
my $OldTime = -M $OldName;

foreach (@ARGV) {
	my $age = -M;
	($OldName, $OldTime) = ($_, $age) if ($age > $OldTime);
}
printf "FileName is %s and Time is %.1f ago\n", $OldName, $OldTime;

