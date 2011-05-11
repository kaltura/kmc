package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.media.MediaUpdateContent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;

	public class MatchMediaCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var e:DropFolderFileEvent = event as DropFolderFileEvent;
			var mu:MediaUpdateContent = new MediaUpdateContent(e.entry.id, e.resource);
			mu.addEventListener(KalturaEvent.COMPLETE, result);
			mu.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mu);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
		}
	}
}