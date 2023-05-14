#!/usr/bin/perl

use v5.30.3;
use strict; 
use warnings;  
use experimental 'smartmatch';

use constant TEMPLATE_PATH => '~/.perl-boiler/perl-template.pl';

sub getFileName {
    my $arg = shift;
    
    return $arg . ".pl";
}

sub checkIfAlreadyExists {
    my $fileName = shift;

    return !!(-e $fileName);
}

sub getCloneCommand {
    my $fileName = shift;

    return "cp " . TEMPLATE_PATH . " $fileName";
}

sub clone {
    my ($fileName, $cloneCommand) = @_;

    say "Creating: " . $fileName;
    my $cloneResults = `$cloneCommand`;
    
    return $cloneResults;
}

sub processArg {
    my ($arg) = @_;

    my $fileName = getFileName($arg);
    my $fileAlreadyExists = checkIfAlreadyExists($fileName);

    if ($fileAlreadyExists) {
        say "Cannot create: $fileName; file already exists";
        return;
    }
    
    my $cloneCommand = getCloneCommand($fileName);
    clone($fileName, $cloneCommand);
}

die "Must provide a filename" unless @ARGV;

processArg $_ foreach @ARGV;
