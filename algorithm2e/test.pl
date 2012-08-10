#/usr/bin/perl

$subs = {};

for my $name('bob','joan','brian')
{
    $subs{$name} = sub
    {
        print $name . "\n";  
    };
}


$subs{'bob'}->();
$subs{'joan'}->();
$subs{'brian'}->();

print "\n\n";

$href_a = {'a'=>'a','b'=>'b','c'=>'c'};
$href_b = {};

%{href_b} = %{href_a};

$href_b->{'a'} = 'd';
$href_b->{'b'} = 'e';
$href_b->{'c'} = 'f';

for $key( qw(a b c) )
{
    printf( "href_a: %s    href_b: %s\n", $href_a->{$key}, $href_b->{$key});
}