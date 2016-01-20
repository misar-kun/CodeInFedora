#!/usr/bin/perl 
use strict;
use warnings;
use 5.010;
use File::Spec::Functions;


my $dir_to_process = "/home/misar";
chdir $dir_to_process or die "Failed chdir to $dir_to_process: $!";

opendir my $dh, $dir_to_process or die "Cannot open $dir_to_process: $!";
foreach my $file (readdir $dh) {
	next if $file =~ /^\./;
	my $name = catfile($dir_to_process, $file);

	say "$name";
}
closedir $dh;

chdir '/home/misar/hack/perl/chapter13/';
foreach my $file (glob '*') {
	next if $file =~ /^\./;
	say "$file";
}

my $delnum = unlink glob 'bad*';
print "delete num is $delnum \n";

