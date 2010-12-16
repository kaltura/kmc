package com.kaltura.commands.permission
{
	import com.kaltura.vo.KalturaPermission;
	import com.kaltura.delegates.permission.PermissionUpdateDelegate;
	import com.kaltura.net.KalturaCall;

	public class PermissionUpdate extends KalturaCall
	{
		public var filterFields : String;
		public function PermissionUpdate( permissionId : int,permission : KalturaPermission )
		{
			service= 'permission';
			action= 'update';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push( 'permissionId' );
			valueArr.push( permissionId );
 			keyValArr = kalturaObject2Arrays(permission,'permission');
			keyArr = keyArr.concat( keyValArr[0] );
			valueArr = valueArr.concat( keyValArr[1] );
			applySchema( keyArr , valueArr );
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields',filterFields);
			delegate = new PermissionUpdateDelegate( this , config );
		}
	}
}
