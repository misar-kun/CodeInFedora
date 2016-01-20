#!/usr/bin/perl

$liuyao = "meimeida";
@fred = qw!"liu", "yao", "ai", "keke"!;
@fred = (@fred, 34, 9, $liuyao);
$keke = pop @fred;
push @fred, "good";
push @fred, $keke;
$len = $#fred;
$cnt = 0;
while ($cnt <= $len) {
	print "Fred $cnt is $fred[$cnt]\n";
	$cnt += 1;
}


