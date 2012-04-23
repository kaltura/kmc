package com.kaltura.edw.control.commands.customData
{
	import com.kaltura.commands.metadataProfile.MetadataProfileGet;
	import com.kaltura.edw.business.EntryFormBuilder;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.MetadataProfileEvent;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaMetadataProfile;

	public class GetMetadataProfileCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var profileId:int = (event as MetadataProfileEvent).profileId;
			if (profileId != -1) {
				var getMetadataProfile:MetadataProfileGet = new MetadataProfileGet(profileId);
				getMetadataProfile.addEventListener(KalturaEvent.COMPLETE, result);
				getMetadataProfile.addEventListener(KalturaEvent.FAILED, fault);
				
				_client.post(getMetadataProfile);
			}
		}
		
		override public function result(data:Object):void {
			var recievedProfile:KalturaMetadataProfile = data.data as KalturaMetadataProfile;
			var filterModel:FilterModel = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
			if (recievedProfile) {
				for (var i:int = 0; i<filterModel.metadataProfiles.length; i++) {
					var profile:KMCMetadataProfileVO = filterModel.metadataProfiles[i] as KMCMetadataProfileVO;
					if (profile.profile.id == recievedProfile.id) {
						profile.profile = recievedProfile;
						(filterModel.formBuilders[i] as EntryFormBuilder).metadataProfile = profile;
						break;
					}
				}
			}
			_model.decreaseLoadCounter();
			
		}
	}
}