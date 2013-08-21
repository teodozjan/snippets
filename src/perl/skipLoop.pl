  for $i(0 .. $#ib){
      my $line = $ib[$i]; 
      if (index(lc($line), lc($name)) != -1){
        ++$i until ( $ib[$i] =~ /\:\:/);
        $ib[$i] =~ /\s\d+\s/;
	      $id = $&;
	      $id =~ tr/ //ds;
	      last;
      }
    }
