#!/usr/bin/perl

use Cwd 'abs_path';
use File::Basename;

# only work in this directory
chdir dirname(abs_path($0)) . "/work" 
    or die "Failed to change to directory of script $!\n";

# table of algorithm files and the width to use for them
$entries = 
[
    ['3.5', 'algorithm2e_howto_read'],
    ['3',   'rrt_generic'],
    ['3',   'rrt_extend'],
    ['4',   'rrtstar_extend'],
];

$format = <<'HERE';
\nonstopmode
\documentclass{article}


\usepackage{amsmath} 
\usepackage{amssymb} 
\usepackage{amsfonts}
\usepackage{graphicx}
\usepackage[lined,boxed,linesnumbered]{algorithm2e}
\usepackage{listings}

\newcommand{\NearNodes}{Near}
\DeclareMathOperator{\Src}{Src}
\DeclareMathOperator{\Dest}{Dest}
\DeclareMathOperator{\Cl}{cl}

\begin{document}
\thispagestyle{empty}
\begin{minipage}{%sin}
    \input{algos/%s.tex}
\end{minipage}
\end{document}
HERE

for $entry( @$entries )
{
    $width = $entry->[0];
    $file  = $entry->[1];
    
    # clean oldfiles
    system('rm','*.aux');
    die "Failed to remove aux files $!\n" if( ($? & 127) != 0 );
    
    # write out the source file
    open ($outfile, '>', 'algorithm.tex');
    print $outfile sprintf($format,$width,$file);
    close($outfile);
    
    for( $i=0; $i < 3; $i++)
    {
        system('pdflatex algorithm.tex');
        die "Failed to run pdflatex $!\n" if( ($? & 127) != 0 );
    }
    
    system ('pdfcrop algorithm.pdf algorithm-crop.pdf');
    die "Failed to run pdfcrop $!\n" if( ($? & 127) != 0 );    
    
    system ( sprintf('convert -density 100 algorithm-crop.pdf ../%s.png', $file) );
    die "Failed to run convert $!\n" if( ($? & 127) != 0 );
}


