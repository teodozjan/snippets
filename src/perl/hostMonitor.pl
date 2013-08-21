use warnings;                                                                                                                                                                                 
use 5.10.0;                                                                                                                                                                                   
use strict;                                                                                                                                                                                   
use Net::Ping;                                                                                                                                                                                
                                                                                                                                                                                              
my $HOST = "192.168.0.";                                                                                                                                                                      
                                                                                                                                                                                              
say "go";                                                                                                                                                                                     
do{                                                                                                                                                                                           
        print "asking";                                                                                                                                                                       
        &go;                                                                                                                                                                                  
        say "done";                                                                                                                                                                           
        }while (sleep(600));                                                                                                                                                                  
                                                                                                                                                                                              
sub go{                                                                                                                                                                                       
         for(my $i=0;$i<200;$i++){                                                                                                                                                            
                print ".";                                                                                                                                                                    
                sleep(1);                                                                                                                                                                     
                my $p = Net::Ping->new();                                                                                                                                                     
                say scalar localtime(),"\n\t$i is alive.\n" if $p->ping($HOST.$i);                                                                                                            
                $p->close();                                                                                                                                                                  
    }                                                                                                                                                                                         
 
      
