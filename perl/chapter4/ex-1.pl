#!/usr/bin/perl

$n = 0;
&marine;
&marine;
&marine;
&marine;
$fred = &marine;
print $fred;

sub marine {
	$n += 1;
	print "Hello, sailor number $n!\n";
	$n + 3;
}
