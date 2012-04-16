#!/usr/bin/env perl

use strict;
use Test::More;
use Readonly;
use lib 'lib';

Readonly my $rgb1 => {
    r => 255,
    g => 100,
    b => 30,
};
Readonly my $rgb2 => {
    r => 123,
    g => 150,
    b => 30,
};

BEGIN { use_ok 'Color::Convert::ANSIColor' }

my $color = Color::Convert::ANSIColor->new();

my $distance = ( $rgb1->{r} - $rgb2->{r} ) ** 2 + ( $rgb1->{g} - $rgb2->{g} ) ** 2 + ( $rgb1->{b} - $rgb2->{b} ) ** 2;
{
    my $calc_distance = $color->distance($rgb1,$rgb2);
    is($distance,$calc_distance);
}
{
    my $calc_distance = $color->distance($rgb2,$rgb1);
    is($distance,$calc_distance);
}

done_testing();
