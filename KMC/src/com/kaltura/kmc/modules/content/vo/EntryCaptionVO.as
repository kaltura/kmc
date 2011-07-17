package com.kaltura.kmc.modules.content.vo
{
	import com.kaltura.vo.KalturaCaptionAsset;

	[Bindable]
	/**
	 * EntryCaption class represent a caption with it download url 
	 * @author Michal
	 * 
	 */	
	public class EntryCaptionVO
	{
		public static var serveURL:String = "/api_v3/index.php/service/caption_captionasset/action/serve";
		/**
		 * The Caption asset 
		 */		
		public var caption:KalturaCaptionAsset;
		/**
		 * The download url from server 
		 */		
		public var downloadUrl:String;
		/**
		 * Url to serve the caption asset 
		 */		
		public var serveUrl:String;
		/**
		 * Upload token id. Indicates the current caption is being uploaded 
		 */		
		public var uploadTokenId:String;
		/**
		 * Extenral URL for the caption asset 
		 */		
		public var resourceUrl:String;
		
		public function EntryCaptionVO()
		{
		}
	}
}