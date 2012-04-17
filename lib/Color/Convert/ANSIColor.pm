package Color::Convert::ANSIColor;
use strict;
use warnings;
use Readonly;
use parent qw(Class::Accessor::Fast);
__PACKAGE__->mk_accessors(qw(from_rgb distance distance_list min_distance_color));
our $VERSION = '0.01';

Readonly my $COLORS => {
    'black'          => { fg => "\e[30m", bg => "\e[40m",  r => 0,     g => 0,     b => 0,     },
    'red'            => { fg => "\e[31m", bg => "\e[41m",  r => 170,   g => 0,     b => 0,     },
    'green'          => { fg => "\e[32m", bg => "\e[42m",  r => 0,     g => 170,   b => 0,     },
    'yellow'         => { fg => "\e[33m", bg => "\e[43m",  r => 170,   g => 170,   b => 0,     },
    'blue'           => { fg => "\e[34m", bg => "\e[44m",  r => 0,     g => 0,     b => 170,   },
    'magenta'        => { fg => "\e[35m", bg => "\e[45m",  r => 170,   g => 0,     b => 170,   },
    'cyan'           => { fg => "\e[36m", bg => "\e[46m",  r => 0,     g => 170,   b => 170,   },
    'white'          => { fg => "\e[37m", bg => "\e[47m",  r => 170,   g => 170,   b => 170,   },
    'bright_black'   => { fg => "\e[90m", bg => "\e[100m", r => 85,    g => 85,    b => 85,    },
    'bright_red'     => { fg => "\e[91m", bg => "\e[101m", r => 255,   g => 85,    b => 85,    },
    'bright_green'   => { fg => "\e[92m", bg => "\e[102m", r => 85,    g => 255,   b => 85,    },
    'bright_yellow'  => { fg => "\e[93m", bg => "\e[103m", r => 255,   g => 255,   b => 85,    },
    'bright_blue'    => { fg => "\e[94m", bg => "\e[104m", r => 85,    g => 85,    b => 255,   },
    'bright_magenda' => { fg => "\e[95m", bg => "\e[105m", r => 255,   g => 85,    b => 255,   },
    'bright_cyan'    => { fg => "\e[96m", bg => "\e[106m", r => 85,    g => 255,   b => 255,   },
    'bright_white'   => { fg => "\e[97m", bg => "\e[107m", r => 255,   g => 255,   b => 255,   },
};

sub from_rgb {
    my ($self,$rgb) = @_;
    my $distance_list = $self->distance_list( $rgb );
    my $color_key = $self->min_distance_color( $distance_list );
    return $COLORS->{$color_key};
}

sub distance {
    my $self = shift;
    my $rgb1 = shift;
    my $rgb2 = shift;
    return ( $rgb1->{r} - $rgb2->{r} ) ** 2 + ( $rgb1->{g} - $rgb2->{g} ) ** 2 + ( $rgb1->{b} - $rgb2->{b} ) ** 2;
}

sub distance_list {
    my ($self,$rgb) = @_;
    my $distance_list;
    for my $key ( keys %$COLORS ) {
        my $distance = $self->distance( $COLORS->{$key}, $rgb);
        $distance_list->{$key} = $distance;
    }
    return $distance_list;
}

sub min_distance_color {
    my ($self,$distance_list) = @_;
    my $min_distance_color;
    my $min_num;
    for my $key ( keys %$distance_list ) {
        if( !defined $min_num ) {
            $min_num = $distance_list->{$key};
            $min_distance_color = $key;
        }
        else {
            ($min_num,$min_distance_color) = ($distance_list->{$key},$key) if $distance_list->{$key} < $min_num;
        }
    }
    return $min_distance_color;
}

1;
__END__

=head1 NAME

Color::Convert::ANSIColor -

=head1 SYNOPSIS

  use Color::Convert::ANSIColor;
  my $color = Color::Convert::ANSIColor->new();
  my $ansi_color_ref = $color->from_rgb({ r => $r, g => $g, b => $b });

=head1 DESCRIPTION

Color::Convert::ANSIColor is converting from rgb to ANSIColor

=head1 AUTHOR

dameninngenn E<lt>dameninngenn.owata {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
