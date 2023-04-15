#!/usr/bin/perl

use strict;
use warnings;

# Get the directory to work with
my $dir = shift or die "Usage: $0 directory\n";

# Make sure the directory exists
die "Directory $dir does not exist\n" unless -d $dir;

# Get the destination directory
my $dest = shift or die "Usage: $0 directory destination\n";

# Make sure the destination directory exists
die "Destination directory $dest does not exist\n" unless -d $dest;

# Get a list of all the files in the directory
opendir(my $dh, $dir) or die "Could not open $dir: $!\n";
my @files = readdir($dh);
closedir($dh);

# Move each file to the destination directory
foreach my $file (@files) {
    next if $file eq '.' or $file eq '..';
    rename "$dir/$file", "$dest/$file" or die "Could not move $file: $!\n";
}