#!/usr/bin/perl

#class Album
package Album
use strict;
use warnings;

#constructor
sub new {
	my ($class) = @_;
	my $self = {
		_name => undef,
		_noTracks =>undef
	};
	bless $self, $class;
	return $self;
}

sub getName {
	my ( $self, $name) = @_;
	$self->{_name} = $name if defined($name);
	return $self->{_name};
}

