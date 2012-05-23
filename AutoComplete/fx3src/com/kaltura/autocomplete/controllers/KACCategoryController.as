package com.kaltura.autocomplete.controllers
{
	import com.hillelcoren.components.AutoComplete;
	import com.kaltura.KalturaClient;
	import com.kaltura.autocomplete.controllers.base.KACControllerBase;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;

	public class KACCategoryController extends KACControllerBase
	{
		public function KACCategoryController(autoComp:AutoComplete, client:KalturaClient)
		{
			super(autoComp, client);
		}
		
		override protected function createCallHook():KalturaCall{
			var filter:KalturaCategoryFilter = new KalturaCategoryFilter();
			filter.nameOrReferenceIdStartsWith = _autoComp.searchText;
			var listCategories:CategoryList = new CategoryList(filter);
			
			return listCategories;
		}
		
		override protected function fetchElements(data:Object):Array{
			return (data.data as KalturaCategoryListResponse).objects;
		}
	}
}