package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.SetCurrentListableEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;

	public class SetCurrentListableCommand extends KalturaCommand {

		override public function execute(event:CairngormEvent):void {
			_model.listableVo = (event as SetCurrentListableEvent).listableVo;

		}
	}
}