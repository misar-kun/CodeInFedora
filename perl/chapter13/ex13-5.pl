#!/usr/bin/perl 
use strict;
use warnings;
use 5.010;

my ($name1, $name2) = @ARGV;

die "No Argument!\n" unless defined($name2);
die "Source File Not Exist!\n" unless -e $name1;
rename $name1, $name2 unless -e $name2;

if (-d $name2) {
	$name1 =~ m{(.*/)?(?<basename>.+)$};
	my $basename = $+{basename};
	$name2 =~ s{/$}{};
	my $destname = $name2 . "/" . $basename;
	rename $name1, $destname;
#	unlink $name1;
}
	
