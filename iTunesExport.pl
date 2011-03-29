#!/usr/bin/perl

use strict;
use warnings;

require './xpath_test.pl';
require './convert_xml.pl';

my $numArgs = $#ARGV + 1;

sub usage {
	print "\nusage:\n\tperl iTunesExport.pl <input_file>\n\n";
	exit();
}

if($numArgs==0) {
	usage()
}

my $input = $ARGV[0];
my $output = "output/converted.xml";
my $outputFinal = "output/albumList.txt";

my $dir = 'output';

unless(-d $dir){
    mkdir $dir or die;
}

my $start_run = time();
print "converting xml file...\n";
&convert($input, $output);
print "file converted!\n";


print "creating hashMap for your music...\n";
my %hash = &createHash($output);
print "hashMap created!\n";

print "creating the output file :: $outputFinal...\n";
open OUT, ">", $outputFinal or die $!;
print OUT &printHash(%hash);

my $end_run = time();
my $runtime = $end_run - $start_run;
print "process completed in $runtime seconds\n";
