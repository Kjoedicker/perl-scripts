#!/usr/bin/perl

use strict;
use warnings;

my $command = shift;

while (1) {
    my $result = system($command);
    last if $result == 0;
    sleep(1);
}