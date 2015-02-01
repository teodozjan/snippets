use v6;

class AnnualCost{
    has Int $.from;
    has Int $.to;
}

class AnnualCostPercentage is AnnualCost {
    has Rat $.interest;
    method get( $toPay,  $mortage) { 
        return $toPay/12/100*$!interest;
    }
}


class AnnualCostMort is AnnualCost {
    has Rat $.interest;
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
    has Rat $.to_pay = Rat.new(298000,1);
    has Rat $.interest;
    has Int $.mortages = 360;
    has Rat $.mortage;
    has Rat $.total_interest = 0.0;
    has Rat $.total_cost = 0.0;
    has AnnualCost @.costs;

    method calc {
        for 1 .. $!mortage -> $mort {            
           
            for @!costs -> $cost {
                if $mort >= $cost.from && $mort <= $cost.to {
                    $!total_cost += $cost.get($.to_pay, $.mortage).Rat; 
                }                
            }
           
            my Rat $intests =  ($!interest*Rat.new(1,1200)*$!to_pay).Rat;
            
            $!to_pay -= $.mortage;
            $!total_interest = $!total_interest+$intests.Rat;
            $!to_pay = $!to_pay = $intests.Rat;
            
            #$!total_interest = Rat.new(98/100)*$!total_interest;
            
            
        }
    }

    method gist {
        return join "\n", $.bank,
        "Rata " ~ $.mortage,
        "Kapital(Int): " ~ $.to_pay.Int,
        "Koszty odsetki(Int): " ~ $.total_interest.Int,
        "Koszty inne: " ~ $.total_cost.Int,
        "Razem(tys): " ~ (($.total_cost+$.total_interest)/100).Int,
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


my $pko = Mortage.new(bank=>"PKO", interest => Rat.new(353,100), mortage=>Rat.new(134314,100));
$pko.add(AnnualCostConst.new(from=>1, to=>360, value=>7));
$pko.add(AnnualCostConst.new(from=>1, to=>1, value=>$pko.to_pay/100*3.25));
$pko.add(AnnualCostPercentage.new(from=>1, to=>64, interest => Rat.new(25,100)));
$pko.add(AnnualCostConst.new(from=>1, to=>1, value=>400));

my $mbank = Mortage.new(bank=>"MBANK",interest => Rat.new(366,100), mortage=>Rat.new(136491,100));
$mbank.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank.to_pay/100*1.64));
$mbank.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank.to_pay/100*1));
$mbank.add(AnnualCostMort.new(from=>25, to=>60, interest => Rat.new(4,1)));

my $mbank2 = Mortage.new(bank=>"MBANK2",interest => Rat.new(366,100), mortage=>Rat.new(135575,100));
$mbank2.cash(2000);
$mbank2.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank2.to_pay/100*1.64));
$mbank2.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank2.to_pay/100*1));
$mbank2.add(AnnualCostMort.new(from=>25, to=>59, interest => Rat.new(4,1)));

my $db = Mortage.new(bank=>"DB",interest => Rat.new(379,100), mortage=>Rat.new(138685,100));
$db.add(AnnualCostConst.new(from=>1, to=>1, value=>$db.to_pay/100*1.08*0.4));
$db.add(AnnualCostConst.new(from=>13, to=>60, value=>268*0.4));
$db.add(AnnualCostPercentage.new(from=>25, to=>66, interest => Rat.new(2,10)));
$db.add(AnnualCostConst.new(from=>1, to=>360, value=>24));
$db.add(AnnualCostConst.new(from=>1, to=>1, value=>300));

$pko.calc;
$mbank2.calc;
$mbank.calc;
$db.calc;

say $pko;
say $mbank;
say $mbank2;
say $db;
