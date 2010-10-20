package com.kaltura.delegates.documents
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class DocumentsAddFromUploadedFileDelegate extends WebDelegateBase
	{
		public function DocumentsAddFromUploadedFileDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
