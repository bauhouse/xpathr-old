<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:oautput method="xml" indent="yes" />

  <xsl:template match="/">

    <result>
      <xsl:value-of select="source/paste" />
    </result>

  </xsl:template>
</xsl:stylesheet>