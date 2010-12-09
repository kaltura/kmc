package com.kaltura.delegates.category
{
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class CategoryUpdateDelegate extends WebDelegateBase
	{
		public function CategoryUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
