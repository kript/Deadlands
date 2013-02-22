#!/usr/bin/perl -w
# a script to show the database which keeps track of how many poker
# chips are in the pot.
#
# show.pl
# v 0.1 20/4/2002
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

print "\nContents of the Chip Database are:\n";

for $colour (keys %chips) {
	print "$colour chips: $chips{$colour}\n";
}

untie %chips;
