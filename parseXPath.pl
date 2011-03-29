#!/usr/bin/perl

use strict;
use warnings;
use XML::XPath;
use XML::XPath::XMLParser;
use Encode;
use Album;
use Track;

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

sub findAttribute {
	my $dict = shift;
	my $attrib = shift;
	return $dict->find('key[@id="' . $attrib . '"]')->string_value;
}

sub fillTrack {
	
	my $dict = shift;
	my $track = new Track();
	
	my $trackId = findAttribute($dict,"Track ID");
	my $trackName = findAttribute($dict,"Name");
	my $artist = findAttribute($dict, "Artist");
	my $album = findAttribute($dict, "Album");
	my $genre = findAttribute($dict, "Genre");
	my $totalTime = findAttribute($dict, "Total Time");
	my $trackNumber = findAttribute($dict, "Track Number");
	my $playCount = findAttribute($dict, "Play Count");
	my $rating = findAttribute($dict, "Rating");
	$track = new Track($trackId, $trackName, $artist, $album, $genre, $totalTime, $trackNumber, $playCount, $rating);

	# debug purpose only
	#$track->printTrackInfo();
	
	return $track;
}

sub fillList {
	my @list=();
	my $input = shift;
	#my $input = "output/converted.xml";
	my $xp = XML::XPath->new(filename => $input);

	#foreach track
	foreach my $dict ($xp->find('/plist/dict/dict/dict')->get_nodelist) {	
		push(@list, fillTrack($dict));
	}
	return @list;
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