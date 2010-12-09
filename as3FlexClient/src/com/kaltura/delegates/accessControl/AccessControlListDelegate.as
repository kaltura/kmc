package com.kaltura.delegates.accessControl
{
	import com.kaltura.commands.accessControl.AccessControlList;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class AccessControlListDelegate extends WebDelegateBase
	{
		public function AccessControlListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
