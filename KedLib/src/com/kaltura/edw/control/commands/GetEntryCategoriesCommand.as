package com.kaltura.edw.control.commands
{
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.commands.categoryEntry.CategoryEntryList;
	import com.kaltura.edw.control.events.KedEntryEvent;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaCategoryEntry;
	import com.kaltura.vo.KalturaCategoryEntryFilter;
	import com.kaltura.vo.KalturaCategoryEntryListResponse;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	public class GetEntryCategoriesCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			switch (event.type) {
				case KedEntryEvent.RESET_ENTRY_CATEGORIES:
					edp.entryCategories = new ArrayCollection();
					break;
				case KedEntryEvent.GET_ENTRY_CATEGORIES:
					_model.increaseLoadCounter();
					
					// get a list of KalturaCategoryEntries
					var e:KedEntryEvent = event as KedEntryEvent;
					
					var f:KalturaCategoryEntryFilter = new KalturaCategoryEntryFilter();
					f.entryIdEqual = e.entryVo.id;
					var p:KalturaFilterPager = new KalturaFilterPager();
					p.pageSize = edp.maxNumCategories;
					var getcats:CategoryEntryList = new CategoryEntryList(f, p);
					
					getcats.addEventListener(KalturaEvent.COMPLETE, result);
					getcats.addEventListener(KalturaEvent.FAILED, fault);
					
					_client.post(getcats);
					break;
			}
		}
		
		
		override public function result(data:Object):void {
			super.result(data);
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			if (data.data is KalturaCategoryEntryListResponse) {
				// get a list of KalturaCategories
				var kce:KalturaCategoryEntry;
				var str:String = '';
				var kces:Array = data.data.objects;
				if (!kces || !kces.length) {
					_model.decreaseLoadCounter();
					return;
				}
				
				for each (kce in kces) {
					str += kce.categoryId + ",";
				}
				var f:KalturaCategoryFilter = new KalturaCategoryFilter();
				f.idIn = str;
				var p:KalturaFilterPager = new KalturaFilterPager();
				p.pageSize = edp.maxNumCategories;
				var getcats:CategoryList = new CategoryList(f, p);
				
				getcats.addEventListener(KalturaEvent.COMPLETE, result);
				getcats.addEventListener(KalturaEvent.FAILED, fault);
				
				_client.post(getcats);
			}
			else if (data.data is KalturaCategoryListResponse) {
				// put the KalturaCategories on the model
				edp.entryCategories = new ArrayCollection((data.data as KalturaCategoryListResponse).objects);
				_model.decreaseLoadCounter();
			}
		}
	}
}