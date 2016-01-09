#!/usr/bin/perl -w

# win2unixLF.pl
# Maria Stalteri
# Dec. 09, 2011

# MS 14/08/2014
# adapted from replaceOldMacCR.pl

# old Mac (pre-OS X)-to-Unix/Linux converter;
# replaces end-of-line \r with \n in files presumably produced 
# by old Mac OS versions prior to OS X

# changes Windows line endings (\r\n) to Unix/Linux
# line endings (\n)

# a short lesson on line endings:
# LF, line feed, is \n
# CR, carriage return, is \r
# Linux uses \n only;
# old Mac (pre OS X) has \r only;
# new Mac (OS X) is compatible with Linux, has \n only;
# Windows has both \r and \n at end of line, \r\n;

# 14/08/2014 first version of modified script is giving
# lines with \n\n instead of just one \n;
# that was because the s/// was telling it to replace \r with \n;

# the last line of the input file has no line ending character at
# all, so it is giving an error at the moment;

# quick fix, just for this file, print line and add \n;

use strict;

# check that program has been called with right number of parameters

if (2 != scalar(@ARGV)){
    die "Usage $0: 
         file to read, with Windows line endings (CR and LF),
         file to write output to, with Unix/Linux line endings (LF only).\n";
}

my $winFile = $ARGV[0];
my $unixFile = $ARGV[1];

# check that output file doesn't already exist
if (-e $unixFile){
    die "Output file $unixFile already exists.\n";
}

# open filehandle for printing
open(OUT, ">$unixFile")
    or die "Unable to open output file $unixFile.\n";



# open filehandle for reading
open(IN, "< $winFile")
    or die "Unable to open Windows format input file, $winFile.\n";


# read in the files with \r\n as end-of-line character
while (my $line = <IN>){
   # check that line has expected format before changing it
   if ($line =~ /\r\n$/){
   
        # change \r\n to \n 
        $line =~ s/\r\n/\n/;
        print OUT $line; 

    }
    else{
        # print an error message to screen
        print "Line $line does not have the expected Windows end of line characters.\n";

        # ms 14/08/2014 quick fix for the current file, where the last line has
        #               no end of line characters;

        print OUT $line, "\n";
    }

}


# close filehandles
close(IN)
    or die "Unable to close Windows format input file $winFile.\n";


close(OUT)
    or die "Unable to close Unix/Linux format output file $unixFile.\n";

