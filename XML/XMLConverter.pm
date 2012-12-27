package XML::XMLConverter;

use Container;

use XML::Twig;
use Music::Track;

sub convert
{
	my ( $self, %args ) = @_;

	my $handler = $args{'handler'};
	my $file 	= $args{'file'};

	my $twig = XML::Twig->new(
		twig_handlers => {
			$handler => sub {
				my ($twig, $section) = @_;

				print "converting track...\n";
				# update counter with returned value from processing function
				
				my $ad = $self->_convert_track($twig, $section, \$counter);

				$counter++;

				if ($@) {
					print "Error processing ad: $@\n";
					return 1;
				}

				$section->purge;
				
				1;
			}
		},
	);

	# start processing $file
	$twig->parsefile( $file );

	# flush leftovers from RAM
	$twig->purge;
}


sub _convert_track
{
	my ($self, $twig, $section, $counter) = @_;
	my $item = $section->simplify;

	my $track = Music::Track->parse( $item );

	print Dumper $track;

}


1;
__END__