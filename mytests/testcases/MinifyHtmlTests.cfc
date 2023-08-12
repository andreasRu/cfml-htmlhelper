component extends="testbox.system.BaseSpec" 
{

	htmlHelperService=new components.HtmlHelper();
	
	
	function run()
	{
		// all your suites go here.
		
		// items=[ "default", 
		// 		"compressWhitespaces", 
		// 		"stripScriptAndCssComments", 
		// 		"stripEmptySpacesBetweenHtmlElements",
		// 		"stripAllCommentsAndCompress",
		// 		"allOff" ];

		items=[ "default" ];

		items.map( ( item ) => {
			
		

		describe( "Testing HtmlHelper.cfc for " & item, function() {
			
				

				it( "Testing " & item, function(){


					// load minifyHTML args and load expected HTML output
					include template="../includes/#item#Result.txt";
					// load HTML input
					include template="../includes/#item#.txt";
					
				
					var result = htmlHelperService.minifyHtml( 
						htmlString=request.testArgs.tmpHtmlInput, 
						compressWhitespaces=request.testArgs.compressWhitespaces,
						stripScriptAndCssComments=request.testArgs.stripScriptAndCssComments,
						stripHtmlComments=request.testArgs.stripHtmlComments, 
						stripEmptySpacesBetweenHtmlElements=request.testArgs.stripEmptySpacesBetweenHtmlElements );

					expect( trim( local.result ) ).toBe( trim( request.testArgs.tmpHtmlResultOutput )  );
				
			
			});
	
		});

	});

	}
}
