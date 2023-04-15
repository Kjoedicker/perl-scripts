#!/usr/bin/perl

use strict;
use warnings;

# set the row count
my $row_count = 10;

# UPDATE ME
my $FILE_NAME = 'input.csv';

# open the csv file
open my $fh, '<', $FILE_NAME or die $!;

# read the header line
my $header = <$fh>;

# set the file counter
my $file_count = 1;

# open the first output file
open my $out_fh, '>', 'output_' . $file_count . '.csv' or die $!;

# write the header line to the first output file
print $out_fh $header;

# set the row counter
my $row_counter = 0;

# loop through the csv
while (my $line = <$fh>) {
    # increment the row counter
    $row_counter++;

    # write the line to the output file
    print $out_fh $line;

    # if the row counter is equal to the row count
    if ($row_counter == $row_count) {
        # reset the row counter
        $row_counter = 0;

        # increment the file counter
        $file_count++;

        # close the output file
        close $out_fh;

        # open the next output file
        open $out_fh, '>', 'output_' . $file_count . '.csv' or die $!;

        # write the header line to the next output file
        print $out_fh $header;
    }
}

# close the output file
close $out_fh;