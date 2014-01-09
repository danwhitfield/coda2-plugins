#!/usr/bin/perl

use strict;
use warnings;

my @document_lines          = <STDIN>;
my $line_number             = $ENV{CODA_LINE_NUMBER};
my $line_index              = $ENV{CODA_LINE_INDEX};
my $line                    = $document_lines[$line_number - 1];
my $line_beginning_snippet  = substr($line, 0, $line_index);
my $line_end_snippet        = substr($line, $line_index, length($line));

chomp($line_beginning_snippet);

sub toggle_case
{
    my $str = shift;
    
    if($str =~ m/[a-z]+/) {
        $str = uc($str);
    } elsif($str =~ m/[A-Z]+/) {
        $str = lc($str);
    }
    
    return $str;
}

$line_beginning_snippet =~ s/([\w]+)$/toggle_case($1)/e;
$line_end_snippet       =~ s/^([\w]+)/toggle_case($1)/e;

$document_lines[$line_number - 1] = $line_beginning_snippet . '$$IP$$' . $line_end_snippet;

print @document_lines;
