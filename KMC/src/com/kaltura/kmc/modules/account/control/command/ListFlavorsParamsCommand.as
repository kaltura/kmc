package com.kaltura.kmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.edw.model.util.FlavorParamsUtil;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.vo.FlavorVO;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	import com.kaltura.vo.KalturaLiveParams;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListFlavorsParamsCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		public static const DEFAULT_PAGE_SIZE:int = 500;
		
		public function execute(event:CairngormEvent):void
		{
			// only load if we are missing data
			if (_model.liveFlavorsData.length == 0 || _model.mediaFlavorsData.length == 0) {
				var pager:KalturaFilterPager = new KalturaFilterPager();
				pager.pageSize = ListFlavorsParamsCommand.DEFAULT_PAGE_SIZE;
			 	var listFlavorParams:FlavorParamsList = new FlavorParamsList(null, pager);
			 	listFlavorParams.addEventListener(KalturaEvent.COMPLETE, result);
				listFlavorParams.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(listFlavorParams);
			}
			else {
				// shortcircuit results - refresh arrays to trigger binding
				var tmp:ArrayCollection = _model.liveFlavorsData;
				_model.liveFlavorsData = null;
				_model.liveFlavorsData = tmp;
					
				tmp = _model.mediaFlavorsData;
				_model.mediaFlavorsData = null;
				_model.mediaFlavorsData = tmp;
			}
		}
		
		
		public function result(event:Object):void
		{
			_model.loadingFlag = false;
			var response:KalturaFlavorParamsListResponse = event.data as KalturaFlavorParamsListResponse;
			var flavorsParams:Array = FlavorParamsUtil.makeManyFlavorParams(response.objects);
			
			var mediaFlvorsTmpArrCol:ArrayCollection = new ArrayCollection();
			var liveFlvorsTmpArrCol:ArrayCollection = new ArrayCollection();
			
			var flavor:FlavorVO;
			for each(var kFlavor:KalturaFlavorParams in flavorsParams) {
				// separate live flavorparams from all other flavor params
				flavor = new FlavorVO();
				flavor.kFlavor = kFlavor;
				if (kFlavor is KalturaLiveParams) {
					liveFlvorsTmpArrCol.addItem(flavor);
				}
				else {
					mediaFlvorsTmpArrCol.addItem(flavor);
				}
			}
			
			_model.mediaFlavorsData = mediaFlvorsTmpArrCol;
			_model.liveFlavorsData = liveFlvorsTmpArrCol;
			
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