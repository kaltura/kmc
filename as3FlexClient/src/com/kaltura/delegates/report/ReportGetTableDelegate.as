package com.kaltura.delegates.report
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class ReportGetTableDelegate extends WebDelegateBase
	{
		public function ReportGetTableDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
