package com.kaltura.kmc.modules.content.vo
{
	import com.kaltura.vo.KalturaAttachmentAsset;
	
	import flash.net.FileReference;

	[Bindable]
	/**
	 * RelatedFileVO contains all relvant data for an entry's related file 
	 * @author Michal
	 * 
	 */	
	public class RelatedFileVO
	{
		public static var serveURL:String = "/api_v3/index.php/service/attachment_attachmentasset/action/serve";		
		/**
		 * file asset
		 * */
		public var file:KalturaAttachmentAsset;
		/**
		 * download url of the file
		 * */
		public var serveUrl:String;
		
		public var fileReference:FileReference;
		
		public function RelatedFileVO()
		{
		}
	}
}