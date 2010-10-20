package com.kaltura.delegates.category
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class CategoryAddDelegate extends WebDelegateBase
	{
		public function CategoryAddDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
