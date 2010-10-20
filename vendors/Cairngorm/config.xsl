<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:template match="/">
		<flex-config>
			<include-classes>
				<xsl:apply-templates select="node()|@*" />
			</include-classes>
		</flex-config>
	</xsl:template>
	
	<xsl:template match="node()|@*">
		<xsl:apply-templates select="node()|@*" />
	</xsl:template>
	

	<xsl:template match="classEntry/@path">
		<class>
			<xsl:value-of select="." />
		</class>
	</xsl:template>
	
</xsl:stylesheet>