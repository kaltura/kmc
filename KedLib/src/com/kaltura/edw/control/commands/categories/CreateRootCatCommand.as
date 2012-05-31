package com.kaltura.edw.control.commands.categories
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.resources.ResourceManager;
	
	public class CreateRootCatCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			// create root category
			var rootCat:KalturaCategory = new KalturaCategory();
			rootCat.fullName = '';
			rootCat.entriesCount = 0;
			rootCat.directSubCategoriesCount = 1; // this is a dummy value, so its "children" property will be initialised
			var root:CategoryVO = new CategoryVO(0,
				ResourceManager.getInstance().getString('filter', 'rootCategoryName'),
				rootCat);
			
			// put it in the map and on the tree
			var filterModel:FilterModel = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
			filterModel.categoriesMap.put(0 + '', root);
			filterModel.categories = root;
		}
	}
}