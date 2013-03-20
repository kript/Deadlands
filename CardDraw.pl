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
$deck       = DL_Deck -> new(deck_wrap     => 0);
$deck -> shuffle_self();
$card = $deck -> draw_card();
$coord = $deck -> get_coord($card);
$trait = $deck -> get_trait($card);
$name = $deck -> card_name($card);

say "Card is: $name";



__END__
=head1 NAME

PrgamName - boilerplate to descrive function



=head1 USAGE

    ProgramName  [options] 

=head1 OPTIONS

=over

=item  -d[ir] [=] <dir>

Specify directory to select the file from [default: dir.default]


=for Euclid:
    dir.type:    string 
    dir.default: './'
    dir.type.error: must be a valid directory

=item  -p[attern] [=] <pattern>

Specify pattern to match the file with, if any [default: pattern.default]

=for Euclid:
    pattern.type:    string
    pattern.type.error: must be a string

=item –v

=item --verbose

Print all warnings

=item --version

=item --usage

=item --help

=item --man

Print the usual program information

=back

=begin remainder of documentation here. . .

