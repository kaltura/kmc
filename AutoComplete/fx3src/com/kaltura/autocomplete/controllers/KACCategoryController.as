package com.kaltura.autocomplete.controllers
{
	import com.hillelcoren.components.AutoComplete;
	import com.hillelcoren.utils.StringUtils;
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
			autoComp.dropDownLabelFunction = categoryLabelFunction;
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
		
		private function categoryLabelFunction(item:Object):String{
			var category:KalturaCategory = item as KalturaCategory;
			
			var labelText:String = category.fullName;
			if (category.referenceId != null && category.referenceId != ""){
				labelText += " (" + category.referenceId + ")";
			}
			
			var searchStr:String = _autoComp.searchText;
			
			// there are problems using ">"s and "<"s in HTML
			labelText = labelText.replace( "<", "&lt;" ).replace( ">", "&gt;" );				
			
			var returnStr:String = StringUtils.highlightMatch( labelText, searchStr );
			
			if (_autoComp.selectedItems.getItemIndex( item ) >= 0 || _autoComp.disabledItems.getItemIndex( item ) >= 0)
			{
				returnStr = "<font color='" + Consts.COLOR_TEXT_DISABLED + "'>" + returnStr + "</font>";
			}
			
			return returnStr;
		}
	}
}