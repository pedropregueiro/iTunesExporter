#!/usr/bin/perl

use strict;
use warnings;


sub convert {
	my $input = shift;
	my $output = shift;
	
	open IN, "<", $input or die $!;
	open OUT, ">", $output or die $!;

	while(<IN>) {
		s/<key>(.+?)<\/key><(.+?)>(.+?)<\/.+/<key id="$1" type="$2">$3<\/key>/g;
		print OUT $_;
	}

	close IN;
	close OUT;
	
}

1;