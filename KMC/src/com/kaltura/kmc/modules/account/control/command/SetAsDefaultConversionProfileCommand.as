package com.kaltura.kmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.conversionProfile.ConversionProfileSetAsDefault;
	import com.kaltura.commands.conversionProfileAssetParams.ConversionProfileAssetParamsList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.utils.ListConversionProfilesUtil;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsListResponse;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class SetAsDefaultConversionProfileCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var mr:MultiRequest = new MultiRequest();
			var setDefault:ConversionProfileSetAsDefault = new ConversionProfileSetAsDefault(event.data);
			mr.addAction(setDefault);
			// list conversion profiles - to get the correct default
			var listProfiles:ConversionProfileList = new ConversionProfileList(_model.mediaCPFilter);
			mr.addAction(listProfiles);
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(mr);
		}
		
		public function result(event:Object):void {
			_model.loadingFlag = false;
			var er:KalturaError;
			if (event.data[0].error) {
				er = event.data[0].error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
				}
			}
			else if (event.data[1].error) {
				er = event.data[1].error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
				}
			}
			else {
				var listResult:Array = ((event.data as Array)[1] as KalturaConversionProfileListResponse).objects;
				_model.mediaConversionProfiles = ListConversionProfilesUtil.handleConversionProfilesList(listResult);
				// use the existing cpaps - they should be valid
				ListConversionProfilesUtil.addAssetParams(_model.mediaConversionProfiles, _model.mediaCPAPs);
			}
			
		}
		
		public function fault(info:Object):void
		{
			_model.loadingFlag = false;
			if(info && info.error && info.error.errorMsg) {
				
				if(info.error.errorMsg.toString().indexOf("Invalid KS") > -1 ) {
					
					JSGate.expired();
				} else {
					Alert.show(info && info.error && info.error.errorMsg);
					
				}
			}
		}
	}
}