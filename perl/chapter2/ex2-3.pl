#!/usr/bin/perl
use diagnostics;

$name = 17;
$ly = "Liu Yao\n";

print $name;
print $name . $ly;
print $name + 5;


$wyy = $name + 5;
$wyy += 10;
print "  ".$wyy;

$biaobai = "\uwang \uyangyun";
$biaobai .= " Love ";
$biaobai .= "\uliu \uyao";
print "\n".$biaobai."\n";

print "\n"x3;

$meal = "bron break";
print "$meal" . " and eat " . $meal;
$endl = "\n"x3;
print "\$meal" . " and eat " . $meal.$endl;

$n = 3;
$what = "steak";
print "fread ate $n ${what}s.\n";
