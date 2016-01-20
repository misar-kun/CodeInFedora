#!/usr/bin/perl
use 5.010;
use warnings;
use strict;

my $some_other = "I dream of betty rubble.";
if ($some_other =~ /\brub/) {
	print "Aye, there's the rub.\n";
}

$_ = "Hello there, neighbor";
if (/\s([a-zA-Z]+),/) {
	print "the word was $1\n";
}

if (/(\S+) (\S+), (\S+)/) {
	print "the word was $1 $3 $2\n";
}
