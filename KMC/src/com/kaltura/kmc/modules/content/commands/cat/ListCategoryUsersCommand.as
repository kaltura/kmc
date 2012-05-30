package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.categoryUser.CategoryUserList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategoryUserFilter;
	import com.kaltura.vo.KalturaCategoryUserListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	public class ListCategoryUsersCommand extends KalturaCommand {
		
		/**
		 * the last filter used for list action 
		 * @internal
		 * the inherit userse from parent action ends in listing users, and requires the last used filter.
		 */		
		private static var lastFilter:KalturaCategoryUserFilter;
		
		override public function execute(event:CairngormEvent):void {
			if (event.type == CategoryEvent.RESET_CATEGORY_USER_LIST) {
				_model.categoriesModel.categoryUsers = null;
				_model.categoriesModel.totalCategoryUsers = 0;
				return;
			}
			
			
			_model.increaseLoadCounter();
			var f:KalturaCategoryUserFilter;
			var p:KalturaFilterPager;
			
			if (event.data is Array) {
				f = event.data[0];
				p = event.data[1];
			}
			
			if (f) {
				// remember given filter
				lastFilter = f;
			}
			else if (lastFilter) {
				// use saved filter
				f = lastFilter;
			}
			
			var getUsrs:CategoryUserList = new CategoryUserList(f, p);
			getUsrs.addEventListener(KalturaEvent.COMPLETE, result);
			getUsrs.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getUsrs);	   
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var resp:KalturaCategoryUserListResponse = data.data as KalturaCategoryUserListResponse;
			_model.categoriesModel.categoryUsers = new ArrayCollection(resp.objects);
			_model.categoriesModel.totalCategoryUsers = resp.totalCount;
			_model.decreaseLoadCounter();
		}
	}
}