package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.metadataProfile.MetadataProfileGet;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.MetadataProfileEvent;
	import com.kaltura.edw.business.FormBuilder;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaMetadataProfile;

	public class GetMetadataProfileCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var profileId:int = (event as MetadataProfileEvent).profileId;
			if (profileId != -1) {
				var getMetadataProfile:MetadataProfileGet = new MetadataProfileGet(profileId);
				getMetadataProfile.addEventListener(KalturaEvent.COMPLETE, result);
				getMetadataProfile.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.context.kc.post(getMetadataProfile);
			}
		}
		
		override public function result(data:Object):void {
			var recievedProfile:KalturaMetadataProfile = data.data as KalturaMetadataProfile;
			if (recievedProfile) {
				for (var i:int = 0; i<_model.filterModel.metadataProfiles.length; i++) {
					var profile:KMCMetadataProfileVO = _model.filterModel.metadataProfiles[i] as KMCMetadataProfileVO;
					if (profile.profile.id == recievedProfile.id) {
						profile.profile = recievedProfile;
						(_model.filterModel.formBuilders[i] as FormBuilder).metadataProfile = profile;
						break;
					}
				}
			}
			_model.decreaseLoadCounter();
			
		}
	}
}