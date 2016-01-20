#!/usr/bin/perl
use 5.010;
use warnings;
use strict;

$_ = "home, sweet home!";
s/home/cave/g;
say;

$_ = "Inpt   data\t may have        extra whitespace.";
s/\s+/ /g;
say;

my $original = 'Fred ate 1 rib';
my $copy = $original;
$copy =~ s/\d+ ribs?/10 ribs/;
say $copy;
