<?xml version="1.0" encoding="utf-8"?>
<!--
  algorithm2e bindings for latexml

  Copyright (C) 2012 Josh Bialkowski (jbialk@mit.edu)
 
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
 
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet
    version     = "1.0"
    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
    xmlns:ltx   = "http://dlmf.nist.gov/LaTeXML"
    xmlns       = "http://www.w3.org/1999/xhtml"
    xmlns:string= "http://exslt.org/strings"
    xmlns:func  = "http://exslt.org/functions"
    xmlns:f     = "http://dlmf.nist.gov/LaTeXML/functions"
    extension-element-prefixes="func f"
    exclude-result-prefixes = "ltx f func string">


<!--  
    The ltx:float element encapsulates the entire algorithm2e environment,
    when we encounter it, we need to setup the container div, which manages
    the alignment, and the shrink-wrapped div which can be styled to have
    various outlines or rules 
  -->
<xsl:template match="ltx:float[contains(concat(' ',@class,' '), 'algorithm2e')]" xml:space="preserve">
  <div class="algorithm2e-container">
  
  <!-- create a div and copy the class attribute from the ltx:float -->
  <div><xsl:attribute name="class"><xsl:value-of select="./@class"/></xsl:attribute>
  
    <!-- 
      if it's one of the ruled styles, then we put the caption here,
      before the content of the algorithm
    -->
    <xsl:if test="contains(concat(' ',@class,' '), 'algorithm2e-ruled') or contains(concat(' ',@class,' '), 'algorithm2e-tworuled')">
      <xsl:apply-templates select="ltx:caption"/>
    </xsl:if>
   
    <!-- 
      this div contains the contents of the algorithm, and has a margin on the
      left where the line number labels can go
    -->
    <div class="algorithm2e-right">
        <xsl:apply-templates select="ltx:inline-block|ltx:p"/>
    </div>
  </div>
  
  <!-- 
    this div just ensures that the caption isn't floated next to the
    algorithm, since the algorithm and the caption have inline-block
    display style
  -->
  <div class="algorithm2e-clear"></div>
  
  <!-- 
    if this algorithm is the plain or boxed style, then the caption goes 
    underneath it, here
  -->
  <xsl:if test="contains(concat(' ',@class,' '), 'algorithm2e-plain') or contains(concat(' ',@class,' '), 'algorithm2e-boxed') ">
      <xsl:apply-templates select="ltx:caption"/>        
  </xsl:if>
  </div>
</xsl:template>



<!-- 
  in the old method of line number label alignment, we map inline blocks to
  divs, so here we apply these mappings, and just copy the class attribute of
  the inline block to the div
-->
<xsl:template match="ltx:inline-block[@class='algorithm2e-block-0']|ltx:inline-block[@class='algorithm2e-block-x']|ltx:inline-block[contains(concat(' ',@class,' '),' algorithm2e-line ')]|ltx:inline-block[@class='algorithm2e-lineno-pos']" xml:space="preserve">
    <div><xsl:attribute name="class"><xsl:value-of select="./@class"/></xsl:attribute>
      <xsl:apply-templates select="ltx:inline-block|ltx:p"/>
    </div>
</xsl:template>

<!-- 
  in the new method of line number label alignment, we map inline blocks to
  <p> or <span> depending on their class name
-->
<xsl:template match="ltx:inline-block[@class='algorithm2e-line-text']" xml:space="preserve">
    <p><xsl:attribute name="class"><xsl:value-of select="./@class"/></xsl:attribute>
      <xsl:apply-templates select="ltx:inline-block|ltx:p"/>
    </p>
</xsl:template>

<xsl:template match="ltx:inline-block[@class='algorithm2e-lineno-anchor']|ltx:inline-block[contains(concat(' ',@class,' '), ' algorithm2e-lineno ')]" xml:space="preserve">
    <span><xsl:attribute name="class"><xsl:value-of select="./@class"/></xsl:attribute><xsl:apply-templates select="ltx:inline-block|ltx:p"/></span>
</xsl:template>

<!-- 
  in the new method of line number label alignment, we have some <p> elements
  which are sitting inside our inline-blocks... and we want those inline-blocks
  to be the <p> so we need to get rid of these <p>'s
-->
<xsl:template match="ltx:inline-block[@class='algorithm2e-line-text']//ltx:p" xml:space="preserve">
  <xsl:apply-templates />
</xsl:template>

<!-- 
  We want to process the algorithm2e caption differently than the normal
  captions, so we map the caption block to a div and then put the contants
  inside it
-->
<xsl:template match="ltx:caption[@class='algorithm2e-caption']" xml:space="preserve">
  <div class="algorithm2e-caption">
    <xsl:apply-templates/>
  </div>
</xsl:template>



</xsl:stylesheet>
