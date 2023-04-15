#!/usr/bin/perl

my ($file, $copies) = @ARGV;

die "file and total copies needed" unless ($file && $copies);

for (my $i = 1; $i <= $copies; $i++) {
    `cp $file $i-$file`;
}