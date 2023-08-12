component {

	/**********************************************************
	 *  HTMLHelper.cfc Version 0.9.3:
	 *  A lambda function expressions delivering component that enables
	 *  basic HTML minifying and html encoding features for trusted HTML
	 *  For more information please visit:
	 *  https://github.com/andreasRu/htmlHelper or
	 *  https://www.rhein-berg-digital.de
	 *  License: MIT License
	 *  (c)2023 C. Andreas Rüger
	 *  https://github.com/andreasRu/
	 ************************************************************/

	public function init() {
		local.service = {
			"demarkerStart": "_s1.",
			"demarkerEnd": "_e2.",
			"encodeTrustedHtml": (required string htmlString) => {
				result = arguments.htmlString;

				htmlBlocksMapArray = reFind(
					"(?i)(<!--.*?-->|<script.*?\/script>|<style.*?\/style>|<code.*?\/code>|<pre.*?\/pre>)",
					result,
					1,
					true,
					"ALL"
				);

				htmlSingleTagMapArray = reFind( "<(.*?)>", result, 1, true, "ALL" );

				// map all pure HTML entities (e.g &amp; &copy; &#169; &#8126; &#xA9; #x000000000a9;)
				htmlEntitiesWithoutBoundariesRegEx = "&(" & chr( 35 ) & "[0-9|xa-f0-9]+|[a-z0-9]+);";
				htmlHTMLEntitiesMapArray = reFindNoCase(
					htmlEntitiesWithoutBoundariesRegEx,
					result,
					1,
					true,
					"ALL"
				);

				/************************************
				 * Copy/replace html tags to properly escape to apply safely encodeforHTML()
				 *************************************/


				// map tags with body )
				if( arrayLen( htmlBlocksMapArray ) > 1 or htmlBlocksMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = mapHTMLtags( result, htmlBlocksMapArray, "CO" );
				}


				// map default tags
				if( arrayLen( htmlSingleTagMapArray ) > 1 or htmlSingleTagMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = mapHTMLtags( result, htmlSingleTagMapArray, "SI" );
				}

				// map all HTML ENTITIES
				if( arrayLen( htmlHTMLEntitiesMapArray ) > 1 or htmlHTMLEntitiesMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = mapHTMLtags( result, htmlHTMLEntitiesMapArray, "EN" );
				}


				// remove all newlines/tabs and spaces
				result = encodeForHTML( result.reReplace( "\s+", " ", "all" ) );


				// unmap all HTML ENTITIES
				if( arrayLen( htmlHTMLEntitiesMapArray ) > 1 or htmlHTMLEntitiesMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = unMapHTMLtags( result, htmlHTMLEntitiesMapArray, "EN" );
				}


				// unmap default tags
				if( arrayLen( htmlSingleTagMapArray ) > 1 or htmlSingleTagMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = unMapHTMLtags( result, htmlSingleTagMapArray, "SI" );
				}


				// unmap tags with body )
				if( arrayLen( htmlBlocksMapArray ) > 1 or htmlBlocksMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = unMapHTMLtags( result, htmlBlocksMapArray, "CO" );
				}

				return trim( result.reReplace( "> <", "><", "all" ) );
			},
			"minifyHtml": (
				required string htmlString,
				boolean stripScriptAndCssComments,
				boolean stripHtmlComments,
				boolean compressWhitespaces,
				boolean stripEmptySpacesBetweenHtmlElements
			) => {
				result = arguments.htmlString;

				// set defaults or pass args
				stripScriptAndCssComments = arguments.stripScriptAndCssComments ?: true;
				stripHtmlComments = arguments.stripHtmlComments ?: true;
				compressWhitespaces = arguments.compressWhitespaces ?: true;
				stripEmptySpacesBetweenHtmlElements = arguments.stripEmptySpacesBetweenHtmlElements ?: true;


				htmlCodeTagMapArray = reFind(
					"(?i)(<code.*?\/code>|<pre.*?\/pre>)",
					result,
					1,
					true,
					"ALL"
				);

				// map spacing honoured elements
				if( arrayLen( htmlCodeTagMapArray ) > 1 or htmlCodeTagMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = mapHTMLtags( result, htmlCodeTagMapArray, "CO" );
				}

				// main minifying happens here
				if( stripHtmlComments ) {
					result = result.reReplace( "<!--.*?-->", "", "all" ); // remove hardcoded html(multiline/singleline) comments
				}

				

				if( stripScriptAndCssComments ) {
					
					result = result
						.reReplace( "(\s)+\/\*(.|\n)*?\*\/", " ", "all" ) // remove hardcoded javascript/css multiline comments;
						.reReplace( "(\s)+\/\/.*?(\r|\n|<\/script)", "\2", "all" ) // remove hardcoded javascript inline comments
						}

				
				elseif( compressWhitespaces ){

					// map multiline comments
					multilineCommentArray = reFind(
						"(\s)+\/\*(.|\n)*?\*\/",
						result,
						1,
						true,
						"ALL"
					);

					// make sure to honour all multiline comments spacing honoured elements
					if( arrayLen( multilineCommentArray ) > 1 or multilineCommentArray[ 1 ].len[ 1 ] > 0 ) {
						result = mapHTMLtags( result, multilineCommentArray, "ML" );
					}

					// replace of inline comments and make multiline comments of it
					result = result.reReplace( "(\s)+\/\/[^\/]+(.*?)(\r|\n|<\/script)", "/*\2*/\3", "all" ) // convert single line comments to multiline, otherwise it will break javascript
				
					// unmap multiline comments
					if( arrayLen( multilineCommentArray ) > 1 or multilineCommentArray[ 1 ].len[ 1 ] > 0 ) {
						result = unMapHTMLtags( result, multilineCommentArray, "ML" );
					}


				}
				

				if( compressWhitespaces  ) {
					result = result.reReplace( "\s+", " ", "all" ); // compress all double tabs/spaces/newlines to single spaces
				}

				// copy spacing honoured elements back
				if( arrayLen( htmlCodeTagMapArray ) > 1 or htmlCodeTagMapArray[ 1 ].len[ 1 ] > 0 ) {
					result = unMapHTMLtags( result, htmlCodeTagMapArray, "CO" );
				}

				if( stripEmptySpacesBetweenHtmlElements ) {
					result = result.reReplace( "(>\s+<)", "><", "all" )
				}

				// return with final mini-minifcation and trimming
				return trim( result );
			}
		}

		return service;
	}



	private string function mapHTMLtags( required string htmlContent, required array arrayMap, required string tagSuffix ) {
		result = arguments.htmlContent;
		startString = service.demarkerStart & arguments.tagSuffix;
		endString = service.demarkerEnd;
		return arguments.arrayMap.reduce( (acc, element, index, theArray) => {
			return acc.replace( theArray[ index ].match[ 1 ], startString & index & endString )
		}, result );

		return trim( result );
	}


	private string function unMapHTMLtags( required string htmlContent, required array arrayMap, required string tagSuffix ) {
		startString = service.demarkerStart & arguments.tagSuffix;
		endString = service.demarkerEnd;

		return arguments.arrayMap.reduce( (acc, element, index, theArray) => {
			return acc.replace( startString & index & endString, theArray[ index ].match[ 1 ] )
		}, result );
	}

}

