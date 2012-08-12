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

$labelMargin    = 50;   # how much margin to leave for line labels

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
$captionMargin  = 10;   # space to leave under algorithm before caption
$algoMargin     = 10;   # space to leave above and below the block


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
                                + $debugSize + 2*$borderWidth;
        }
    }
    
        
    $document = <<"HERE";
    
div.algorithm2e-container
{
    text-align:    center;
    margin-top:    ${algoMargin}px;
    margin-bottom: ${algoMargin}px;
}
    
div.algorithm2e
{
  text-align:     left;
  display: inline-block;
  max-width:     80%;
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
  margin-left: ${labelMargin}px;
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
  padding:    0px;
  margin:     0px;
}

div.algorithm2e-lineno-pos
{
  position: relative;
  width:    0px;
  height:   0px;
$openComment
  border:   ${borderWidth}px solid #0e9600;
  width:    ${debugSize}px;
  height:   ${debugSize}px;
$closeComment
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
  width:    ${debugSize}px;
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
  padding:      0px 2px;
  margin:       0px;
  padding-left: ${lineIndent}px;
  text-indent:  -${lineIndent}px;
}

div.algorithm2e-caption
{
$openComment
  border:        ${borderWidth}px solid black;
  margin:        ${debugMargin}px;
$closeComment
  margin-top:    ${captionMargin}px;
  text-align:    left;
  display:       inline-block;
  max-width:     60%;
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

div.algorithm2e-clear
{
     width:  0px;
     height: 0px;
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

$document .= "\n";
    
if($debug)
{
    open ($outfile, ">", "algorithm2e_debug.css")
}
else
{
    open ($outfile, ">", "algorithm2e.css")
} 
    
print $outfile $document;
close($outfile);
    
}