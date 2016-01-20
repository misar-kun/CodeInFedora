#!/usr/bin/perl 

use strict;
use warnings;
use 5.010;
do 'BasicLogicGate.pl';
do 'BasicFunction.pl';

sub D_FlipFlop_SetResetbak {
#Input: (Pre Clr D Q @Clk)
#Output: (Q NotQ)
	my ($Pre, $Clr, $D, $Q, @ClkTab) = @_;
	my ($q1, $nq1) = ($Q, &NOT1P($Q));
	my @RetQTab = ($Q, &NOT1P($Q));
	my ($q2, $q3, $nq2, $nq3);
	say "$ClkTab[0], $ClkTab[1]";
	foreach $_ (@ClkTab) {
		say "$_";
		my $Clk = &NOT1P($_);
		for (0..9) {
			($q2, $nq2) = &RS_FlipFlop(&OR($nq1, $Clk), $D, $q1);
			($q3, $nq3) = &RS_FlipFlop($nq2, $Clk, $nq3);
			last if ($q1 ~~ $q2 and  $nq1 ~~ $nq3);
			($q1, $nq1) = ($q2, $nq3);
		}
		die "Triger Loop Failed. \@D_FlipFlop_SetReset with input \"@_\". Please Check\n"
			if $_ > 8;

		@RetQTab = &RS_FlipFlop($nq1, $q1, $RetQTab[0]);
		say "$nq1, $q1, $RetQTab[0]";
	}
	say "@RetQTab";
	return @RetQTab;
}
sub D_FlipFlop_SetReset {
#Input: (Pre Clr D Q @Clk)
#Output: (Q NotQ)
	my ($Pre, $Clr, $D, $Q, @ClkTab) = @_;
	my ($q1, $nq1) = ($Q, &NOT1P($Q));
	my @RetQTab = ($Q, &NOT1P($Q));
	my ($q2, $q3, $nq2, $nq3);
	foreach (@ClkTab) {
		my $Clk = &NOT1P($_);
		for (0..9) {
			($q2, $nq2) = &RS_FlipFlop(&OR($nq1, $Clk), $D, $q1);
			$q3 = &NOR($nq1, $nq2);
			($q3, $nq3) = &RS_FlipFlop($nq2, $Clk, $q3);
			last if ($q1 ~~ $q2 and  $nq1 ~~ $nq3);
			($q1, $nq1) = ($q2, $nq3);
		}
		die "Triger Loop Failed. \@D_FlipFlop_SetReset with input \"@_\". Please Check\n"
			if $_ > 8;

		@RetQTab = &RS_FlipFlop($nq1, $q1, $RetQTab[0]);
#say "$nq1, $q1, $RetQTab[0]";
	}
	return @RetQTab;
}

my @Input;
my @Ans;
@Input = qw/0 0 1 1 0 1/;
@Ans = &D_FlipFlop_SetReset(@Input);
say "@Input <-> @Ans";
@Input = qw/0 0 1 0 0 1/;
@Ans = &D_FlipFlop_SetReset(@Input);
say "@Input <-> @Ans";
@Input = qw/0 0 1 0 1 1/;
@Ans = &D_FlipFlop_SetReset(@Input);
say "@Input <-> @Ans";
@Input = qw/0 0 1 0 0 0/;
@Ans = &D_FlipFlop_SetReset(@Input);
say "@Input <-> @Ans";
@Input = qw/0 0 1 0 1 0/;
@Ans = &D_FlipFlop_SetReset(@Input);
say "@Input <-> @Ans";
@Input = qw/0 0 0 1 0 1/;
@Ans = &D_FlipFlop_SetReset(@Input);
say "@Input <-> @Ans";

say "__----___--_-__-__";

say "-----------------";
my @A = qw /1 1 1/;
my @RsRet = &RS_FlipFlop(@A);
say "@RsRet";

say "-----------------";
for (0..15) {
	my @Input = &dec2bin($_, 4);
	my @Output = &D_FlipFlop(@Input);
	say "$Input[0] $Input[1] : $Input[2] $Input[3] : <--> @Output"
		unless ($Input[1] ~~ $Output[0]);
}

say "-----------------";
my @Input1 = &dec2bin(-37, 10);
my @Input2 = &dec2bin(-237, 10);
my @Ret = &Add(@Input1, @Input2);
say "@Ret";
my $RetVal = &bin2dec(@Ret, 's');
say $RetVal;
