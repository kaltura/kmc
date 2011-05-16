package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.conversionProfile.ConversionProfileList;
	import com.kaltura.commands.conversionProfile.ConversionProfileSetAsDefault;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.utils.ListConversionProfilesUtil;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	import com.kaltura.vo.KalturaConversionProfileListResponse;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class SetAsDefaultConversionProfileCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var mr:MultiRequest = new MultiRequest();
			var setDefault:ConversionProfileSetAsDefault = new ConversionProfileSetAsDefault(event.data );
			mr.addAction(setDefault);
			var listProfiles:ConversionProfileList = new ConversionProfileList(_model.cpFilter);
			mr.addAction(listProfiles);
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(mr);
		}
		
		public function result(data:Object):void {
			_model.loadingFlag = false;
			var listResult:Array = ((data.data as Array)[1] as KalturaConversionProfileListResponse).objects;
			ListConversionProfilesUtil.handleConversionProfilesList(listResult);
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