package com.kaltura.edw.control.commands.categories
{
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryCount;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;

	public class ListAllCategoriesCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
//			var multiRequest:MultiRequest = new MultiRequest();
//			var mefilter:KalturaMediaEntryFilter = new KalturaMediaEntryFilter();
//			
//			mefilter.statusIn = KalturaEntryStatus.NO_CONTENT + "," + KalturaEntryStatus.ERROR_CONVERTING + "," + KalturaEntryStatus.ERROR_IMPORTING +
//				"," + KalturaEntryStatus.IMPORT + "," + KalturaEntryStatus.PRECONVERT + "," +
//				KalturaEntryStatus.READY;
//			mefilter.mediaTypeIn = KalturaMediaType.VIDEO + "," + KalturaMediaType.IMAGE + "," +
//				KalturaMediaType.AUDIO + "," + "6" + "," + KalturaMediaType.LIVE_STREAM_FLASH;
//			
//			// to bypass server defaults
//			mefilter.moderationStatusIn = '';
//			
//			var getEntryCount:BaseEntryCount = new BaseEntryCount(mefilter);
//			multiRequest.addAction(getEntryCount);
			
			var listCategories:CategoryList = new CategoryList();
//			multiRequest.addAction(listCategories);
			// listeners
			listCategories.addEventListener(KalturaEvent.COMPLETE, result);
			listCategories.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(listCategories);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var filterModel:FilterModel = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
			buildCategoriesHyrarchy((data.data as KalturaCategoryListResponse).objects, filterModel.categoriesMap);
			_model.decreaseLoadCounter();
		}
		
		private function buildCategoriesHyrarchy(kCats:Array, catMap:HashMap):void {
			
			
			// create the rest of the category VOs
			var categories:ArrayCollection = new ArrayCollection();
			var category:CategoryVO;
			for each (var kCat:KalturaCategory in kCats) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				categories.addItem(category)
			}
			
			// create tree: list children on parent categories
			for each (var cat:CategoryVO in categories) {
				var parentCategory:CategoryVO = catMap.getValue(cat.category.parentId + '') as CategoryVO;
				if (parentCategory != null) {
					parentCategory.children.addItem(cat);
					// (for falcon, don't sort, use received value)
					// sortCategories(parentCategory.children);
				}
			}
		}
		
		
		//		private function sortCategories(catArrCol:ArrayCollection):void {
		//			var dataSortField:SortField = new SortField();
		//			dataSortField.name = "name";
		//			dataSortField.caseInsensitive = true;
		//			dataSortField.descending = false;
		//			var dataSort:Sort = new Sort();
		//			dataSort.fields = [dataSortField];
		//			catArrCol.sort = dataSort;
		//			catArrCol.refresh();
		//		}
	}
}