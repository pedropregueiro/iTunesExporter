#!/usr/bin/perl

#class Track
package Track;
use strict;
use warnings;

#constructor
sub new {
	my $class = shift;
	my $self = {
		_id => shift,
		_name =>shift,
		_artist =>shift,
		_album =>shift,
		_genre =>shift,
		_totalTime =>shift,
		_trackNumber =>shift,
		_playCount =>shift,
		_rating => shift,		
	};
	bless $self, $class;
	return $self;
}

sub getName {
	my ( $self, $name) = @_;
	$self->{_name} = $name if defined($name);
	return $self->{_name};
}

sub printTrackInfo{
	my ( $self ) = @_;
	print "---------------------\n";
	print "ID :: $self->{_id}\n";
	print "Name :: $self->{_name}\n";
	print "Artist :: $self->{_artist}\n";
	print "Album :: $self->{_album}\n";
	print "Genre :: $self->{_genre}\n";
	print "Total Time :: $self->{_totalTime}\n";
	print "Track Number :: $self->{_trackNumber}\n";
	print "Play Count :: $self->{_playCount}\n";
	print "Rating :: $self->{_rating}\n";
	print "---------------------\n";
}

1;