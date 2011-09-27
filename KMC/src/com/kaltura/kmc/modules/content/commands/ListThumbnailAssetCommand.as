package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.thumbAsset.ThumbAssetGetByEntryId;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.vo.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaDistributionThumbDimensions;
	import com.kaltura.vo.KalturaThumbAsset;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class ListThumbnailAssetCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var listThumbnailAsset:ThumbAssetGetByEntryId = new ThumbAssetGetByEntryId(_model.entryDetailsModel.selectedEntry.id);
			listThumbnailAsset.addEventListener(KalturaEvent.COMPLETE, result);
			listThumbnailAsset.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(listThumbnailAsset);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var resultArray:Array =  data.data as Array;
			handleThumbAssetResult(resultArray);		
		}
		
		private function handleThumbAssetResult(thumbsResultArray:Array):void {
			//copy this array so we can delete from it without damage the original profiles array
			var profilesArray:Array = _model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray.concat();
			//resets old data
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = new Array();
			buildThumbsWithDimensionsArray(_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray, profilesArray, thumbsResultArray);
		}
		
		/**
		 * this function will aggregate profiles that use the same dimensions with an entry of the same dimensions
		 * */
		private function buildThumbsWithDimensionsArray(thumbsWithDimensionsArray:Array, profilesArray:Array, thumbsArray:Array):void {
			
			//will indicate if the requiredthumbs of these profiles exist
			var isRequiredThumbsExistArray:Array = new Array();
			//initilize with all false values
			for each (var currentProfile:KalturaDistributionProfile in profilesArray) {
				var currentArray:Array = new Array();
				for each (var currentDimension:KalturaDistributionThumbDimensions in currentProfile.requiredThumbDimensions) {
					currentArray.push(false);
				}
				isRequiredThumbsExistArray.push(currentArray);
			}
			
			for each (var currentThumb:KalturaThumbAsset in thumbsArray) {
				var curUsedProfiles:Array = new Array();
				var curThumbExist:Boolean = false;
				//search for thumb with identical dimensions, to copy the used profiles from it
				for each (var existingThumb:ThumbnailWithDimensions in thumbsWithDimensionsArray) {
					if ((currentThumb.width==existingThumb.width) && (currentThumb.height==existingThumb.height)) {
						curUsedProfiles = existingThumb.usedDistributionProfilesArray;
						if (!existingThumb.thumbAsset) {
							existingThumb.thumbAsset = currentThumb;
							existingThumb.thumbUrl = buildThumbUrl(existingThumb);
							curThumbExist = true;
						}
						break;
					}
				}
				//search for all profiles that require the thumb dimensions
				if (curUsedProfiles.length == 0) {
					for (var i:int=profilesArray.length-1; i>=0; i--) {
						var distributionProfile:KalturaDistributionProfile = profilesArray[i] as KalturaDistributionProfile;
						if (distributionProfile.requiredThumbDimensions) {
							for (var j:int=0; j<distributionProfile.requiredThumbDimensions.length; j++) {
								var dim:KalturaDistributionThumbDimensions = distributionProfile.requiredThumbDimensions[j] as KalturaDistributionThumbDimensions;
								if ((dim.width==currentThumb.width) && (dim.height==currentThumb.height)) {
									curUsedProfiles.push(distributionProfile);
									isRequiredThumbsExistArray[i][j] = true;
									break;
								}
							}
							
						}
					}
				}
				//should create new thumbnailWithDimensions object
				if (!curThumbExist) {
					var newThumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions (currentThumb.width,currentThumb.height, currentThumb);
					newThumbToAdd.thumbUrl = buildThumbUrl(newThumbToAdd);
					newThumbToAdd.usedDistributionProfilesArray = curUsedProfiles;
					thumbsWithDimensionsArray.push(newThumbToAdd);
				}			
			}
			
			var remainingProfilesArray:Array = new Array();
			//go over all profiles that don't have matching thumbs
			for (var k:int = 0; k < isRequiredThumbsExistArray.length; k++) {
				var array:Array = isRequiredThumbsExistArray[k] as Array;
				for (var l:int=0; l<array.length; l++) {
					
					if (!array[l]) {
						var profile:KalturaDistributionProfile = profilesArray[k] as KalturaDistributionProfile;
						var requireDimensions:KalturaDistributionThumbDimensions = profile.requiredThumbDimensions[l] as KalturaDistributionThumbDimensions;
						var profileExist:Boolean = false;
						var leftUsedProfiles:Array = new Array();
						for each (var thumbnail:ThumbnailWithDimensions in remainingProfilesArray) {
							if ((thumbnail.width==requireDimensions.width) && (thumbnail.height==requireDimensions.height)) {
								leftUsedProfiles = thumbnail.usedDistributionProfilesArray;
								profileExist = true;
								break;
							}
						}
						if (!profileExist) {
							var thumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions(requireDimensions.width, requireDimensions.height);
							remainingProfilesArray.push(thumbToAdd);
							leftUsedProfiles = thumbToAdd.usedDistributionProfilesArray;		
						}
						leftUsedProfiles.push(profile);
						
					}
				}
			}
			
			thumbsWithDimensionsArray = thumbsWithDimensionsArray.concat(remainingProfilesArray);
			thumbsWithDimensionsArray.sortOn(["width", "height"], Array.NUMERIC | Array.DESCENDING);
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = thumbsWithDimensionsArray;
		}
		
		private function buildThumbUrl(thumb:ThumbnailWithDimensions):String {
			return _model.context.kc.protocol + _model.context.kc.domain + ThumbnailWithDimensions.serveURL + "/ks/" + _model.context.kc.ks + "/thumbAssetId/" + thumb.thumbAsset.id;
		}
		
	}
	
}