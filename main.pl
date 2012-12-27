
use strict;
use warnings;

use Getopt::Long;

use Framework;

my $input = '';
my $output = '';

GetOptions ('i|in=s' => \$input, 'o|out=s' => \$output) or die $!;

my $worker = Framework->new();
$worker->initialize( input => $input, output => $output );
$worker->process();

