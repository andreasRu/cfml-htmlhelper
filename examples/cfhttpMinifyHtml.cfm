<!--- cfhttpMinifyHtml.cfm: minifyHtml() --->
<!--- Make sure to override admin setting and read template with correct charset(UTF-8) --->
<cfprocessingdirective pageEncoding="UTF-8">
<cfscript>
	// get whitespace polluted wordpress page!
	cfhttp(method="GET", charset="utf-8", url="https://news.microsoft.com/source/", result="result" ) {};
	
	htmlHelperService=new components.HtmlHelper();
	cfcontent( reset = "true" );
	writeoutput( 
		htmlHelperService.minifyHtml( result.filecontent )
	);
</cfscript>