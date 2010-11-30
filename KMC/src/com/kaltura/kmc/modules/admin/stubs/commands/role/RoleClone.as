package com.kaltura.kmc.modules.admin.stubs.commands.role
{
	import com.kaltura.kmc.modules.admin.stubs.delegates.role.RoleCloneDelegate;
	import com.kaltura.net.KalturaCall;

	public class RoleClone extends KalturaCall
	{
		public var filterFields : String;
		public function RoleClone( id : int )
		{
			service= 'role';
			action= 'clone';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'id' );
			valueArr.push( id );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new RoleCloneDelegate( this , config );
		}
	}
}
