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
		
		public var caption:KalturaCaptionAsset;
		public var downloadUrl:String;
		public var serveUrl:String;
		public var uploadTokenId:String;
		
		public function EntryCaptionVO()
		{
		}
	}
}