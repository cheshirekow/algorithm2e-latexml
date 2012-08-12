#!/usr/bin/perl

#  make_html.pl - generates documentation html file by running markdown
#
#  Copyright (c) Josh Bialkowski <jbialk@mit.edu>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
# 
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 

use Cwd 'abs_path';
use File::Basename;


chdir dirname(abs_path($0)) 
    or die "Failed to change to directory of script $!\n";


$header = <<'HERE';
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">

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

print `inkscape --export-png=images/layout.png images/layout.svg`;
print `inkscape --export-png=images/layout_explain.png images/layout_explain.svg`;