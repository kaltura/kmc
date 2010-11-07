package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.flavorParams.FlavorParamsList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.kmc.modules.account.vo.FlavorVO;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaFlavorParams;
	import com.kaltura.vo.KalturaFlavorParamsListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListConversionProfilesAndFlavorParamsCommand implements ICommand, IResponder
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var mr:MultiRequest = new MultiRequest();
			
			_model.loadingFlag = true;
			
			var getListFlavorParams:FlavorParamsList = new FlavorParamsList();
			mr.addAction(getListFlavorParams);
			
			var getListConversionProfiles:ConversionProfileList = new ConversionProfileList(_model.cpFilter, new KalturaFilterPager());
		 	mr.addAction(getListConversionProfiles);
			
		 	mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);	
		}
		
		public function result(event:Object):void
		{
			event.toLocaleString();
			var flvorsTmpArrCol:ArrayCollection = new ArrayCollection();
			var kEvent:KalturaEvent = event as KalturaEvent;
			var flavorsRespones:KalturaFlavorParamsListResponse = (kEvent.data as Array)[0] as KalturaFlavorParamsListResponse;
			for each(var kFlavor:Object in flavorsRespones.objects)
			{
				if (kFlavor is KalturaFlavorParams) {
					var flavor:FlavorVO = new FlavorVO();
					flavor.kFlavor = kFlavor as KalturaFlavorParams;
					flvorsTmpArrCol.addItem(flavor);
				}
			}
			_model.flavorsData = flvorsTmpArrCol;
			
			var convProfilesTmpArrCol:ArrayCollection = new ArrayCollection();
			var convsProfilesRespones:KalturaConversionProfileListResponse = (kEvent.data as Array)[1] as KalturaConversionProfileListResponse;
			for each(var cProfile:KalturaConversionProfile in convsProfilesRespones.objects)
			{
				var cp:ConversionProfileVO = new ConversionProfileVO();
				cp.profile = cProfile;
				
				if(cp.profile.isDefault)
				{
					convProfilesTmpArrCol.addItemAt(cp, 0);
				}
				else
				{
					convProfilesTmpArrCol.addItem(cp);
				}
				
			}
			_model.conversionData = convProfilesTmpArrCol;
			_model.loadingFlag = false;
	
			_model.partnerInfoLoaded = true;
		}
		
		public function fault(event:Object):void
		{
			Alert.show(ResourceManager.getInstance().getString('kmc', 'notLoadConversionProfiles') + "\n\t" + event.error.errorMsg, ResourceManager.getInstance().getString('kmc', 'error'));
			_model.loadingFlag = false;
		}
		

	}
}