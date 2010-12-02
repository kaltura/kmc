package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListConversionProfilesCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			var getListConversionProfiles:ConversionProfileList = new ConversionProfileList(_model.cpFilter, new KalturaFilterPager());
		 	getListConversionProfiles.addEventListener(KalturaEvent.COMPLETE, result);
			getListConversionProfiles.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListConversionProfiles);	
		}
		
		public function result(event:Object):void
		{
			var response:KalturaConversionProfileListResponse = event.data as KalturaConversionProfileListResponse;
	//		clearOldData();
			_model.loadingFlag = false;
			var tempArrCol:ArrayCollection = new ArrayCollection();
			
			for each(var cProfile:KalturaConversionProfile in response.objects)
			{
				var cp:ConversionProfileVO = new ConversionProfileVO();
				cp.profile = cProfile;
				if(cp.profile.isDefault)
				{
					tempArrCol.addItemAt(cp, 0);
				}
				else
				{
					tempArrCol.addItem(cp);
				}
			}
			
			_model.conversionData = tempArrCol;
//			setDummyData();
			
			_model.partnerInfoLoaded = true;
		}
		
		public function fault(event:Object):void
		{
			Alert.show(ResourceManager.getInstance().getString('account', 'notLoadConversionProfiles') + "\n\t" + event.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			_model.loadingFlag = false;
		}
		
		private function clearOldData():void
		{
			_model.conversionData.removeAll();
		}
	
	}
}