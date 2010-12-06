package com.kaltura.delegates.storageProfile
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class StorageProfileListByPartnerDelegate extends WebDelegateBase
	{
		public function StorageProfileListByPartnerDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
