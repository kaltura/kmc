package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.thumbAsset.ThumbAssetGetByEntryId;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.model.ThumbnailWithDimensions;
	import com.kaltura.vo.KalturaDistributionProfile;
	import com.kaltura.vo.KalturaThumbAsset;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
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
			var thumbsResultArray:Array =  data.data as Array;

			//copy this array so we can delete from it without damage the original profiles array
			var profilesArray:Array = _model.entryDetailsModel.distributionProfileInfo.kalturaDistributionProfilesArray.concat();
			//resets old data
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = new Array();
			buildThumbsWithDimensionsArray(_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray, profilesArray, thumbsResultArray);
			
		}
		
		private function buildThumbsWithDimensionsArray(thumbsWithDimensionsArray:Array, profilesArray:Array, thumbsArray:Array):void {
			
			for each (var currentThumb:KalturaThumbAsset in thumbsArray) {
				var curUsedProfiles:Array;
				var curThumbExist:Boolean = false;
				for each (var existingThumb:ThumbnailWithDimensions in thumbsWithDimensionsArray) {
					if ((currentThumb.width==existingThumb.width) && (currentThumb.height==existingThumb.height)) {
						curUsedProfiles = existingThumb.usedDistributionProfilesArray;
						curThumbExist = true;
						break;
					}
				}
				if (!curThumbExist) {
					var newThumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions (currentThumb.width,currentThumb.height, currentThumb);
					newThumbToAdd.thumbUrl = _model.context.kc.protocol + _model.context.kc.domain + ThumbnailWithDimensions.serveURL + "&ks=" + _model.context.kc.ks + "&thumbAssetId=" + newThumbToAdd.thumbAsset.id;
					thumbsWithDimensionsArray.push(newThumbToAdd);
					curUsedProfiles = newThumbToAdd.usedDistributionProfilesArray;
				}
				
				for (var i:int=profilesArray.length-1; i>=0; i--) {
					var distributionProfile:KalturaDistributionProfile = profilesArray[i] as KalturaDistributionProfile;
					if ((distributionProfile.width==currentThumb.width) && (distributionProfile.height==currentThumb.height)) {
						curUsedProfiles.push(distributionProfile);
						//we hadnled it so we remove it
						profilesArray.splice(i,1);
					}
				}
			}
			var remainingProfilesArray:Array = new Array();
			//go over remaining profiles with no suitable thumb
			for each (var profile:KalturaDistributionProfile in profilesArray) {
				var leftUsedProfiles:Array = new Array();
				var profileExist:Boolean = false;
				for each (var thumbnail:ThumbnailWithDimensions in remainingProfilesArray) {
					if ((thumbnail.width==profile.width) && (thumbnail.height==profile.height)) {
						leftUsedProfiles = thumbnail.usedDistributionProfilesArray;
						profileExist = true;
						break;
					}
				}
				if (!profileExist) {
					var thumbToAdd:ThumbnailWithDimensions = new ThumbnailWithDimensions(profile.width, profile.height);
					remainingProfilesArray.push(thumbToAdd);
					leftUsedProfiles = thumbToAdd.usedDistributionProfilesArray;	
				}
				leftUsedProfiles.push(profile);
			}
			
			_model.entryDetailsModel.distributionProfileInfo.thumbnailDimensionsArray = thumbsWithDimensionsArray.concat(remainingProfilesArray);
		}
		
	}

}