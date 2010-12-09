package com.kaltura.delegates.user
{
	import com.kaltura.commands.user.UserUpdate;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class UserUpdateDelegate extends WebDelegateBase
	{
		public function UserUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
