#!/usr/bin/perl

use v5.30.3;
use strict; 
use warnings;  
use JSON;


my ($csv_file) = @ARGV;

die "A csv file is required.\nExample: `perl jsonify.pl ./some-file.csv`" unless $csv_file;

open my $file_handler, "<", $csv_file or die "Error opening file";

my @mapped_csv;

chomp(my $header_line = <$file_handler>);
my @headers = split(",", $header_line);

while (<$file_handler>) {
    my @row_values = split(",", $_);

    my %mapped_row;
    my $value_index = 0;
    foreach (@row_values) {
        chomp(my $column = $_);
    
        my $key = $headers[$value_index];
        $mapped_row{$key} = $column;
    
        $value_index++;
    }

    push(@mapped_csv, \%mapped_row);
}

my $json = encode_json \@mapped_csv;

print($json);
