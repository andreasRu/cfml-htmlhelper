<!--- minifyHtml.cfm: minifyHtml() --->
<!--- Make sure to override admin setting and read template with correct charset(UTF-8) --->
<cfprocessingdirective pageEncoding="UTF-8">
<cfsavecontent variable="someHtmlBlock">
	<!DOCTYPE html>
	<head>
<title>Hot CFML Page & content</title>
				<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style> /* some comment 
*/ 
.someClass{ 
	font-size: 1rem; /* set font size */        } </style>
																				
																									
																									
<meta name="description" content="Just some Example">
<link rel="stylesheet" href="css/main.css">
		</head> <body>
<!--     Say "Hello" to the CFML coders! --> <p>Hello to all CFML devs 😀 🤩 around the 🌎!!! </p>
<script>    /*    this is just some 
		embedded JavaScript          */
console.log('Log Something'); // this is just a trailing comment one Javascript
console.log('Log Something else'); // this is another trailing comment with a trailing double// 
// a third javascript comment beginning at the line; 
    // a fourth javascript comment in the middle; 
// and some more comment with another outcommented Javascript // console.log('this shouldn't show!'); 
     console.log('Log final');  
	 
	 </script>        </body> </html>
	</cfsavecontent>
	<cfscript>
	htmlHelperService=new components.HtmlHelper();
	cfcontent( reset = "true" );
	writeoutput( 
		htmlHelperService.minifyHtml( 
			htmlString=someHtmlBlock, 
			compressWhitespaces=true,
			stripScriptAndCssComments=true,
			stripHtmlComments=false, 
			stripEmptySpacesBetweenHtmlElements=true )
	);
</cfscript>