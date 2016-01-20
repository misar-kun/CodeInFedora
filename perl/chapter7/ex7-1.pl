#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

#while (<>) {
#	if (/[fF]red/) {
#		print $_;
#	}
#}

#while (<>) {
#	if (/./) {
#		print $_;
#	}
#}

while (<>) {
	if (/(wilma)+.*(fred)+ |(fred)+.*(wilma)+/) {
		print $_;
	}
}
