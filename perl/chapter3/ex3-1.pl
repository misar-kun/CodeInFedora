#!/usr/bin/perl

$fred[0] = 'a';
$fred[1] = 'b';
$fred[2] = 'c';
$fred[3] = 'd';

$fred[3] .= "wang\n";
$fred[5] = "aha\n";

#@fred = (1,2,3,4);
#@fred = (3..5);
@freq = qw("liu", "yao", "ai", "keke");
$len = $#fred;
$cnt = 0;
while ($cnt <= $len) {
	print "Fred $cnt is $fred[$cnt]\n";
	$cnt += 1;
}
