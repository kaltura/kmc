package com.kaltura.delegates.user
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class UserSetInitialPasswordDelegate extends WebDelegateBase
	{
		public function UserSetInitialPasswordDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
