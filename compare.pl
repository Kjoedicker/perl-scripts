use v5.30.3;

sub slurp {
    my $file = shift;
    open my $fh, '<', $file or die;
    local $/ = undef;
    my $cont = <$fh>;
    close $fh;
    return split("\n", $cont);
}

my @set = slurp($ARGV[0]);
my @subset = slurp($ARGV[1]);

my %set_map = map { lc($_) => 1 } @set;

# Run through @subset and:
#     * print what is in @set to STDIN
#     * print what is NOT in @set to STDOUT
foreach (@subset) {
    my $is_subset = exists($set_map{lc($_)});

    if ($is_subset) {
        print STDOUT "$_\n";
    } else {
        print STDERR "$_\n";
    }
}

# perl compare.pl set.csv subset.csv > matches.csv 2> outliers.csv