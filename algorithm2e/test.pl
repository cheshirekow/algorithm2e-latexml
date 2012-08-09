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
