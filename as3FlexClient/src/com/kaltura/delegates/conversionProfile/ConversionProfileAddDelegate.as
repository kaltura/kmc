package com.kaltura.delegates.conversionProfile
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class ConversionProfileAddDelegate extends WebDelegateBase
	{
		public function ConversionProfileAddDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
