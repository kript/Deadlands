#!/usr/bin/perl -w
# script to generate dice rolls from Peginc's Deadlands System
# john@kript.net
# version .1
#

use strict;

@ARGV == 1 || die "Usage: $0 xdy where x is no. of dice, and y is type\n";


# Declare the variables
my ($step, $type, $decrement, $increment, $request, $numdice, $check, $biggest);
my (@results, @dicetoroll);

#Initialise the variables
$request = $ARGV[0];

#split it into number of dice (only 1 digit) and type of dice (Max two digits)
$_ = $request;
m/(\d{1})d(\d+)/i;
$numdice = $1;
$type = $2;


#check the die type
unless ($type == 4 ||
        $type  == 6 ||
        $type  == 8 ||
        $type  == 10 ||
        $type  == 12 ||
        $type  == 20 ) {
        die "Not a valid die type, I'm afraid\n";
}


sub DiceRoll {

my ($dicetype, $count, $dice, $reroll, $type, $roll);
my (@rolls);

# initialise the variables
$count = 0;
$dicetype = shift @_;

# generate a dice roll, if the dice is at its max value, roll again 
#  and append it to the $roll variable
		$roll = int(rand($dicetype)) + 1;
		$reroll = 1;
		while ($roll % $dicetype == 0 && $roll != 0 && $reroll !=0) {
			$reroll = int(rand($dicetype)) + 1;
			$roll = $roll + $reroll;
	}
return ($roll);
} 



#
# main code begins here
#


# set the counter to 0
$increment = 0;

while ($increment != $numdice ) {
	$results[$increment] = DiceRoll($type);
	$increment++;
}

# instead of the sort below, find the highest number in the array and print it

$check = 0;
$biggest = 0;

for $check (@results) {
	if ($check > $biggest) {
		$biggest = $check;
	}
}
print "Largest Die roll is $biggest\n";

# The sorting's not perfect, but hey..
        foreach (sort @results) {
        print "$_ ";
        }
        print "\n";

