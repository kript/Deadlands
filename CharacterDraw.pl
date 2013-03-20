#!/software/bin/perl-5.12.2 -w
# template script to run on linux/cluster machines with embedded documentation and command parsing

use strict;
use v5.12.2; #make use of the say command and other nifty perl 10.0 onwards goodness
use Carp;
use DL_Deck;

#set the version number in a way Getopt::Euclid can parse
BEGIN { use version; our $VERSION = qv('0.1.1_3') }

use Getopt::Euclid; # Create a command-line parser that implements the documentation below... 

my $dir = $ARGV{-d};
my $pattern = $ARGV{-p};
          
my ($deck, $card, $coord, $trait, $name); 
$deck       = DL_Deck -> new(deck_wrap     => 0,
                             shuffle_times => 25);
$deck -> shuffle_self();

for(my $i=1;$i<12;$i++)
{
    $card = $deck -> draw_card();
    $coord = $deck -> get_coord($card);
    $trait = $deck -> get_trait($card);
    $name = $deck -> card_name($card);
    print "$card: " . $coord . 'd' . $trait . "\n";
}
