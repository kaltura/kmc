package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryUpdate;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class SetEntriesOwnerCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			
			var e:EntriesEvent = event as EntriesEvent;
			var userid:String = e.data;
			var entry:KalturaBaseEntry;
			var updateEntry:BaseEntryUpdate
			var mr:MultiRequest = new MultiRequest();
			
			for (var i:uint = 0; i < e.entries.length; i++) {
				entry = e.entries[i] as KalturaBaseEntry;
				entry.userId = userid;
				entry.setUpdatedFieldsOnly(true);
				if (entry.conversionProfileId) {
					entry.conversionProfileId = int.MIN_VALUE;
				}
				// don't send categories - we use categoryEntry service to update them in EntryData panel
				entry.categories = null;
				entry.categoriesIds = null;
				
				updateEntry = new BaseEntryUpdate(entry.id, entry);
				mr.addAction(updateEntry);
			}
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
			
		}
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			if (!checkError(data)) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'updateCompleteOwner'));
			}
		}
	}
}