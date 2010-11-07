package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.kmc.modules.account.vo.FlavorVO;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListFlavorsParamsCommand implements ICommand, IResponder
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
		 	var getListFlavorParams:FlavorParamsList = new FlavorParamsList();
		 	getListFlavorParams.addEventListener(KalturaEvent.COMPLETE, result);
			getListFlavorParams.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListFlavorParams);	 
		}
		
		public function result(event:Object):void
		{
			_model.loadingFlag = false;
	//		clearOldData();
			var response:KalturaFlavorParamsListResponse = event.data as KalturaFlavorParamsListResponse;
			var tempArrCol:ArrayCollection = new ArrayCollection();
			var flavor:FlavorVO;
			for each(var kFlavor:Object in response.objects)
			{
				if (kFlavor is KalturaFlavorParams) {
					flavor = new FlavorVO();
					flavor.kFlavor = kFlavor as KalturaFlavorParams;
					tempArrCol.addItem(flavor);
				}
			}
			
			_model.flavorsData = tempArrCol
			
			_model.partnerInfoLoaded = true;
		}
		
		private function clearOldData():void
		{
			_model.flavorsData.removeAll();
		}
		
		public function fault(info:Object):void
		{
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
			Alert.show(ResourceManager.getInstance().getString('kmc', 'notLoadFlavors') + "/n/t"  + info.error.errorMsg, ResourceManager.getInstance().getString('kmc', 'error'));
	//		clearOldData();
	//		setDummyData();
			_model.loadingFlag = false;
		}
	}
}