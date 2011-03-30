#!/usr/bin/perl

#class Album
package Album;
use strict;
use warnings;

#constructor
sub new {
	my $class = shift;
	my $self = {
		_name => shift,
		_noTracks =>shift,
	};
	print "Name is $self->{_name}\n";
	bless $self, $class;
	return $self;
}

sub getName {
	my ( $self, $name) = @_;
	$self->{_name} = $name if defined($name);
	return $self->{_name};
}

1;