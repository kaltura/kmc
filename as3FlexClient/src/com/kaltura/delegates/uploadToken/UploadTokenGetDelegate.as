package com.kaltura.delegates.uploadToken
{
	import com.kaltura.commands.uploadToken.UploadTokenGet;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class UploadTokenGetDelegate extends WebDelegateBase
	{
		public function UploadTokenGetDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
