#!/usr/bin/perl

use strict;
use warnings;
use XML::XPath;
use XML::XPath::XMLParser;
use Encode;

our %hashMap = ();

# sort method - alphabetically
sub artistNameAscends {
	$hashMap{$a} cmp $hashMap{$b};
}

sub printHash {
	my $whole = "";
	foreach my $album ( sort artistNameAscends (keys %hashMap) ) {
		my $line = "$hashMap{$album} - $album\n"; 
		$whole = $whole . decode_utf8($line);
	}
	return $whole;
}

sub createHash {
	my $input = shift;
	my $xp = XML::XPath->new(filename => $input);
	foreach my $dict ($xp->find('/plist/dict/dict/dict')->get_nodelist) {	
		my $hashKey = $dict->find('key[@id="Album"]')->string_value;
		my $hashValue = $dict->find('key[@id="Artist"]')->string_value;
		$hashMap{$hashKey} = $hashValue;
	}
	return %hashMap;
}

1;