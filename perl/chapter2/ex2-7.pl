#!/usr/bin/perl

$endl = "\n"x3;
# exercise 1
$pi = 3.141592654;
$r = 12.5;
$d = 2 * $r * $pi;
print $d . $endl;

# exercise 2
$pi = 3.141592654;
print "Input the r:";
chomp($r = <STDIN>);
if ($r < 0) {
	$d = 0;
} else {
	$d = 2 * $r * $pi;
}

print $d . $endl;
