package com.kaltura.kmc.modules.admin.stubs.delegates.role
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class RoleUpdateDelegate extends WebDelegateBase
	{
		public function RoleUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
