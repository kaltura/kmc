package com.kaltura.autocomplete.controllers
{
	import com.hillelcoren.components.AutoComplete;
	import com.hillelcoren.utils.StringUtils;
	import com.kaltura.KalturaClient;
	import com.kaltura.autocomplete.controllers.base.KACControllerBase;
	import com.kaltura.commands.user.UserGet;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserFilter;
	import com.kaltura.vo.KalturaUserListResponse;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	
	public class KACUsersController extends KACControllerBase
	{
		public function KACUsersController(autoComp:AutoComplete, client:KalturaClient)
		{
			super(autoComp, client);
			
			autoComp.labelField = "id";
			autoComp.dropDownLabelFunction = userLabelFunction;
			autoComp.setStyle("unregisteredSelectedItemStyleName", "unregisteredSelectionBox"); 
			BindingUtils.bindSetter(onIdentifierSet, autoComp, "selectedItemIdentifier");
			autoComp.addEventListener(Event.CHANGE, onSelectionChanged, false, int.MAX_VALUE);
		}
		
		private function onSelectionChanged(event:Event):void
		{
			for (var index:uint = 0; index < _autoComp.selectedItems.length; index++){
				var item:Object = _autoComp.selectedItems.getItemAt(index);
				if (item is String){
					var userItem:KalturaUser = new KalturaUser();
					userItem.id = item as String;
					_autoComp.selectedItems.setItemAt(userItem, index);
				}
			}
		}
		
		private function onIdentifierSet(ident:Object):void
		{
			var userId:String = ident as String;
			if (userId != null){
				var getUser:UserGet = new UserGet(userId);
				getUser.addEventListener(KalturaEvent.COMPLETE, getUserSuccess);
				getUser.addEventListener(KalturaEvent.FAILED, fault);
				getUser.queued = false;
				
				_client.post(getUser);
			} else {
				_autoComp.selectedItem = null;
			}
		}
		
		private function getUserSuccess(data:Object):void
		{
			if (data.data is KalturaError){
				fault(data as KalturaEvent);
			} else {
				var user:KalturaUser = data.data as KalturaUser;
				if (_autoComp.selectedItems != null){
					_autoComp.selectedItems.addItem(user);
				} else {
					_autoComp.selectedItem = user;
				}
			}
		}
		
		override protected function createCallHook():KalturaCall{
			var filter:KalturaUserFilter = new KalturaUserFilter();
			filter.idOrScreenNameStartsWith = _autoComp.searchText;
			
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageIndex = 0;
			pager.pageSize = 30;
			
			var listUsers:UserList = new UserList(filter, pager);
			
			return listUsers;
		}
		
		override protected function fetchElements(data:Object):Array{
			return (data.data as KalturaUserListResponse).objects;
		}
		
		private function userLabelFunction(item:Object):String{
			var user:KalturaUser = item as KalturaUser;
			
			var labelText:String = user.id;
			if (user.screenName != null && user.screenName != ""){
				labelText += " (" + user.screenName + ")";
			}
			
			var searchStr:String = _autoComp.searchText;
			
			// there are problems using ">"s and "<"s in HTML
			labelText = labelText.replace( "<", "&lt;" ).replace( ">", "&gt;" );				
			
			var returnStr:String = StringUtils.highlightMatch( labelText, searchStr );
			
			var isDisabled:Boolean = false;
			var currUser:KalturaUser = item as KalturaUser;
			var ku:KalturaUser;
			for each (ku in _autoComp.disabledItems.source){
				if (ku.id == currUser.id){
					isDisabled = true;
					break;
				}
			}
			
			var isSelected:Boolean = false;
			for each (ku in _autoComp.selectedItems.source){
				if (ku.id == currUser.id){
					isSelected = true;
					break;
				}
			}
			
			if (isSelected || isDisabled)
			{
				returnStr = "<font color='" + Consts.COLOR_TEXT_DISABLED + "'>" + returnStr + "</font>";
			}
			
			return returnStr;
		}
	}
}