#!/usr/bin/perl -w
# a script to setup the database which keeps track of how many poker
# chips are in the pot.
#
# initialise.pl
# v 0.2 20/4/2002
# john@kript.net
#

# use decent variable control, import file locking and DBM library
use strict;
use Fcntl qw(:DEFAULT :flock);
use GDBM_File;

#check the command line arguments
unless (@ARGV == 1) { 
die "Useage: $0 filename\n where filename is the name  of the chip database to use\n";
}


#initialise the variables
my (%chips);
my ($filename, $colour, $no);

# open the chips database
$filename = "$ARGV[0]";
tie (%chips, "GDBM_File", $filename, O_CREAT | O_RDWR, 0644) || die "Cannot open $filename: $!\n";

print "\nSetting the Chip Database to defaults.  Please wait..\n";

$colour = "white";
$no = 50;
$chips{$colour} = $no;

print "set $colour chips to $no\n";

$colour = "red";
$no = 25;
$chips{$colour} = $no;

print "set $colour chips to $no\n";

$colour = "blue";
$no = 10;
$chips{$colour} = $no;

print "set $colour chips to $no\n";

$colour = "legend";
$no = 0;
$chips{$colour} = $no;

print "set $colour chips to $no\n";


untie %chips;
