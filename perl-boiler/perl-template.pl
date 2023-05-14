#!/usr/bin/perl

use v5.30.3;
use strict; 
use warnings;  
use experimental 'smartmatch';

use Data::Dumper;
use JSON;
use YAML::Syck;

sub default {
    return 1;
}

sub parseCLIargs {
    print $_ foreach @ARGV;
}

say "Init setup";