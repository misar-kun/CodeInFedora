#!/usr/bin/perl 

use strict;
use warnings;
use 5.010;
do 'BasicFunction.pl';

####### BASIC PRINT FUNCTION REALISE #######
sub IsParameterGeNum {
	my $Num = shift @_;
	return 1 if @_ >= $Num;
	say "Parameter Too Few.";
	return 0;
}


####### LOGIC FUNCTION REALISE #######

sub AND {
	&IsParameterGeNum(2, @_) or die "Error Logic Gate <AND/NAND> of \"@_\". Please Check\n";
	my $Xcnt = 0;
	foreach (@_) {
		return 0 if $_ ~~ 0;
		next if $_ ~~ 1;
		if (m/^X$/i) {
			$Xcnt++;
			next;
		}
		die "Parameter Error at Logic Gate <AND/NAND> is $_. Please Check\n";
	}
	return 1 if $Xcnt == 0;
	return 'X';
}

sub NAND {
	my $ANDRet = &AND(@_);
	return 0 if $ANDRet ~~ 1;
	return 1 if $ANDRet ~~ 0;
	return 'X';
}

sub OR {
	&IsParameterGeNum(2, @_) or die "Error Logic Gate <OR/NOR> of \"@_\". Please Check\n";
	my $Xcnt = 0;
	foreach (@_) {
		return 1 if $_ ~~ 1;
		next if $_ ~~ 0;
		if (m/^X$/i) {
			$Xcnt++;
			next;
		}
		die "Parameter Error at Logic Gate <OR/NOR> is @_. Please Check\n";
	}
	return 0 if $Xcnt == 0;
	return 'X';
}

sub NOR {
	my $ORRet = &OR(@_);
	return 0 if $ORRet ~~ 1;
	return 1 if $ORRet ~~ 0;
	return 'X';
}

sub NOT1P {
	&IsParameterGeNum(1, @_) or die "Error Logic Gate <NOT1P> of \"@_\". Please Check\n";
	return 0 if $_[0] ~~ 1;
	return 1 if $_[0] ~~ 0;
	return 'X' if $_[0] =~ m/^X$/i;
	die "Parameter Error at Logic Gate <NOT1P> is @_. Please Check\n";
}
sub NOT {
	my @RetTable;
	push @RetTable, &NOT1P($_) foreach (@_);
	return @RetTable;
}

sub BUFF {
	return @_;
}

sub XOR {
	die "To Much Parameter for Logic Gate <XOR/XNOR> of \"@_\". Please Check\n" if (@_ > 2);
	my $GateTmp1 = &OR(@_);
	my $GateTmp2 = &NAND(@_);
	return &AND($GateTmp1, $GateTmp2);
}

sub XNOR {
	return (1 - &XNOR(@_));
}

####### Basic Combinational Logic Circuit #######
sub HalfAdder {
	#Input: (A, B)
	#Output: (Carry, Sum)
	my @RetTable;
	push @RetTable, &AND(@_);
	push @RetTable, &XOR(@_);
	return @RetTable;
}

sub FullAdder {
	#Input: (A, B, CarryIn)
	#Output: (CarryOut, Sum)
	my($A, $B, $CarryIn) = @_;
	my ($HalfAdderCarry1, $HalfAdderSum) = &HalfAdder($A, $B);
	my ($HalfAdderCarry2, $Sum) = &HalfAdder($HalfAdderSum, $CarryIn);
	my $CarryOut = &OR($HalfAdderCarry1, $HalfAdderCarry2);
	return ($CarryOut, $Sum);
}

sub Add {
	#Input: (@A, @B, $CarryIn)
	#Output: ($CarryOut, @Sum)
	#Note: length(A) = length(B)
	my ($Carry, $Sum) = (pop @_, 0);
	my $SplitLocation = @_ / 2;
	my @AdderB = splice @_, $SplitLocation;
	my @AdderA = @_;
	my @AdderRet;
	for (1..$SplitLocation) {
		($Carry, $Sum) = &FullAdder(pop @AdderA, pop @AdderB, $Carry);
		unshift @AdderRet, $Sum;
	}
	unshift @AdderRet, $Carry;
	return @AdderRet;
}

	 
####### Basic Sequential Logic Circuit #######
sub RS_FlipFlop {
#Input: (R S Q)
#Output: (Q NotQ)
	&IsParameterGeNum(3, @_) or die "Error Logic Triger <RS> of \"@_\". Please Check\n";
	my ($R, $S, $Q) = @_;
	if (1 == @ClkTab) {
		@ClkTab = qw/0 0/ if (0 == ($ClkTab[0] % 4));
		@ClkTab = qw/0 1/ if (1 == ($ClkTab[0] % 4));
		@ClkTab = qw/1 1/ if (2 == ($ClkTab[0] % 4));
		@ClkTab = qw/1 0/ if (3 == ($ClkTab[0] % 4));
	}

	my @QOld = ($Q, &NOT1P($Q));
	for (0..9)
	{
		my @QNew = (&NOR($R, $QOld[1]), &NOR($S, $QOld[0]));
		return @QNew if @QOld ~~ @QNew;
		@QOld = @QNew;
	}
	die "Triger Loop Failed. \@RS_Triger with input \"@_\". Please Check\n";
	return qw /X X/;
}

sub D_FlipFlop {
#Input: (D Q @Clk)	#@Clk could use dec2bin(0-3, 2)
#Output: (Q NotQ)
	my ($D, $Q, @ClkTab) = @_;
	if (1 == @ClkTab) {
		@ClkTab = qw/0 0/ if (0 == ($ClkTab[0] % 4));
		@ClkTab = qw/0 1/ if (1 == ($ClkTab[0] % 4));
		@ClkTab = qw/1 1/ if (2 == ($ClkTab[0] % 4));
		@ClkTab = qw/1 0/ if (3 == ($ClkTab[0] % 4));
	}
	
	my ($q1, $nq1) = ($Q, &NOT1P($Q));	#Get Form last Q State
						#Even Changed, It's Means Pre State
	my ($q2, $nq2) = ($Q, &NOT1P($Q));
	foreach my $Clk (@ClkTab) {
		my ($b, $a) = (&AND($D, &NOT1P($Clk)), &AND(&NOT1P($D), &NOT1P($Clk)));
		($q1, $nq1) = &RS_FlipFlop($a, $b, $q1);
		my ($c, $d) = (&AND($nq1, $Clk), &AND($q1, $Clk));
		($q2, $nq2) = &RS_FlipFlop($c, $d, $q2);
	}
	return ($q2, $nq2);
}

######## TEST FUNCTION #######
#my @Test1 = qw /1 1/;
#my @Test2 = qw /0 0/;
#my @Test3 = qw /0 1/;
#my @Test4 = qw /a b/;
#
#my $LogicRet;
#my @Test;
#
#say "--- AND TEST ---";
#@Test = @Test1;
#$LogicRet = &AND(@Test);
#say "@Test is $LogicRet";
#@Test = @Test2;
#$LogicRet = &AND(@Test);
#say "@Test is $LogicRet";
#@Test = @Test3;
#$LogicRet = &AND(@Test);
#say "@Test is $LogicRet";
##@Test = @Test4;
##$LogicRet = &AND(@Test);
##say "@Test is $LogicRet";
#
#say "--- NAND TEST ---";
#@Test = @Test1;
#$LogicRet = &NAND(@Test);
#say "@Test is $LogicRet";
#@Test = @Test2;
#$LogicRet = &NAND(@Test);
#say "@Test is $LogicRet";
#@Test = @Test3;
#$LogicRet = &NAND(@Test);
#say "@Test is $LogicRet";
##@Test = @Test4;
##$LogicRet = &NAND(@Test);
##say "@Test is $LogicRet";
#
#say "--- OR TEST ---";
#@Test = @Test1;
#$LogicRet = &OR(@Test);
#say "@Test is $LogicRet";
#@Test = @Test2;
#$LogicRet = &OR(@Test);
#say "@Test is $LogicRet";
#@Test = @Test3;
#$LogicRet = &OR(@Test);
#say "@Test is $LogicRet";
##@Test = @Test4;
##$LogicRet = &OR(@Test);
##say "@Test is $LogicRet";
#
#say "--- NOR TEST ---";
#@Test = @Test1;
#$LogicRet = &NOR(@Test);
#say "@Test is $LogicRet";
#@Test = @Test2;
#$LogicRet = &NOR(@Test);
#say "@Test is $LogicRet";
#@Test = @Test3;
#$LogicRet = &NOR(@Test);
#say "@Test is $LogicRet";
##@Test = @Test4;
##$LogicRet = &NOR(@Test);
##say "@Test is $LogicRet";
