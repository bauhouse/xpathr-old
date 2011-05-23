<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<!-- Parameters -->
<xsl:param name="root" select="'http://www.example.com'" />
<xsl:param name="workspace" select="'http://www.example.com/workspace'" />
<xsl:param name="version" select="'001'" />
<xsl:param name="client-name" select="'Client Name'" />
<xsl:param name="project-title" select="'Project Title'" />

<xsl:template match="/">
	<html lang="en">
		<xsl:apply-templates select="data/site-maps/entry" />
	</html>
</xsl:template>

<xsl:template match="data/site-maps/entry">
	<head>
		<title>Site Map <xsl:value-of select="$version" /> | <xsl:value-of select="$project-title" /> | <xsl:value-of select="$client-name" /></title>
		<link rel="stylesheet" type="text/css" media="screen, print" href="{$workspace}/assets/sitemaps/css/slickmap.css" />
		<xsl:comment><![CDATA[[if IE 6]><link rel="stylesheet" type="text/css" href="]]><xsl:value-of select="$root"/><![CDATA[/workspace/assets/sitemaps/css/ie.css" media="screen" /><![endif]]]></xsl:comment>
	</head>
	<body>
		<div class="sitemap">
			<h1><xsl:value-of select="$client-name" /></h1>
			<h2>Site Map &#8212; Version <xsl:value-of select="$version" /></h2>
			<xsl:apply-templates select="site-map" />
		</div>
	</body>
</xsl:template>

<!-- Find h3 elements to build the site map navigation trees -->
<xsl:template match="site-map">
	<xsl:apply-templates select="h3" />
</xsl:template>

<!-- For each h2 create a ul element for each navigation tree -->
<xsl:template match="h3">
	<xsl:param name="columns" select="count(following-sibling::ul[1]/li) - 1" />
	<xsl:param name="class">
		<xsl:choose>
			<xsl:when test=". = 'Utility Nav'">utility-nav</xsl:when>
			<xsl:when test=". = 'Primary Nav'">primary-nav navigation col<xsl:value-of select="$columns" /></xsl:when>
			<xsl:when test=". = 'Secondary Nav'">secondary-nav navigation col<xsl:value-of select="$columns" /></xsl:when>
			<xsl:when test=". = 'Site Info'">utility-nav site-info</xsl:when>
		</xsl:choose>
	</xsl:param>
	<ul class="{$class}">
		<xsl:apply-templates select="following-sibling::ul[1]/li" mode="html" />
	</ul>
</xsl:template>

<!-- Default HTML Manipulation (The Ninja Technique) -->
<xsl:template match="*" mode="html">
	<xsl:element name="{name()}">
		<xsl:apply-templates select="* | @* | text()" mode="html"/>
	</xsl:element>
</xsl:template>
<xsl:template match="@*" mode="html">
	<xsl:attribute name="{name()}">
		<xsl:value-of select="."/>
	</xsl:attribute>
</xsl:template>

<!--
Apply an id of home to the Home page.
Find <li> elements with <a> elements and recursively process nodes with the Ninja Technique.
Find <li> elements that contain a text node and wrap the text in an <a> element.
-->
<xsl:template match="li" mode="html">
	<xsl:param name="id">
		<xsl:if test=". = 'Home' or ./a = 'Home'">home</xsl:if>
	</xsl:param>
	<xsl:element name="{name()}">
		<xsl:if test="$id = 'home'">
			<xsl:attribute name="id">home</xsl:attribute>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="a"><xsl:apply-templates select="* | @* | text()" mode="html" /></xsl:when>
			<xsl:when test="text()"><a href="#"><xsl:value-of select="normalize-space(text())" /></a><xsl:apply-templates select="*" mode="html" /></xsl:when>
		</xsl:choose>
	</xsl:element>
</xsl:template>

<xsl:template match="data">
	<section class="main">
		<article class="content">
			<header>
				<h1><xsl:value-of select="$client-name" /></h1>
				<h2><xsl:value-of select="$project-title" /></h2>
			</header>
			<p class="intro">These pages will serve as an overview of the project and an area to document the design and development process of the websites and online brand of <xsl:value-of select="$client-name" />.</p>
			<section id="sitemap-section" class="separate">
				<h3><a id="sitemaps" href="#sitemaps">Site Maps</a></h3>
				<ul class="menu status-menu">
					<li class="in-progress">
						<p>
							<span class="resource"><a href="{$root}/design/sitemaps/001/">Site Map 001</a></span>
							<span class="separator">&#8212;</span>
							<span class="date">May 18, 2011</span>
							<span class="separator">&#8212;</span>
							<span class="status">In Progress</span>
						</p>
					</li>
				</ul>
			</section>
		</article>
	</section>
</xsl:template>

<xsl:template match="data" mode="aside">
	<aside>
		<nav>
			<h3>Design</h3>
			<ul class="menu list-menu" style="position: relative; z-index: 10;">
				<li><a href="{$root}/{$root-page}/sitemaps/" class="current">Site Maps</a></li>
				<li><a href="{$root}/{$root-page}/wireframes/">Wireframes</a></li>
				<li><a href="{$root}/{$root-page}/templates/">Templates</a></li>
				<li><a href="{$root}/{$root-page}/layouts/">Layouts</a></li>
			</ul>
		</nav>
	</aside>
</xsl:template>

</xsl:stylesheet>