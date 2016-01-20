#!/usr/bin/perl
#use diagnostics;

$endl = "\n"x2;
#$alef = chr(0x05D0);
$alpha = chr(hex('03b1'));
$omega = chr(0x03C9);
$code_point = ord('?');

#print "$alpha$omega".$endl;
#print "$code_point and \x{03B1}\x{03C9}".$endl;
print 4**3 + 3 . $endl;

print 35 != 5*7 . $endl;

$wyy = "wang";
if ($wyy eq "wang" )
{
	print "aiyaomei\n";
}
else
{
	print "gengai \n";
}

