package com.kaltura.edw.vo
{
	import com.kaltura.vo.KalturaCaptionAsset;

	[Bindable]
	/**
	 * EntryCaption class represent a caption with it download url 
	 * @author Michal
	 * 
	 */	
	public class EntryCaptionVO extends AssetVO
	{
		public static var generalServeURL:String = "/api_v3/index.php/service/caption_captionasset/action/serve";
		
		/*
		* captions statuses
		*/
		public static const UPLOADING:String = "UPLOADING"; 
		public static const ERROR:String = "ERROR"; 
		public static const READY_FOR_SAVE:String = "READY_FOR_SAVE"; 
		public static const SAVED:String = "SAVED"; 
		public static const EMPTY:String = "EMPTY"; 
		public static const PROCESSING:String = "PROCESSING"; 
		
		
		/**
		 * are the items editable or not, based on R&P. 
		 */		
		public static var editable:Boolean = true;
		
		/**
		 * status to be displayed for this caption in KMC
		 * */
		public var kmcStatus:String;
		
		/**
		 * is this caption set as default caption (before save).
		 * */
		public var isKmcDefault:Boolean;
		
		/**
		 * The Caption asset 
		 */		
		public var caption:KalturaCaptionAsset;
		
		
		/**
		 * The download url returned by server 
		 * (result of <code>CaptionAssetGetUrl</code>)
		 */		
		public var downloadUrl:String;

		/**
		 * Url of the caption asset, either downloadUrl or new value entered by user
		 * @internal
		 * used to determin if user changed the url, which means they expect uploading a new file
		 */		
		public var resourceUrl:String;
		
		/**
		 * was caption data changed?
		 * */
		public var isChanged:Boolean;
	}
}