#LATEXMLPOST=/home/josh/Codes/devroot/usr/bin/latexmlpost
#export PERL5LIB=/home/josh/Codes/devroot/usr/share/perl/5.10.1/

LATEXMLPOST=latexmlpost

$LATEXMLPOST --novalidate \
                --stylesheet=../../../algorithm2e/LaTeXML-xhtml.xsl \
                --destination=test_debug.xhtml \
                --css=/usr/local/share/perl/5.12.4/LaTeXML/style/core.css \
                --css=../../../algorithm2e/algorithm2e_debug.css \
                test.xml

$LATEXMLPOST --novalidate \
                --stylesheet=../../../algorithm2e/LaTeXML-xhtml.xsl \
                --destination=test.xhtml \
                --css=/usr/local/share/perl/5.12.4/LaTeXML/style/core.css \
                --css=../../../algorithm2e/algorithm2e.css \
                test.xml
