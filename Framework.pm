package Framework;

use Container;
use XML::XMLConverter;

sub new
{
	my ($self, %args) = @_;
	return $self;
}

sub initialize
{
	my ( $self, %args ) = @_;

	$self->{_input} = $args{input};
	$self->{_output} = $args{output};

	# TODO: change this into some default behaviour
	my $tmp_input = '/tmp/tmp_input.xml';

	open my $fi, "<", $self->{_input} or die $!;
	open my $fo, ">", $tmp_input or die $!;
	while( <$fi> ) {
		s/<key>(.+?)<\/key><(.+?)>(.+?)<\/.+/<key id="$1" type="$2">$3<\/key>/g;
		print $fo $_;
	}
	close $fi;
	close $fo;

	$self->{_input} = $tmp_input;
}

sub process
{
	my ( $self, %args ) = @_;
	my $file 	= $self->{_input};

	print "converting |$file|...\n";

	XML::XMLConverter->convert(
		file 	=> $self->{_input},
		handler => 'dict/dict/dict'
	);
}



1;
__END__