package Music::Track;

use Container;
use utf8;


sub parse
{
	my ( $self, $args ) = @_;

	if( !$self->{_config} )
	{
		$self->_load_config();
	}

	my $item = $args->{'key'};
	my %track = ();

	my %params = %{ $self->{_config}->{track}->{parameters} };

	for my $key ( keys %params )
	{
		my ( $field ) = keys %{ $params{$key}};
		$field =~ s~\s+~~s;
		$track{$field} = $item->{$key}->{content};
	}

	
	return \%track;
}


sub _load_config 
{
	my ( $self, %args ) = @_;
	my $config = Conf->load( name => '/music/track.conf' );
	$self->{_config} = $config;
}


1;
__END__