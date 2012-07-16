package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.categoryUser.CategoryUserList;
	import com.kaltura.commands.user.UserGet;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategoryUser;
	import com.kaltura.vo.KalturaCategoryUserFilter;
	import com.kaltura.vo.KalturaCategoryUserListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserFilter;
	import com.kaltura.vo.KalturaUserListResponse;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class ListCategoryUsersCommand extends KalturaCommand {
		
		
		
		/**
		 * the last filter used for list action 
		 * @internal
		 * the inherit users from parent action ends in listing users, and requires the last used filter.
		 */		
		private static var lastFilter:KalturaCategoryUserFilter;
		
		
		private const CHUNK_SIZE:int = 20;
		
		private var _totalCategoryUsers:int;
		private var _categoryUsers:Array;
		
		private var _users:Array;
		private var _lastCatUsrIndex:int;
		
		
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
			getUsrs.addEventListener(KalturaEvent.COMPLETE, getUsers);
			getUsrs.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getUsrs);	   
		}
		
		
		private function getUsers(data:KalturaEvent):void {
			super.result(data);
			if (!checkError(data)) {
				var resp:KalturaCategoryUserListResponse = data.data as KalturaCategoryUserListResponse; 
				_categoryUsers = resp.objects;
				_totalCategoryUsers = resp.totalCount;
				
				_users = [];
				
				
				var mr:MultiRequest = new MultiRequest();
				var ug:UserGet;
				for each (var kcu:KalturaCategoryUser in _categoryUsers) {
					ug = new UserGet(kcu.userId);
					mr.addAction(ug);
				}
				mr.addEventListener(KalturaEvent.COMPLETE, getUsersResult);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.increaseLoadCounter();
				_model.context.kc.post(mr);
				
			}
			_model.decreaseLoadCounter();
		}
		
		
		private function getUsersResult(e:KalturaEvent):void {
			_model.decreaseLoadCounter();
			for each (var o:Object in e.data) {
				if (o is KalturaUser) {
					_users.push(o);
				}
			}
			
			// match to categoryUsers
			addNameToCategoryUsers();
		}
		
		
		
		/**
		 * get the next chunk of KalturaUser objects 
		 */		
		private function getUsersChunk():void {
			var ids:String = '';
			var i:int;
			for (i = 0; i < CHUNK_SIZE; i++) {
				if (_lastCatUsrIndex + i < _categoryUsers.length) {
					ids += (_categoryUsers[_lastCatUsrIndex + i] as KalturaCategoryUser).userId + ",";  
				}
				else {
					break;
				}
			} 
			_lastCatUsrIndex = _lastCatUsrIndex + i;
			
			var f:KalturaUserFilter = new KalturaUserFilter();
			f.idIn = ids;
			
			// CHUNK_SIZE is less than the default pager, so no need to add one.
			var getUsrs:UserList = new UserList(f);
			getUsrs.addEventListener(KalturaEvent.COMPLETE, getUsersChunkResult);
			getUsrs.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.increaseLoadCounter();
			_model.context.kc.post(getUsrs);
		}
		
		
		/**
		 * accunulate received result and trigger next load if needed 
		 * @param data	users data from server
		 */		
		private function getUsersChunkResult(data:KalturaEvent):void {
			super.result(data);
			if (!checkError(data)) {
				_users = _users.concat((data.data as KalturaUserListResponse).objects);
				if (_lastCatUsrIndex < _categoryUsers.length) {
					// there are more users to load
					getUsersChunk();
				}
				else {
					// match to categoryUsers
					addNameToCategoryUsers();
				}
			}
			_model.decreaseLoadCounter();	
		}
		
		private function addNameToCategoryUsers():void {
			var usr:KalturaUser;
			for each (var cu:KalturaCategoryUser in _categoryUsers) {
				for (var i:int = 0; i<_users.length; i++) {
					usr = _users[i] as KalturaUser;
					if (cu.userId == usr.id) {
						cu.userName = usr.screenName;
						_users.splice(i, 1);
						break;
					}
				}
			}
			_model.categoriesModel.categoryUsers = new ArrayCollection(_categoryUsers);
			_model.categoriesModel.totalCategoryUsers = _totalCategoryUsers;
		}
		
	}
}