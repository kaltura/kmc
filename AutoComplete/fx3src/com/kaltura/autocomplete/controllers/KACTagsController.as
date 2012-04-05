package com.kaltura.autocomplete.controllers
{
	import com.hillelcoren.components.AutoComplete;
	import com.kaltura.KalturaClient;
	import com.kaltura.autocomplete.controllers.base.KACControllerBase;
	import com.kaltura.commands.tag.TagSearch;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaTagFilter;
	import com.kaltura.vo.KalturaTagListResponse;
	
	public class KACTagsController extends KACControllerBase
	{
		public function KACTagsController(autoComp:AutoComplete, client:KalturaClient)
		{
			super(autoComp, client);
		}
		
		override protected function createCallHook():KalturaCall{
			var filter:KalturaTagFilter = new KalturaTagFilter();
			filter.tagStartsWith = _autoComp.searchText;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			
			// TODO: Check size limit?
			pager.pageSi1ze = 30;
			pager.pageIndex = 0;
			
			var listTags:TagSearch = new TagSearch(filter, pager);
			return listTags;
		}
		
		override protected function fetchElements(data:Object):Array{
			return (data.data as KalturaTagListResponse).objects;
		}
	}
}