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
         for(101 .. 254){                                                                                                                                                                     
                print ".";                                                                                                                                                                    
                sleep(1);                                                                                                                                                                     
                my $p = Net::Ping->new();                                                                                                                                                     
                say "\n\t",scalar localtime()," $_ is alive.\n" if $p->ping($HOST.$_);                                                                                                        
                $p->close();                                                                                                                                                                  
    }                                                                                                                                                                                         

                                                                                                                                                                                              
}                     
