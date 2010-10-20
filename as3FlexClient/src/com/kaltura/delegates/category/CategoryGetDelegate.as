package com.kaltura.delegates.category
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class CategoryGetDelegate extends WebDelegateBase
	{
		public function CategoryGetDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
