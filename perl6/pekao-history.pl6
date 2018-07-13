use v6;
use Form;

my @file = 'OPERHIST_1.txt'.IO.lines;
my @cut = @file.splice(2);


my %result;

for @cut -> $line {
    
    next unless $line ~~ /\w/;
    my @data = $line.split(/\t+/);
    my Rat $amount = +(@data[5].subst(',', '.'));
    my Str $what = @data[7];

    %result{$what} += $amount;
}

for %result.pairs.sort: {.value} -> $pair {
    print form '{<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<}  {<<<<<<<<<<<}', ~$pair.key, ~$pair.value
}
