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

sub id {
	my $self = shift;
	if(@_) {
		$self->{_id} = shift;
		return $self;
	} else {
		return $self->{_id};
	}
}

sub name {
	my $self = shift;
	if(@_) {
		$self->{_name} = shift;
		return $self;
	} else {
		return $self->{_name};
	}
}


sub artist {
	my $self = shift;
	if(@_) {
		$self->{_artist} = shift;
		return $self;
	} else {
		return $self->{_artist};
	}
}


sub album {
	my $self = shift;
	if(@_) {
		$self->{_album} = shift;
		return $self;
	} else {
		return $self->{_album};
	}
}

sub genre {
	my $self = shift;
	if(@_) {
		$self->{_genre} = shift;
		return $self;
	} else {
		return $self->{_genre};
	}
}

sub totalTime {
	my $self = shift;
	if(@_) {
		$self->{_totalTime} = shift;
		return $self;
	} else {
		return $self->{_totalTime};
	}
}

sub trackNumber {
	my $self = shift;
	if(@_) {
		$self->{_trackNumber} = shift;
		return $self;
	} else {
		return $self->{_trackNumber};
	}
}

sub playCount {
	my $self = shift;
	if(@_) {
		$self->{_playCount} = shift;
		return $self;
	} else {
		return $self->{_playCount};
	}
}

sub rating {
	my $self = shift;
	if(@_) {
		$self->{_rating} = shift;
		return $self;
	} else {
		return $self->{_rating};
	}
}

sub getAttributes(@_) {

	my $self = shift;
	return map { $self->{$_} . ";" } @_;

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