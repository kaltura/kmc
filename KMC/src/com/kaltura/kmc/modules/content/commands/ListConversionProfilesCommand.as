package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.vo.ConversionProfileVO;
	import com.kaltura.types.KalturaConversionProfileOrderBy;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileFilter;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListConversionProfilesCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var cpFilter:KalturaConversionProfileFilter = new KalturaConversionProfileFilter();
			cpFilter.orderBy =  KalturaConversionProfileOrderBy.CREATED_AT_DESC;
			var getListConversionProfiles:ConversionProfileList = new ConversionProfileList(cpFilter);
		 	getListConversionProfiles.addEventListener(KalturaEvent.COMPLETE, result);
			getListConversionProfiles.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListConversionProfiles);	
		}
		
		override public function result(event:Object):void
		{
//			super.result(event);
			if (event.error) {
				var er:KalturaError = event.error as KalturaError;
				if (er) {
					// ignore service forbidden
					if (er.errorCode != APIErrorCode.SERVICE_FORBIDDEN) {
						Alert.show(er.errorMsg, "Error");
					}
				}
			}
			else {
				var response:KalturaConversionProfileListResponse = event.data as KalturaConversionProfileListResponse;
				
				var tempArrCol:ArrayCollection = new ArrayCollection();
				
				for each(var cProfile:KalturaConversionProfile in response.objects)
				{
					var cp:ConversionProfileVO = new ConversionProfileVO();
					cp.profile = cProfile;
					tempArrCol.addItem(cp);
					
					if(cp.profile.isDefault)
					{
						_model.bulkUploadModel.defaultConversionProfileId = cp.profile.id;
					}
				}
				
				_model.bulkUploadModel.conversionData = tempArrCol;
				
				_model.extSynModel.partnerInfoLoaded = true;
			}
			_model.decreaseLoadCounter();
		}
		
//		override public function fault(event:Object):void
//		{
//			//TODO -- remove in time (needed for bulk upload)
//			if (event.error.errorCode != APIErrorCode.SERVICE_FORBIDDEN) {
//				Alert.show(ResourceManager.getInstance().getString('cms', 'notLoadConversionProfiles') + "\n\t" + event.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
//			}
//			_model.decreaseLoadCounter();
//		}
	}
}