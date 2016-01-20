#!/usr/bin/perl
use strict;
use 5.010;
use warnings;

my %hash = ( a => 1, b => 2, c => 3);

my $k = keys %hash;
my $v = values %hash;
print "\n$k and $v\n";

while (my ($key, $value) = each %hash) {
	print "$key => $value\n";
}

print "\n\n";
foreach my $key(sort keys %hash) {
	my $value = $hash{$key};
	say "$key => $value";
}

print "\n\n";

my $misar = "a";
delete $hash{$misar};
if (exists $hash{$misar}) {
	print "Hey, Find One: $hash{$misar}\n";
}


print "PATH is $hash{b}\n";
print "PATH is $ENV{PATH}\n";
print "MISAR is $ENV{MISAR}\n";
print "PATH is $ENV{\"PATH\"}\n";
