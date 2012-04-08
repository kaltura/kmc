package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.categoryEntry.CategoryEntryList;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaCategoryEntryFilter;
	
	import mx.collections.ArrayCollection;

	public class GetEntryCategoriesCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var e:KedEntryEvent = event as KedEntryEvent;
			
			var f:KalturaCategoryEntryFilter = new KalturaCategoryEntryFilter();
			f.entryIdEqual = e.entryVo.id;
			var getcats:CategoryEntryList = new CategoryEntryList(f);
			
			getcats.addEventListener(KalturaEvent.COMPLETE, result);
			getcats.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(getcats);
		}
		
		
		override public function result(data:Object):void {
			super.result(data);
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			edp.entryCategories = new ArrayCollection(data.objects);
			_model.decreaseLoadCounter();
		}
	}
}