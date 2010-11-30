package com.kaltura.kmc.modules.admin.stubs.commands.role
{
	import com.kaltura.delegates.user.UserListDelegate;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRoleFilter;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.vo.KalturaFilterPager;

	public class RoleList extends KalturaCall
	{
		public var filterFields : String;
		public function RoleList( filter : KalturaRoleFilter=null,pager : KalturaFilterPager=null )
		{
			if(filter== null)filter= new KalturaRoleFilter();
			if(pager== null)pager= new KalturaFilterPager();
			service= 'role';
			action= 'list';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
 			keyValArr = kalturaObject2Arrays(filter,'filter');
			keyArr = keyArr.concat( keyValArr[0] );
			valueArr = valueArr.concat( keyValArr[1] );
 			keyValArr = kalturaObject2Arrays(pager,'pager');
			keyArr = keyArr.concat( keyValArr[0] );
			valueArr = valueArr.concat( keyValArr[1] );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new UserListDelegate( this , config );
		}
	}
}
