package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.uiConf.UiConfGet;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.GeneralUiconfEvent;
	import com.kaltura.vo.KalturaUiConf;
	
	/**
	 * This class will get the default metadata view and save the uiconf xml on the entryDetailsModel.
	 * @author Michal
	 * 
	 */
	public class GetMetadataUIConfCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var uiconfRequest:UiConfGet = new UiConfGet(_model.entryDetailsModel.metadataDefaultUiconf);
			uiconfRequest.addEventListener(KalturaEvent.COMPLETE, result);
			uiconfRequest.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(uiconfRequest);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var result:KalturaUiConf = data.data as KalturaUiConf;
			if (result)
				_model.entryDetailsModel.metadataDefaultUiconfXML = new XML(result.confFile);
			
			_model.decreaseLoadCounter();
			
		}
	}
}