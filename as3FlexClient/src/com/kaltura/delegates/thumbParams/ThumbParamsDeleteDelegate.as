package com.kaltura.delegates.thumbParams
{
	import com.kaltura.commands.thumbParams.ThumbParamsDelete;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class ThumbParamsDeleteDelegate extends WebDelegateBase
	{
		public function ThumbParamsDeleteDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
