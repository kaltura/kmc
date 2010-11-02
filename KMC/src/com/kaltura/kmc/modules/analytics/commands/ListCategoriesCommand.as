package com.kaltura.kmc.modules.analytics.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.analytics.model.KMCModelLocator;
	import com.kaltura.kmc.modules.analytics.vo.CategoryVO;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListCategoriesCommand implements ICommand,IResponder
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag = true;
			var mr:MultiRequest = new MultiRequest();
			
		/* 	var getEntryCount:BaseEntryCount = new BaseEntryCount();
			mr.addAction(getEntryCount); */
			
			var listCategories:CategoryList = new CategoryList(new KalturaCategoryFilter());
		 	mr.addAction(listCategories);
			
		 	mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);	
			
			
		}
		
		public function fault(info:Object):void
		{
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('kmc','error'));
		}

		public function result(event:Object):void
		{
			_model.loadingFlag = false;
			
			var kclr:KalturaCategoryListResponse;
			var kc:KalturaCategory;
			
			if(event.data[0] is KalturaError)
			{
				Alert.show((event.data[0] as KalturaError).errorMsg, ResourceManager.getInstance().getString('kmc','error'));
			}
			else
			{
				var categories:Array =  (event.data[0] as KalturaCategoryListResponse).objects;
				//_model.categories.source = buildCategoriesHyrarchy(categories);
				//	var hd:HierarchicalData = new HierarchicalData( buildCategoriesHyrarchy(categories) );
				//	hd.childrenField = 'children';
				_model.categories = buildCategoriesHyrarchy(categories, event.data[0] as String);
			}
		
		}
		
		private function buildCategoriesHyrarchy(array:Array, totalEntryCount:String):CategoryVO
		{
			var catMap:HashMap = _model.categoriesMap;
			catMap.clear();
			
			var root:CategoryVO = new CategoryVO(0, ResourceManager.getInstance().getString('cms','rootCategoryName'), new KalturaCategory());
			root.category.fullName = '';
			root.category.entriesCount = int(totalEntryCount);
			catMap.put(0 + '', root);
			
			var tempArr:ArrayCollection = new ArrayCollection();
			
			var tempCatNames:ArrayCollection = new ArrayCollection();
			
			for each(var kCat:KalturaCategory in array)
			{
				var category:CategoryVO = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				var catName:Object = new Object();
				catName.label = kCat.fullName;
				tempCatNames.addItem(catName);
				tempArr.addItem(category)
			}
			
			_model.categoriesFullNameList = tempCatNames;
			
			for each(var cat:CategoryVO in tempArr)
			{
				var parentCategory:CategoryVO = catMap.getValue(cat.category.parentId + '') as CategoryVO;
				if(parentCategory != null)
				{
					parentCategory.children.addItem(cat);
					sortCategories(parentCategory.children);
				}
			}
			
			
			return root;
		}
		
		private function sortCategories(catArrCol:ArrayCollection):void
		{
			var dataSortField:SortField = new SortField();
            dataSortField.name = "name";
            dataSortField.caseInsensitive = true;
			dataSortField.descending = false;
            var dataSort:Sort = new Sort();
            dataSort.fields = [dataSortField];
            catArrCol.sort = dataSort;
            catArrCol.refresh();
		}

	}
}