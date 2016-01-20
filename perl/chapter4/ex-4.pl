#!/usr/bin/perl
use strict;
use 5.010;

running_sum(5, 6);
running_sum(1..3);
running_sum(4);

sub running_sum {
	state $sum = 0;
	state @numbers;

	foreach my $number (@_) {
		push @numbers, $number;
		$sum += $number;
	}
	say "The sum of (@numbers) is $sum";
}

sub total {
	my $sum = 0;
	foreach my $num (@_) {
		$sum += $num;
	}
	$sum;
}

my @fred = qw{1 3 5 7 9};
my $fred_total = total(@fred);
print "the total of \@fred is $fred_total.\n";
print "Enter some number on separate line: ";
my $user_total = total(<STDIN>);
print "the total of those numbers is $user_total.\n";








