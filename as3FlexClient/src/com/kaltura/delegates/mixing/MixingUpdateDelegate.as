package com.kaltura.delegates.mixing
{
	import com.kaltura.commands.mixing.MixingUpdate;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class MixingUpdateDelegate extends WebDelegateBase
	{
		public function MixingUpdateDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
