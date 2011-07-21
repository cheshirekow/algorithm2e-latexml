#LATEXMLPOST=/home/josh/Codes/devroot/usr/bin/latexmlpost
#export PERL5LIB=/home/josh/Codes/devroot/usr/share/perl/5.10.1/

LATEXMLPOST=latexmlpost

$LATEXMLPOST --novalidate --stylesheet=LaTeXML-xhtml.xsl --destination=test.xhtml --css=core.css --css=algorithm2e.css test.xml
