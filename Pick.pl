#!/usr/bin/perl -w
# a script to randomly pick a chip from the specified database
#
# Pick.pl
# v 0.1 21/4/2002
# john@kript.net
#

# use decent variable control and DBM library
use strict;
use GDBM_File;
use Fcntl qw(:DEFAULT :flock);

#check the command line arguments
unless (@ARGV == 2) {
die "Useage: $0 filename number\n where filename is the name of the chip database to draw from, and \nno is the no. of chips to draw\n";
}

unless (int($ARGV[1])) {
	die "you must specify a number of chips to draw\n";
}

#initialise the variables
my (%chips, %chances);
my ($filename, $colour, $no, $draw, $max, $roll, $calc, $total);
my ($white, $red, $blue, $legend);

$filename = $ARGV[0];
$draw = $ARGV[1];
$total = 0;

# open the chips database
tie (%chips, "GDBM_File", $filename, O_CREAT | O_RDWR, 0644) || die "Cannot open $filename: $!\n";


#total up the number of chips in the pot
$white = $chips{white};
$red = $white + $chips{red};
$blue = $red + $chips{blue};
$legend = $blue + $chips{legend};

$total = $legend;

while ($draw != 0) {
        #random generate a number
        $roll = int(rand($total)) + 1;
	#heck which chip it corresponds to
	SWITCH: {
	if ($roll <= $white) { print "Drew a white chip\n"; last SWITCH; }
	if ($roll <= $red) { print "Drew a red chip\n"; last SWITCH; }
	if ($roll <= $blue) { print "Drew a blue chip\n"; last SWITCH;  }
	if ($roll <= $legend) { print "Drew a Legend Chip!\n"; last SWITCH; }
	}
$draw--;
}


untie %chips;
