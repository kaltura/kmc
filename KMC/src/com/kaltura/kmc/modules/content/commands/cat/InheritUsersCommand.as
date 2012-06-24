package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryGet;
	import com.kaltura.commands.categoryUser.CategoryUserAdd;
	import com.kaltura.commands.categoryUser.CategoryUserCopyFromCaregory;
	import com.kaltura.commands.categoryUser.CategoryUserList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryUser;
	import com.kaltura.vo.KalturaCategoryUserFilter;
	import com.kaltura.vo.KalturaCategoryUserListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	public class InheritUsersCommand extends KalturaCommand {
		
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var catid:int = (event.data as KalturaCategory).id;
			var mr:MultiRequest = new MultiRequest();
			var call:KalturaCall = new CategoryUserCopyFromCaregory(catid);
			mr.addAction(call);
			call = new CategoryGet(catid);
			mr.addAction(call);
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
			
		}
		
		override public function result(data:Object):void {
			super.result(data);
			if (!checkError(data)) {
				var cg:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORY_USERS);
				cg.dispatch();
				// set new numbers of members to the category object
				var updatedCat:KalturaCategory = data.data[data.data.length-1] as KalturaCategory;
				_model.categoriesModel.selectedCategory.membersCount = updatedCat.membersCount;
				_model.categoriesModel.selectedCategory.pendingMembersCount = updatedCat.pendingMembersCount;
			}
			_model.decreaseLoadCounter();
		}
	}
}