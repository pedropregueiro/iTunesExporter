package Conf;

use Container;
use Config::General;
use Tie::IxHash;

my $BASE = 'Configuration/';

sub load
{
	my ( $self, %args ) = @_;

	my $path = $BASE . $args{'name'};

	print "loading |$path|...\n";

	my %params = (
		-ConfigFile      => $path,
		-InterPolateVars => 1,
		-IncludeAgain    => 1,
		-UTF8            => 1,
		-Tie             => 'Tie::IxHash',
	);

	my $config = eval { Config::General->new( %params ) };
	tie my %config_data, "Tie::IxHash";
	%config_data = $config->getall;

	return \%config_data;
}
