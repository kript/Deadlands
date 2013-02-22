#code copied from http://www.thebrogue.com/dl_draw.html
# and therefore Copyright James A. McCarthy
# the code was placed in clear text on the site, so I hope its OK to reproduce here

package DL_Deck;

$VERSION = 1.00;

use strict;

BEGIN { 
   $SIG{__WARN__} = sub { warn @_ unless $_[0] =~ /Use of uninitialized value/ }; 
}

{
    my %_attributes = (
                       deck_wrap     => [1,  'r' ], 
                       shuffle_times => [50, 'rw'],
                       );

    sub _accessible     { $_attributes{$_[1]}[1] =~ m/$_[2]/; }
    sub _default_value  { $_attributes{$_[1]}[0]; }
    sub _attribute_keys { keys %_attributes; }
}

my @_deck   = ();
my $_draw   = 0;
my $_bottom = 0;

# Constructor Method.

sub new {
    my ($class, %arg) = @_;
    my $self = bless {}, $class;
    foreach my $attr ($self->_attribute_keys()) { 
       (exists $arg{$attr})?($self->{$attr} = $arg{$attr}):($self->{$attr} = $self->_default_value($attr)); 
    }
    my $card  = 2;
    $_deck[0] = 'RC';
    $_deck[1] = 'BC';
    foreach my $suite (qw(C D H S)) {
        foreach my $face (qw(A 2 3 4 5 6 7 8 9 J Q K)) {
            $_deck[$card++] = $suite . $face;;
        }
    }
    $_bottom = $card;
    return $self;
}

# Attribute Accessor Methods

sub get_attr { $_[0]->{$_[1]}; }
sub set_attr { ($_[0]->_accessible($_[1], 'w'))?($_[0]->{$_[1]} = $_[2]):(undef); }

# Deck Methods

sub shuffle {
    for (my $iter = 1; $iter <= $_[0]->get_attr('shuffle_times'); $iter++) {
        for (my $i = @_deck; --$i; ) {
            my $j = int(rand($i+1));
            if ($i == $j) { next; }
            @_deck[$i,$j] = @_deck[$j,$i];
        }
    }
    1;
}

sub draw_card { 
    if ($_[0]->get_attr('wrap_deck')) { $_deck[$_bottom++] = $_deck[$_draw]; }  
    return $_deck[$_draw++];
}

sub get_coord {
    if    ($_[1] =~ m/^C/) { return 1; }
    elsif ($_[1] =~ m/^D/) { return 2; }
    elsif ($_[1] =~ m/^H/) { return 3; }
    elsif ($_[1] =~ m/^S/) { return 4; }
    else                   { return(int(rand(4)+1)); }
}

sub get_trait {
    if    ($_[1] =~ m/2$/)     { return 4;  }
    elsif ($_[1] =~ m/(A|C)$/) { return 12; }
    elsif ($_[1] =~ m/(9|J)$/) { return 8;  }
    elsif ($_[1] =~ m/(Q|K)$/) { return 10; }
    else                       { return 6;  }
}

sub card_name {
    my %face  = ('A' => 'Ace',   '5' => 'Five',  '9' => 'Nine',
                 '2' => 'Deuce', '6' => 'Six',   'J' => 'Jack',
                 '3' => 'Three', '7' => 'Seven', 'Q' => 'Queen',
                 '4' => 'Four',  '8' => 'Eight', 'K' => 'King');
    my %suite = ('C' => 'of Clubs',  
                 'D' => 'of Diamonds',
                 'H' => 'of Hearts',
                 'S' => 'of Spades');
    if    ($_[1] eq 'RC') { return 'Red Joker'; }
    elsif ($_[1] eq 'BC') { return 'Black Joker'; }
    else                  {
        my $temp = $_[1];
        $temp =~ s/^(.)(.)$/$face{$2} $suite{$1}/;
        return $temp;
    } 
}

1;
