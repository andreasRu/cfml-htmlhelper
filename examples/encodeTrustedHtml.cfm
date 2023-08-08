<!--- /examples/encodeTrustedHtml.cfm: encodeTrustedHtml() --->
<!--- Make sure to override admin setting and read template with correct charset(UTF-8) --->
<cfprocessingdirective pageEncoding="UTF-8">
<cfsavecontent variable="someHtmlBlock">
	<div>
		Just adding some characters like " &amp; or & " ... both will create the same source.
		But you can add ä, ö, Ä, ü, é, ~ > or other characters here.
	</div>
</cfsavecontent>
<cfscript>
	htmlHelperService=new components.HtmlHelper();
	cfcontent( reset = "true" );
	writeoutput( 
		htmlHelperService.encodeTrustedHtml ( someHtmlBlock )
	);
</cfscript>