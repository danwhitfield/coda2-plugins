#!/usr/bin/perl

use strict;
use warnings;

my @lines       = <STDIN>;
my $new_output  = '';
my $tab_width   = 4;

if($#lines > 0) {
    my ($line, $longest_line, $equals_operator, $split_regex, $padding, $line_number, $line_start, $line_end);

    foreach $line (@lines) {
        next if $line !~ m/.+[=\:]/;

        ($equals_operator)      = ($line =~ m/([\.\+\-]?[=\:][\>\&\~]?)/);
        ($split_regex           = $equals_operator) =~ s/([\.\+\-\=\>\&])/\\$1/g;
        ($line_start = $line)   =~ s/($split_regex.+?)$//;
        $line_start             =~ s/([\t\s]+$)//;
        $longest_line           = length($line_start) if length($line_start) > $longest_line;
    }

    foreach $line (@lines) {
        $line_number++;

        if($line =~ m/.+[=\:]/) {
            ($equals_operator)      = ($line =~ m/([\.\+\-]?[=\:][\>\&\~]?)/);
            ($split_regex           = $equals_operator) =~ s/([\.\+\-\=\>\&])/\\$1/g;
            ($line_start = $line)   =~ s/$split_regex.+?$//;
            ($line_end   = $line)   =~ s/^.+?$split_regex//;
            $line_start             =~ s/([\s]+$)//;
            $line_end               =~ s/^[\s]+//;
            $padding                = ($line_number == 1) ? $longest_line - $ENV{CODA_LINE_INDEX} : $longest_line;
            $padding               += $tab_width - ($longest_line % $tab_width);
            $padding               += $tab_width if $padding == $longest_line;
            
            $padding--;
            $padding++ if $equals_operator !~ m/[\.\+\-]=$/;
            
            $new_output .= sprintf("%-${padding}s${equals_operator} %s", $line_start, $line_end);
        } else {
            $new_output .= $line;
        }
    }

    print $new_output;
}
