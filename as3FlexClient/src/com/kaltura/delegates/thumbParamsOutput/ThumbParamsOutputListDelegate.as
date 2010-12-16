package com.kaltura.delegates.thumbParamsOutput
{
	import flash.utils.getDefinitionByName;

	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	public class ThumbParamsOutputListDelegate extends WebDelegateBase
	{
		public function ThumbParamsOutputListDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
