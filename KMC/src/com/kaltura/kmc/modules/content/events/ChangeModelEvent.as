package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ChangeModelEvent extends CairngormEvent {
		
		
		public static const SET_CUSTOM_METADATA:String = "content_setCustomMetadata";
		
		public static const SET_UPDATE_CUSTOM_DATA:String = "content_setUpdateCustomData";

		public static const SET_DISTRIBUTION:String = "content_setDistribution";

		public static const SET_SINGLE_ENTRY_EMBED_STATUS:String = "singleEntry_setEmbedStatus";
		
		public static const SET_PLAYLIST_EMBED_STATUS : String = "playlist_setEmbedStatus";
		
		public static const SET_REMOTE_STORAGE : String = "content_setRemoteStorage";

		public static const SET_ENABLE_THUMB_RESIZE : String = "content_setDisableThumbResize";

		public static const SET_LOTS_OF_CATEGORIES_FLAG : String = "content_lotsOfCategoriesFlag";
		
		public static const SET_CONFIRM_MODERATION : String = "content_SET_CONFIRM_MODERATION";
		
		public static const SET_ALLOW_TRIMMING: String = "content_SET_ALLOW_TRIMMING";
		
		public static const SET_ALLOW_CLIPPING: String = "content_SET_ALLOW_CLIPPING";
		
		public static const ENABLE_AKAMAI_LIVE: String = "content_ENABLE_AKAMAI_LIVE";
		
		public static const ENABLE_KALTURA_LIVE: String = "content_ENABLE_KALTURA_LIVE";
		
		public static const ENABLE_KALTURA_RECORDING: String = "content_ENABLE_KALTURA_RECORDING";
		
		private var _newValue:*;
		
		public function ChangeModelEvent(type:String, value:*, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_newValue = value;
		}

		public function get newValue():Boolean
		{
			return _newValue;
		}

	}
}