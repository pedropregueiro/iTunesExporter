#!/usr/bin/perl
use strict;
use warnings;
require './parseXPath.pl';
require './converterXML.pl';


my $numArgs = $#ARGV + 1;
our $input = "";
our $output = "";
our $outputFinal = "";
our %hash = ();

sub usage {
	print "\nusage:\n\tperl iTunesExport.pl <input_file>\n\n";
	exit();
}

if($numArgs==0) {
	usage()
}

main();

sub init {
	$input = $ARGV[0];
	$output = "output/converted.xml";
	$outputFinal = "output/albumList.txt";
	my $dir = 'output';
	unless(-d $dir){
    	mkdir $dir or die;
	}
}

sub convertXML {
	print "converting xml file...\n";
	&convert($input, $output);
	print "file converted!\n";
}


sub createHashMap {
	print "creating hashMap for your music...\n";
	%hash = &createHash($output);
	print "hashMap created!\n";
}


sub createOutput{
	print "creating the output file :: $outputFinal...\n";
	open OUT, ">", $outputFinal or die $!;
	print OUT &printHash(%hash);
}


sub main {
	my $start_run = time();
	init();
	convertXML();
	createHashMap();
	createOutput();
	my $end_run = time();
	my $runtime = $end_run - $start_run;
	print "process completed in $runtime seconds\n";
}

