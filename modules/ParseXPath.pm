#!/usr/bin/perl
package ParseXPath;

use strict;
use warnings;
use base 'Exporter';
use XML::XPath;
use XML::XPath::XMLParser;
use Encode;
use Track;
use Album;

our @EXPORT = qw(convertXML printHash createHash);
our %hashMap = ();

## teste printTracks...
my $testeInput = "../input/music.xml";
my @params = ("Artist", "Album");
printTracks($testeInput, @params);

sub printTracks {

	my $input = shift;
	my @params = @_;

	convertXML($input,"teste.xml");
	my @tracks = fillList("teste.xml");
	foreach my $param (@params) {
		print "PARAM :: $param\n";
	}
	
	foreach my $track (@tracks) {
		#print "$track->{_artist}\n";
		
		my @results = $track->getAttributes("_name", "_artist");
		print "_name\t\t_artist\n";
		foreach my $result (@results) {
			#print $result;
			#print split(";", $result);
			foreach my $value (split(";", $result)) {
				print $value . " -- ";
			}
				
		}
		print "\n";
		#print $track->id() . "\n";

	}

	#unlink("teste.xml");
}


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

sub fillList {
	my @list=();
	my $input = shift;
	my $xp = XML::XPath->new(filename => $input);
	#foreach track
	foreach my $dict ($xp->find('/plist/dict/dict/dict')->get_nodelist) {	
		push(@list, fillTrack($dict));
	}
	return @list;
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

sub convertXML {
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