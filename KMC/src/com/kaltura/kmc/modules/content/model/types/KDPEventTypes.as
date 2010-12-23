package com.kaltura.kmc.modules.content.model.types
{
	/**
	 * list of KDP notifications used by content application. 
	 * @author Atar
	 */	
	public class KDPEventTypes {
		
		public static const KDP_READY:String = "kdpReady";
		
		public static const ENTRY_READY:String = "entryReady";
		
		public static const THUMBNAIL_SAVED:String = "thumbnailSaved";
		
		public static const CAPTURE_THUMBNAIL:String = "captureThumbnail";

		public static const CHANGE_MEDIA:String = "changeMedia";
		
		public static const DO_STOP:String = "doStop";
		
		public static const CLEAN_MEDIA:String = "cleanMedia";
		
		public static const DO_PAUSE:String = "doPause";
		
		public static const MEDIA_READY:String = "mediaReady";
		
		public static const MEDIA_LOADED:String = "mediaLoaded";
	}
}