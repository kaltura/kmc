package com.kaltura.delegates.report
{
	import flash.utils.getDefinitionByName;
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	public class ReportGetTotalDelegate extends WebDelegateBase
	{
		public function ReportGetTotalDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
