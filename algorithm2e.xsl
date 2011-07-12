<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version     = "1.0"
    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
    xmlns:ltx   = "http://dlmf.nist.gov/LaTeXML"
    xmlns:algorithm2e  = "http://dlmf.nist.gov/LaTeXML/packages/algorithm2e"
    xmlns       = "http://www.w3.org/1999/xhtml"
    xmlns:string= "http://exslt.org/strings"
    xmlns:func  = "http://exslt.org/functions"
    xmlns:f     = "http://dlmf.nist.gov/LaTeXML/functions"
    extension-element-prefixes="func f"
    exclude-result-prefixes = "ltx f func string">

<xsl:template match="algorithm2e:algorithm" xml:space="preserve">
  <div class="{f:classes(.)}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="algorithm2e:algorithm/algorithm2e:line" xml:space="preserve">
  <div class="{f:classes(.)}">
    <span class="algorithm2e"> <xsl:value-of select="./@refnum"/> </span> <xsl:apply-templates/>
  </div>
</xsl:template>

</xsl:stylesheet>
