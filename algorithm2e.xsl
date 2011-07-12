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

<func:function name="f:alternate">
  <xsl:param name="node"/>
    <xsl:choose>
      <xsl:when test="@refnum mod 2 = 0">
        <func:result>line-a</func:result>
      </xsl:when>
      <xsl:otherwise>
        <func:result>line-b</func:result>
      </xsl:otherwise>
    </xsl:choose>
</func:function>

<func:function name="f:depth">
    <func:result> <xsl:value-of select="./@depth"/> </func:result>
</func:function>

<xsl:template match="algorithm2e:algorithm" xml:space="preserve">
  <div class="algorithm2e-algorithm">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="algorithm2e:algorithm/algorithm2e:block" xml:space="preserve">
  <div class="algorithm2e-block-{f:depth}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template name="spacer.loop">
    <xsl:param name="i" />
    <xsl:param name="count" />

    <!--begin_: Line_by_Line_Output -->
    <xsl:if test="$i &lt;= $count">
    <div class="algorithm2e-spacer"></div>
    </xsl:if>

    <!--begin_: RepeatTheLoopUntilFinished-->
    <xsl:if test="$i &lt;= $count">
      <xsl:call-template name="spacer.loop">
        <xsl:with-param name="i">
          <xsl:value-of select="$i + 1"/>
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
</xsl:template>



<xsl:template match="algorithm2e:algorithm/algorithm2e:block/algorithm2e:line" xml:space="preserve">
  <div class="algorithm2e-line algorithm2e-{f:alternate(.)}">
    <div class="algorithm2e-lineno"><xsl:value-of select="./@refnum"/></div> 
    <xsl:call-template name="spacer.loop" xml:space="default">
      <xsl:with-param name="i">1</xsl:with-param>
      <xsl:with-param name="count"><xsl:value-of select="../@depth - 1"/></xsl:with-param>
    </xsl:call-template>     
    <xsl:apply-templates/>
  </div>
  <div style="clear: both;"></div>
</xsl:template>

</xsl:stylesheet>
