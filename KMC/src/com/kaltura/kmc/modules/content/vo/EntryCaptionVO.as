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
		public var caption:KalturaCaptionAsset;
		public var downloadUrl:String;
		public var uploadTokenId:String;
		
		public function EntryCaptionVO()
		{
		}
	}
}