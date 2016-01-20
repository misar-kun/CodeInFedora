#!/usr/bin/perl
use strict;

my $n = 4;

$n = &max(3, 6, 80);
print $n . "\n";

$n = &max2(3, 16, 80);
print $n . "\n";

$n = &max3(3, 16, 80);
print $n . "\n";


foreach (1..10) {
	my($squre) = $_ * $_;
	print "Squre of $_ is $squre\n";
}

foreach my $rock (qw /bderock slate lava/) {
	print "One rock is $rock.\n";
}

sub max {
	if ($_[0] > $_[1]) {
	      $_[0]
	} else {
	      $_[1]
	}
}

sub max2 {
	my($m, $n) = @_;
	if ($m > $n)
	{ $m } else { $n }
}

sub max3 {
	my($max_so_far) = unshift @_;
	foreach (@_) {
		if ($_ > $max_so_far) {
			$max_so_far = $_;
		}
	}
	$max_so_far;
}
