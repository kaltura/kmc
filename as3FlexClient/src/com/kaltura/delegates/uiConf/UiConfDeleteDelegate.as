package com.kaltura.delegates.uiConf
{
	import com.kaltura.commands.uiConf.UiConfDelete;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class UiConfDeleteDelegate extends WebDelegateBase
	{
		public function UiConfDeleteDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
