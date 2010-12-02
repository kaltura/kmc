package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.partner.PartnerGetUsage;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.AccountUsageVO;
	import com.kaltura.vo.KalturaPartnerUsage;
	
	import flash.external.ExternalInterface;
	
	import mx.rpc.IResponder;
	
	public class GetUsageGraphCommand implements ICommand, IResponder
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			new KalturaPartnerUsage();
			var params:Object = event.data;
			var getPartnerUsage:PartnerGetUsage = new PartnerGetUsage(params.year, params.month, params.resolution);
			getPartnerUsage.addEventListener(KalturaEvent.COMPLETE, result);
			getPartnerUsage.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getPartnerUsage);	
		}
		
		public function result(data:Object):void
		{
			var usageData:AccountUsageVO = new AccountUsageVO();
			usageData.hostingGB = data.data.hostingGB;
			usageData.totalBWSoFar = data.data.usageGB;
			usageData.totalPercentSoFar = data.data.Percent;
			usageData.usageSeries = data.data.usageGraph;
			usageData.packageBW = data.data.packageBW;
			
			_model.usageData = usageData;
		}
		
		public function fault(info:Object):void
		{
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				ExternalInterface.call("kmc.functions.expired");
				return;
			}
		}
	}
}