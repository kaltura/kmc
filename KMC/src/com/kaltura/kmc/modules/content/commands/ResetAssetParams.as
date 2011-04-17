package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ResetAssetParams extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.entryDetailsModel.selectedCPAssetParams = null;
		}
	}
}