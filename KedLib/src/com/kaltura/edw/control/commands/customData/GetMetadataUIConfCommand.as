package com.kaltura.edw.control.commands.customData
{
	import com.kaltura.commands.uiConf.UiConfGet;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.CustomDataDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaUiConf;
	
	/**
	 * This class will get the default metadata view and save the uiconf xml on the entryDetailsModel.
	 * @author Michal
	 * 
	 */
	public class GetMetadataUIConfCommand extends KedCommand
	{
		private var _cddp:CustomDataDataPack;
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			_cddp = _model.getDataPack(CustomDataDataPack) as CustomDataDataPack

			var uiconfRequest:UiConfGet = new UiConfGet(_cddp.metadataDefaultUiconf);
			uiconfRequest.addEventListener(KalturaEvent.COMPLETE, result);
			uiconfRequest.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(uiconfRequest);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var result:KalturaUiConf = data.data as KalturaUiConf;
			if (result)
				_cddp.metadataDefaultUiconfXML = new XML(result.confFile);
			
			_model.decreaseLoadCounter();
			
		}
	}
}