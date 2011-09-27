package com.kaltura.edw.vo
{
	import com.kaltura.vo.KalturaAttachmentAsset;
	
	import flash.net.FileReference;
	import com.kaltura.edw.vo.AssetVO;

	[Bindable]
	/**
	 * RelatedFileVO contains all relvant data for an entry's related file 
	 * @author Michal
	 * 
	 */	
	public class RelatedFileVO extends AssetVO
	{
		public static var serveURL:String = "/api_v3/index.php/service/attachment_attachmentasset/action/serve";		
		/**
		 * file asset
		 * */
		public var file:KalturaAttachmentAsset;
		
		public var fileReference:FileReference;
	
		public function RelatedFileVO()
		{
		}
	}
}