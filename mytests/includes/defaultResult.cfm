<cfscript>
request.testArgs= {  
		"stripScriptAndCssComments"=true,
		"stripHtmlComments"=true, 
		"stripEmptySpacesBetweenHtmlElements"=true
	};
</cfscript>
<cfprocessingdirective pageEncoding="UTF-8">
<cfsavecontent variable="request.testArgs.tmpHtmlResultOutput"><!DOCTYPE html><head><title>Hot CFML Page & content</title><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"><meta name="viewport" content="width=device-width, initial-scale=1"><style> .someClass{ font-size: 1rem; } </style><meta name="description" content="Just some Example"><link rel="stylesheet" href="css/main.css"></head><body><p>Hello to all CFML devs 😀 🤩 around the 🌎!!! </p><script>console.log("Step0");console.log("Step2");console.log("Step3");console.log("Step4");console.log("Step5");console.log("Step6");console.log("Step7");console.log("Step8");console.log("Step9");console.log("Step10");console.log("Step11");console.log("Step12");console.log("Step13");console.log("Step14");console.log("Step15"); </script></body></html></cfsavecontent>