package com.kaltura.kmc.modules.studio.model.types
{
	import mx.resources.ResourceManager;
	
	/**
	 * UIConfType lists types of player uiconfs. 
	 */	
	public class UIConfType
	{
		public static const PLAYER : uint = 1;
		public static const PLAYLIST: uint = 2;
		public static const MULTIPLE_PLAYLIST: uint = 3;
		
		
		/**
		 * uiconfEnumToName translates uiconf types from enum to name.
		 * @param type	uiconf type value
		 * @return 		uiconf type name
		 */		
		public static function uiconfEnumToName( type : uint ) : String
		{
			var result:String;
			switch(type)
			{	
				case 1: result = ResourceManager.getInstance().getString('aps','player'); break;
				case 2: result = ResourceManager.getInstance().getString('aps','playlist'); break;
				case 3: result = ResourceManager.getInstance().getString('aps','multiPlaylist'); break;
				default: result = ""; 
			}
			
			return result;
		}
	}
}