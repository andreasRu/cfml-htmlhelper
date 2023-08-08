<!--- minifyHtml.cfm: minifyHtml() --->
<!--- Make sure to override admin setting and read template with correct charset(UTF-8) --->
<cfprocessingdirective pageEncoding="UTF-8">
<cfsavecontent variable="someHtmlBlock">
	<!DOCTYPE html>
	<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<title>Some Html</title>
		<link rel="stylesheet" href="./style.css">
		<link rel="icon" href="./favicon.ico" type="image/x-icon">
	</head>
	<body>
		<main>
			<h1>This is just a sample page!</h1>  
		</main>
		<script src="index.js"></script>
	</body>
	</html>
	</cfsavecontent>
	<cfscript>
	htmlHelperService=new components.HtmlHelper();
	cfcontent( reset = "true" );
	writeoutput( 
		htmlHelperService.minifyHtml( someHtmlBlock )
	);
</cfscript>