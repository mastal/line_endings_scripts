#!/usr/bin/perl -w

# replaceOldMacCR.pl
# Maria Stalteri
# Dec. 09, 2011

# old Mac (pre-OS X)-to-Unix/Linux converter;
# replaces end-of-line \r with \n in files presumably produced 
# by old Mac OS versions prior to OS X


use strict;

# check that program has been called with right number of parameters

if (2 != scalar(@ARGV)){
    die "Usage $0: 
         file to read, with old Mac OS line endings (CR),
         file to write output to, with Unix/Linux line endings (newline).\n";
}

my $macFile = $ARGV[0];
my $unixFile = $ARGV[1];

# check that output file doesn't already exist
if (-e $unixFile){
    die "Output file $unixFile already exists.\n";
}

# open filehandle for printing
open(OUT, ">$unixFile")
    or die "Unable to open output file $unixFile.\n";


# change line input separator to \r
$/ = "\r";

# open filehandle for reading
open(IN, "<$macFile")
    or die "Unable to open old Mac format input file, $macFile.\n";


# read in the files with \r as end-of-line character
while (my $line = <IN>){
   # change \r to \n 
   $line =~ s/\r/\n/;
   print OUT $line; 

}

# reset the line input separator back to the default setting
$/ = "\n";

# close filehandles
close(IN)
    or die "Unable to close old Mac format input file $macFile.\n";


close(OUT)
    or die "Unable to close Unix/Linux format output file $unixFile.\n";

