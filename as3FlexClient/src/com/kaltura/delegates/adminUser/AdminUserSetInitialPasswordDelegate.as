package com.kaltura.delegates.adminUser
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class AdminUserSetInitialPasswordDelegate extends WebDelegateBase
	{
		public function AdminUserSetInitialPasswordDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
