package com.kaltura.delegates.documents
{
	import com.kaltura.commands.documents.DocumentsDelete;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;

	import flash.utils.getDefinitionByName;

	public class DocumentsDeleteDelegate extends WebDelegateBase
	{
		public function DocumentsDeleteDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
