package com.kaltura.delegates.upload
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class UploadGetUploadedFileTokenByFileNameDelegate extends WebDelegateBase
	{
		public function UploadGetUploadedFileTokenByFileNameDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
