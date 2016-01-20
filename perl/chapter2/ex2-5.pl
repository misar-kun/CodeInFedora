#!/usr/bin/perl

$wyy = "wang ang";
$is_equal = "wang" eq $wyy;
if ($is_equal) {
	print "ai yaomei\n";
}
else {
	print "geng ai\n";
}

if (!$is_equal) {
	print "ai yaomei\n";
}
else {
	print "geng ai\n";
}

$still_true = !! 'Fred';
$still_faile = !! '0';

print "$still_true and $still_faile \n";

$line = <STDIN>;
if ($line eq "\n") {
	print "That was just a blank line!\n";
}
else {
	print "That line of input was: \"$line\"\n";
}

$text = "a line new line \n jiushijiushi";
print $text;
chomp($text);
print ($text);
