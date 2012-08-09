Algorithm2e Bindings for LaTeXML
=================================

This code provides latexml bindings for the algorithm2e package. You can see
[a  demo](test.xhtml "Algorithm2d Demo XHTML") in the same directory as this
file. 


Info
--------------------------

Copyright (C) 2012 Josh Bialkowski (jbialk@mit.edu)

This software is licensed under the GPL v3. You can find this documentation 
at [Documentation][] and the source code at [Source][]

[Documentation]: http://www.cheshirekow.com/~projects/algorithm2e_latexml/
[Source]:        git://git.cheshirekow.com/algorithm2e_latexml/


Notes 
--------------------------

*   There is a relevant thread on 
    [the mailing list][]
*   This code is mostly a proof of concept and has been semi abandoned. I hope
    to get around to it sooner or later. 
    
[the mailing list]: http://lists.jacobs-university.de/pipermail/project-latexml/2011-July/000507.html


How it works
--------------------------

Here is the basic mapping that of pseudocode layout to latexml elements

    pseudo code layout        latexml element        html   class
    ------------------        ---------------        ------ -------
    algorithm            =>   ltx:float         =>   div    algorithm2e
    block                =>   ltx:inline-block  =>   span   algorithm2e-block
    line                 =>   ltx:p             =>   p      algorithm2e-line
    caption              =>   ltx:caption       =>   div    algorithm2e-caption
    

The layout is done using some ugly css hacks and several levels of nested 
elements. Here is a diagram which should illustrate whats going on:

![Layout Method](layout.png)