#!/usr/bin/perl

use Cwd 'abs_path';
use File::Basename;


chdir dirname(abs_path($0)) 
    or die "Failed to change to directory of script $!\n";


$header = <<'HERE';
<html>
    <head>
        <link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"/>
        <title>Algorithm2e Bindings for LaTeXML</title>   
    </head>
    <body>
    
HERE

$footer = <<'HERE';
    </body>
</html>
HERE




open ($outfile, ">", "index.html");

print $outfile $header;
print $outfile `markdown readme.txt`;
print $outfile $footer;

close($outfile);

print `inkscape --export-png=layout.png layout.svg`;
print `inkscape --export-png=layout_explain.png layout_explain.svg`;