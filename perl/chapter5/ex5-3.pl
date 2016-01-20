#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

#==== exercise 5.1 ====
#my %NameHash = (fred => 'flintstone', barney => 'rubble', wilma => 'fintstone');
#
#while (my $in = <STDIN>) {
#	chomp $in;
#	if (exists $NameHash{$in}) {
#		print "fine name is $NameHash{$in}\n";
#	}
#}

#==== exercise 5.1 ====
#open FILEIN, '<', "$ARGV[1]";
my %Hash1;
while (defined (my $in = <>)) {
	chomp $in;
	$Hash1{$in} += 1;
}
foreach my $mykey (sort keys %Hash1) {
	say "$mykey appared $Hash1{$mykey} times";
}

print "\n\n\n";
my $maxlen = 0;
foreach my $myenv (keys %ENV) {
	my $varlen = length $myenv;
	$maxlen = $varlen if $varlen > $maxlen;
}
say "Length is $maxlen";

foreach my $myenv (sort keys %ENV) {
	printf "%-" . ($maxlen+5) . "s%-s\n", $myenv, $ENV{$myenv};
}

