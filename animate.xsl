<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg">
  <xsl:output omit-xml-declaration="yes" />

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/*">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <animateTransform
        attributeName="transform"
        type="scale"
        from="1"
        to="0"
        dur="1s"
        repeatCount="indefinite"
        calcMode="discrete"
      />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
