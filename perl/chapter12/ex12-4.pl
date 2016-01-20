#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

die "Empyt File List" unless @ARGV;

foreach (@ARGV) {
	say "File is Read and Writeable and wonner is you" if ( -r -w -O );
}
	
