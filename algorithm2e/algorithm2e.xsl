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


<xsl:template match="ltx:float[contains(concat(' ',@class,' '), 'algorithm2e')]">
  <div class="algorithm2e-container">
  <div>
    <xsl:attribute name="class">
        <xsl:value-of select="./@class"/>    
    </xsl:attribute>
    <xsl:if test="contains(concat(' ',@class,' '), 'algorithm2e-ruled') or contains(concat(' ',@class,' '), 'algorithm2e-tworuled')">
      <xsl:apply-templates select="ltx:caption"/>
    </xsl:if>
    
    <div class="algorithm2e-right">
        <xsl:apply-templates select="ltx:inline-block|ltx:p"/>
    </div>
  </div>
  </div>
  <xsl:if test="contains(concat(' ',@class,' '), 'algorithm2e-plain') or contains(concat(' ',@class,' '), 'algorithm2e-boxed') ">
      <xsl:apply-templates select="ltx:caption"/>        
  </xsl:if>
</xsl:template>


<xsl:template match="ltx:inline-block[@class='algorithm2e-block-0']|ltx:inline-block[@class='algorithm2e-block-x']">
    <div>
      <xsl:attribute name="class">
          <xsl:value-of select="./@class"/>
      </xsl:attribute>
      <xsl:apply-templates select="ltx:inline-block|ltx:p"/>
    </div>
</xsl:template>

<xsl:template match="ltx:inline-block[@class='algorithm2e-block-0']|ltx:inline-block[@class='algorithm2e-block-x']|ltx:inline-block[@class='algorithm2e-line']|ltx:inline-block[@class='algorithm2e-lineno-pos']">
    <div>
      <xsl:attribute name="class">
          <xsl:value-of select="./@class"/>
      </xsl:attribute>
      <xsl:apply-templates select="ltx:inline-block|ltx:p"/>
    </div>
</xsl:template>

<!-- 
<xsl:template match="ltx:caption[@class='algorithm2e-caption']" xml:space="preserve">
  <div class="algorithm2e-caption">
    Algorithm <xsl:value-of select="../@refnum"/>. <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="ltx:inline-block[@class='algorithm2e-block']" xml:space="preserve">
    <div class="algorithm2e-block algorithm2e-block-{f:depth(.)}">
      <xsl:apply-templates/>
    </div>
</xsl:template>


<xsl:template match="ltx:inline-block[@class='algorithm2e-block']/ltx:p[@class='algorithm2e-line']" xml:space="preserve">
  <div class="algorithm2e-line algorithm2e-{f:alternate(.)}">
    <div class="algorithm2e-lineno algorithm2e-lineno-{f:depth(..)}"><xsl:value-of select="./@refnum"/></div> 
    <xsl:call-template name="spacer.loop" xml:space="default">
      <xsl:with-param name="i">1</xsl:with-param>
      <xsl:with-param name="count"><xsl:value-of select="../@depth - 1"/></xsl:with-param>
    </xsl:call-template>
    <div class="algorithm2e-linecontent algorithm2e-line-{f:depth(..)}">     
      <xsl:apply-templates/>
    </div>
  </div>
  <div style="clear: both;"></div>
</xsl:template>
 -->

</xsl:stylesheet>
