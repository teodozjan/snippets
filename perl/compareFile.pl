use Tie::File;

tie @changedsrc,'Tie::File','file1.h' or die $!;
tie @generalsrc,'Tie::File', 'file2.h' or die $!;

my %changed;


for my $line (@changedsrc){
  next unless $line =~ /TTYPE/;
  my @array = split(',',$line);
  $changed{$array[1]} = $array[2];
}


for my $line (@generalsrc){
  next unless $line =~ /TTYPE/;
  my @array = split(',',$line);
  if(exists $changed{$array[1]}){
    print   $array[2] ," ->", $changed{$array[1]}, "\n";
  }
  
}
