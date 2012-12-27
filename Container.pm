package Container;

use strict;
use lib '/iTunesExport';
use base 'Exporter';
use Data::Dumper qw();
our @EXPORT = qw( Dumper );
use utf8;

use Conf;


sub Dumper
{
	&Data::Dumper::Dumper
}

1;
__END__