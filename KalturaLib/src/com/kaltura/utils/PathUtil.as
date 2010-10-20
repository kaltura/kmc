package com.kaltura.utils
{
	import mx.utils.URLUtil;

	public class PathUtil
	{

		/**
		 *  @author Zohar Babin
	     *  Determines if a string is a valid URL.
	     *  @param url The URL to analyze.
	     *  @return <code>true</code> if the URL is a valid url.
	     */
	    static private const isUrlRegEx:RegExp = 
	    /\b(?<protocol>[A-Z]{0,5}):\/\/(?<domain>[-A-Z0-9.]+)(?<file>\/[-A-Z0-9+&@#\/%=~_|!:,.; ]*)?(?<parameters>\?[-A-Z0-9+&@#\/%=~_|!:,.; ]*)?/i; 
	    public static function isStringUrl (url:String):Boolean
	    {
	    	var result:Object = isUrlRegEx.exec(url);
            if(result == null) {
                return false;
            }
            return true;
	    }

	    /**
	     *  Converts a potentially relative URL/System path to a fully-qualified URL/System path.
	     *  If the URL is not relative, it is returned as is.
	     *  If the URL starts with a slash, the host and port
	     *  from the root URL are prepended.
	     *  Otherwise, the host, port, and path are prepended.
	     *
	     *  @param rootUrl URL/Path used to resolve the URL/Path specified by the <code>path</code> parameter, if <code>path</code> is relative.
	     *  @param url URL/System path to convert.
	     *
	     *  @return Fully-qualified URL/System path.
	     */
		public static function getAbsoluteUrl(rootUrl:String, url:String):String
		{
			var isFileSystemPath:Boolean;
			if (url && isAbsolutePath(url))
			{
				return url;
			}
			else if (!url)
			{
				return rootUrl;
			}
			else
			{
				var fileSystem:String;
				if (isFileSystem(rootUrl))
				{
					isFileSystemPath = true;
					fileSystem = rootUrl.substr(0, 11);
					rootUrl = "http://" + rootUrl.substr(11);
				}
				var rootUrlPath:String = getUrlPath(rootUrl);
				var rootUrlTop:String = rootUrlPath ? rootUrl.substring(0, rootUrl.indexOf(rootUrlPath)) : rootUrl;
				var resolvedRootUrlPath:String = resolve2DotsSyntax(rootUrlPath, url) ;
				url = remove2DotsSyntax(url);

				var resolvedRootUrl:String = URLUtil.getFullURL(rootUrlTop, resolvedRootUrlPath);

				var absUrl:String = URLUtil.getFullURL(resolvedRootUrl, url);

				return isFileSystemPath ?
					absUrl.replace("http://", fileSystem):
					absUrl;
			}
		}

		private static function remove2DotsSyntax(url:String):String
		{
			var upperDir2Dots:RegExp = /[.][.][\/]+/g;
			return url.replace(upperDir2Dots, "");
		}
		/**
		 *Returns the full path that leads a given URL/path without the file name.
		 * For example "http://www.kaltura.com/samples/Sample.swf is converted to |http://www.kaltura.com/samples/"
		 * @param url
		 * @return
		 *
		 */
		public static function getSourceUrl(url:String):String
		{
			var cleanUrl:String = removeSandboxNoise(url);
			return cleanUrl.substring(0, cleanUrl.lastIndexOf('/') + 1);
		}

		public static function getFileName(url:String):String
		{
			var questionMarkIndex:int = url.indexOf("?");
			var endIndex:int = questionMarkIndex != -1 ? questionMarkIndex : 0x7FFFFFFF;
			var startIndex:int = url.lastIndexOf("/", endIndex) + 1;
			return url.substring(startIndex, endIndex);
		}

		/**
		 * Removes the "[[IMPORT]]" from a URL string.
		 * For example the URL http://sandbox.kaltura.com/[[IMPORT]]/cdnsandbox.kaltura.com/Sample.swf will be cut to http://cdnsandbox.kaltura.com/Sample.swf
		 * If the given url does not contain the [[IMPORT]] string, the url is returned without any changes.
		 * The [[IMPORT]] string is known to be concatenated when a swf is loaded from a different into an existing security sandbox.
		 * @param url A URL, that potentially contains the '[[IMPORT]]' String.
		 * @return A concatenation of the url parameter protocol + the string found after the [[IMPORT]] string
		 *
		 */
		private static function removeSandboxNoise(url:String):String
		{
			// when the application is loaded into a warapper that set the SecuritySandbox to SecuritySandbox.currentDomain, the root.loaderInfo.url is somehow set to
			//
			var importIndex:int = url.indexOf("[[IMPORT]]/");
			if (importIndex != -1)
				var startIdx:int = importIndex + 11;
			else
				return url;

			var strippedUrl:String = url.substring(startIdx);
			var protocol:String = URLUtil.getProtocol(url)
			strippedUrl = protocol + "://" + strippedUrl;
			return strippedUrl
		}

		private static function isAbsolutePath(path:String):Boolean
		{
			return URLUtil.getProtocol(path) != "";
		}

		private static function resolve2DotsSyntax(rootUrlPath:String, path:String):String
		{

			var upperDirPattern:RegExp = /[.][.][\/]+/g;
			var upDistance:uint = path.match(upperDirPattern).length;
			var upperPath:String = getUpperDir(rootUrlPath, upDistance);
			return upperPath;
		}
		/**
		 * Enables to manipulate the nesting level by specifying a desired nesting "distance" to go up by.
		 * <p>For example:
		 * <pre>
		 * var path:String = "/aa aa/bb bb/dd dd";
		 * trace(getUpperDir("/aa aa/bb bb/dd dd", 2));
		 * </pre>
		 * Prints "/aa aa" to the trace log
		 * </p>
		 * @param path A path, whose part separated by '/' slashes
		 * @param level The requested "distance" to go up by.
		 * @return
		 *
		 */
		private static function getUpperDir(path:String, level:uint):String
		{
			if (level == 0) return path;
			var pathParts:Array = path.split("/");
			var appendSlash:Boolean;
			if (pathParts[pathParts.length-1] == "")
			{
				pathParts.pop();
				appendSlash = true
			}
			pathParts.splice(-level);
			return pathParts.join("/") + (appendSlash ? "/" : "");
		}
		/**
		 * Extracts the path part of the URL
		 * <p>
		 * For example: getUpperDir("http://www.kaltura.com/home/index") returns "home/index";
		 * </p>
		 * @param url
		 * @return
		 *
		 */
		private static function getUrlPath(url:String):String
		{
			var serverName:String = URLUtil.getServerName(url);
			var idx:int = url.indexOf(serverName) + serverName.length + 1;
			return url.substr(idx);
		}

		private static function isFileSystem(url:String):Boolean
		{
			return url.substr(0, 8) == "file:///";
		}
	}
}