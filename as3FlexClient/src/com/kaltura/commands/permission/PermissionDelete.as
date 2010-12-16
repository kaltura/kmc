package com.kaltura.commands.permission
{
	import com.kaltura.delegates.permission.PermissionDeleteDelegate;
	import com.kaltura.net.KalturaCall;

	public class PermissionDelete extends KalturaCall
	{
		public var filterFields : String;
		public function PermissionDelete( permissionId : int )
		{
			service= 'permission';
			action= 'delete';

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
			delegate = new PermissionDeleteDelegate( this , config );
		}
	}
}
