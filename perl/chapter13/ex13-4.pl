#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

foreach (@ARGV) {
	unlink $_ or warn "File delete Failed: $_\n";
}
