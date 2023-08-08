<cfsavecontent variable="htmlHead">
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<meta name="theme-color" content="&#x23;017f8e">
		<meta name="description" content="HtmlHelper.cfc: minifyHtml() to get rid of CFML generated whitespace, or use encodeTrustedHtml() to encode HTML of a trusted source that has unencoded characters in inner Html">
		<meta name="robots" content="index,follow">
		<meta itemprop="name" content="minifyHtml() and encodeTrustedHtml() | A basic Html Helper Component for CFML">
		<meta property="og:url" content="https://andreasru.github.io/cfml-htmlhelper/">
		<meta property="og:title" content="minifyHtml() and encodeTrustedHtml() | A basic Html Helper Component for CFML">
		<meta property="og:type" content="website">
		<meta property="og:site_name" content="A basic Html Helper Component for CFML">
		<meta property="og:description" content="HtmlHelper.cfc: minifyHtml() to get rid of CFML generated whitespace, or use encodeTrustedHtml() to encode HTML of a trusted source that has unencoded characters in inner Html">
		<title>HtmlHelper.cfc: minifyHtml() &amp; encodeTrustedHtml() in your CFML Projects</title>
		<link rel="stylesheet" href="libs/normalizecss/normalize.min.css">
		<link rel="stylesheet" href="libs/highlightjs/highlightjs_styles_default.min.css">
		<link rel="stylesheet" href="libs/highlightjs/highlightjs_atom-one-dark.min.css">
		<link rel="stylesheet" href="libs/main.css">
		<link rel="stylesheet" href="libs/open-sans.css">
	</head>

	<body>
		<span id="forkongithub">
			<a href="https://github.com/andreasRu/cfml-htmlhelper">
				Fork me on GitHub</a>
		</span>
</cfsavecontent>
<cfsavecontent variable="htmlFoot">
	<cfprocessingdirective pageEncoding="UTF-8">
	<p class="footer">Static version generated with the amazing❤️<br><a href="https://www.lucee.org/">Lucee CFML Engine</a></p>
	<!-- Launch highlightJS according its BSD 3-Clause License, Copyright 
		
		
		(c) 2006, Ivan Sagalaev -->  
	<script src="libs/highlightjs/highlight.min.js"></script>
	<script>
		const elements = document.querySelectorAll('code');
		elements.forEach((element) => {
			element.classList.add('language-html');
		});

		const aTags = document.querySelectorAll('a');
		aTags.forEach((element) => {
			element.setAttribute('target', '_blank');
		});

		hljs.highlightAll();
	</script>
	</body>

	</html>
</cfsavecontent>

<cfscript>
	cffile(action = "read", file = "#expandPath("./")#/README.md", variable = "someMarkdown", charset = "UTF-8");
	htmlHelperService=new components.HtmlHelper();
	cfcontent( reset = "true" );
	writeOutput( htmlHelperService.minifyHTML( htmlHelperService.encodeTrustedHtml(  htmlhead & markDownToHTML(
	someMarkdown ) & htmlfoot) ) );
</cfscript>
<!---<cfsavecontent variable="htmlTest">
<cfprocessingdirective pageEncoding="UTF-8">
<div class="someClass">
	I tend to add "€, ä, &, é, ß" and I 
	even might tend to add a > (greater sign)
	directly into my html 😲, because I'm
	a lazy content writer and I don't like 
	adding those as html encoded characters manually!
</div>
</cfsavecontent>
<cfscript>
	cfcontent( reset = "true" );
	writeOutput(  htmlHelperService.encodeTrustedHtml(  htmlTest ) );
</cfscript>

<cfsavecontent variable="htmlTest">
<cfprocessingdirective pageEncoding="UTF-8">
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
console.log('Log Something'); // this is just some Javascript </script>        </body> </html>
</cfsavecontent>
<cfscript>
	cfcontent( reset = "true" );
	writeOutput( htmlHelperService.minifyHTML( htmlHelperService.encodeTrustedHtml(  htmlTest ) ) );
</cfscript--->