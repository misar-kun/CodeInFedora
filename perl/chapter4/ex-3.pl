#!/usr/bin/perl
use strict;
use 5.010;

my($x) = 3;
my($y) = 9;
print &list_from_a_to_b(3, 9);
print "\n";
print &list_from_a_to_b(23, 9);
print "\n";

sub list_from_a_to_b {
	my($a, $b) = @_;
	if ($a < $b) {
		$a..$b;
	} else {
		reverse $b..$a;
	}
}
		
my($n) = 3;
&marine;
&marine;
&marine;
&marine;
sub marine {
	state $n = 0;
	$n += 1;
	print "Hello, sailr num $n!\n";
}
