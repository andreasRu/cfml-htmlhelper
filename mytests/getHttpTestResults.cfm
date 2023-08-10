<cfscript>
	htmlHelperService=new components.HtmlHelper();
	include template="./includes/default.txt";
    cfcontent( reset = "true" );
	writeoutput( 
		    htmlHelperService.minifyHtml( 
			htmlString=request.testArgs.tmpHtmlInput, 
			compressWhitespaces=true,
			stripScriptAndCssComments=true,
			stripHtmlComments=true, 
			stripEmptySpacesBetweenHtmlElements=false ) 
	);
</cfscript>