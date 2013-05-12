package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.FlavorVO;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import com.kaltura.edw.model.util.FlavorParamsUtil;
	
	public class ListFlavorsParamsCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		public static const DEFAULT_PAGE_SIZE:int = 500;
		
		public function execute(event:CairngormEvent):void
		{
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageSize = DEFAULT_PAGE_SIZE;
		 	var getListFlavorParams:FlavorParamsList = new FlavorParamsList(null, pager);
		 	getListFlavorParams.addEventListener(KalturaEvent.COMPLETE, result);
			getListFlavorParams.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListFlavorParams);	 
		}
		
		public function result(event:Object):void
		{
			_model.loadingFlag = false;
			var response:KalturaFlavorParamsListResponse = event.data as KalturaFlavorParamsListResponse;
			var flavorsParams:Array = FlavorParamsUtil.makeManyFlavorParams(response.objects);
			var tempArrCol:ArrayCollection = new ArrayCollection();
			var flavor:FlavorVO;
			for each(var kFlavor:Object in flavorsParams)
			{
				if (kFlavor is KalturaFlavorParams) {
					flavor = new FlavorVO();
					flavor.kFlavor = kFlavor as KalturaFlavorParams;
					tempArrCol.addItem(flavor);
				}
			}
			
			_model.flavorsData = tempArrCol
		}
		
		private function clearOldData():void
		{
			_model.flavorsData.removeAll();
		}
		
		public function fault(info:Object):void
		{
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				JSGate.expired();
				return;
			}
			Alert.show(ResourceManager.getInstance().getString('account', 'notLoadFlavors') + "/n/t"  + info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			_model.loadingFlag = false;
		}
	}
}