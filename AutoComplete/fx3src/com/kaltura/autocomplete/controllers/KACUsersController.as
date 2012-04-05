package com.kaltura.autocomplete.controllers
{
	import com.hillelcoren.components.AutoComplete;
	import com.kaltura.KalturaClient;
	import com.kaltura.autocomplete.controllers.base.KACControllerBase;
	import com.kaltura.commands.user.UserList;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaUserFilter;
	import com.kaltura.vo.KalturaUserListResponse;
	
	public class KACUsersController extends KACControllerBase
	{
		public function KACUsersController(autoComp:AutoComplete, client:KalturaClient)
		{
			super(autoComp, client);
		}
		
		override protected function createCallHook():KalturaCall{
			var filter:KalturaUserFilter = new KalturaUserFilter();
			filter.screenNameStartsWith = _autoComp.searchText;
			
			var pager:KalturaFilterPager = new KalturaFilterPager();
			pager.pageIndex = 0;
			pager.pageSize = 30;
			
			var listUsers:UserList = new UserList(filter, pager);
			
			return listUsers;
		}
		
		override protected function fetchElements(data:Object):Array{
			return (data.data as KalturaUserListResponse).objects;
		}
	}
}