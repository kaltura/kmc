package com.kaltura.kmc.modules.content.model
{
	import com.kaltura.vo.KalturaCaptionAsset;

	[Bindable]
	/**
	 * EntryCaption class represent a caption with it download url 
	 * @author Michal
	 * 
	 */	
	public class EntryCaption
	{
		public var caption:KalturaCaptionAsset;
		public var downloadUrl:String;
		
		public function EntryCaption()
		{
		}
	}
}