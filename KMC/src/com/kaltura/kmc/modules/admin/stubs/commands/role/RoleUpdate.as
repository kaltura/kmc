package com.kaltura.kmc.modules.admin.stubs.commands.role
{
	import com.kaltura.kmc.modules.admin.stubs.delegates.role.RoleUpdateDelegate;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRole;
	import com.kaltura.net.KalturaCall;

	public class RoleUpdate extends KalturaCall
	{
		public var filterFields : String;
		public function RoleUpdate( roleId : String, user : KalturaRole )
		{
			service= 'role';
			action= 'update';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'roleId' );
			valueArr.push( roleId );
 			keyValArr = kalturaObject2Arrays(user,'role');
			keyArr = keyArr.concat( keyValArr[0] );
			valueArr = valueArr.concat( keyValArr[1] );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new RoleUpdateDelegate( this , config );
		}
	}
}
