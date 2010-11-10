package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DownloadEvent extends CairngormEvent
	{
		public static const DOWNLOAD_ENTRY : String = "downloadEntry";
		public var entriesIds : String; 
		public var flavorParamId : String;
		
		public function DownloadEvent(type:String, entriesIds : String , flavorParamId : String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.entriesIds = entriesIds;
			this.flavorParamId = flavorParamId;
		}
		
	}
}