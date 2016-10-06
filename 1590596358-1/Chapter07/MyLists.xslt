<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">

	<script language="javascript">
	function toggleRssItem(theParentDiv, resourcePath)
	{
		// get the div id
		var parentId = theParentDiv.id;

		// get the child div
		var childDiv = document.getElementById(parentId + "__child");
		
		// toggle the display
		if (theParentDiv.src.indexOf("collapsePlus.gif") &gt; -1) {
			theParentDiv.src = resourcePath + "/collapseMinus.gif";
			childDiv.style.display = "";
		}
		else {
			theParentDiv.src = resourcePath + "/collapsePlus.gif";
			childDiv.style.display = "none";
		}
	}
	</script>

	<!-- Display all Contacts -->
	<xsl:call-template name="sectionBody">
		<xsl:with-param name="sectionTitle" select="'Contact Lists'"/>
		<xsl:with-param name="template" select="'Contacts'"/>
	</xsl:call-template>

	<!-- Display all Contacts -->
	<xsl:call-template name="sectionBody">
		<xsl:with-param name="sectionTitle" select="'Document Libraries'"/>
		<xsl:with-param name="template" select="'DocumentLibrary'"/>
	</xsl:call-template>

	<!-- Display all Event Lists -->
	<xsl:call-template name="sectionBody">
		<xsl:with-param name="sectionTitle" select="'Event Lists'"/>
		<xsl:with-param name="template" select="'Events'"/>
	</xsl:call-template>

	<!-- Display all Task Lists -->
	<xsl:call-template name="sectionBody">
		<xsl:with-param name="sectionTitle" select="'Task Lists'"/>
		<xsl:with-param name="template" select="'Tasks'"/>
	</xsl:call-template>

</xsl:template>

<xsl:template name="sectionBody">
<xsl:param name="sectionTitle"/>
<xsl:param name="template"/>
<table width="90%" cellpadding="0" cellspacing="0">
  <tr>
    <td vAlign="top" align="center" width="3%" class="ms-WPBody" valign="middle">
	<img id="{$template}" onclick="toggleRssItem(this,'/_layouts/images');" alt="Click here to expand/collapse item detail" src="/_layouts/images/collapsePlus.gif" border="0"/>  
    </td>
    <td class="ms-WPBody">
	<strong><xsl:value-of select="$sectionTitle"/></strong>
	<br/>
    </td>
  </tr>
</table>
<div id="{$template}__child" style="display: none;">
  <table width="90%" cellpadding="0" cellspacing="0">
    <tbody>
	<xsl:for-each select="/MyLists/MyLists">
	  <xsl:if test="$template=Template">
	    <tr>
             <td width="5%"/>
		<td class="ms-WPBody" valign="middle">
		  <a href="{Url}" target="_top">
		    <xsl:value-of select="Title"/>
		  </a>
              </td>
            </tr>
          </xsl:if>
        </xsl:for-each>
      </tbody>
    </table>
</div>
</xsl:template>

</xsl:stylesheet>
