package com.kaltura.kmc.modules.content.vo
{
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * Data concerning a file about to be uploaded as a flavour to an entry. 
	 * @author Atar
	 */	
	public class UploadFileVo {
		
		public function UploadFileVo(){}
		
		/**
		 * the id of the flavorparam associated with this file 
		 */
		public var flavorParamId:String;
		
		
		/**
		 * the id of the flavorasset this file should replace 
		 */
		public var flavorAssetId:String;
		
		
		/**
		 * the string that will be shown on screen
		 */
		public var fileName:String;
		
		
		/**
		 * relevant FileReference object if exists 
		 */
		public var fileData:FileReference

		
		/**
		 * list of optional conversion flavors for the selected profile 
		 */
		public var flavors:ArrayCollection;
		
		
		
	}
}