#!/usr/bin/perl

$endl = "\n"x5;
chomp($text = <STDIN>);
print "Input Str is: \"$text\"\n";

$count = 0;
while ($count < 10) { 
	$count += 2;
	print "count is now $count\n";
}

$n = 1;
while ($n < 10) {
	$sum += $n;
	$n += 2;
}
print "the total was $sum.\n";

$madonna = <STDIN>;
chomp($madonna);
$madonna = ord($madonna);
if (defined($madonna)) {
	print "The input was $madonna\n";
} else {
	print "No intput avaliable!\n";
}
