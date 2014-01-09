#!/usr/bin/perl

use strict;
use warnings;

$/;

my $selection = <STDIN>;

if($selection) {
    $selection = lc($selection);
    
    while(<STDIN>) {
        $selection .= lc($_);
    }
    
    print $selection;
}
