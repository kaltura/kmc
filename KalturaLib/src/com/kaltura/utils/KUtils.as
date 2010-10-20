package com.kaltura.utils
{
	/**
	 * A class that contains Kaltura specific functions
	 *
	 */
	public class KUtils
	{
		public static function hostFromCode(hostCode:String):String
		{
			/*if( URLUtil.isHttpURL(hostCode) ||  URLUtil.isHttpsURL(hostCode))
				return hostCode.substr( 7 );*/
				
			var hostUrl:String;
			switch (hostCode)
			{
				case "0":
					hostUrl = "kaldev.kaltura.com";
				break;
				// default server is www.kaltura.com
				case null:
				case "1":
					hostUrl = "www.kaltura.com";
				break;

				case "2":
					hostUrl = "localhost";
				break;

				case "3":
					hostUrl = "sandbox.kaltura.com";
				break;

				default: // a url
					hostUrl = hostCode;
				break;
			}
			return hostUrl;
		}
	}
}