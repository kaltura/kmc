package com.kaltura.edw.vo
{
	import com.kaltura.KalturaClient;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaThumbAsset;
	
	import flash.events.EventDispatcher;
	
	import mx.resources.ResourceManager;

	/**
	 * This class represents thumbnail dimensions. contains width, height, and which distribution profiles
	 * use these dimensions. 
	 * @author Michal
	 * 
	 */	
	[Bindable]
	public class ThumbnailWithDimensions extends EventDispatcher
	{
		public static var serveURL:String = "/api_v3/index.php/service/thumbasset/action/serve";
		public static const DEFAULT_THUMB:String = "default_thumb";
		
		/**
		 * the height of the thubnail
		 * */
		public var height:int;
		
		/**
		 * the width of the thumbnail
		 * */
		public var width:int;
		
		/**
		 * contains all distribution profiles that use these dimensions
		 * */
		public var usedDistributionProfilesArray:Array;
		
		/**
		 * represents the thumbnail asset
		 * */
		public var thumbAsset:KalturaThumbAsset;
		
		/**
		 * thumb url
		 * */
		public var thumbUrl:String;
		
		
		/**
		 * Creates a new ThumbnailDimensions object 
		 * @param dimensionsWidth the width 
		 * @param dimensionsHeight the height
		 * @param thumbnailAsset is the thumbnail asset with the given dimensions. if this param is recieved, the given dimensionsWidth
		 * and dimensionsHeight params will be ignored
		 * 
		 */		
		public function ThumbnailWithDimensions(dimensionsWidth:int, dimensionsHeight:int, thumbnailAsset:KalturaThumbAsset = null)
		{
			if (thumbnailAsset) {
				thumbAsset = thumbnailAsset;
				width = thumbAsset.width;
				height = thumbAsset.height;
			}
			else {
				width = dimensionsWidth;
				height = dimensionsHeight;
			}
			usedDistributionProfilesArray = new Array();
		}
		
		public function buildThumbUrl(client:KalturaClient):String {
			var result:String = client.protocol + client.domain + ThumbnailWithDimensions.serveURL + "/ks/" + client.ks + "/thumbAssetId/" + thumbAsset.id ;
			if (thumbAsset.version > 1) {
				result += "/version/" + thumbAsset.version;
			}
			return result;
		}
		
		/**
		 * get the list of distribution profiles names that require this dimension 
		 * @param showEmpty		should a string be returned for empty list
		 * @param concatElement	the element used to concat profile names
		 * @return "pretty-printed" list of profile names 
		 */
		public function getDistributionsListString(showEmpty:Boolean = true, concatElement:String = ','):String {
			if (!usedDistributionProfilesArray|| usedDistributionProfilesArray.length==0) {
				if (showEmpty) {
					return ResourceManager.getInstance().getString('cms', 'thumbanilNotRequired');
				}
				else {
					return '';
				}
			}
			var profileNameArray:Array = new Array();
			for each (var profile:KalturaDistributionProfile in usedDistributionProfilesArray) {
				profileNameArray.push(profile.name);
			}
			var distributionsList:String = profileNameArray.join(concatElement);
			return distributionsList;
		}
	}
}