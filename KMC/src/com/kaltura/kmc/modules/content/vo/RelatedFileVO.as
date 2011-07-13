package com.kaltura.kmc.modules.content.vo
{

	[Bindable]
	/**
	 * RelatedFileVO contains all relvant data for an entry's related file 
	 * @author Michal
	 * 
	 */	
	public class RelatedFileVO
	{
		///TODO change to KalturaAttachmentAsset
		/**
		 * file asset
		 * */
		public var file:Object;
		/**
		 * download url of the file
		 * */
		public var downloadUrl:String;
		
		public function RelatedFileVO()
		{
		}
	}
}