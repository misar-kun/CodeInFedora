#!/usr/bin/perl 
use strict;
use warnings;
use 5.010;

chdir '/etc' or die "Cannot chdir to /etc: $!";
my @FileList = glob "*.conf *.d";
foreach (@FileList) {
	say "$_";
}

my $dir_to_process = "/home/misar";
chdir $dir_to_process or die "Failed chdir to $dir_to_process: $!";

opendir my $dh, $dir_to_process or die "Cannot open $dir_to_process: $!";
foreach my $file (readdir $dh) {
	next if $file =~ /^\./;
	say "one file in $dir_to_process is $dir_to_process/$file";
}
