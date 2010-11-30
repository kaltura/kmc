package com.kaltura.kmc.modules.admin.stubs.commands.role
{
	import com.kaltura.kmc.modules.admin.stubs.delegates.role.RoleGetDelegate;
	import com.kaltura.net.KalturaCall;

	public class RoleGet extends KalturaCall
	{
		public var filterFields : String;
		public function RoleGet( roleId : String )
		{
			service= 'role';
			action= 'get';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'roleId' );
			valueArr.push( roleId );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new RoleGetDelegate( this , config );
		}
	}
}
