#!/usr/bin/perl
use warnings;
use 5.010;
use strict;

foreach my $filename (@ARGV) {
#	say $filename;
	&FileNameCheck($filename);
}

sub FileNameCheck {
	my $FileName = $_[0];
	if (-e $FileName) {
		say "$FileName is Exist";
		say "$FileName is Readable" if -R $FileName;
		say "$FileName is Writeable" if -W $FileName;
		say "$FileName is Executeable" if -X $FileName;
	} else {
		say "$FileName is Not Exist";
	} 
}
