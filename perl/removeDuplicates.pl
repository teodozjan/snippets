=head1 Remove Duplicates

Useful when no sort --unique available 

=cut

tie @src,'Tie::File','file.txt' or die $!;

for my $line (@src){

  $hash{$line} =1;
}

print join("\n",keys %hash);

