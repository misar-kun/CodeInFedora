#!/usr/bin/perl 

use strict;
use warnings;
use 5.010;

### Function bin2dec Realise ###
sub bin2dec {
	my $SignFlag = $_[-1];
	if ($SignFlag =~ m/^u$/i) {
		pop @_;
		$SignFlag = 0;
	} elsif ($SignFlag =~ m/^s$/i) {
		pop @_;
		$SignFlag = 1;
	} else {
		$SignFlag = 0;
	}
	
	my $Value = 0;
	$Value = $Value * 2 + $_ foreach (@_);
	$Value -= (1 << @_) if $SignFlag;
	return $Value;
}

### Function dec2bin Realise ###
sub dec2bin {
	return &dec2bin_positive(@_) if ($_[0] >= 0) ;
	my $DecVal = -1 * shift @_;
	my $BinNum = shift @_;
	unless (defined($BinNum) and ($BinNum >= 0) and ((1 << ($BinNum - 1)) > $DecVal))
	{
		$BinNum = 1;
		$BinNum++ while ((1 << ($BinNum - 1)) <= $DecVal);
	}
	my $ConvertVal = (1 << $BinNum) - $DecVal;
	return &dec2bin_positive($ConvertVal, $BinNum);
}

sub dec2bin_positive {
	my @RetTable;
	my $DecVal = shift @_;
	my $BinNum = shift @_;

	my $WtNum = 0;
	while ($DecVal > 0 || (defined($BinNum) and ($WtNum < $BinNum))) {
	      unshift @RetTable, ($DecVal % 2);
	      $DecVal = $DecVal >> 1;
	      $WtNum++;
	}
	return @RetTable;
}

#my @ConvertAns = &dec2bin(10, 8);
#say "@ConvertAns";
#@ConvertAns = &dec2bin(10, -8);
#say "@ConvertAns";
#@ConvertAns = &dec2bin(10);
#say "@ConvertAns";
#@ConvertAns = &dec2bin(-10, 8);
#say "@ConvertAns";
#@ConvertAns = &dec2bin(-10);
#say "@ConvertAns";
#@ConvertAns = &dec2bin(-10, -8);
#say "@ConvertAns";
