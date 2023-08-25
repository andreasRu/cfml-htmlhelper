component output = false {

	/**********************************************************
	 *  HTMLHelper.cfc Version 0.9.4:
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
			"version"      : "0.9.4",
			"startTickCount": getTickCount(),
			"debug"        : true,
			"demarkerStart": "_1.",
			"demarkerEnd"  : "_2.",
			"debugResult"  : function( htmlstring, label = "", regexForDump ) {
				// if set to debug force output!
				if( service.debug ) {
					writeOutput( "<hr>" & label & ":" );
					if( !arguments.label=="result" ){ 
						writeOutput( "HtmlString.Length(): " & len( arguments.HtmlString ) ) ;
				
					}else{
						writeOutput( "TimeStamp: " & ((getTickCount() - service.startTickCount)) & "ms" ) ;
						service.startTickCount=getTickCount();
					}
					
					if( structKeyExists( arguments, "regexForDump" ) ) {
						writeOutput( "Regex: /" & encodeForHTML( arguments.regexForDump ) & "/" );
						//dump( htmlstring.reMatch( arguments.regexForDump ) );
						
					}
					
					writeOutput( "<pre style='font-size:0.6rem;border:1px solid red;max-height:3rem;overflow:auto;'><code>" & encodeForHTML( htmlstring ) & "</code></pre>" );
				}
			},
			"reduceArrayAndReplaceString": function( arrayWithElements, contentString, replaceWith ) {
				replaceWith = arguments.replaceWith;
				return arguments.arrayWithElements.reduce( function( acc, element, index, theArray ) {
					return acc.replace( element, replaceWith );
				}, arguments.contentString );
			},
			"stripMultlineComments": function( htmlcontent ) {
				stringsToRemove = [];
				result          = arguments.htmlcontent;
				service.debugResult( htmlstring = result, label = "stripMultlineComments", regexForDump = "(\s)+\/\*(.|\n)*?\*\/" );

				stringsToRemove.append( result.reMatch( "(\s)+\/\*(.|\n)*?\*\/" ), true );
				result = service.reduceArrayAndReplaceString( stringsToRemove, result, "" );
				service.debugResult( htmlstring = result, label = "Result" );
				return result;
			},
			"stripSingleLineComments": function( htmlcontent ) {
				stringsToRemove = [];
				result          = arguments.htmlcontent;
				service.debugResult( htmlstring = result, label = "stripSingleLineComments", regexForDump = "(\s)+(?:\/\/)(.*?)[\r|\n]" );
				stringsToRemove.append( result.reMatch( "(\s)+(?:\/\/)(.*?)[\r|\n]" ), true );
				result = service.reduceArrayAndReplaceString( stringsToRemove, result, chr( 10 ) );
				service.debugResult( htmlstring = result, label = "Result" );
				return result;
			},
			"stripHtmlComments": function( htmlcontent ) {
				stringsToRemove = [];
				result          = arguments.htmlcontent;
				service.debugResult( htmlstring = result, label = "stripHtmlComments", regexForDump = "<!--.*?-->" );
				stringsToRemove.append( result.reMatch( "<!--.*?-->" ), true );
				result = service.reduceArrayAndReplaceString( stringsToRemove, result, "" );
				service.debugResult( htmlstring = result, label = "Result" );
				return result;
			},
			"compressBlankSpaces": function( htmlcontent ) {
				stringsToRemove = [];
				result          = arguments.htmlcontent;
				service.debugResult( htmlstring = result, label = "compressBlankSpaces", regexForDump = "[ \t]+" );
				resure=result.reReplace( "[ \t]+", " ", "All" ).reReplace( "\s+[\n\r]+", chr( 10 ), "ALL" );
				// stringsToRemove.append( result.reMatch( "[ \t]+" ), true ); // compress spaces/tabs to single spaces
				// result = service.reduceArrayAndReplaceString( stringsToRemove, result, " " ).reReplace( "\s+[\n\r]+", chr( 10 ), "ALL" );
				service.debugResult( htmlstring = result, label = "Result" );
				return result;
			},
			"compressNewLines": function( htmlcontent, replaceWith ) {
				stringsToRemove = [];
				result          = arguments.htmlcontent;
				service.debugResult( htmlstring = result, label = "compressNewLines" );

				stringsToRemove.append( result.reMatch( "[\n\r]+" ), true ); // compress spaces/tabs to single spaces
				result = service.reduceArrayAndReplaceString( stringsToRemove, result, arguments.replaceWith );
				service.debugResult( htmlstring = result, label = "Result" );
				return result;
			},
			"stripEmptySpacesBetweenHtmlElements": function( htmlcontent, replaceWith ) {
				stringsToRemove = [];
				result          = arguments.htmlcontent;
				service.debugResult( htmlstring = result, label = "stripEmptySpacesBetweenHtmlElements" );
				stringsToRemove.append( result.reMatch( ">\s+<" ), true ); // compress spaces/tabs to single spaces
				result = service.reduceArrayAndReplaceString( stringsToRemove, result, arguments.replaceWith );
				service.debugResult( htmlstring = result, label = "Result" );
				return result;
			},
			"encodeTrustedHtml": function( required string htmlString ) {
				stringsToMap = [];
				unmapper     = [ : ];
				result       = arguments.htmlString;

				stringsToMap.append( result.reMatch( "(?i)(<!--.*?-->|<script.*?\/script>|<style.*?\/style>|<code.*?\/code>|<pre.*?\/pre>)" ), true );
				result = stringsToMap.reduce( function( acc, element, index, theArray ) {
					mapID = "_.C#index#._";
					unmapper.insert( "#mapID#", element );
					return acc.replace( element, mapID );
				}, result );

				stringsToMap.append( result.reMatch( "<[^>]*?>" ), true );
				result = stringsToMap.reduce( function( acc, element, index, theArray ) {
					mapID = "_.S#index#._";
					unmapper.insert( "#mapID#", element );
					return acc.replace( element, mapID );
				}, result );

				stringsToMap.append( result.reMatch( "(?i)&(" & chr( 35 ) & "[0-9|xa-f0-9]+|[a-z0-9]+);" ), true );
				result = stringsToMap.reduce( function( acc, element, index, theArray ) {
					mapID = "_.E#index#._";
					unmapper.insert( "#mapID#", element );
					return acc.replace( element, mapID );
				}, result );

				// encode for html everythng that is within bodys
				result = encodeForHTML( result.reReplace( "\s+", " ", "all" ) );

				result = unmapper.reduce( function( content, key, value ) {
					return content.replace( key, value );
				}, result );

				return result;
			},
			"minifyHtml": function(
				required string htmlString,
				boolean stripScriptAndCssComments,
				boolean stripHtmlComments,
				boolean stripEmptySpacesBetweenHtmlElements
			) {
				stringsToMap = [];
				unmapper     = [ : ];
				result       = arguments.htmlString;

				// set defaults or pass args
				argStripScriptAndCssComments           = arguments.stripScriptAndCssComments ?: true;
				argStripHtmlComments                   = arguments.stripHtmlComments ?: true;
				argStripEmptySpacesBetweenHtmlElements = arguments.stripEmptySpacesBetweenHtmlElements ?: true;

				stringsToMap.append( result.reMatch( "(?i)(<code.*?/code>|<pre.*?\/pre>|<textarea.*?\/textarea>)" ), true );
				result = stringsToMap.reduce( function( acc, element, index, theArray ) {
					mapID = "_.#index#._";
					unmapper.insert( "#mapID#", element );
					return acc.replace( element, mapID );
				}, result );


				// whitespace 1
				result = trim( service.compressBlankSpaces( result ) );

				if( argStripHtmlComments ) {
					result = service.stripHtmlComments( result );
				}

				if( argStripScriptAndCssComments ) {
					result = service.stripMultlineComments( result );
					result = service.stripSingleLineComments( result );
				}

				// whitespace new lines
				if( argStripScriptAndCssComments ) {
					result = service.compressNewLines( result, "" );
				} else {
					// make sure compressing new lines won't break the page because of double slashed "//" comments
					// better would be a function that converts // comments into /* multiline */
					result = service.stripSingleLineComments( result );
					result = service.compressNewLines( result, "" );
					// result = service.compressNewLines( result, chr(10) );
				}

				result = unmapper.reduce( function( content, key, value ) {
					return content.replace( key, value );
				}, result );

				if( argStripEmptySpacesBetweenHtmlElements ) {
					result = service.stripEmptySpacesBetweenHtmlElements( result, "><" );
				} else {
					result = service.stripEmptySpacesBetweenHtmlElements( result, ">#chr( 10 )#<" );
				}
				return result;
			}
		}

		return service;
	}

}

