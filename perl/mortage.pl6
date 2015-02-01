use v6;

class AnnualCost{
    has Int $.from;
    has Int $.to;
}

class AnnualCostPercentage is AnnualCost {
    has $.interest;
    method get( $toPay,  $mortage) { 
        return $toPay/12/100*$!interest;
    }
}


class AnnualCostMort is AnnualCost {
    has $.interest;
    method get( $toPay,  $mortage) {
        return $mortage/12*$!interest;
    }
}
class AnnualCostConst is AnnualCost {
    has  $.value;
    method get( $toPay,  $mortage)   { 
        return $!value;
    }

}
    
class Mortage {
    has Str $.bank;
    has $.to_pay = FatRat.new(298000,1);
    has $.interest;
    has Int $.mortages = 360;
    has $.mortage;
    has $.total_interest = FatRat.new(0,1);
    has $.total_cost = FatRat.new(0,1);
    has AnnualCost @.costs;

    method calc {
        for 1 .. $!mortages -> $mort {            
           
            for @!costs -> $cost {
                if $mort >= $cost.from && $mort <= $cost.to {
                    $!total_cost += $cost.get($.to_pay, $.mortage); 
                }                
            }
           
            my $intests =  $!interest*$!to_pay;

            #say $mort, "  ",$intests.round(0.01), " ", $!to_pay.round(0.01);
            
            $!to_pay -= $!mortage;
            $!total_interest += $intests;
            $!to_pay +=  $intests;
            
            ##$!total_interest = Rat.new(98/100)*$!total_interest;
            
            
        }
    }

    method gist {
        return join "\n", $.bank,
        "Rata " ~ $.mortage.round(0.01),
        "Kapital: " ~ $.to_pay.round(0.01),
        "Koszty odsetki: " ~ $.total_interest.round(0.01),
        "Koszty inne: " ~ $.total_cost.round(0.01),
        "Razem): " ~ ($.total_cost+$.total_interest).round(0.01),
        "\n";
    }

    method calc_mortage {

            my $c = $.interest/12/100;
            my $n = $.mortages;
            my $L = $.to_pay;
            my $my_mortage = ($L*($c*(1 + $c)**$n))/((1 + $c)**$n - 1);
            return $my_mortage;

            
    }

    method add(AnnualCost $cost){
        @!costs.push($cost);
    }

    method cash($cash){
        $!to_pay -= $cash;
    }
}

say "Init";
my $pko = Mortage.new(bank=>"PKO", interest => FatRat.new(353,120000), mortage=>FatRat.new(134313,100));
$pko.add(AnnualCostConst.new(from=>1, to=>360, value=>Rat.new(7,1)));
$pko.add(AnnualCostConst.new(from=>1, to=>1, value=>$pko.to_pay/100*3.25));
$pko.add(AnnualCostPercentage.new(from=>1, to=>64, interest => Rat.new(25,100)));
$pko.add(AnnualCostConst.new(from=>1, to=>1, value=>400));

my $mbank = Mortage.new(bank=>"MBANK",interest => FatRat.new(366,120000), mortage=>FatRat.new(136491,100));
$mbank.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank.to_pay/100*1.64));
$mbank.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank.to_pay/100*1));
$mbank.add(AnnualCostMort.new(from=>25, to=>60, interest => Rat.new(4,1)));

my $mbank2 = Mortage.new(bank=>"MBANK2",interest => FatRat.new(366,120000), mortage=>FatRat.new(135575,100));
$mbank2.cash(2000);
$mbank2.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank2.to_pay/100*1.64));
$mbank2.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank2.to_pay/100*1));
$mbank2.add(AnnualCostMort.new(from=>25, to=>59, interest => Rat.new(4,1)));

my $db = Mortage.new(bank=>"DB",interest => FatRat.new(379,120000), mortage=>FatRat.new(138685,100));
$db.add(AnnualCostConst.new(from=>1, to=>1, value=>$db.to_pay/100*1.08*0.4));
$db.add(AnnualCostConst.new(from=>13, to=>60, value=>268*0.4));
$db.add(AnnualCostPercentage.new(from=>25, to=>66, interest => Rat.new(2,10)));
$db.add(AnnualCostConst.new(from=>1, to=>360, value=>24));
$db.add(AnnualCostConst.new(from=>1, to=>1, value=>300));

say "1";
$pko.calc;
say "2";
$mbank2.calc;
say "3";
$mbank.calc;
say "4";
$db.calc;

say "Done";
say $pko;
say $mbank;
say $mbank2;
say $db;
