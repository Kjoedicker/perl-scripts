#!/usr/bin/perl

use v5.30.3;
use strict; 
use warnings;  

my ($port) = @ARGV;

die "A specified port is required\nExample: `perl port-closer.pl 8080`" unless $port;

sub get_mapped_listeners {
    my @listeners =  split("\n", `lsof -n -i :$port | grep LISTEN`);

    die "[INFO] no listeners on port :$port" unless !!@listeners;

    my %mapped_listeners;
    foreach (@listeners) {
        my ($program, $pid) = split(" ", $_);

        $mapped_listeners{$program} = $pid;
    }

    return \%mapped_listeners;
}

sub select_program_to_terminate {
    my ($mapped_listeners) = @_;

    my $running_programs = join("\n", keys %$mapped_listeners);

    chomp(my $program_to_terminate = `echo "$running_programs" | fzf`);

    die "[INFO] no program selected for termination\n" unless !!$program_to_terminate;

    return $program_to_terminate;
}

sub kill_pid {
    my ($pid) = @_;

    my $command = "kill -9 $pid";

    return `$command`;
}

my $mapped_listeners     = get_mapped_listeners();
my $program_to_terminate = select_program_to_terminate($mapped_listeners);
my $program_pid          = $mapped_listeners->{$program_to_terminate};
my $kill_results         = kill_pid($program_pid);

my $message = $kill_results eq "" ? 
        "[SUCCESS] $program_to_terminate PID:$program_pid is terminated" : 
        "[ERROR] failed to terminate $program_to_terminate PID:$program_pid: $kill_results";

say($message);
