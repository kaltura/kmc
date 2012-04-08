package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.categoryEntry.CategoryEntryAdd;
	import com.kaltura.commands.categoryEntry.CategoryEntryDelete;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryEntry;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class UpdateEntryCategoriesCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var e:KedEntryEvent = event as KedEntryEvent;
			var mr:MultiRequest = new MultiRequest();
			var toAdd:Array = e.data[0];	// categories to add to the entry
			var toRemove:Array = e.data[1];	// categories to remove from the entry
			
			var kCat:KalturaCategory;
			var ce:KalturaCategoryEntry;
			// add
			for each (kCat in toAdd) {
				ce = new KalturaCategoryEntry();
				ce.categoryId = kCat.id;
				ce.entryId = e.entryVo.id;
				mr.addAction(new CategoryEntryAdd(ce));
			} 
			// remove
			for each (kCat in toRemove) {
				ce = new KalturaCategoryEntry();
				mr.addAction(new CategoryEntryDelete(e.entryVo.id, kCat.id));
			} 
			
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);

			_client.post(mr);
		}
		
		
		override public function result(data:Object):void {
			super.result(data);
			var er:KalturaError = (data as KalturaEvent).error;
			for each (var o:Object in data.data) {
				er = o.error as KalturaError;
				if (er) {
					Alert.show(er.errorMsg, ResourceManager.getInstance().getString('drilldown', 'error'));
				}
			}
		
			_model.decreaseLoadCounter();
		}
	}
}