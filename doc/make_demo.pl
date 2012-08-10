#!/usr/bin/perl

use Cwd 'abs_path';
use File::Basename;

chdir dirname(abs_path($0)) 
    or die "Failed to change to directory of script $!\n";


# ------------------------------------------------------------------------------
#                               Style Parameters
# ------------------------------------------------------------------------------

# all units are in pixels

$debugMargin    = 1;    # how much margin to add in debug mode

$debugSize      = 10;   # how big to make zero sized elements in debug mode

$borderWidth    = 1;    # how wide are the border and lines

# how wide are the rule which are drawn in the "ruled" algorithm2e style
$ruleWidth      = 2*$borderWidth;
                        
$blockMargin    = 5;    # the size of the margin in a code block with
                        # depth > 0, see layout.svg 
$blockPadding   = 5;    # the size of the padding in a code block with
                        # depth > 0, see layout.svg 
$blockDrop      = 5;    # how much margin to put underneith a code block
                        # with depth > 0
$blockContentPad= 2;    # how much the contents of a code block are padded
$underbarWidth  = 10;   # if the algorithm has the style of using a horizontal
                        # line at the end of a codeblock instead of the word
                        # "end" (compact style) then this is how wide that 
                        # horizontal bar should be
$maxDepth       = 10;   # the maximum depth expected, this is the number of
                        # levels of style classes that are generated
$lineIndent     = 20;   # how much of an indent second and susequent lines of
                        # text should have when a single line of code is wrapped
                        # into multiple lines of text
$lineNoPad      = 5;    # how much the line numbers should be padded from the
                        # right, will be the distance between the lineno and the
                        # text of the line
$minWidth       = 600;  # minimum width of an algorithm block


# this is where we'll store the calculated offsets for positioning line numbers
@offsets        = ();

for $debug (0,1)
{
 
    # in debug mode, we'll comment out the colored borders and the extra
    # margins   
    if($debug)
    {
        $openComment = "";
        $closeComment= "";
    }
    else
    {
        $openComment = "/*";
        $closeComment= "*/";
    }
    
    # calculate the value of the "right" field for the lineno elements
    for ($depth=0; $depth < $maxDepth; $depth++)
    {
        $offsets[$depth] = ($blockMargin+$borderWidth+$blockPadding) * $depth;
        if($debug)
        {
            $offsets[$depth]+= 3*($borderWidth+$debugMargin)
                               + $debugSize;
        }
    }
    
        
    $document = <<"HERE";
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html>
  <head>
    <title>LaTeXML Algorithm2e Layout Fiddle</title>
    <style type="text/css">
    
div.algorithm2e
{
  margin-left:    auto;
  margin-right:   auto;
  
  width:     80%;
  min-width: ${minWidth}px;
}

div.algorithm2e-boxed
{
    border: ${borderWidth}px solid black;       
}

div.algorithm2e-ruled
{
    border-top:     ${ruleWidth}px solid black;
    border-bottom:  ${ruleWidth}px solid black;       
}
      
div.algorithm2e-right
{
$openComment
  border:      ${borderWidth}px solid #c900b8;
  margin:      ${debugMargin}px;
$closeComment
  margin-left: 50px;
  padding:     1px;
}
          
div.algorithm2e-block-0
{
$openComment
  border:  ${borderWidth}px solid #aaaaaa;
  margin:  ${debugMargin}px;
$closeComment
  padding: 1px;
}

div.algorithm2e-block-x
{
$openComment
  border:         ${borderWidth}px solid #aaaaaa;
  margin:         ${debugMargin}px;
$closeComment
  position:       relative;
  border-left:    ${borderWidth}px solid black;
  padding:        ${blockContentPad}px;
  margin-left:    ${blockMargin}px;
  padding-left:   ${blockPadding}px;
}

div.algorithm2e-block-vlined
{
    margin-bottom:  ${blockDrop}px;
}

div.algorithm2e-underbar
{
  position:  absolute;
  height:    0px;
  width:          ${underbarWidth}px;
  bottom:         -${borderWidth}px;
  left:           -${borderWidth}px;
}

div.algorithm2e-underbar-vlined
{
    border-bottom:  ${borderWidth}px solid black;
}

div.algorithm2e-line
{
  position:   relative;
}

div.algorithm2e-lineno-pos
{
$openComment
  border:   ${borderWidth}px solid #0e9600;
$closeComment
  position: relative;
  width:    0px;
  height:   0px;
}

span.algorithm2e-lineno-anchor
{
  display:        inline-block;
  vertical-align: bottom;
  position:       relative;
  width:    0px;
  height:   0px;
$openComment
  border:   ${borderWidth}px solid #0e9600;
  background-color: #0e9600;
  width:    ${debugSize}x;
  height:   ${debugSize}px;
$closeComment
}

p.algorithm2e-lineno
{
$openComment
  border:     ${borderWidth}px solid #f5b131;
$closeComment
  text-align:    right;
  position:      absolute;
  top:           0px;
  padding:       0px;
  padding-right: ${lineNoPad}px;
  margin:        0px;
  font-size:     smaller;
}

span.algorithm2e-lineno
{
$openComment
  border:           ${borderWidth}px solid #f5b131;
  background-color: #f5b131;
$closeComment
  font-size:     smaller;
  display:       inline-block;
  text-align:    right;
  position:      absolute;
  bottom:        0px;
  padding:       0px;
  padding-right: ${lineNoPad}px;
  margin:        0px;
}

p.algorithm2e-line-text
{
$openComment
  border:      ${borderWidth}px solid #001dff;
$closeComment
  padding:      2px;
  margin:       0px;
  padding-left: ${lineIndent}px;
  text-indent:  -${lineIndent}px;
}

div.algorithm2e-caption
{
  border:        ${borderWidth}px solid black;
  margin:        ${debugMargin}px;
  margin-left:   auto;
  margin-right:  auto;
  width:         60%;
  min-width:     ${minWidth}px;
  padding:       1px;
}

div.algorithm2e-caption-ruled
{
  border-bottom: ${ruleWidth}px solid black;
  margin:        ${debugMargin}px;
  padding:       1px;
}

span.algorithm2e-label
{
  font-weight: bold;
}

span.algorithm2e-kw
{
  font-family: monospace;
  font-weight: bold;
}
                
HERE


for($depth=0; $depth < $maxDepth; $depth++)
{
    $document .= sprintf(
        "p.algorithm2e-lineno-%d{ right: %4dpx; }\n", 
        $depth,
        $offsets[$depth]);
        
    $document .= sprintf(
        "span.algorithm2e-lineno-%d{ right: %4dpx; }\n", 
        $depth,
        $offsets[$depth]);
}

$document .= <<"HERE";
                
      </style>
    </head>
    
    <body>
    
    
  <div class="algorithm2e algorithm2e-boxed">
    <div class="algorithm2e-right">
      <div class="algorithm2e-block-0">
        <div class="algorithm2e-line">
          <div class="algorithm2e-lineno-pos">
            <p class="algorithm2e-lineno algorithm2e-lineno-0">1</p>
          </div>

          <p class="algorithm2e-line-text">
          blah
          </p>
        </div>

        <div class="algorithm2e-line">
          <div class="algorithm2e-lineno-pos">
            <p class="algorithm2e-lineno algorithm2e-lineno-0">2</p>
          </div>

          <p class="algorithm2e-line-text">blah</p>
        </div>

        <div class="algorithm2e-line">
          <div class="algorithm2e-lineno-pos">
            <p class="algorithm2e-lineno algorithm2e-lineno-0">3</p>
          </div>

          <p class="algorithm2e-line-text"><span class=
          "algorithm2e-kw">while</span> some condition <span class=
          "algorithm2e-kw">do</span></p>
        </div>

        <div class="algorithm2e-block-x">
          <div class="algorithm2e-line">
            <div class="algorithm2e-lineno-pos">
              <p class="algorithm2e-lineno algorithm2e-lineno-1">4</p>
            </div>

            <p class="algorithm2e-line-text">blah</p>
          </div>

          <div class="algorithm2e-line">
            <div class="algorithm2e-lineno-pos">
              <p class="algorithm2e-lineno algorithm2e-lineno-1">5</p>
            </div>

            <p class="algorithm2e-line-text"><span class=
            "algorithm2e-kw">if</span> condition <span class=
            "algorithm2e-kw">then</span></p>
          </div>

          <div class="algorithm2e-block-x">
            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                  <p class="algorithm2e-lineno algorithm2e-lineno-2">6</p>
                </div>
              
              <p class="algorithm2e-line-text">
              This is one really
              long line see how subsequent parts of it (i.e.
              wrapped parts) are slightly indented? I dont think
              the latex package will do that for you, but this
              binding can. Also, note that the line number for this
              line is top-aligned. Nifty huh?</p>
            </div>

            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                <p class="algorithm2e-lineno algorithm2e-lineno-2">7</p>
              </div>

              <p class="algorithm2e-line-text">blah</p>
            </div>
          </div>

          <div class="algorithm2e-line">
            <div class="algorithm2e-lineno-pos">
              <p class="algorithm2e-lineno algorithm2e-lineno-1">200</p>
            </div>

            <p class="algorithm2e-line-text"><span class=
            "algorithm2e-kw">else</span></p>
          </div>

          <div class="algorithm2e-block-x">
            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                <p class="algorithm2e-lineno algorithm2e-lineno-2">201</p>
              </div>

              <p class="algorithm2e-line-text">blah</p>
            </div>

            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                <p class="algorithm2e-lineno algorithm2e-lineno-2">202</p>
              </div>

              <p class="algorithm2e-line-text">blah</p>
            </div>

            <div class="algorithm2e-underbar"></div>
          </div>
          
          <div class="algorithm2e-line">
            <div class="algorithm2e-lineno-pos">
              <p class="algorithm2e-lineno algorithm2e-lineno-1">203</p>
            </div>

            <p class="algorithm2e-line-text">
                <span class="algorithm2e-kw">end</span>
            </p>
          </div>

          <div class="algorithm2e-underbar"></div>
        </div>
        
        <div class="algorithm2e-line">
          <div class="algorithm2e-lineno-pos">
            <p class="algorithm2e-lineno algorithm2e-lineno-0">204</p>
          </div>
    
          <p class="algorithm2e-line-text">
              <span class="algorithm2e-kw">end</span>
          </p>
        </div>
      </div>
    </div>
  </div>
  <div class="algorithm2e-caption">
    <span class="algorithm2e-label">Algorithm 1:</span>
    <span class="algorithm2e-label-text">
    This is a demonstration of the [boxed, lined] style. Note that this is a 
    nice long caption that spans many many lines and has lots of great
    information about the algorithm. It really is very long. Look
    at how many lines it takes up.</span>
  </div>
  
  <div style="height: 50px"></div>
  
  <div class="algorithm2e algorithm2e-ruled">
    <div class="algorithm2e-caption-ruled">
        <span class="algorithm2e-label">Algorithm 2:</span>
        <span class="algorithm2e-label-text">
          This is a demonstration of the [ruled, vlined] style. We should keep
          the caption pretty short so that it doesn't take up a lot of space
        </span>
    </div>
    <div class="algorithm2e-right">
      <div class="algorithm2e-block-0">
        <div class="algorithm2e-line">
          <div class="algorithm2e-lineno-pos">
            <p class="algorithm2e-lineno algorithm2e-lineno-0">1</p>
          </div>

          <p class="algorithm2e-line-text">blah</p>
        </div>

        <div class="algorithm2e-line">
          <div class="algorithm2e-lineno-pos">
            <p class="algorithm2e-lineno algorithm2e-lineno-0">2</p>
          </div>

          <p class="algorithm2e-line-text">blah</p>
        </div>

        <div class="algorithm2e-line">
          <div class="algorithm2e-lineno-pos">
            <p class="algorithm2e-lineno algorithm2e-lineno-0">3</p>
          </div>

          <p class="algorithm2e-line-text"><span class=
          "algorithm2e-kw">while</span> some condition <span class=
          "algorithm2e-kw">do</span></p>
        </div>

        <div class="algorithm2e-block-x algorithm2e-block-vlined">
          <div class="algorithm2e-line">
            <div class="algorithm2e-lineno-pos">
              <p class="algorithm2e-lineno algorithm2e-lineno-1">4</p>
            </div>

            <p class="algorithm2e-line-text">blah</p>
          </div>

          <div class="algorithm2e-line">
            <div class="algorithm2e-lineno-pos">
              <p class="algorithm2e-lineno algorithm2e-lineno-1">5</p>
            </div>

            <p class="algorithm2e-line-text"><span class=
            "algorithm2e-kw">if</span> condition <span class=
            "algorithm2e-kw">then</span></p>
          </div>

          <div class="algorithm2e-block-x">
            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                <p class="algorithm2e-lineno algorithm2e-lineno-2">6</p>
              </div>

              <p class="algorithm2e-line-text">This is one really
              long line see how subsequent parts of it (i.e.
              wrapped parts) are slightly indented? I dont think
              the latex package will do that for you, but this
              binding can. Also, note that the line number for this
              line is top-aligned. Nifty huh?</p>
            </div>

            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                <p class="algorithm2e-lineno algorithm2e-lineno-2">7</p>
              </div>

              <p class="algorithm2e-line-text">blah</p>
            </div>
            
            <div class="algorithm2e-underbar"></div>
          </div>

          <div class="algorithm2e-line">
            <div class="algorithm2e-lineno-pos">
              <p class="algorithm2e-lineno algorithm2e-lineno-1">200</p>
            </div>

            <p class="algorithm2e-line-text">
                <span class="algorithm2e-kw">else</span>
            </p>
          </div>

          <div class="algorithm2e-block-x algorithm2e-block-vlined">
            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                <p class="algorithm2e-lineno algorithm2e-lineno-2">201</p>
              </div>

              <p class="algorithm2e-line-text">blah</p>
            </div>

            <div class="algorithm2e-line">
              <div class="algorithm2e-lineno-pos">
                <p class="algorithm2e-lineno algorithm2e-lineno-2">202</p>
              </div>

              <p class="algorithm2e-line-text">blah</p>
            </div>

            <div class="algorithm2e-underbar algorithm2e-underbar-vlined"></div>
          </div>
          
          <div class="algorithm2e-underbar algorithm2e-underbar-vlined"></div>
        </div>
      </div>
    </div>
  </div>
  
  <div style="height: 50px"></div>
  
  <div class="algorithm2e algorithm2e-boxed">
    <div class="algorithm2e-right">
      <div class="algorithm2e-block-0">
        <div class="algorithm2e-line">
          <p class="algorithm2e-line-text">
          <span class="algorithm2e-lineno-anchor">
              <span class="algorithm2e-lineno algorithm2e-lineno-0">1</span>
          </span>
          blah
          </p>
        </div>

        <div class="algorithm2e-line">
          <p class="algorithm2e-line-text">
          <span class="algorithm2e-lineno-anchor">
              <span class="algorithm2e-lineno algorithm2e-lineno-0">2</span>
          </span>
          blah</p>
        </div>

        <div class="algorithm2e-line">
          <p class="algorithm2e-line-text">
          <span class="algorithm2e-lineno-anchor">
              <span class="algorithm2e-lineno algorithm2e-lineno-0">3</span>
          </span>
          <span class=
          "algorithm2e-kw">while</span> some condition <span class=
          "algorithm2e-kw">do</span></p>
        </div>

        <div class="algorithm2e-block-x">
          <div class="algorithm2e-line">
            <p class="algorithm2e-line-text">
            <span class="algorithm2e-lineno-anchor">
              <span class="algorithm2e-lineno algorithm2e-lineno-1">4</span>
            </span>
            blah
            </p>
          </div>

          <div class="algorithm2e-line">
            <p class="algorithm2e-line-text">
            <span class="algorithm2e-lineno-anchor">
              <span class="algorithm2e-lineno algorithm2e-lineno-1">5</span>
            </span>
            <span class=
            "algorithm2e-kw">if</span> condition <span class=
            "algorithm2e-kw">then</span></p>
          </div>

          <div class="algorithm2e-block-x">
            <div class="algorithm2e-line">
              <p class="algorithm2e-line-text">
                <span class="algorithm2e-lineno-anchor">
                  <span class="algorithm2e-lineno algorithm2e-lineno-2">6</span>
                </span>
              This is one really
              long line see how subsequent parts of it (i.e.
              wrapped parts) are slightly indented? I dont think
              the latex package will do that for you, but this
              binding can. Also, note that the line number for this
              line is top-aligned. Nifty huh?</p>
            </div>

            <div class="algorithm2e-line">
              <p class="algorithm2e-line-text">
              <span class="algorithm2e-lineno-anchor">
                  <span class="algorithm2e-lineno algorithm2e-lineno-2">7</span>
                </span>
              blah</p>
            </div>
          </div>

          <div class="algorithm2e-line">
            <p class="algorithm2e-line-text">
            <span class="algorithm2e-lineno-anchor">
                  <span class="algorithm2e-lineno algorithm2e-lineno-1">200</span>
                </span>
            <span class=
            "algorithm2e-kw">else</span></p>
          </div>

          <div class="algorithm2e-block-x">
            <div class="algorithm2e-line">
              <p class="algorithm2e-line-text">
              <span class="algorithm2e-lineno-anchor">
                  <span class="algorithm2e-lineno algorithm2e-lineno-2">201</span>
                </span>
                blah</p>
            </div>

            <div class="algorithm2e-line">
              <p class="algorithm2e-line-text">
              <span class="algorithm2e-lineno-anchor">
                  <span class="algorithm2e-lineno algorithm2e-lineno-2">202</span>
                </span>
                blah</p>
            </div>

            <div class="algorithm2e-underbar"></div>
          </div>
          
          <div class="algorithm2e-line">
            <p class="algorithm2e-line-text">
                <span class="algorithm2e-lineno-anchor">
                  <span class="algorithm2e-lineno algorithm2e-lineno-1">203</span>
                </span>
                <span class="algorithm2e-kw">end</span>
            </p>
          </div>

          <div class="algorithm2e-underbar"></div>
        </div>
        
        <div class="algorithm2e-line">
          <p class="algorithm2e-line-text">
            <span class="algorithm2e-lineno-anchor">
                  <span class="algorithm2e-lineno algorithm2e-lineno-0">204</span>
                </span>
              <span class="algorithm2e-kw">end</span>
          </p>
        </div>
      </div>
    </div>
  </div>
  <div class="algorithm2e-caption">
    <span class="algorithm2e-label">Algorithm 1:</span>
    <span class="algorithm2e-label-text">
    This demonstration is the same as the first but uses an alternate method
    of anchoring the line labels that hopefully will keep them bottom-aligned
    with the baseline of the first text line in the paragraph.</span>
  </div>
  
  </body>
</html>

HERE
    
    
    
    if($debug)
    {
        open ($outfile, ">", "demo_debug.html")
    }
    else
    {
        open ($outfile, ">", "demo.html")
    } 
        
    print $outfile $document;
    close($outfile);
    
}