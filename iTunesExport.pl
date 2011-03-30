#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use lib './modules';
use ParseXPath;

my $numArgs = $#ARGV + 1;
our $input = "";
our $outputTemp = "";
our $outputFinal = "";
our %hash = ();
my $verbose = '';
my $in = '';
my $out = '';

GetOptions ('v|verbose' => \$verbose, 'i|in=s' => \$in, 'o|out=s' => \$out);

if(!$in) {
	usage();
}

if(!$out) {
	$out = "output/albumList.txt";
}

main();

sub usage {
	print "\nusage:\n\tperl iTunesExport.pl -i input_name [-o output_name] [-v | --verbose]\n\n";
	exit();
}

sub init {
	$input = $in;
	$outputFinal = $out;
	$outputTemp = "converted.xml";
}


sub createHashMap {
	print "creating hashMap for your music...\n" if $verbose;
	%hash = createHash($outputTemp);
	print "hashMap created!\n" if $verbose;
}


sub createOutput {
	print "creating the output file :: $outputFinal...\n" if $verbose;
	open OUT, ">", $outputFinal or die $!;
	print OUT printHash(%hash)
}

sub deleteTemp {
	unlink($outputTemp);
}

sub convert {
	print "converting xml file...\n" if $verbose;
	convertXML($input, $outputTemp);
	print "file converted!\n" if $verbose;
}

sub main {
	my $start_run = time();
	init();
	convert();
	createHashMap();
	createOutput();
	deleteTemp($outputTemp);
	my $end_run = time();
	my $runtime = $end_run - $start_run;
	print "process completed in $runtime seconds\n" if $verbose;
}

