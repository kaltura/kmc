package com.kaltura.edw.vo
{
	[Bindable]
	/**
	 * AssetVO class represents VO's of Kaltura assets 
	 * @author Michal
	 * 
	 */	
	public class AssetVO
	{
		/**
		 * download url of the file
		 * */
		public var serveUrl:String;
		
		/**
		 * upload token associated with this asset
		 * */
		public var uploadTokenId:String;
		
		/**
		 * is current asset is new, and fileReference was upload successfully
		 * */
		public var isNewUploaded:Boolean = false;
		/**
		 * is current asset is new, and fileReference has failed to upload
		 * */
		public var isNewUploadError:Boolean = false;
	}
}