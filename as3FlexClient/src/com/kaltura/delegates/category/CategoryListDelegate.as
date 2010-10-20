package com.kaltura.delegates.category
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class CategoryListDelegate extends WebDelegateBase
	{
		public function CategoryListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
