package com.kaltura.delegates.user
{
	import com.kaltura.commands.user.UserAdd;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class UserAddDelegate extends WebDelegateBase
	{
		public function UserAddDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
