package com.kaltura.delegates.documents
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class DocumentsAddFromFlavorAssetDelegate extends WebDelegateBase
	{
		public function DocumentsAddFromFlavorAssetDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
