<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom">


<xsl:template match="data" mode="header">

	<xsl:param name="show-logo" select="true()" />

	<div id="header">
		<div class="area">
			<div class="section">

				<xsl:if test="$show-logo = true()">
					<h1>
						<a href="{$root}/">
							Xpath <span>of the</span> Ninja
						</a>
					</h1>
					<p class="tagline">
						paste service for
						<acronym title="eXtensible Stylesheet Language Transformations">XSLT</acronym>
						code
					</p>
				</xsl:if>

				<div class="navigation">
					<form action="" method="post" class="create">
						<input type="submit" name="action[new-snippet]" value="Create new" />
					</form>
					<ul id="nav">
						<li>
							<a href="{$root}/">Home</a>
						</li>
						<li>
							<a href="{$root}/my-snippets/"><span>my</span> Snippets</a>
						</li>
						<li>
							<a href="{$root}/snippets/">Snippets</a>
						</li>
						<!-- <li>
							<a href="users">Users</a>
						</li> -->
						<li class="help">
							<a href="{$root}/help/">Help</a>
						</li>
					</ul>
				</div>

			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="data" mode="footer">
	<div id="footer">
		<div class="area">
			<ul class="section thirds">
				<li class="subsection complex">
					<div class="content snippets">
						<h5><a href="{$root}/snippets/">Snippets</a></h5>
						<ul>
							<xsl:apply-templates select="footer-snippet-list/entry" />
						</ul>
					</div>
				</li>
				<li class="subsection complex">
					<div class="content twitter">
						<h5><a href="http://twitter.com/search?q=%23spongebob">Twitter</a></h5>
						<ul>
							<xsl:apply-templates select="footer-twitter//atom:entry[position() &lt; 4]" />
						</ul>
					</div>
				</li>
				<li class="help subsection complex">
					<div class="content help">
						<h5><a href="{$root}/help/">Help</a></h5>
						<ul>
							<xsl:apply-templates select="footer-help-notes/entry">
								<xsl:sort select="order"/>
							</xsl:apply-templates>
						</ul>
					</div>
					<div class="content about">
						<h5>About</h5>
						<p>
							A project by <a href="http://github.com/alpacaaa/">Marco Sampellegrini</a>.<br />
							Built in <a href="http://symphony-cms.com/">Symphony CMS</a>.
						</p>
					</div>
				</li>
			</ul>
		</div>
	</div>
</xsl:template>


<xsl:template match="footer-snippet-list/entry">
	<li>
		<a href="{$root}/snippets/all/{uniq-id}/">
			<xsl:value-of select="title" />
		</a>
	</li>
</xsl:template>

<xsl:template match="footer-help-notes/entry">
	<li>
		<a href="{$root}/help/#note-{@id}">#<xsl:value-of select="order" /></a> - 
		<xsl:value-of select="question" />
	</li>
</xsl:template>

<xsl:template match="footer-twitter//atom:entry">
	<li>
		<xsl:value-of select="atom:content" disable-output-escaping="yes"/>
	</li>
</xsl:template>
</xsl:stylesheet>
