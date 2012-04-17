#!/usr/bin/env perl

use strict;
use Test::Most;
use Readonly;

Readonly my $rgb => {
    r => 255,
    g => 100,
    b => 30,
};

BEGIN { use_ok 'Color::Convert::ANSIColor' }

my $color = Color::Convert::ANSIColor->new();
my $ansi_ref = $color->from_rgb( $rgb );

cmp_deeply(
    $ansi_ref,
    {
        r => re('^\d+$'),
        g => re('^\d+$'),
        b => re('^\d+$'),
        fg => re('^\\e\[\d+m$'),
        bg => re('^\\e\[\d+m$'),
    },
);

done_testing();
