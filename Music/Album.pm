package Music::Album;

use Data::Dumper;

sub test
{
	print "test!\n";
}

sub new {

	my ( $self, %args ) = @_;

	my $class = shift;
	my $self = {
		_name => shift,
		_noTracks =>shift,
	};
	print "Name is $self->{_name}\n";
	bless $self, $class;
	return $self;
}


sub get_name {
	my ( $self, %args ) = @_;
	return $self->{_name};
}

1;
__END__