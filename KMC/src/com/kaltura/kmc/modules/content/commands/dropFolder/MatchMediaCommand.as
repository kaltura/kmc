package com.kaltura.kmc.modules.content.commands.dropFolder
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryUpdate;
	import com.kaltura.commands.media.MediaUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.DropFolderFileEvent;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;

	public class MatchMediaCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var e:DropFolderFileEvent = event as DropFolderFileEvent;
			
			var willHaveReplacement:Boolean = e.entry.status != KalturaEntryStatus.NO_CONTENT;
			
			e.entry.setUpdatedFieldsOnly(true);
			
			var mu:MediaUpdate;
			
			if (willHaveReplacement) {
				// change the slug on the replacement entry 
				var mr:MultiRequest = new MultiRequest();
				// media update:
				mu = new MediaUpdate(e.entry.id, (e.entry as KalturaMediaEntry), e.resource);
				mr.addAction(mu);
				
				// set the reference id on the replacement entry id
				var me:KalturaMediaEntry = new KalturaMediaEntry();
				me.referenceId = e.slug;
				me.setUpdatedFieldsOnly(true);
				var eu:BaseEntryUpdate = new BaseEntryUpdate("a", me);
				mr.addAction(eu);
				
				// map the result of the first call to the second
				mr.mapMultiRequestParam(1, "replacingEntryId", 2,  "entryId");
				
				// add listeners and post call
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.context.kc.post(mr);
			}
			else {
				// send the entry for update - if it needs a slug update it is already there.
				// media update:
				mu = new MediaUpdate(e.entry.id, (e.entry as KalturaMediaEntry), e.resource);
				// add listeners and post call
				mu.addEventListener(KalturaEvent.COMPLETE, result);
				mu.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.context.kc.post(mu);
			}
			
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			//TODO do we need to do anything?
			
		}
	}
}