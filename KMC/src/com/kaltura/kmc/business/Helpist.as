package com.kaltura.kmc.business
{
	import com.kaltura.kmc.events.KmcHelpEvent;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * this class handles all help-related issues - it has the listener for the help event, 
	 * handles the mapping of keys to anchors and opens the help pages on the required page   
	 * @author atar.shadmi
	 * 
	 */	
	public class Helpist {
		
		private static var _protocol:String;
		private static var _host:String;
		private static var _baseURL:String;
		private static var _map:XMLList;
		
		/**
		 * 
		 * @param map		mapping of keys (KMC) to anchors (help pages)
		 * @param baseURL	concatenated to all help requests, so the help event supplies only the anchor in the help page.
		 * @param host		host server of help files
		 * @param protocol	protocol for accessing help files
		 */		
		public static function init(map:XMLList, baseURL:String, host:String, protocol:String = ''):void {
			// assume the map is: <item key="a" anchor="1" />
			_map = map;
			
			_baseURL = baseURL;
			_host = host;
			_protocol = protocol;
		}
		
		
		
		/**
		 * open the relevant help page on a new browser window,
		 * based on the anchor in the event.
		 * @param e	help request dispatched by anything on the displayList.
		 * */
		public static function showHelp(e:Event):void {
			e.stopImmediatePropagation();
			var url:String = _protocol;
			if (!url) {
				url = "http://";
			}
			var key:String;
			if (e is KmcHelpEvent) {
				key = (e as KmcHelpEvent).anchor;
			}
			else {
				key = e["data"];
			}
			url += _host + _baseURL + getMapping(key);
			navigateToURL(new URLRequest(url), "_blank");
			//JSGate.openHelp(_helpBaseUrl, anchor);
		}
		
		
		/**
		 * given a key, return the corresponding anchor  
		 */		
		public static function getMapping(key:String):String {
			var xml:XML = _map.(@key==key)[0];
			return xml.@anchor;
		}
		
	}
}