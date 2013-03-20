#!/software/bin/perl-5.12.2 -w
# template script to run on linux/cluster machines with embedded documentation and command parsing

use strict;
use warnings;

use DL_Deck;

          
my ($deck, $card, $coord, $trait, $mysterious_past); 
$deck       = DL_Deck -> new(deck_wrap     => 0);
$deck -> shuffle_self();

for(my $i=1;$i<12;$i++)
{
    $mysterious_past = '';
    $card = $deck -> draw_card();
    $coord = $deck -> get_coord($card);
    $trait = $deck -> get_trait($card);
    
    if($deck->is_joker($card))
    {
        $mysterious_past = 'Have the Marshal draw for a Mysterious Past.';
    }
    print "$card: " . $coord . 'd' . $trait . ' ' . $mysterious_past . "\n";
}
