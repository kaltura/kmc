package com.kaltura.delegates.mixing
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class MixingGetDelegate extends WebDelegateBase
	{
		public function MixingGetDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
