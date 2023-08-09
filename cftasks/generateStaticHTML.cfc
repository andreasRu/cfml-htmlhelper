/**
 * Description of task
 */
component {

	/**
	 *
	 */
	function run() {
		var basePath = getDirectoryFromPath( getCurrentTemplatePath() ) & "../";
		print.boldCyanLine( "Base path defined: " & basePath );
		fileSystemUtil.createMapping( "components", basePath & "components" );
		print.boldCyanLine( "Map 'components' created." );
		cfhttp(
			method = "GET",
			charset = "utf-8",
			url = "http://localhost:8080/",
			result = "result"
		) {
		}

		print.boldCyanLine( "Retrieving http to http://localhost:8080" );
		htmlHelperService = new components.HtmlHelper();
		resultFinal = result.filecontent.replacenocase( "If you want to see an enhanced version of this page, please visit <a href=""https://andreasru.github.io/cfml-htmlhelper/"">https&##x3a;&##x2f;&##x2f;andreasru.github.io&##x2f;cfml-htmlhelper&##x2f;</a>", "", "ALL" );
		print.boldCyanLine( "Minifying content" );
		minifiedfilecontent = htmlHelperService.minifyHtml( resultFinal );
		print.boldCyanLine( "CfContent minified" );

		print.boldCyanLine( "Writing static index.html to distro..." );
		fileWrite( basePath & "docs/index.html", minifiedfilecontent, "utf-8" );

		print.boldCyanLine( "Copying libs to distro..." );
		directoryCopy( source = basePath & "libs", destination = basePath & "docs/libs", recurse = true );

		print.boldCyanLine( "Copying images to distro..." );
		directoryCopy( source = basePath & "images", destination = basePath & "docs/images", recurse = true );


		print.GreenLine( "READY!" );
	}

}
