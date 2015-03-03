use v6;

constant $more_than_percent = 120000;
constant $more_than_promile = 10000;

class AnnualCost{
    has Int $.from;
    has Int $.to;
}

class AnnualCostPercentage is AnnualCost {
    has $.interest;
    method get( $toPay,  $mortage) { 
        return $toPay*$!interest;
    }
}


class AnnualCostMort is AnnualCost {
    has $.interest;
    method get( $toPay,  $mortage) {
        return $mortage*$!interest;
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
    has $.to_pay = Rat.new(297000,1);
    has $.interest;
    has Int $.mortages = 360;
    has $.mortage;
    has $.total_interest = Rat.new(0,1);
    has $.total_cost = Rat.new(0,1);
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
            
            # Uncomment if want infltation
            #$!total_interest *= 1-Rat.new(200,$more_than_percent);
            
            
        }
    }

    method gist {
        return join " PLN\n", $.bank,
        "Rata " ~ $.mortage.round(0.01),
        "Kapital(kontrolnie): " ~ $.to_pay.round(0.01),
        "Koszty odsetki: " ~ $.total_interest.round(0.01),
        "Koszty inne: " ~ $.total_cost.round(0.01),
        "Razem: " ~ ($.total_cost+$.total_interest).round(0.01);
        # if correctly calculated $.to_pay should be close to 0
    }

    method calc_mortage {

            my $c = $.interest;
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
my $pko = Mortage.new(bank=>"PKO", interest => Rat.new(353,$more_than_percent), mortage=>Rat.new(133864,100));
# Oplata za konto
$pko.add(AnnualCostConst.new(from=>1, to=>360, value=>Rat.new(7*5,3)));
# Pseudo polisa
$pko.add(AnnualCostConst.new(from=>1, to=>1, value=> Rat.new(325,$more_than_promile)*$pko.to_pay));
#Podwyzszenie marzy
$pko.add(AnnualCostMort.new(from=>1, to=>64, interest => Rat.new(25,$more_than_percent)));
#Wycena
$pko.add(AnnualCostConst.new(from=>1, to=>1, value=>400));

my $mbank = Mortage.new(bank=>"MBANK",interest => Rat.new(366,$more_than_percent), mortage=>Rat.new(136033,100));
# polisa
$mbank.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank.to_pay* Rat.new(164,$more_than_promile)));
# Prowizja
$mbank.add(AnnualCostConst.new(from=>1, to=>1, value=>$mbank.to_pay * Rat.new(1,100)));
# ubezp
$mbank.add(AnnualCostMort.new(from=>25, to=>60, interest => Rat.new(4,100)));

# FIXME: Niedokladne nie uwzglednia zyskow z funduszy ani oplaty za prowadzenie ,,portfela'' 
my $db = Mortage.new(bank=>"DB",interest => Rat.new(379,$more_than_percent), mortage=>Rat.new(138220,100));
#$db.add(AnnualCostConst.new(from=>1, to=>1, value=>$db.to_pay * Rat.new(108,$more_than_promile)*Rat.new(3,10)));
#$db.add(AnnualCostConst.new(from=>13, to=>60, value=>Rat.new(268,1)*Rat.new(3,10)));
$db.add(AnnualCostPercentage.new(from=>1, to=>12, interest=>Rat.new(-59,$more_than_percent)));
$db.add(AnnualCostPercentage.new(from=>25, to=>66, interest => Rat.new(2,$more_than_percent)));
$db.add(AnnualCostConst.new(from=>1, to=>360, value=>24));

say $pko.calc_mortage.round(0.01);
say $mbank.calc_mortage.round(0.01);
say $db.calc_mortage.round(0.01);


$pko.calc;
$mbank.calc;
$db.calc;

say "Done";
say $pko;
say $mbank;
say $db;

