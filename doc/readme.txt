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
*   This code is mostly a proof of concept and not all features are 
    implemented. I hope to get around to it sooner or later. 
    
[the mailing list]: http://lists.jacobs-university.de/pipermail/project-latexml/2011-July/000507.html


How it works
--------------------------

Here is the basic mapping of pseudocode layout to latexml elements using the
old line number label positioning (aligned to the top)

    pseudo code layout        latexml element        html   class
    ------------------        ---------------        ------ -------
    algorithm            =>   ltx:float         =>   div    algorithm2e
    block                =>   ltx:inline-block  =>   div    algorithm2e-block-[0|x]
    line                 =>   ltx:inline-block  =>   div    algorithm2e-line
    line number          =>   ltx:inline-block  =>   div    algorithm2e-lineno-pos
                              ltx:p             =>   div    algorithm2e-lineno, algorithm2e-lineno-[x]
    line text            =>   ltx:p             =>   p      algorithm2e-line-text
    caption              =>   ltx:caption       =>   div    algorithm2e-caption
    
Using the new positioning scheme, line number labels are bottom-aligned to the
baseline of the first line of text in the psuedocode line. In other words
if the pseudo code is too long for a single line and it wraps to more than
one actual line, the line number remains bottom-aligned to the baseline of
the text in the first actual line.

    pseudo code layout        latexml element        html   class
    ------------------        ---------------        ------ -------
    algorithm            =>   ltx:float         =>   div    algorithm2e
    block                =>   ltx:inline-block  =>   div    algorithm2e-block-[0|x]
    line                 =>   ltx:inline-block  =>   div    algorithm2e-line
    line text            =>   ltx:inline-block  =>   p      algorithm2e-line-text
    line number          =>   ltx:inline-block  =>   span   algorithm2e-lineno-anchor
                              ltx:inline-block  =>   span   algorithm2e-lineno, algorithm2e-lineno-[x]
    caption              =>   ltx:caption       =>   div    algorithm2e-caption
    

The layout is done using some ugly css hacks and a couple levels of nested 
elements. Here is a diagram which should illustrate whats going on (at least 
for the old alignment):

![Layout Method](images/layout.png)
![Layout Method](images/layout_explain.png)

There is a demo of this layout using CSS [here](demo/index.html) and with 
informative outlines [here](demo/debug.html). You can also see the output of
a test file [here](test/test.xhtml), or with the debug stylesheet 
[here](test/test_debug.xhtml).

The new alignment is illustrated in the last of the three algorithms in the
demo. 


CSS Stylesheet
========================

The css stylesheet for use of this package is algorithm2e.css and is generated
by make_css.pl. Since line numbers are positioned absolutely using a distance
which is calculated based on how wide the margins, padding, and border are
for the block-divs the script will automatically calculate these sums and
generate the css code. There are many options at the beginning of the file so
feel free to play with them if you think the layout requires more/less 
whitespace, etc. 


Implemented Features
========================

Note that many of the commands in algorithm2e pertain to the style in which 
the algorithms are typeset (as opposed to the layout structure). The latexml
binding only handles the positioning, and the unimplemented style settings 
can be achieved by altering the css file.  

Package options
----------------

    option                  implemented
    ------------            ------------
    algo2e                  [ ]
    slide                   [ ]
    norelsize               [n]
    english                 [ ]
    french                  [ ]
    german                  [ ]
    protugues               [ ]
    czech                   [ ]                   
    onelanguage             [ ]
    figure                  [ ]
    endfloat                [ ]
    algopart                [ ]
    algochapter             [ ]
    algosection             [ ]
    procnumbered            [ ]
    boxed                   [x]
    boxruled                [x]
    ruled                   [x]
    algoruled               [x]
    tworuled                [x]
    plain                   [x]
    lined                   [x]
    vlined                  [x]
    noline                  [x]
    linesnumbered           [x]
    linesnumberedhidden     [x]
    commentsnumbered        [x]
    inoutnumbered           [x]
    rightnl                 [ ]
    titlenumbered           [ ]
    titlenonumbered         [ ]
    resetcount              [x]
    noresetcount            [x]
    algonl                  [ ]
    longend                 [x]
    shortend                [x]
    noend                   [x]
    dotocloa                [ ]
    scright                 [ ]
    scleft                  [ ]
    fillcomment             [ ]
    nofillcomment           [ ]
    nokwfunc                [ ]
    
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    


Commands provided with the package
-----------------------------------

### Basic typesetting commands

    command                     description                         implemented
    ------------                -------------------                 ------------
    \;                          marks the end of the line                   [x]
    \DontPrintSemicolon         stops printing ';' at the end of lines      [x] 
    \PrintSemicolon             starts printing ';' at the end of lines     [x]
    \BlankLine                  prints a blank line                         [x]
    \Indp                       increases indent                            [ ]
    \Indm                       decreases indent                            [ ]
                        
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    
### environment level stuff
    
#### caption title and changing reference

    command                     description                         implemented
    ------------                -------------------                 ------------
    \caption{title}             inserts entry into list of                  [x] 
                                algorithms and puts a title on 
                                the algorithm
    \TitleOfAlgo{.}             gives an algorithm a title but no           [ ]
                                caption, and therefore no entry 
                                in the list of algorithms
    \listofalgorithms           inserts the list of all algorithms          [ ]
                                having a caption
    \SetAlgoRefName{ref}        changes reference of algorithm to           [ ] 
                                allow naming but not numbering
    \SetAlgoRelativeSize{int}   sets the output size of reference           [ ]
                                in list of algorithms   
                        
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    
#### setting style and layout of algorithm, caption, and title

    command                     description                         implemented
    ------------                -------------------                 ------------
    \SetAlgoCaptionSeparator{.} sets the separator between the              [x]
                                title of the algorithms, default
                                is ':'
    \SetAlCapSkip{length}       sets the distance between the               [n]
                                algorithm body and the caption in
                                plain and boxed mode
    \SetAlCapHSkip{length}      set the distance between the                [n]
                                caption and the algorithm body in
                                ruled mode
    \SetTitleStyle{style}{size} sets typography and size of titles          [ ]
                                defined with \TitleofAlgo{}
    \NoCaptionOfAlgo            doesn't print "Algorithm" and number        [ ]
                                in the caption, only in ruled and
                                algoruled mode (for short algos)
    \RestoreCaptionOfAlgo       restores correct captions corrupted         [ ]
                                by \NoCaptionOfAlgo 
    \SetAlgoCaptionLayout{.}    sets the global style of the caption,       [ ]
                                argument is the name of a macro taking
                                one argument (the caption text)
    
                                                                                        
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented


### line numbering
    
#### labeling and numbering

    command                     description                         implemented
    ------------                -------------------                 ------------
    \AlgoLine                   counter used to number the lines            [x]
    \LinesNumbered              makes lines of all following                [x]
                                algorithms to be auto-numbered              
    \LinesNumberedHidden        makes lines auto-numbered, but              [x] 
                                not shown
    \LinesNotNumbered           makes lines not auto-numbered               [x]
    \nllabel{label}             labels lines when auto-numbering            [x]
                                is active
    \nl                         numbers the line, must begin the line       [x]
    \lnl{label}                 numbers and labels the line                 [x]
    \nlset{text}                works like \nl except that the
                                additional argument is the text
                                to put at the beginning of the line
    \lnlset{text}{label}        works like \nlset but with text             [x]
    \ShowLn                     shows the number of the line when           [x]
                                they are currently hidden
    \ShowLn{label}              shows the number of the line when           [x]
                                hidden, and adds label
                            
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    
#### setting the style of lines

    command                     description                         implemented
    ------------                -------------------                 ------------
    \SetNlSty{font}{txt}{txt}   defines how to print line numbers,          [x]
                                will print <font><txt>#<txt>, 
                                default is {textbf}{}{}
    \SetNlSkip{length}          sets the value of the space                 [n]
                                between line numbers and the text
    \SetAlgoNLRelativeSize{.}   sets the relative size of line numbers,     [n]
                                by default they are two sizes smaller
                                than the algorithm text
                            
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented


### Standard styles
    
#### standard font shapes and styles

    command                     description                         implemented
    ------------                -------------------                 ------------
    \SetAlFnt                   defines \AlFnt which is a                   [x]
                                macro that is executed at the
                                start of any algorithm to define
                                the fonts
    \KwSty{txt}                 sets txt in kw type style                   [x]
    \SetKwSty{}                 defines \KwStyl                             [x]
    \FuncSty{txt}               sets txt in function style                  [x]
    \SetFuncSty{}               defines \FuncSty                            [x]
    \ArgSty                                                                 [x]
    \SetArgSty                                                              [x]
    \DataSty                                                                [x]
    \SetDataSty                                                             [x]
    \CommentSty                                                             [x]
    \SetCommentSty                                                          [x]
    \NlSty                                                                  [x]
    \SetN1Sty                                                               [x]
    \ProcNameSty                                                            [x]
    \SetProcNameSty                                                         [x]
    \ProcArgSty                                                             [x]
    \SetProcArgSty                                                          [x]
                            
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    
#### caption and title font style

    command                     description                         implemented
    ------------                -------------------                 ------------
                            
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    
### Controlling Layout
    
    
    command                     description                         implemented
    ------------                -------------------                 ------------
    \SetAlgoVlined              prints vertical line followed by            [x]
                                little horizontal line to denote
                                a block
    \SetNoline                  doesn't print vertical lines                [x]
    \SetAlgoLines               prints vertical lines between block         [x]
                                keywords like start/end
    \SetAlgoLongEnd                                                         [x]
    \SetAlgoShortEnd                                                        [x]
    \SetAlgoNoEnd                                                           [x]
    \SetInd{}{}                                                             [n]
    \Setvlineskip                                                           [n]
    \SetAlgoSkip                                                            [n]
    \SetAlgoInsideSkip                                                      [n]
    \algomargin                                                             [n]
    \IncMargin                                                              [ ]
    \DecMargin                                                              [ ]
    \SetAlgoNlRelativeSize                                                  [n]
    \SetAlgoCaptionLayout                                                   [n]
    
                            
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    
### Comments
    
    
    command                     description                         implemented
    ------------                -------------------                 ------------
    \SetSideCommentLeft                                                     [ ]
    \SetSideCommentRight                                                    [ ]
    \SetFillComment                                                         [ ]
    \SetNoFillComment                                                       [ ]
    
                            
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented
    
    
Predefined Language Keywords
-----------------------------------

    command                     description                         implemented
    ------------                -------------------                 ------------
    \KwIn                                                                   [x]
    \KwOut                                                                  [x]
    \KwData                                                                 [x]
    \KwResult                                                               [x]
    
    \KwTo                                                                   [x]
    \KwRet                                                                  [x]
    \Return                                                                 [x]
    \Begin{}                                                                [x]
    \Begin(){}                                                              [x]
    
    \tcc{}                                                                  [ ]
    \tcc*{}                                                                 [ ]
    \tcc*[r|l|hf]{}                                                         [ ]
    \tcp{}                                                                  [ ]
    \tcp*{}                                                                 [ ]
    \tcp*[r|l|h|f]{}                                                        [ ]
    
    \If{}{}                                                                 [x]
    \If(){}{}                                                               [x]
    \uIf{}{}                                                                [x]
    \uIf(){}{}                                                              [x]
    \lIf{}{}                                                                [x]
    \lIf(){}{}                                                              [x]
    \ElseIf{}                                                               [x]
    \ElseIf(){}                                                             [x]
    \uElseIf{}                                                              [x]
    \uElseIf(){}                                                            [x]
    \lElseIf{}                                                              [x]
    \lElseIf(){}                                                            [x]
    \Else{}                                                                 [x]
    \Else(){}                                                               [x]
    \uElse{}                                                                [x]
    \uElse(){}                                                              [x]
    \lElse{}                                                                [x]
    \lElse(){}                                                              [x]
    \eIf{}{}{}                                                              [x]
    \eIf(){}{}(){}                                                          [x]
    \eIf(){}{}{}                                                            [x]
    \eIf{}{}(){}                                                            [x]
                            
    \Switch(){}{}                                                           [x]
    \Switch{}{}                                                             [x]
    \Case{}{}                                                               [x]
    \Case(){}{}                                                             [x]
    \uCase{}{}                                                              [x]
    \uCase(){}{}                                                            [x]
    \lCase{}{}                                                              [x]
    \lCase(){}{}                                                            [x]
    \Other{}                                                                [x]
    \Other(){}                                                              [x]
    \lOther{}                                                               [x]
    \lOther(){}                                                             [x]
    
    \For{}{}                                                                [x]
    \For(){}{}                                                              [x]
    \lFor{}{}                                                               [x]
    \lFor(){}{}                                                             [x]
    \While{}{}                                                              [x]
    \While(){}{}                                                            [x]
    \lWhile{}{}                                                             [x]
    \lWhile(){}{}                                                           [x]
    \ForEach{}{}                                                            [x]
    \ForEach(){}{}                                                          [x]
    \lForEach{}{}                                                           [x]
    \lForEach(){}{}                                                         [x]
    \ForAll{}{}                                                             [x]
    \ForAll(){}{}                                                           [x]
    \lForAll{}{}                                                            [x]
    \lForAll(){}{}                                                          [x]
        
    \Repeat{}{}                                                             [x]
    \Repeat(){}{}()                                                         [x]
    \Repeat(){}{}                                                           [x]
    \Repeat{}{}()                                                           [x]
    \lRepeat{}{}                                                            [x]
    \lRepeat(){}{}                                                          [x]
                            
    legend: 
    [ ] unimplemented
    [x] implemented
    [n] not applicable, wont be implemented