package com.kaltura.commands.permission
{
	import com.kaltura.delegates.permission.PermissionGetDelegate;
	import com.kaltura.net.KalturaCall;

	public class PermissionGet extends KalturaCall
	{
		public var filterFields : String;
		public function PermissionGet( permissionId : int )
		{
			service= 'permission';
			action= 'get';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'permissionId' );
			valueArr.push( permissionId );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new PermissionGetDelegate( this , config );
		}
	}
}
