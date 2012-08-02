package com.kaltura.autocomplete.controllers
{
	import com.hillelcoren.components.AutoComplete;
	import com.kaltura.KalturaClient;
	import com.kaltura.autocomplete.controllers.base.KACControllerBase;
	import com.kaltura.autocomplete.itemRenderers.selection.TagsSelectedItem;
	import com.kaltura.commands.tag.TagSearch;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.types.KalturaTaggedObjectType;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaTag;
	import com.kaltura.vo.KalturaTagFilter;
	import com.kaltura.vo.KalturaTagListResponse;
	
	import mx.core.ClassFactory;
	
	public class KACTagsController extends KACControllerBase
	{
		private var _objType:String;
		
		public function KACTagsController(autoComp:AutoComplete, client:KalturaClient, objType:String)
		{
			super(autoComp, client);
//			autoComp.allowEditingSelectedValues = true;
			autoComp.selectionItemRendererClassFactory = new ClassFactory(TagsSelectedItem);
//			autoComp.allowEditingNewValues = true;
			_objType = objType;
		}
		
		override protected function createCallHook():KalturaCall{
			var filter:KalturaTagFilter = new KalturaTagFilter();
			filter.tagStartsWith = _autoComp.searchText;
			filter.objectTypeEqual = _objType;
			var pager:KalturaFilterPager = new KalturaFilterPager();
			
			// TODO: Check size limit?
			pager.pageSize = 30;
			pager.pageIndex = 0;
			
			var listTags:TagSearch = new TagSearch(filter, pager);
			return listTags;
		}
		
		override protected function fetchElements(data:Object):Array{
			if ((data.data as KalturaTagListResponse).objects != null) {
			var tags:Vector.<KalturaTag> = Vector.<KalturaTag>((data.data as KalturaTagListResponse).objects);
			var tagNames:Array = new Array();
			
			for each (var tag:KalturaTag in tags){
				tagNames.push(tag.tag);
			}
				
			return tagNames;
			
			} else {
				return new Array();
			}
		}
	}
}