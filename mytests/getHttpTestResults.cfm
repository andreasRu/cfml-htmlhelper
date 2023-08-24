<cfscript>
	htmlHelperService=new components.HtmlHelper();
	include template="./includes/default.cfm";
    cfcontent( reset = "true" );
	writeoutput( 
		    htmlHelperService.minifyHtml( 
			htmlString=request.testArgs.tmpHtmlInput, 
			stripScriptAndCssComments=true,
			stripHtmlComments=true, 
			stripEmptySpacesBetweenHtmlElements=true ) 
	);
</cfscript>