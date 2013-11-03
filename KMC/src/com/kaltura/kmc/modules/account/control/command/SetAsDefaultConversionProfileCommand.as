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
	import com.kaltura.kmc.modules.account.control.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.utils.ListConversionProfilesUtil;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.types.KalturaConversionProfileType;
	import com.kaltura.vo.KalturaConversionProfile;
	import com.kaltura.vo.KalturaConversionProfileAssetParamsListResponse;
	import com.kaltura.vo.KalturaConversionProfileFilter;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class SetAsDefaultConversionProfileCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		private var _nextEvent:CairngormEvent;
		
		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			
			_nextEvent = (event as ConversionSettingsEvent).nextEvent;
			
			var cp:KalturaConversionProfile = event.data as KalturaConversionProfile;
			var setDefault:ConversionProfileSetAsDefault = new ConversionProfileSetAsDefault(cp.id);
			
			setDefault.addEventListener(KalturaEvent.COMPLETE, result);
			setDefault.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(setDefault);
		}
		
		
		public function result(event:Object):void {
			_model.loadingFlag = false;
			var er:KalturaError;
			if (event.error) {
				er = event.error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
				}
			}
			if (_nextEvent) {
				_nextEvent.dispatch();
			}
		}
		
		
		public function fault(info:Object):void
		{
			_model.loadingFlag = false;
			if (info && info.error && info.error.errorMsg) {
				if (info.error.errorMsg.toString().indexOf("Invalid KS") > -1 ) {
					JSGate.expired();
				} 
				else {
					Alert.show(info && info.error && info.error.errorMsg);
					
				}
			}
		}
	}
}