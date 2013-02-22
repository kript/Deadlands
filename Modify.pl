#!/usr/bin/perl -w
# a script to modify the contents of the database of poker chips
#
# Modify.pl
# v 0.1 20/4/2002
# john@kript.net
#

# use decent variable control, import file locking and DBM library
use strict;
use Fcntl qw(:DEFAULT :flock);
use GDBM_File;

#check the command line arguments
unless (@ARGV == 4) {
print "\nUseage: $0 filename a/r number chip\n"; 
print "where filename is the name  of the chip database to use, \n";
print "a/r is Add or Remove\n";
print "number is number of chips\n";
print "chip type is (w)hite (r)ed (b)lue or (l)egend\n";
print "e.g. $0 test a 5 w\n";
print "add's 5 white chips to the test database\n";
die "\n";
}

#initialise the variables
my (%chips);
my ($filename, $colour, $no, $operation, $chip, $calc);

#setup the values, tranforming the charecters into lower case to make
#  comparisons easier
$filename = $ARGV[0];
$operation = lc($ARGV[1]);
$no = $ARGV[2];
$chip = lc($ARGV[3]);

# perform some validation

unless ($operation eq "r" || $operation eq "a" ) {
	die "valid operations are (a)dd or (r)emove\n";
}
unless (int($no)) {
	die "whole numbers for  no. of chips pleas\n";
}
unless ($chip eq "w" || $chip eq "r" || $chip eq "b" || $chip eq "l" ) {
        die "valid operations are (w)hite, (r)ed, (b)lue or (l)egend \n";
}
 
#setup the hash values according to the input
if ($chip eq "w") { $colour = "white"; }
if ($chip eq "b") { $colour = "blue"; }
if ($chip eq "r") { $colour = "red"; }	
if ($chip eq "l") { $colour = "legend"; }

# open the chips database
tie (%chips, "GDBM_File", $filename, O_CREAT | O_RDWR, 0644) || die "Cannot open $filename: $!\n";

print "\nChip Database:\n";

if ($operation eq "a") {
	$calc = $chips{$colour} + $no;
	$chips{$colour} = $calc;
	print "Added $no $colour chips to database\n";
} else {
	$calc = $chips{$colour} - $no;
	$chips{$colour} = $calc;
	print "Removed $no $colour chips from database\n";	
}


untie %chips;
