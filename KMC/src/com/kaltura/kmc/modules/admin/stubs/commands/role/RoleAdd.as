package com.kaltura.kmc.modules.admin.stubs.commands.role
{
	import com.kaltura.kmc.modules.admin.stubs.delegates.role.RoleAddDelegate;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRole;
	import com.kaltura.net.KalturaCall;

	public class RoleAdd extends KalturaCall
	{
		public var filterFields : String;
		public function RoleAdd( role : KalturaRole )
		{
			service= 'role';
			action= 'add';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
 			keyValArr = kalturaObject2Arrays(role,'role');
			keyArr = keyArr.concat( keyValArr[0] );
			valueArr = valueArr.concat( keyValArr[1] );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new RoleAddDelegate( this , config );
		}
	}
}
