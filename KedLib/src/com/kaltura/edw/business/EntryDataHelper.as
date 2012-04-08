package com.kaltura.edw.business
{
	import com.kaltura.edw.vo.FlavorAssetWithParamsVO;
	import com.kaltura.types.KalturaEntryModerationStatus;
	import com.kaltura.types.KalturaEntryType;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaFlavorAsset;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class EntryDataHelper {
		
		/**
		 * given 2 array collections, are their contents equal? 
		 * comparisn by object id. 
		 * @param ac1
		 * @param ac2
		 * @return 
		 */
		public static function areCollectionsEqual(ac1:ArrayCollection, ac2:ArrayCollection):Boolean {
			if (ac1 == null || ac2 == null) {
				return false;
			}
			
			if (ac1.length != ac2.length) {
				return false;
			}
			
			for (var index:uint = 0; index < ac1.length; index++) {
				var obj1:Object = ac1.getItemAt( index );
				var obj2:Object = ac2.getItemAt( index );
				
				if (obj1.id != obj2.id) {
					return false;
				}
			}
			
			return true;
		}
		
		/**
		 * caculate the differences between categories before / after change </br>
		 * result[0] - cats to add </br>
		 * result[1] - cats to remove
		 * */
		public static function getCategoriesUpdateValues(newlst:ArrayCollection, oldlst:ArrayCollection):Array {
			var toAdd:Array = [];
			var toRemove:Array = [];
			var found:Boolean;
			var kcat:KalturaCategory, kcat2:KalturaCategory;
			// add categories
			for each (kcat in newlst) {
				found = false;
				for each (kcat2 in oldlst) {
					if (kcat.id == kcat2.id) {
						found = true;
						break;
					}
				}
				if (!found) {
					toAdd.push(kcat);
				}
			}
			// remove categories
			for each (kcat in oldlst) {
				found = false;
				for each (kcat2 in newlst) {
					if (kcat.id == kcat2.id) {
						found = true;
						break;
					}
				}
				if (!found) {
					toRemove.push(kcat);
				}
			}
			// result
			return new Array(toAdd, toRemove);
		}
		
		
		/**
		 * for trim / clip buttons, decide if the button should be
		 * enabled according to whether entry has source flavor.
		 * @param flavors	the list of flavors associated with this entry
		 * @return whether the button should be enabled or not
		 * */
		public static function entryHasSource(flavors:ArrayCollection):Boolean {
			var hasSource:Boolean = false;
			var asset:KalturaFlavorAsset;
			for each (var vo:FlavorAssetWithParamsVO in flavors) {
				asset = vo.kalturaFlavorAssetWithParams.flavorAsset;
				if (asset && asset.isOriginal) {
					hasSource = true;
					break;
				}
			}
			return hasSource;
		}
		
		
		public static function getModeration(moderationCode:int):String {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			switch (moderationCode) {
				case KalturaEntryModerationStatus.APPROVED:  {
					return resourceManager.getString('drilldown', 'approved');
				}
				case KalturaEntryModerationStatus.FLAGGED_FOR_REVIEW:  {
					return resourceManager.getString('drilldown', 'pending');
				}
				case KalturaEntryModerationStatus.REJECTED:  {
					return resourceManager.getString('drilldown', 'rejected');
				}
				case KalturaEntryModerationStatus.AUTO_APPROVED:  {
					return resourceManager.getString('drilldown', 'autoApproved');
				}
				case KalturaEntryModerationStatus.PENDING_MODERATION:  {
					return resourceManager.getString('drilldown', 'pendingModeration');
				}
					
				default:  {
					return ' -- ';
				}
			}
		}
		
		
		/**
		 * The function translate media type enum to the matching locale string
		 * @param mediaType
		 * @param type - special param for mix since mix is type 2 and other types are type 1 with different mediaTypes
		 */
		public static function getMediaTypes(mediaType:int, type:String):String {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			if (type == KalturaEntryType.MIX) {
				return resourceManager.getString('drilldown', 'videoMix');
			}
			switch (mediaType) {
				case KalturaMediaType.VIDEO:
					return resourceManager.getString('drilldown', 'video');
					break;
				case KalturaMediaType.IMAGE:
					return resourceManager.getString('drilldown', 'image');
					break;
				case KalturaMediaType.AUDIO:
					return resourceManager.getString('drilldown', 'audio');
					break;
				case "6":
					return resourceManager.getString('drilldown', 'videoMix');
					break;
				case "10":
					return resourceManager.getString('drilldown', 'xml');
					break;
				case KalturaMediaType.LIVE_STREAM_FLASH:
					return resourceManager.getString('drilldown', 'liveStream');
					break;
			}
			
			return "";
		}
		
		
		/**
		 * Format the creation date
		 */
		public static function formatDate(date:Number):String {
			var df:DateFormatter = new DateFormatter();
			df.formatString = ResourceManager.getInstance().getString('drilldown', 'drilldowndateformat');
			var dt:Date = new Date();
			dt.setTime(date * 1000);
			return df.format(dt);
		};
	}
}