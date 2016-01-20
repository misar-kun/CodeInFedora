#!/usr/bin/perl
use strict;
use 5.010;
use warnings;

my %family_name;
$family_name{'fred'} = 'flintstone';
$family_name{'barney'} = 'rubble';

foreach my $person (qw/barney fred/) {
	print "I've heard of $person $family_name{$person}.\n";
}

my %some_hash = ('foo', 35, 'bar', 12.4, 2.5, 'hello', 
	'wilma', 1.72e30, 'betty', "bye\n");
my @any_arry = %some_hash;
print "@any_arry";

my %new_hash = %some_hash;

my %last_hash = (
	fred => 'flintstone',
	dino => undef,
	barney => 'rubble',
	betty => 'rubble',
	);

my $k = keys %last_hash;
my $v = values %last_hash;
print "\n\n$k and $v\n";

while (my ($key, $value) = each %last_hash) {
	print "$key => $value\n";
}

print "\n\n\n\n";
foreach my $key(sort keys %last_hash) {
	my $value = $last_hash{$key};
	say "$key => $value";
}
