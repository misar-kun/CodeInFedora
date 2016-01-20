#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

my $UsrDir = shift @ARGV;
if (defined $UsrDir) {
	chdir $UsrDir or die "Cannot Chdir to $UsrDir: $!";
} else {
	chdir;
}

my @filelist = glob "* .*";
foreach (sort @filelist) {
#next if /^\./;
	say "$_";
}

say "\n\n\n\n";
opendir my $fp, "." or die "Cannot open dir: $!";

my @liuyao = readdir $fp;
foreach (sort @liuyao) {
	next if /^\./;
	say "$_";
}
