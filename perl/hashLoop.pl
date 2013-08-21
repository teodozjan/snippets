my %hash = @($_ => 'abc' for 1..4);
say %hash;
#("1" => "abc", "2" => "abc", "3" => "abc", "4" => "abc").hash
my %hash2;
for 1..4
{
        %hash2{$_}='abc';
}
say %hash2;
# ("1" => "abc", "2" => "abc", "3" => "abc", "4" => "abc").hash
