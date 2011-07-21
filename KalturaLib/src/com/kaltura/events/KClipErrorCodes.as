package com.kaltura.events
{
	/**
	 * Error codes for CLIPPER_ERROR events 
	 * @author Michal
	 * 
	 */	
	public class KClipErrorCodes
	{
		public static const CUEPOINT_ADD_FAILED:String = "cuePointAddFailed";
		
		public static const CUEPOINT_LOCATION_FAILED:String = "cuePointLocationFailed";
		
		public static const CUEPOINT_UPDATE_FAILED:String = "cuePointUpdateFailed";
		
		public static const CLIP_ADD_FAILED:String = "clipAddFailed";
		
		public static const CLIP_UPDATE_FAILED:String = "clipUpdateFailed";
		
		public static const SELECT_CLIP:String = "selectClip";
		
		public static const SELECT_CUEPOINT:String = "selectCuePoint";
		
		public static const UNKNOWN_CUEPOINT_TYPE:String = "unknownCuePointType";
		
		public static const MEDIA_LOAD_FAILED:String = "mediaLoadFailed";
		
		public static const CUEPOINT_LOAD_FAILED:String = "cuePointLoadFailed";
		
		public static const SAVE_FAILED:String = "saveFailed";
		
		public static const CLIP_TOO_SHORT:String = "clipTooShort";
		
		public static const WRONG_STATE:String = "wrongState";
		
		public static const ENTRY_PROCESSING:String = "entryProcessing";
		
	}
}